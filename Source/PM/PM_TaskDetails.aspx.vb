#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class PM_TaskDetails
    Inherits WebPages.Template.WhizTemplate

    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0

    Protected CONST_MODE_QUERY As String = "RUN"
    Protected CONST_MODE_COUNT As String = "COUNT"
    Protected CONST_ACTION_CLEAR As String = "CLEAR"
    Protected CONST_ACTION_EXECUTE As String = "EXECUTE"
    Protected CONST_ACTION_SAVE As String = "SAVE"

    Protected m_strMode As String
    Protected m_strAlphabet As String
    Protected m_strWindowTitle As String
    Protected m_strOrderBy As String
    Protected m_strSortOrder As String

    '2020
    Protected m_strSelectedValue As String
    '2020

    Protected m_blnIsValidQuery As Boolean = True
    Private m_strProjectID As String
    Private m_strProjectTypeID As String
    Private m_strAction As String
    Private m_strExecute As String
    Private m_strFieldName As String
    Private m_strWhereClause As String
    Private m_strTaskType As String
    Private m_strPhase As String
    Private m_strModule As String
    Private m_strSubProject As String
    Private m_strMilestone As String
    Private m_strFeatures As String
    Private m_strSQLQuery As String
    Private m_strUserName As String
    Private m_strLoginType As String
    Private m_strColumnName As String
    Private m_intRecordCount As Integer
    'Intigrated by harshk for sp4 issueid 200
    Private m_strDeliverable As String
    'End Intigrated by harshk for sp4 issueid 200
    Private WithEvents objGrid As WebPage.Templates.GenericGrid

    Protected m_blnShowPhase As Boolean
    Protected m_blnShowModule As Boolean
    Protected m_blnShowSubProject As Boolean
    Protected m_blnShowMilestone As Boolean
    Protected m_blnShowFeatures As Boolean
    Protected m_blnShowChangeRequest As Boolean

    Private m_strDisableTaskType As String = ""
    Private m_strDisablePhase As String = ""
    Private m_strDisableModule As String = ""
    Private m_strDisableSubProject As String = ""
    Private m_strDisableMilestone As String = ""
    Private m_strDisableFeatures As String = ""
    'Intigrated by HarshK for sp4 issueid 200
    Private m_strDisableDeliverable As String = ""
    'End  Intigrated by HarshK for sp4 issueid 200
    'Private m_strDisableChangeRequest As String

    ' Added By NitinVS on 6 Dec 2005 for WhizibleSEM SP5 for Editable Date Control IssueID 672
    Protected m_UseEditableDateControl As Boolean = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
    ' End Addition By NitinVS on 6 Dec 2005 for WhizibleSEM SP5 for Editable Date Control IssueID 672

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
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")
    End Sub

    Public Sub New()
        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PM_TaskDetails", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "Task Details ->InvalidInput"
        Throw ex
    End Sub
    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 20 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String
        Dim strPagingSQL As String
        Dim strRecordCountSQL As String

        ' Get the Global object 
        GetGlobalObject()

        'get the values from the query string and session
        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_MODE_QUERY
        m_strAction = Request.QueryString("Action") + ""
        m_strExecute = Request.QueryString("Execute") + ""
        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"
        m_strOrderBy = Request.QueryString("OrderBy") + ""
        If m_strOrderBy = "" Then m_strOrderBy = "TaskName" 'default column to sort on
        m_strSortOrder = Request.QueryString("SortOrder") + ""
        If m_strSortOrder = "" Then m_strSortOrder = "ASC" 'default sort order
        m_strProjectID = Session("intProjectID").ToString
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        '2020
        m_strSelectedValue = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("SelectedValue"), ""), String)
        '2020

        ''TODO get it from the session
        'm_strProjectID = "268"
        'm_strUserName = "Admin"
        'm_strLoginType = "E"

        'get the values from the page controls when it is posted back and 
        'for the first time initialize them with blank
        If IsPostBack Then
            m_strFieldName = MyBase.GetFormValue("cboFieldName") + ""
            m_strWhereClause = MyBase.GetFormValue("txtQueryText", False) + ""
            m_strTaskType = MyBase.GetFormValue("cboColTaskType") + ""
            m_strPhase = MyBase.GetFormValue("cboColPhase") + ""
            m_strModule = MyBase.GetFormValue("cboColModule") + ""
            m_strSubProject = MyBase.GetFormValue("cboColSubProject") + ""
            m_strMilestone = MyBase.GetFormValue("cboColMilestone") + ""
            m_strFeatures = MyBase.GetFormValue("cboColFeature") + ""
            'Intigrated bY harshK for sp4 issueid 200
            m_strDeliverable = MyBase.GetFormValue("cboColDeliverable") + ""
            'end Intigrated bY harshK for sp4 issueid 200
            m_strColumnName = MyBase.GetFormValue("txtColumnName") + ""
            m_intRecordCount = CType(MyBase.GetFormValue("txtRecordCount"), Integer)
        Else
            m_strWhereClause = ""
            m_strTaskType = ""
            m_strPhase = ""
            m_strModule = ""
            m_strSubProject = ""
            m_strMilestone = ""
            m_strFeatures = ""
            m_strColumnName = ""
            'Intigrated bY harshK for sp4 issueid 200
            m_strDeliverable = ""
            'End Intigrated bY harshK for sp4 issueid 200
            m_intRecordCount = 0

            'here Where clause is created for the first time when page is loaded
            '
            If Request.QueryString("TaskType") <> "" Then
                Dim strTaskCode As String
                strTaskCode = Request.QueryString("TaskType") + ""
                If strTaskCode.ToUpper = "O" Then
                    'Code Added By VidyaJ on Jan 17th 2005
                    'For issueID - 15433
                    m_strWhereClause = "" '"WhichTask = 'General Task'"
                ElseIf strTaskCode.ToUpper = "M" Then
                    m_strWhereClause = "WhichTask = 'MPP Task'"
                ElseIf strTaskCode.ToUpper = "A" Then
                    m_strWhereClause = "WhichTask = 'Assigned Task'"
                End If

                'Commented by JayavantK on 12-Oct-2004 
                'the use of resource name in the query causes some difficulties as there is Parent and child tasks involved.
                'If Request.QueryString("Resource") <> "" Then
                'm_strWhereClause += " AND UserName = '" + General.BuildQueryString(Request.QueryString("Resource")) + "' "
                'End If
                'End Comments
            End If

        End If

        m_strProjectTypeID = ""
        strSQL = "usp_Sel_tbl_PM_Project " + m_strProjectID.Trim
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            m_strProjectTypeID = Data.CheckIsDBNull(objDR("ProjectTypeID"), "").ToString + ""
        End If
        Data.DisposeDataReader(objDR)

        strSQL = "usp_Sel_tbl_PRS_ProjectTypes " + m_strProjectTypeID.Trim
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            m_blnShowPhase = CType(Data.CheckIsDBNull(objDR("ShowPhaseInAT"), "0").ToString, Boolean)
            m_blnShowModule = CType(Data.CheckIsDBNull(objDR("ShowModuleInAT"), "0").ToString, Boolean)
            m_blnShowSubProject = CType(Data.CheckIsDBNull(objDR("ShowSubProjectInAT"), "0").ToString, Boolean)
            m_blnShowMilestone = CType(Data.CheckIsDBNull(objDR("ShowMilestoneInAT"), "0").ToString, Boolean)
            m_blnShowFeatures = CType(Data.CheckIsDBNull(objDR("ShowFeatureInAT"), "0").ToString, Boolean)
            m_blnShowChangeRequest = CType(Data.CheckIsDBNull(objDR("ShowChangeRequestInAT"), "0").ToString, Boolean)
        Else
            m_blnShowPhase = False
            m_blnShowModule = False
            m_blnShowSubProject = False
            m_blnShowMilestone = False
            m_blnShowFeatures = False
            m_blnShowChangeRequest = False
        End If
        Data.DisposeDataReader(objDR)
        'TM_HELP_406

        'create the SP used to populate the grid in both mode
        Select Case m_strMode
            Case CONST_MODE_QUERY

                strSQL = " Where ProjectID=" + m_strProjectID.Trim + " AND IsActive=1 "

                'Integrated by MrugajaB on 28th July 2005 for WhizibleSEM SP4 Issue ID.91  Task completed in MPP cannot be mapped
                'Added By JayavantK On 10-Aug-2004
                'Modified by SiddharthS on 16 Mar 2005 for Issue Id 15675
                'strSQL &= "  AND IsTaskComplete = 0 AND (WhichTask <>''Assigned Task'' AND WhichTask <>''General Task'' OR (WhichTask=''Assigned Task'' AND ParentTask_UID IS NULL))"
                'Modification ends.
                'End Addition
                ' Added By PradipK on 11 July 2005
                ' Purpose : To Solve Issue 19853
                ' To Map Task (Completed in MPP) to Task Type,Modules etc Through 'Task Mapping'
                'strSQL &= "   AND (WhichTask <>''Assigned Task'' AND WhichTask <>''General Task'' OR (WhichTask=''Assigned Task'' AND ParentTask_UID IS NULL))"
                If m_strSelectedValue = "Assigned Task" Then
                    strSQL &= "   AND (WhichTask <>''Assigned Task'' AND WhichTask <>''General Task'' OR (WhichTask=''Assigned Task'' AND ParentTask_UID IS NULL))"
                End If
                If m_strSelectedValue = "Assigned Issues" Then
                    strSQL &= "   AND (WhichTask <>''Assigned Task'' AND WhichTask <>''General Task'' OR (WhichTask=''Assigned Issues'' AND ParentTask_UID IS NULL))"
                End If


                'End Addition By PradipK on 11 July 2005
                'End Integration

                'when page is loaded first time or no execute is clicked then dont display
                'any record, so here added the condition which can not be satisfied
                If m_strExecute <> CONST_ACTION_EXECUTE Then strSQL += " And 1=2 "

                If m_strWhereClause <> "" Then

                    strSQL += " And ( " + General.BuildQueryString(m_strWhereClause.Trim) + " ) "

                    'here TaskType is the name used to display but the actual name in the database is 
                    'moduleName, if where clause contains "TaskName" field then replace it with "ModuleName"
                    If strSQL.IndexOf("TaskType", 0) <> -1 Then
                        strSQL = strSQL.Replace(" TaskType ", " ModuleName ")
                    End If
                End If

                'create the SP required for paging
                strPagingSQL = "usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL.Trim + "','P'"

                'apply the paging filter here 
                If m_strAlphabet <> "-1" Then
                    strSQL += " AND LTRIM(RTRIM(LEFT(ISNULL(TaskName,''''),1))) = ''" + General.BuildQueryString(m_strAlphabet.Trim) + "'' "
                End If

                'create SP for getting the record count
                strRecordCountSQL = "Exec usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL.Trim + "','C'"

                strSQL += " ORDER BY " + m_strOrderBy.Trim + " " + m_strSortOrder.Trim

                Dim strCheckSQL As String
                strCheckSQL = "Exec usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL.Trim + "','T'"
                'validate the SP with parameter
                m_blnIsValidQuery = Data.ValidateQuery(strCheckSQL, MyBase.UseSQL)

                If m_blnIsValidQuery = True Then
                    'create the SP here by passing the Where clause as parameter to the SP
                    m_strSQLQuery = "Exec usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + strSQL.Trim + "','T'"
                Else
                    m_strSQLQuery = "Exec usp_Sel_QRB_QueriesForEntity_ProjectTasks '" + " Where ProjectID=" + m_strProjectID.Trim + " AND IsActive=1 "
                    If m_strExecute <> CONST_ACTION_EXECUTE Then m_strSQLQuery += " And 1=2 "
                    m_strSQLQuery += " ' "
                    m_strWhereClause = ""
                End If

            Case CONST_MODE_COUNT
                'SP required for grid
                m_strSQLQuery = "usp_Sel_tbl_PM_ProjectTasks_TaskDetails " + m_strProjectID.Trim + ",'" + m_strColumnName.Trim + "','" + m_strOrderBy.Trim + "','" + m_strSortOrder.Trim + "','" + General.BuildQueryString(m_strAlphabet.Trim) + "'"
                'create paging SQL
                strPagingSQL = "usp_Sel_tbl_PM_ProjectTasks_TaskDetails_Paging " + m_strProjectID.Trim + ",'" + m_strColumnName.Trim + "'"
                'create SP for getting the record count
                strRecordCountSQL = "usp_Sel_tbl_PM_ProjectTasks_TaskDetails " + m_strProjectID.Trim + ",'" + m_strColumnName.Trim + "','" + m_strOrderBy.Trim + "','" + m_strSortOrder.Trim + "','" + General.BuildQueryString(m_strAlphabet.Trim) + "','C'"

                'Here in the column count click mode check which column count is clicked and excluding 
                'that disable other columns
                If m_strColumnName.ToUpper.Trim = "MODULENAME" Then m_strDisableTaskType = "" Else m_strDisableTaskType = "Disabled"
                If m_strColumnName.ToUpper.Trim = "PHASE" Then m_strDisablePhase = "" Else m_strDisablePhase = "Disabled"
                If m_strColumnName.ToUpper.Trim = "MODULE" Then m_strDisableModule = "" Else m_strDisableModule = "Disabled"
                If m_strColumnName.ToUpper.Trim = "SUBPROJECT" Then m_strDisableSubProject = "" Else m_strDisableSubProject = "Disabled"
                If m_strColumnName.ToUpper.Trim = "MILESTONE" Then m_strDisableMilestone = "" Else m_strDisableMilestone = "Disabled"
                If m_strColumnName.ToUpper.Trim = "PROJECTFEATUREID" Then m_strDisableFeatures = "" Else m_strDisableFeatures = "Disabled"
                'Intigrated by HarshK for sp4 issueid 200
                If m_strColumnName.ToUpper.Trim = "DELIVERABLEID" Then m_strDisableDeliverable = "" Else m_strDisableDeliverable = "Disabled"
                'end Intigrated by HarshK for sp4 issueid 200

        End Select

        'if given query is valid then get the record count
        If m_blnIsValidQuery = True Then
            'get the record count for the current SP to show or hide Save, Select All & Clear All menu
            m_intRecordCount = CType(Data.GetDataScalar(strRecordCountSQL, MyBase.UseSQL), Integer)
        End If

        'perform the action
        If m_strAction <> "" Then
            Call performAction()
        End If

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        If m_intRecordCount > 0 Then
            'Modified by NitinVS on 22 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11944 

            If m_objAccessRights.Edit = True Then
                arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
            End If
            ' End Modified by NitinVS on 22 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11944 

            arrMenu.Add(MyBase.GetResourceString("MENU_SELECTALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")) : arrClientSideFunctions.Add("SelectAll_OnClick()")
            arrMenu.Add(MyBase.GetResourceString("MENU_CLEARALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")) : arrClientSideFunctions.Add("ClearAll_OnClick()")
        End If
        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('TM_HELP_406')")

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

        strPagingHTML = ""
        If m_blnIsValidQuery = True Then
            'display the paging links on the menu bar
            objPaging = New WebPage.Templates.Paging
            strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strPagingSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "PAGENUMBER", True)
            objPaging = Nothing
        End If

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)

        'draw upper menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")
        'create lower menu without paging links 
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PM_TaskDetails", "AppResources")

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
        General.WriteHTML("<BR>")

        ''draw page description
        'objHeader = New WebPage.Templates.HeaderFooter
        'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC") + ""
        'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
        'General.WriteHTML("<BR>")
        'objHeader = Nothing

        'plot the controls 
        Call plotScreenForTaskDetails()

        'write lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForTaskDetails
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls and grid for the query creation and task list on the page
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 21 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForTaskDetails()
        Dim strSQL As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim ObjSectionTitle As New WebPage.Templates.SectionTitle
        Dim intTaskTypeCount As Integer
        Dim intPhaseCount As Integer
        Dim intModuleCount As Integer
        Dim intSubProjectCount As Integer
        Dim intMilestoneCount As Integer
        Dim intFeatureCount As Integer
        Dim intGridRowCount As Integer
        'Intigrated by HarshK for sp4 issueid 200
        Dim intDeliverableCount As Integer
        'End Intigrated by HarshK for sp4 issueid 200
        ObjSectionTitle = New WebPage.Templates.SectionTitle
        General.WriteHTML(ObjSectionTitle.GetSectionTitle(MyBase.GetResourceString("QUERY_PART"), "DivQuery", "QueryPartShowHide", , , , , , , , True, , True, True))
        General.WriteHTML("<Script language=javascript>" + ObjSectionTitle.ClientsideScript + "</Script>")
        ObjSectionTitle = Nothing
        'plot the controls

        General.WriteHTML("<Div id='DivQuery' width=100% >")
        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")

        General.WriteHTML("<TR class='clsTREven'>")
        'display field
        General.WriteHTML("<TD align='left' nowrap  width=25% >" + MyBase.GetResourceString("CAP_FIELD") + "&nbsp;")
        strSQL = "Exec usp_sel_ProjectTasks_GetFieldList "
        If m_blnShowPhase = True Then strSQL += "1" Else strSQL += "0"
        If m_blnShowModule = True Then strSQL += ",1" Else strSQL += ",0"
        If m_blnShowSubProject = True Then strSQL += ",1" Else strSQL += ",0"
        If m_blnShowMilestone = True Then strSQL += ",1" Else strSQL += ",0"
        If m_blnShowFeatures = True Then strSQL += ",1" Else strSQL += ",0"
        General.WriteHTML(HTMLControls.DrawComboBox("cboFieldName", strSQL, 150, , " onchange='javascript:Field_OnChange()'", True, True) + "</TD>")

        'display operator
        General.WriteHTML("<TD align='left' width=10% >" + MyBase.GetResourceString("CAP_OPERATOR") + "&nbsp;")
        strSQL = "usp_sel_ProjectTasksMapping_OperatorList"
        General.WriteHTML(HTMLControls.DrawComboBox("cboOperator", strSQL, 100, , , True, True) + "</TD>")

        'display value textbox
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_VALUE") + "&nbsp;</TD>")
        General.WriteHTML("<TD id='TDFieldValue' align='left' width=30% >")
        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        General.WriteHTML(HTMLControls.DrawTextBox("txtValue", "txtValue", , 100, 100, , , , , , , , , True, EnableHTMLEncode:=True) + "&nbsp;</TD>")
        '''End of Modification by Dhanashri S on 7 Oct 2015

        '*************************************************************************************************
        'plot the dynamic controls for each field and hide them 
        strSQL = "Exec usp_Sel_tbl_PM_Project_TaskTypes_Names_TaskMapping " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboTaskType", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec Usp_Sel_tbl_IB_Project_Phases " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboPhase", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_tbl_PM_Module_TaskMapping " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboModule", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_tbl_PM_SubProject_TaskMapping " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboSubproject", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_tbl_PM_Milestones_TaskMapping " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboMilestone", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_tbl_PM_ReviewStatistics_EmployeeList 'Reviewee', " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboResources", strSQL, 100, , , True, , , , , True)
        strSQL = "Exec usp_Sel_tbl_PM_Project_Features_TaskMapping " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboFeature", strSQL, 100, , , True, , , , , True)
        'Intigrated by HarshK for sp4 issueid 200 
        strSQL = "Exec usp_Sel_tbl_PM_Project_Deliverables_TaskMapping " + m_strProjectID.ToString
        CommonFunction.HTMLControls.DrawComboBox("cboDeliverable", strSQL, 200, , , True, , , , , True)
        'End Intigrated by HarshK for sp4 issueid 200 
        'Modified By VidyaJ on 17th Jan 2005
        'For IssueID- 15433
        strSQL = "Exec usp_sel_ProjectTasks_TaskTypes 1"
        'End of Modification
        CommonFunction.HTMLControls.DrawComboBox("cboWhichTask", strSQL, 100, , , True, , , , , True)

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunction.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", , 100, 100, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015

        ' Modified By NitinVS on 3 Dec 2005 for WhizibleSEM SP5 For The Editable Date Control Problem IssueID 672
        ' To Draw the date control if editable date control is to be shown
        'If m_UseEditableDateControl = True And CommonFunctions.General.IsClientBrowserIE = True Then
        If m_UseEditableDateControl = True Then
            CommonFunction.HTMLControls.DrawDateControl("txtStartDate", "txtStartDate", , 100, , , "frmTaskDetails", DisplayNone:=True)

            CommonFunction.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , 100, , , "frmTaskDetails", DisplayNone:=True)
        Else
            'Added By VarunA on 24-Sep-2008 IssueID-22519
            'Purpose : To have start date & end date with out trucation in (Mozilla)
            'CommonFunction.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", , 100, 10, , , , , True, , , , , , , , True)
            'CommonFunction.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", , 100, 10, , , , , True, , , , , , , , True)

            '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
            CommonFunction.HTMLControls.DrawTextBox("txtStartDate", "txtStartDate", , 100, 12, , , , , True, , , , , , , , True, EnableHTMLEncode:=True)
            CommonFunction.HTMLControls.DrawTextBox("txtEndDate", "txtEndDate", , 100, 12, , , , , True, , , , , , , , True, EnableHTMLEncode:=True)
            '''End of Modification by Dhanashri S on 7 Oct 2015

            'End By VarunA on 24-Sep-2008 IssueID-22519
        End If

        ' End Modification By NitinVS on 3 Dec 2005 for WhizibleSEM SP5 For The Editable Date Control Problem IssueID 672

        General.WriteHTML(HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendar", " style='Display: none; CURSOR: hand;'", "javascript:Calender_OnClick()", , , "Click to open calendar", True))
        '*************************************************************************************************
        General.WriteHTML("</TD>")

        'display append link
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"

        General.WriteHTML("<TD align='left'>")
        objLink.LinkName = MyBase.GetResourceString("LINK_APPEND")
        objLink.Tooltip = MyBase.GetResourceString("LINK_APPEND_TOOLTIP")
        objLink.FunctionName = "Append_OnClick()"
        General.WriteHTML("| <B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_BRACKET_OPEN")
        objLink.Tooltip = MyBase.GetResourceString("LINK_BRACKET_OPEN_TOOLTIP")
        objLink.FunctionName = "Bracket_OnClick('(')"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_BRACKET_CLOSE")
        objLink.Tooltip = MyBase.GetResourceString("LINK_BRACKET_CLOSE_TOOLTIP")
        objLink.FunctionName = "Bracket_OnClick(')')"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_AND")
        objLink.Tooltip = MyBase.GetResourceString("LINK_AND_TOOLTIP")
        objLink.FunctionName = "Operator_OnClick('AND')"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_OR")
        objLink.Tooltip = MyBase.GetResourceString("LINK_OR_TOOLTIP")
        objLink.FunctionName = "Operator_OnClick('OR')"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        'plot the query text box
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD colspan=5 align='left'>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML(HTMLControls.DrawTextArea("txtQueryText", "txtQueryText", , , , "frmTaskDetails", , , 870, 100, , m_strWhereClause.Trim, , , , True, , , , True) + "")
        General.WriteHTML(HTMLControls.DrawTextArea("txtQueryText", "txtQueryText", , , , "frmTaskDetails", , , 870, 100, , m_strWhereClause.Trim, , , , True, , , , True, EnableHTMLEncode:=True) + "")
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")
        'plot the lower links for execute, redo,undo,clear
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD colspan=4 align='left'></TD>")
        General.WriteHTML("<TD align='left'>")
        objLink.LinkName = MyBase.GetResourceString("LINK_EXECUTE")
        objLink.Tooltip = MyBase.GetResourceString("LINK_EXECUTE_TOOLTIP")
        objLink.FunctionName = "Execute_OnClick()"
        General.WriteHTML("| <B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_REDO")
        objLink.Tooltip = MyBase.GetResourceString("LINK_REDO_TOOLTIP")
        objLink.FunctionName = "Redo_OnClick()"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_UNDO")
        objLink.Tooltip = MyBase.GetResourceString("LINK_UNDO_TOOLTIP")
        objLink.FunctionName = "Undo_OnClick()"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
        objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
        objLink.FunctionName = "Clear_OnClick()"
        General.WriteHTML("<B>" + objLink.GetDynamicLink() + "</B> | ")
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")
        General.WriteHTML("<BR>")

        'get the record count for column for which value is not set
        'these counts will be displayed infront of column name caption as links
        intTaskTypeCount = getRecordCountForColumn("ModuleName")
        intPhaseCount = getRecordCountForColumn("Phase")
        intModuleCount = getRecordCountForColumn("Module")
        intSubProjectCount = getRecordCountForColumn("SubProject")
        intMilestoneCount = getRecordCountForColumn("Milestone")
        intFeatureCount = getRecordCountForColumn("ProjectFeatureID")
        'Intigrated by HarshK for sp4 issueid 200
        intDeliverableCount = getRecordCountForColumn("DeliverableID")
        'End Intigrated by HarshK for sp4 issueid 200
        'count the total no of combo boxes to be shown 

        'count the total no of combo boxes to be shown 
        Dim intFirstRowColumnCnt As Integer
        Dim intSecondRowColumnCnt As Integer
        Dim intColPlotted As Integer

        intFirstRowColumnCnt = 1

        If m_blnShowPhase = True Then intFirstRowColumnCnt += 1
        If m_blnShowModule = True Then intFirstRowColumnCnt += 1
        If m_blnShowSubProject = True Then intSecondRowColumnCnt += 1
        If m_blnShowMilestone = True Then intSecondRowColumnCnt += 1
        If m_blnShowFeatures = True Then intSecondRowColumnCnt += 1

        General.WriteHTML("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0 >")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' colspan=6 >")
        General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_MAP_TASK") + "</B></TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTREven'>")
        intColPlotted = 0

        'display task Type column combo box
        intColPlotted = 1
        objLink.LinkName = " (" + intTaskTypeCount.ToString + ") "
        objLink.FunctionName = "Count_OnClick('ModuleName')"

        'Modified Resource String for issueID-15430
        objLink.Tooltip = MyBase.GetResourceString("LINK_COUNT_TASKTYPE_TOOLTIP") + ""
        General.WriteHTML("<TD align='right' nowrap>" + MyBase.GetResourceString("CAP_TASK_TYPE") + "&nbsp;")
        General.WriteHTML(objLink.GetDynamicLink() + "&nbsp;&nbsp;")
        General.WriteHTML("</TD><TD align='left' nowrap>")
        'strSQL = "usp_sel_tbl_PM_Project_TaskTypes_Names " + m_strProjectID.Trim   --Commented by JayavantK On 21-Oct-2004. IssueID=13561
        strSQL = "usp_sel_tbl_PM_Project_TaskTypes_Names_New " + m_strProjectID.Trim
        'Modified By VidyaJ for Nuclus issue ID - 19314 
        'Increase width of combo
        'modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05

        'Modified By nitinVS on 23 Mar 2007 for WhizibleSEM SP 8 regression Issue 11968 
        ' Not to allow changeing task type for case 3 project 
        'Dim IsCaseThreeProject As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(" SELECT ProjectID FROM Tbl_PM_Project WHERE ProjectID = " + m_strProjectID + " AND HaveSubTaskTypes =1 AND ApplyEffortDistribution =1 ", MyBase.UseSQL), ""), String)
        Dim IsCaseThreeProject As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(" usp_sel_Tbl_PM_Project_HaveSubTaskTypes_ApplyEffortDistribution " + m_strProjectID, MyBase.UseSQL), ""), String)

        If IsCaseThreeProject <> "" Then
            General.WriteHTML(HTMLControls.DrawComboBox("cboColTaskType", strSQL, 275, m_strTaskType.Trim, " disabled ", True, True) + "&nbsp;")
        Else

            General.WriteHTML(HTMLControls.DrawComboBox("cboColTaskType", strSQL, 275, m_strTaskType.Trim, m_strDisableTaskType, True, True) + "&nbsp;")
            If m_strDisableTaskType = "" Then
                General.WriteHTML("<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:ImgButton_OnClick(""TASKTYPE"")'>&nbsp;")
            End If

        End If

        'End Modification By NitinVS on 23 Mar 2007 for WhizibleSEM SP 8 regression Issue 11968


        'End modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
        'End Of Modification

        'Modified BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 
        ' Clear link not to be shown for TaskType
        'If m_objAccessRights.Edit = True Then
        '    objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
        '    objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
        '    objLink.FunctionName = "ColumnClear_OnClick('ModuleName')"
        '    General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | &nbsp;")
        'End If

        'End Modification BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 

        General.WriteHTML("</TD>")

        If m_blnShowPhase = True Then
            'display Phase column combo box
            intColPlotted += 1
            objLink.LinkName = " (" + intPhaseCount.ToString + ") "
            objLink.FunctionName = "Count_OnClick('Phase')"
            objLink.Tooltip = MyBase.GetResourceString("LINK_COUNT_PHASE_TOOLTIP") + ""
            General.WriteHTML("<TD align='right' nowrap>" + MyBase.GetResourceString("CAP_PHASE") + "&nbsp;")
            General.WriteHTML(objLink.GetDynamicLink() + "&nbsp;&nbsp;")
            General.WriteHTML("</TD><TD align='left' nowrap>")
            strSQL = "Usp_Sel_tbl_IB_Project_Phases " + m_strProjectID + ",null,0,'T'"
            'Modified By VidyaJ for Nuclus issue ID - 19314 
            'Increase width of combo
            'modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
            General.WriteHTML(HTMLControls.DrawComboBox("cboColPhase", strSQL, 275, m_strPhase.Trim, m_strDisablePhase, True, True) + "&nbsp;")
            If m_strDisablePhase = "" Then
                General.WriteHTML("<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:ImgButton_OnClick(""PHASE"")'>&nbsp;")
            End If
            'End modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
            'End Of Modification

            'Modified BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 
            If m_objAccessRights.Edit = True Then

                objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
                objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
                objLink.FunctionName = "ColumnClear_OnClick('Phase')"
                General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | &nbsp;")

            End If

            'End Modification BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 

            General.WriteHTML("</TD>")
        End If

        Dim i As Integer
        'Modified By VidyaJ for Nuclus issue ID - 19314 
        'Plot 2 combo's in a line
        'For i = 1 To (2 - intColPlotted)
        'End Of Modification
        'General.WriteHTML("<TD width=15% ></TD><TD width=15% ></TD>")
        'Next
        If intColPlotted Mod 2 = 0 Then
            General.WriteHTML("</TR>")
            General.WriteHTML("<TR class='clsTREven'>")
        End If
        'End

        If m_blnShowModule = True Then
            'display Module column combo box
            intColPlotted += 1
            objLink.LinkName = " (" + intModuleCount.ToString + ") "
            objLink.FunctionName = "Count_OnClick('Module')"
            objLink.Tooltip = MyBase.GetResourceString("LINK_COUNT_MODULE_TOOLTIP") + ""
            General.WriteHTML("<TD align='right' nowrap>" + MyBase.GetResourceString("CAP_MODULE") + "&nbsp;")
            General.WriteHTML(objLink.GetDynamicLink() + "&nbsp;&nbsp;")
            General.WriteHTML("</TD><TD align='left' nowrap>")
            strSQL = "Usp_Sel_tbl_PM_Module " + m_strProjectID + ",NULL,'T'"
            'Modified By VidyaJ for Nuclus issue ID - 19314 
            'Increase width of combo
            'modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
            General.WriteHTML(HTMLControls.DrawComboBox("cboColModule", strSQL, 275, m_strModule, m_strDisableModule, True, True) + "&nbsp;")
            If m_strDisableModule = "" Then
                General.WriteHTML("<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:ImgButton_OnClick(""MODULE"")'>&nbsp;")
            End If
            'End modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
            'End

            'Modified BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 
            If m_objAccessRights.Edit = True Then

                objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
                objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
                objLink.FunctionName = "ColumnClear_OnClick('Module')"
                General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | &nbsp;")


            End If

            'End Modification BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 

            General.WriteHTML("</TD>")
        End If
        'Modified By VidyaJ for Nuclus issue ID - 19314 
        If intColPlotted Mod 2 = 0 Then
            General.WriteHTML("</TR>")
            General.WriteHTML("<TR class='clsTREven'>")
        End If
        'End

        If intSecondRowColumnCnt > 0 Then
            'Commented By VidyaJ for Nuclus issue ID - 19314 
            ' General.WriteHTML("<TR class='clsTREven'>")
            'intColPlotted = 0

            If m_blnShowSubProject = True Then
                'display sub project column combo box
                intColPlotted += 1
                objLink.LinkName = " (" + intSubProjectCount.ToString + ") "
                objLink.FunctionName = "Count_OnClick('SubProject')"
                objLink.Tooltip = MyBase.GetResourceString("LINK_COUNT_SUBPROJECT_TOOLTIP") + ""
                General.WriteHTML("<TD align='right' nowrap>" + MyBase.GetResourceString("CAP_SUBPROJECT") + "&nbsp;")
                General.WriteHTML(objLink.GetDynamicLink() + "&nbsp;&nbsp;")
                General.WriteHTML("</TD><TD align='left' nowrap>")
                strSQL = "usp_Sel_tbl_PM_SubProject " + m_strProjectID
                'Modified By VidyaJ for Nuclus issue ID - 19314 
                'Increase width of combo
                'modify and added by harshk for sp4 issueid 200 (popup page) on 14/09/05
                General.WriteHTML(HTMLControls.DrawComboBox("cboColSubProject", strSQL, 275, m_strSubProject.Trim, m_strDisableSubProject, True, True) + "&nbsp;")
                If m_strDisableSubProject = "" Then
                    General.WriteHTML("<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:ImgButton_OnClick(""SUBPROJECT"")'>&nbsp;")
                End If
                'End modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
                'End
                'display clear link

                'Modified BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 
                If m_objAccessRights.Edit = True Then


                    objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
                    objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
                    objLink.FunctionName = "ColumnClear_OnClick('SubProject')"
                    General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | &nbsp;")


                End If

                'End Modification BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 

                General.WriteHTML("</TD>")
            End If

            'Modified By VidyaJ for Nuclus issue ID - 19314 
            If intColPlotted Mod 2 = 0 Then
                General.WriteHTML("</TR>")
                General.WriteHTML("<TR class='clsTREven'>")
            End If
            'End

            If m_blnShowMilestone = True Then
                'display Milestone column combo box
                intColPlotted += 1
                objLink.LinkName = " (" + intMilestoneCount.ToString + ") "
                objLink.FunctionName = "Count_OnClick('Milestone')"
                objLink.Tooltip = MyBase.GetResourceString("LINK_COUNT_MILESTONE_TOOLTIP") + ""
                General.WriteHTML("<TD align='right' nowrap>" + MyBase.GetResourceString("CAP_MILESTONE") + "&nbsp;")
                General.WriteHTML(objLink.GetDynamicLink() + "&nbsp;&nbsp;")
                General.WriteHTML("</TD><TD align='left' nowrap>")
                strSQL = "usp_Sel_tbl_PM_Milestones " + m_strProjectID
                'Modified By VidyaJ for Nuclus issue ID - 19314 
                'Increase width of combo
                ''modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
                General.WriteHTML(HTMLControls.DrawComboBox("cboColMilestone", strSQL, 275, m_strMilestone, m_strDisableMilestone, True, True) + "&nbsp;")
                If m_strDisableMilestone = "" Then
                    General.WriteHTML("<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:ImgButton_OnClick(""MILESTONE"")'>&nbsp;")
                End If
                'End modify and added by harshk for sp4 issueid 200(popup page) on 14/09/05
                'End
                'display clear link

                'Modified BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 
                If m_objAccessRights.Edit = True Then


                    objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
                    objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
                    objLink.FunctionName = "ColumnClear_OnClick('Milestone')"
                    General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | &nbsp;")

                End If

                'End Modification BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 

                General.WriteHTML("</TD>")
            End If

            'Modified By VidyaJ for Nuclus issue ID - 19314 
            If intColPlotted Mod 2 = 0 Then
                General.WriteHTML("</TR>")
                General.WriteHTML("<TR class='clsTREven'>")
            End If
            'End

            If m_blnShowFeatures = True Then
                'display Milestone column combo box
                intColPlotted += 1
                objLink.LinkName = " (" + intFeatureCount.ToString + ") "
                objLink.FunctionName = "Count_OnClick('ProjectFeatureID')"
                objLink.Tooltip = MyBase.GetResourceString("LINK_COUNT_FEATURE_TOOLTIP") + ""
                General.WriteHTML("<TD align='right' nowrap>" + MyBase.GetResourceString("CAP_FEATURES") + "&nbsp;")
                General.WriteHTML(objLink.GetDynamicLink() + "&nbsp;&nbsp;")
                General.WriteHTML("</TD><TD align='left' nowrap>")
                strSQL = "usp_Sel_tbl_PM_Project_Features NULL," + m_strProjectID
                'Modified By VidyaJ for Nuclus issue ID - 19314 
                'Increase width of combo
                'modify and added by harshk for sp4 issueid 200(popup page)
                General.WriteHTML(HTMLControls.DrawComboBox("cboColFeature", strSQL, 275, m_strFeatures, m_strDisableFeatures, True, True) + "&nbsp;")
                If m_strDisableFeatures = "" Then
                    General.WriteHTML("<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:ImgButton_OnClick(""FEATURE"")'>&nbsp;")
                End If
                'END 'modify and added by harshk for sp4 issueid 200(popup page)
                'End

                'display clear link
                'Modified BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 
                If m_objAccessRights.Edit = True Then

                    objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
                    objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
                    objLink.FunctionName = "ColumnClear_OnClick('ProjectFeatureID')"
                    General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | &nbsp;")

                End If

                'End Modification BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 

                General.WriteHTML("</TD>")
            End If
            'Intigrated by harshK for sp4 issueid 200
            If intColPlotted Mod 2 = 0 Then
                General.WriteHTML("</TR>")
                General.WriteHTML("<TR class='clsTREven'>")
            End If
            'display Deliverable column combo box
            intColPlotted += 1
            objLink.LinkName = " (" + intDeliverableCount.ToString + ") "
            objLink.FunctionName = "Count_OnClick('DeliverableID')"
            objLink.Tooltip = MyBase.GetResourceString("LINK_COUNT_DELIVERABLE_TOOLTIP") + ""
            General.WriteHTML("<TD align='left' nowrap>" + MyBase.GetResourceString("CAP_DELIVERABLES") + "&nbsp;")
            General.WriteHTML(objLink.GetDynamicLink() + "&nbsp;")
            General.WriteHTML("</TD><TD align='left' nowrap>")
            strSQL = " usp_Sel_tbl_PM_OtherSchedule " & Session("intProjectID").ToString
            General.WriteHTML(HTMLControls.DrawComboBox("cboColDeliverable", strSQL, 275, m_strDeliverable, m_strDisableDeliverable, True, True) + "&nbsp;")
            If m_strDisableDeliverable = "" Then
                General.WriteHTML("<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:ImgButton_OnClick(""DELIVERABLE"")'>&nbsp;")
            End If
            'display clear link
            'Modified BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 
            If m_objAccessRights.Edit = True Then

                objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR")
                objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP")
                objLink.FunctionName = "ColumnClear_OnClick('DeliverableID')"
                General.WriteHTML(" | <B>" + objLink.GetDynamicLink() + "</B> | &nbsp;")

            End If

            'End Modification BY NitinVS on 22 Mar 2006 for WhizibleSEM SSP 8 Regression Issue 11944 

            General.WriteHTML("</TD>")
            'End Intigrated by harshK for sp4 issueid 200
            If intColPlotted Mod 2 <> 0 Then
                General.WriteHTML("<TD ></TD>")
                General.WriteHTML("<TD ></TD>")
            End If

            General.WriteHTML("</TR>")
            'End Of Modifications
        End If

        General.WriteHTML("</Table>")
        objLink = Nothing
        General.WriteHTML("<BR>")

        'plot the grid here 
        'Added by HarshK for sp4 issueid 200
        General.WriteHTML("<DIV style='Overflow:auto;height:147;width:100%;'>")
        Call plotGrid(intGridRowCount)
        General.WriteHTML("</DIV >")
        'End Added by HarshK for sp4 issueid 200
        'display table row count at the footer
        General.WriteHTML("<BR>")
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 ><TR class='clsTREven'><TD align='right'>" + MyBase.GetResourceString("ROW_COUNT") + " : " + intGridRowCount.ToString + "</TD></TR></Table>")

        'keep all the values in the hidden controls

        '''Modified by Dhanashri S on 7 Oct 2015  Purpose:HTML Encode
        CommonFunctions.HTMLControls.DrawTextBox("txtRecordCount", "txtRecordCount", , , , intGridRowCount.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtColumnName", "txtColumnName", , , , m_strColumnName.Trim.Trim, , , , , , True, EnableHTMLEncode:=True)
        '''End of Modification by Dhanashri S on 7 Oct 2015

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid for the SP created in the pageInit in m_strSQL 
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 21 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotGrid(ByRef intRowCount As Integer)
        Dim arrlstColHeader As Collections.ArrayList
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstRowLink As Collections.ArrayList
        Dim arrlstTDStyle As Collections.ArrayList
        Dim arrlstCheckBox As Collections.ArrayList
        Dim intNoOfCol As Integer

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        arrlstColHeader = New Collections.ArrayList
        arrlstAN = New Collections.ArrayList
        arrlstRowLink = New Collections.ArrayList
        arrlstTDStyle = New Collections.ArrayList
        arrlstCheckBox = New Collections.ArrayList

        If m_strMode = CONST_MODE_COUNT Then
            'only task name column is present in the count click mode
            arrlstColHeader.Add(MyBase.GetResourceString("COL_TASK_NAME"))
            arrlstAN.Add("TaskName")
            arrlstRowLink.Add("Task_OnClick(TaskID)")
            arrlstTDStyle.Add("align='left'")
            arrlstCheckBox.Add("")
            intNoOfCol = 1
        Else
            m_strColumnName = ""

            'Task Name and Type column are always present in the query execute mode
            arrlstColHeader.Add(MyBase.GetResourceString("COL_TASK_NAME")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_TASK_TYPE"))
            arrlstAN.Add("TaskName") : arrlstAN.Add("ModuleName")
            arrlstRowLink.Add("Task_OnClick(TaskID)") : arrlstRowLink.Add("")
            arrlstCheckBox.Add("") : arrlstCheckBox.Add("")
            arrlstTDStyle.Add("align='left'") : arrlstTDStyle.Add("align='left'")
            intNoOfCol = 2
            'set the columns of the grid if the flag for that column is true
            If m_blnShowPhase = True Then
                arrlstColHeader.Add(MyBase.GetResourceString("COL_PAHSE"))
                arrlstAN.Add("Phase")
                arrlstRowLink.Add("")
                arrlstTDStyle.Add("align='left'")
                arrlstCheckBox.Add("")
                intNoOfCol += 1
            End If
            If m_blnShowModule = True Then
                arrlstColHeader.Add(MyBase.GetResourceString("COL_MODULE"))
                arrlstAN.Add("Module")
                arrlstRowLink.Add("")
                arrlstTDStyle.Add("align='left'")
                arrlstCheckBox.Add("")
                intNoOfCol += 1
            End If
            If m_blnShowSubProject = True Then
                arrlstColHeader.Add(MyBase.GetResourceString("COL_SUBPROJECT"))
                arrlstAN.Add("SubProject")
                arrlstRowLink.Add("")
                arrlstTDStyle.Add("align='left'")
                arrlstCheckBox.Add("")
                intNoOfCol += 1
            End If
            If m_blnShowMilestone = True Then
                arrlstColHeader.Add(MyBase.GetResourceString("COL_MILESTONE"))
                arrlstAN.Add("Milestone")
                arrlstRowLink.Add("")
                arrlstTDStyle.Add("align='left'")
                arrlstCheckBox.Add("")
                intNoOfCol += 1
            End If
            If m_blnShowFeatures = True Then
                arrlstColHeader.Add(MyBase.GetResourceString("COL_FEATURE"))
                arrlstAN.Add("FeatureName")
                arrlstRowLink.Add("")
                arrlstTDStyle.Add("align='left'")
                arrlstCheckBox.Add("")
                intNoOfCol += 1
            End If
            'Intigrated by HarshK for sp4 issueid 200
            arrlstColHeader.Add("Deliverable")
            arrlstAN.Add("DeliverableName")
            arrlstRowLink.Add("")
            arrlstTDStyle.Add("align='left'")
            arrlstCheckBox.Add("")
            intNoOfCol += 1
            'End Intigrated by HarshK for sp4 issueid 200
        End If


        'apply check box column is always present in both mode
        arrlstColHeader.Add(MyBase.GetResourceString("COL_APPLY"))
        arrlstAN.Add("")
        arrlstRowLink.Add("")
        arrlstTDStyle.Add("align='center'")
        arrlstCheckBox.Add("chkApply")

        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String
        Dim arrCheckBox(arrlstCheckBox.Count) As String
        Dim arrTDStyle(arrlstTDStyle.Count) As String

        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)
        arrlstCheckBox.CopyTo(arrCheckBox)
        arrlstTDStyle.CopyTo(arrTDStyle)

        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing
        arrlstTDStyle = Nothing
        arrlstCheckBox = Nothing

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.TDStyleArray = arrTDStyle
        objGrid.PrimaryKey = "TaskID"
        objGrid.ClientSideSortFunctionName = "Sort_OnClick"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 300
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = intNoOfCol
        objGrid.SortOrder = m_strSortOrder
        objGrid.SortBy = m_strOrderBy
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = m_strSQLQuery
        objGrid.UseSQL = MyBase.UseSQL
        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        ''End of Addition by Dhanashri S on 7 Oct 2015

        'plot the grid 
        objGrid.DrawGrid()
        intRowCount = objGrid.NoOfRows
        objGrid = Nothing

    End Sub

    '=====================================================================
    ' Procedure Name		:	performAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To perform the action based on the action specified
    ' Description			:	This procedure will update the database for the tasks based on the action 
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 23 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction()
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strTaskIDList As String
        Dim strSET As String
        Dim blnAddQuama As Boolean
        Dim strColumnValue As String
        'Added By JayavantK On 21-Oct-2004. IssueID=13561
        Dim strQuery As String = ""
        'End Addition

        'get the quama seperated list of Task id selected 
        strTaskIDList = MyBase.GetFormValue("chkApply") + ""

        Select Case m_strAction
            Case CONST_ACTION_CLEAR
                'update the database to set the value of the column selected to NULL 
                'for the selected task ids
                strSQL = "usp_upd_tbl_PM_ProjectTasks_SetMapping " + m_strProjectID.Trim + ",'" + m_strColumnName.Trim + "','" + strTaskIDList.Trim + "','NULL'"
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            Case CONST_ACTION_SAVE

                Select Case m_strMode
                    Case CONST_MODE_COUNT

                        Select Case m_strColumnName.ToUpper.Trim
                            Case "PHASE"
                                strColumnValue = m_strPhase.Replace("+", "")
                                strSET = " Set PhaseID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                                strSET += " Phase='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"

                            Case "MODULENAME"
                                strColumnValue = m_strTaskType.Replace("+", "")
                                'Added By JayavantK On 21-Oct-2004. IssueID=13561
                                strSET = " Set TaskTypeID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                                strSET += " ModuleName='" + CommonFunction.General.BuildQueryString(strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1))) + "'"
                                'End Addition
                                'strSET = " Set ModuleName='" + strColumnValue.Trim + "'"   -- Commented By JayavantK On 21-Oct-2004. IssueID=13561.

                            Case "MODULE"
                                strColumnValue = m_strModule.Replace("+", "")
                                strSET = " Set ModuleID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                                strSET += " Module='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"

                            Case "SUBPROJECT"
                                strColumnValue = m_strSubProject.Replace("+", "")
                                strSET = " Set SubProjectID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                                strSET += " Subproject='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"

                            Case "MILESTONE"
                                strColumnValue = m_strMilestone.Replace("+", "")
                                strSET = " Set MilestoneID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                                strSET += " Milestone='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"

                            Case "PROJECTFEATUREID"
                                strColumnValue = m_strFeatures.Replace("+", "")
                                strSET = " set ProjectFeatureID=" + strColumnValue.Trim
                                'Intigrated by HarshK for sp4 issueid 200
                            Case "DELIVERABLEID"
                                strColumnValue = m_strDeliverable.Replace("+", "")
                                strSET = " Set DeliverableID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|"))
                                'end Intigrated by HarshK for sp4 issueid 200

                        End Select

                    Case CONST_MODE_QUERY
                        strSET = " Set "
                        blnAddQuama = False

                        If m_strPhase <> "" Then
                            strColumnValue = m_strPhase.Replace("+", "")
                            strSET += " PhaseID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                            strSET += " Phase='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"
                            blnAddQuama = True
                        End If

                        'Commented By JayavantK On 21-Oct-2004. IssueID=13561.
                        'If m_strTaskType <> "" Then
                        '    If blnAddQuama = True Then strSET += " ,"
                        '    strColumnValue = m_strTaskType.Replace("+", "")
                        '    strSET += " ModuleName='" + strColumnValue.Trim + "'"
                        '    blnAddQuama = True
                        'End If
                        'Added By JayavantK On 21-Oct-2004. IssueID=13561
                        If m_strTaskType <> "" Then
                            strColumnValue = m_strTaskType.Replace("+", "")
                            ''Commented And Modified By AmitJ For Comsoft IssueId  3926
                            Dim strTaskTypeId As String
                            Dim strModuleName As String
                            strTaskTypeId = strColumnValue.Substring(0, strColumnValue.IndexOf("|"))
                            strModuleName = CommonFunction.General.BuildQueryString(strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)))
                            strQuery = "usp_UPD_tbl_PM_ProjectTasks_TaskManagement " + strTaskTypeId.Trim + ",'" + strModuleName.Trim + "','" + strTaskIDList.Trim + "'"

                            'strQuery = "UPDATE tbl_PM_ProjectTasks "
                            'strQuery += " SET TaskTypeID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                            'strQuery += " ModuleName='" + CommonFunction.General.BuildQueryString(strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1))) + "'"
                            'strQuery += " WHERE IsActive = 1 AND TaskID IN (" + strTaskIDList.Trim + ") AND "
                            'strQuery += " TaskID NOT IN (SELECT ParentTask_UID FROM tbl_PM_ProjectTasks WHERE IsActive=1 "
                            'strQuery += " AND ParentTask_UID IN (" + strTaskIDList.Trim + ") "
                            'strQuery += " GROUP BY ParentTask_UID HAVING Count(TaskID) > 0)"
                            'End of Modifications By AmtiJ
                            Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                        End If
                        'End Addition

                        If m_strModule <> "" Then
                            If blnAddQuama = True Then strSET += " ,"
                            strColumnValue = m_strModule.Replace("+", "")
                            strSET += " ModuleID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                            strSET += " Module='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"
                            blnAddQuama = True
                        End If
                        If m_strSubProject <> "" Then
                            If blnAddQuama = True Then strSET += " ,"
                            strColumnValue = m_strSubProject.Replace("+", "")
                            strSET += " SubProjectID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                            strSET += " Subproject='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"
                            blnAddQuama = True
                        End If
                        If m_strMilestone <> "" Then
                            If blnAddQuama = True Then strSET += " ,"
                            strColumnValue = m_strMilestone.Replace("+", "")
                            strSET += " MilestoneID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|")) + ","
                            strSET += " Milestone='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"
                            blnAddQuama = True
                        End If
                        If m_strFeatures <> "" Then
                            If blnAddQuama = True Then strSET += " ,"
                            strColumnValue = m_strFeatures.Replace("+", "")
                            'strSET += " ProjectFeatureID=" + strColumnValue.Trim

                            'Modified by MrugajaB on 8th April,2006 for resolving page crash on mapping Feature
                            'Intigrated by HarshK for sp4 issueid 200
                            If strColumnValue.IndexOf("|") = -1 Then
                                strSET += " ProjectFeatureID=" + strColumnValue
                            Else
                                strSET += " ProjectFeatureID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|"))   '+ ","
                                'strSET += " FeatureName='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"
                            End If
                            'Intigrated by HarshK for sp4 issueid 200
                            'strSET += " ProjectFeatureID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|"))   '+ ","
                            'End Modification

                            'strSET += " FeatureName='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"
                            blnAddQuama = True
                            'End Intigrated by HarshK for sp4 issueid 200
                        End If

                        'Intigrated by HarshK for sp4 issueid 200
                        If m_strDeliverable <> "" Then
                            If blnAddQuama = True Then strSET += " ,"
                            strColumnValue = m_strDeliverable.Replace("+", "")

                            strSET += " DeliverableID=" + strColumnValue.Substring(0, strColumnValue.IndexOf("|"))  ' + ","
                            'strSET += " DeliverableName='" + strColumnValue.Substring(strColumnValue.IndexOf("|") + 1, strColumnValue.Length - (strColumnValue.IndexOf("|") + 1)) + "'"
                            'Modified By nitinVS on 23 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12275
                            ' To Update DevliverableTypeID along with DeliverableID 
                            'strSET += " , DeliverableTypeID = " + CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ScheduleTypeID FROM tbl_PM_OtherSchedules WHERE ScheduleID = " + strColumnValue.Substring(0, strColumnValue.IndexOf("|")), MyBase.UseSQL), "0"), String)
                            strSET += " , DeliverableTypeID = " + CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_OtherSchedules_ScheduleTypeID " + strColumnValue.Substring(0, strColumnValue.IndexOf("|")), MyBase.UseSQL), "0"), String)
                            ' End Modification By nitinVS on 23 Apr 2007 for WhizibleSEM SP 8 Regression Fixes 12275
                            blnAddQuama = True
                        End If
                        'End Intigrated by HarshK for sp4 issueid 200

                End Select

                If strSET.Trim <> "" And strSET.Trim.ToUpper <> "SET" Then   'Added By JayavantK On 21-Oct-2004. IssueID=13561.
                    'create the update query with the set and column name and value string prepared above
                    strSQL = "UPDATE tbl_PM_ProjectTasks " + strSET + " WHERE TaskID IN (" + strTaskIDList.Trim + ")"
                    'Added By JayavantK On 17-Aug-2004 - Update the child tasks also.
                    'Modified By VidyaJ - For IssueID - 313 - SP4
                    'Update Active as well as inactive tasks
                    'strSQL &= " OR (IsActive = 1 AND ParentTask_UID IN (" + strTaskIDList.Trim + "))"
                    strSQL &= " OR ( ParentTask_UID IN (" + strTaskIDList.Trim + "))"
                    'End Addition 
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If                                  'Added By JayavantK On 21-Oct-2004. IssueID=13561.
        End Select
    End Sub

    '=====================================================================
    ' Procedure Name		:	getRecordCountForColumn
    ' Parameters Passed		:	strColumnName - String 
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To get the record count for which the column passed is not set
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 21 2004
    ' Revisions				:	
    '=====================================================================
    Private Function getRecordCountForColumn(ByVal strColumnName As String) As Integer
        Dim strSQL As String
        Dim intRecordCount As Integer

        strSQL = "usp_Sel_tbl_PM_ProjectTasks_TaskDetails " + m_strProjectID.Trim + ",'" + strColumnName.Trim + "','TaskName','ASC','-1','C'"
        intRecordCount = CType(Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), Integer)
        getRecordCountForColumn = intRecordCount

    End Function

    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColumnName = MyBase.GetResourceString("COL_APPLY") Then
            Args.IsCheckBoxChecked = True
        End If
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
End Class
