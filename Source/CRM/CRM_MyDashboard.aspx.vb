Imports System.Text

Public Class CRM_MyDashboard
    Inherits WebPages.Template.WhizTemplate

    Private m_strAction As String = ""
    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    Private m_blnIsDefaultMode As Boolean = False

    Protected m_strSortBy As String
    Protected m_strSortOrder As String
    Protected m_intPageNumber As Integer = 1
    Protected m_strClientSideScript As String
    Protected tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
    Protected divGraphs As System.Web.UI.HtmlControls.HtmlControl
    Protected m_strMenu As String
    Protected m_intNoOfRows As Integer
    Protected blnIsHRM As Int32 = 0

    Private m_blnShowOtherGraphs As Boolean = True
    Private m_blnShowGrid As Boolean = True
    Private m_lngStatusID As Long = 0
    Private m_lngFilterID As Long = 0
    Private m_lngLocationID As Long = 0
    Private m_lngDepartmentID As Long = 0

    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Private WithEvents m_objSectionTitle As New WebPage.Templates.SectionTitle

    ' Added By NitinVS on 26 July 2005 for PSPL 
    Private m_intTotalNoOfRows As Integer
    Private m_blnShowAssignTaskInHelpDesk As Boolean
    ' End Addition By NitinVS on 26 July 2005 for PSPL 

    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197	
    Protected m_PKToken_Go_Behalf_ADD As String
    Protected m_PKToken_Query_DT As String
    Protected m_PKToken_GoOnClick As String
    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	

    'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
    Private m_arrAccessibleDepartments As New Hashtable
    'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
    ' Added BY NitinVs on 13 mar 2007 for WhizibleSEM SP 8 IssueID 11455
    Protected m_blnDashboardAccess As Boolean
    'End Addition BY NitinVs on 13 mar 2007 for WhizibleSEM SP 8 IssueID 11455
    'Integrated by ArchanaN on 27 Apr 2007
    'Added by SriaknthY on 05 Jan 2006 To integrate Flag Tracking screen on MY e-Dashboard list  
    Protected m_FlagStatus As String
    Protected m_Queryid As Integer
    'Integration Ends
    Private m_dsGrid As DataSet

    'Addition by SuchitraP on 30-Aug-2008 
    'Purpose:To Show Publish to KM and WF approvals link only when WF is enabled
    Private strIsActive As Boolean
    Protected m_strMode As String
    'End by SuchitraP
    'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
    'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
    Private intTotalCol As Integer
    Private count As Integer = 1
    Private strClass As String = "clsTROdd"
    Private strAction As String
    Private iterator As Integer = 1
    Private strRequestor As String = ""
    Private strRequestor_ForControl As String = ""
    'Ended by ShraddahM
    'Added by Amit Mahadik on 29 Mar 2011
    Private m_strQueryid As String
    'End Added by Amit Mahadik on 29 Mar 2011

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

        If Not Request.QueryString("Action") Is Nothing And Request.QueryString("Action") <> "" Then
            strAction = Request.QueryString("Action").ToString()
        End If

        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If

    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        '' MyBase.ApplySecurity(False, 2)
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        If Session("strCRM_Filter_MD") Is Nothing Then
            Session("strCRM_Filter_MD") = ""
        End If

        ' Mode of the  page
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode").ToString.ToUpper() = "DB" Then
                Server.Transfer("CRM_Dashboard.aspx", True)
            End If
        End If


        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        ' Sort by of the page
        If Not Request.QueryString("SortBy") Is Nothing Then
            m_strSortBy = Request.QueryString("SortBy").ToString
        Else
            m_strSortBy = "SUBMITTEDDATE"
        End If
        ' Sort order of the page
        If Not Request.QueryString("SortOrder") Is Nothing Then
            m_strSortOrder = Request.QueryString("SortOrder").ToString
        Else
            m_strSortOrder = "DESC"
        End If



        If Trim(MyBase.GetFormValue("cboStatus") & "") <> "" Then
            m_lngStatusID = CType(MyBase.GetFormValue("cboStatus"), Long)
            'Uncommented By ShradddhaM on 25,July 2007
            '//HelpDesk - e-Dashboard-> Filter value does not persist
            'Added By KapilGK on 19 Oct 2006 
        Else
            If Request.QueryString("StatusID") <> "" Then
                m_lngStatusID = CType(Request.QueryString("StatusID"), Long)
            End If
            'End of Addition By KapilGK On 19 Oct 2006
            'End of Uncommented By ShradddhaM on 25,July 2007
        End If

        ' Commented by shraddhaM on 30 Apr 209 Location filter is removed from UI
        'If Trim(MyBase.GetFormValue("cboLocation") & "") <> "" Then
        '    m_lngLocationID = CType(MyBase.GetFormValue("cboLocation"), Long)
        '    'Uncommented By ShradddhaM on 25,July 2007
        '    '//HelpDesk - e-Dashboard-> Filter value does not persist
        '    'Added By KapilGK on 19 Oct 2006 
        'Else
        '    If Request.QueryString("LocationID") <> "" Then
        '        m_lngLocationID = CType(Request.QueryString("LocationID"), Long)
        '    End If
        '    'End of Addition By KapilGK On 19 Oct 2006
        '    'End of Uncommented By ShradddhaM on 25,July 2007
        'End If
        ' End Commented by shraddhaM on 30 Apr 209 Location filter is removed from UI

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        m_blnIsDefaultMode = IsDefaultMode(m_lngEmployeeID)
        m_lngDepartmentID = GetEmployeeDepartment(m_lngEmployeeID)

        'm_blnDashboardAccess variable is intitalize within this method but below
        'm_blnDashboardAccess = CheckDashboardAccess(m_lngEmployeeID)



        If m_lngStatusID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_STATUS" Then
            ' get the default status for the user
            m_lngStatusID = CType(GetDefault(m_lngEmployeeID, "DefaultStatus_MD"), Long)
        End If

        ' Commented by shraddhaM on 30 Apr 209 Location filter is removed from UI
        'If m_lngLocationID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_LOCATION" Then
        '    ' get the default location for the user
        '    m_lngLocationID = CType(GetDefault(m_lngEmployeeID, "DefaultLocation"), Long)
        'End If
        'End Commented by shraddhaM  on 30 Apr 209 Location filter is removed from UI

        If Trim(Session("strCRM_Filter_MD").ToString & "") = "" Then
            'added by harshada d for issue id helpdesk issue id 1936 for retaining the filter on 28 th april 2006
            If Not Request.QueryString("FilterID") Is Nothing Then
                If Request.QueryString("FilterID") <> "" Then
                    m_lngFilterID = CType(Request.QueryString("FilterID"), Long)
                End If

            End If

            'end of addition by harshada d for issue id 1936 on 28 th april 2006
            If Trim(m_lngFilterID & "") = "" And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" Then
                ' get the default filter for the user
                m_lngFilterID = CType(GetDefault(m_lngEmployeeID, "DefaultFilter_MD"), Long)
            End If
        End If

        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        m_PKToken_Go_Behalf_ADD = ""
        m_PKToken_Go_Behalf_ADD = CommonFunctions.Security.Token.GetToken("0" + CType(m_lngEmployeeID, String) + CType(0, String) + CType(0, String))
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

        ' Added By NitinVS on 25 July 2005 To show Assign Task Link conditionaly 
        'm_blnShowAssignTaskInHelpDesk = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ShowAssignTaskInHelpDesk FROM Tbl_PM_CompanyInformation ", MyBase.UseSQL), "0"), "0"), Boolean)
        m_blnShowAssignTaskInHelpDesk = CommonFunction.Application.ShowAssignTaskInHelpDesk
        ' End Addition By NitinVS on  25 July 2005 To show Assign Task Link conditionaly

        'Following Code is commented by PrashantD on 6 Jun 2007 for CleanUp Activity
        ''Added by Manishk on 25th Feb 06 For SP 6 issue
        'Dim dr As IDataReader
        'Dim strSQL As String
        'Dim lngCRMID As Long
        'blnIsHRM = 0

        'strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
        'dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        'If dr.Read Then
        '    lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        'End If

        'If lngCRMID <> 0 Then
        '    blnIsHRM = 1
        'Else
        '    blnIsHRM = 0
        'End If
        '' for department Head 
        'strSQL = "select departmentHeadID FROM tbl_PM_DepartmentMaster where departmentHeadID = " & m_lngEmployeeID
        'dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        'If dr.Read Then
        '    lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("departmentHeadID"), "0"), Long)
        'End If
        'If lngCRMID <> 0 Then
        '    blnIsHRM = 1
        'Else
        '    blnIsHRM = 0
        'End If
        'CommonFunctions.Data.DisposeDataReader(dr)
        'End Added by Manishk on 25th Feb 06 For SP 6 issue
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity

        'Follwing code is from WriteGrid moved here by PrashantD on 6 Jun 2007
        Dim drAccessibleDepartments As IDataReader
        Dim sbAccessibleDepartemnts As New System.Text.StringBuilder
        Dim Counter As Integer = 0
        sbAccessibleDepartemnts.Append("")
        'm_arrAccessibleDepartments 
        sbAccessibleDepartemnts.Append(" SELECT FunctionID FROM tbl_CRM_Function_CRMS Where CRMID = ")
        sbAccessibleDepartemnts.Append(m_lngEmployeeID.ToString)
        sbAccessibleDepartemnts.Append(" Union " + vbCrLf)
        sbAccessibleDepartemnts.Append("select 	DepartmentID from tbl_pm_departmentmaster Where departmentHeadID = ")
        sbAccessibleDepartemnts.Append(m_lngEmployeeID.ToString)
        'Added by PrashantD on 22 Jun 2007 for CleanUp Activity
        sbAccessibleDepartemnts.Append(" UNION Select  ISNULL(DepartmentID, 0)" + vbCrLf)
        sbAccessibleDepartemnts.Append("from tbl_crm_employeeAccess" + vbCrLf)
        sbAccessibleDepartemnts.Append("LEFT JOIN tbl_CRM_employee_Requestor ON tbl_crm_employeeAccess.EmployeeID = tbl_CRM_employee_Requestor.EmployeeID AND CustomerID IS NULL" + vbCrLf)
        sbAccessibleDepartemnts.Append("where tbl_crm_employeeAccess.EmployeeID = " + m_lngEmployeeID.ToString + vbCrLf)
        sbAccessibleDepartemnts.Append("and AllowToSeeDashboard=1")
        'End of addition by PrashantD on 22 Jun 2007 for CleanUp Activity



        drAccessibleDepartments = CommonFunction.Data.GetDataReader(sbAccessibleDepartemnts.ToString, MyBase.UseSQL)
        If drAccessibleDepartments.Read Then
            m_arrAccessibleDepartments(Counter) = CType(CommonFunction.Data.CheckIsDBNull(drAccessibleDepartments("FunctionID"), "0"), Integer)
            Counter += 1
            blnIsHRM = 1
            m_blnDashboardAccess = True
        Else
            m_blnDashboardAccess = False
        End If
        While drAccessibleDepartments.Read
            m_arrAccessibleDepartments(Counter) = CType(CommonFunction.Data.CheckIsDBNull(drAccessibleDepartments("FunctionID"), "0"), Integer)
            Counter += 1
        End While

        CommonFunction.Data.DisposeDataReader(drAccessibleDepartments)
        'end of move by PrashantD on 6 Jun 2007

        'Added by ShraddhaM for Requestor Filter in Whiziblesem8 on 27,Apr 2009

        If Trim(MyBase.GetFormValue("txtRequestor") & "") <> "" Then
            strRequestor = Request.Form("txtRequestor").ToString()
            strRequestor_ForControl = strRequestor
            strRequestor = strRequestor.Replace("''", """")
            strRequestor = strRequestor.Replace("'", "''")
        Else
            strRequestor = ""
            strRequestor_ForControl = ""
        End If

        If strRequestor = "" And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_REQUESTORFILTER" Then
            strRequestor = GetDefault(m_lngEmployeeID, "DefaultRequestorFilter_MD")
            strRequestor_ForControl = strRequestor
            strRequestor = strRequestor.Replace("''", """")
            strRequestor = strRequestor.Replace("'", "''")
        End If
        If strRequestor = "0" Then
            strRequestor = ""
            strRequestor_ForControl = ""
        End If
        'Ended by ShraddhaM


    End Sub
    Private Function CheckDashboardAccess(ByVal EmployeeID As Long) As Boolean
        '=====================================================================
        ' Procedure Name        : funCheckDashboardAccess
        ' Description           : to check the dashboard access of the user
        ' Purpose               : 
        ' Parameters Passed     : EmployeeID
        ' Returns               : true/false
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunctions.Data.GetDataReader("usp_CRM_CheckCRMAccess	" & EmployeeID, m_blnUseSQL)
        If dr.Read Then
            If Trim(dr("Access").ToString & "") = "0" Then
                CheckDashboardAccess = False
            Else
                CheckDashboardAccess = True
            End If
        Else
            CheckDashboardAccess = False
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

    End Function

    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim lngEscalateQueryID As Long

        Select Case UCase(Trim(m_strAction & ""))
            Case "SET_DEFAULT_MODE"
                ' Login type filter added by harshada d on 22 11 2005 for checking the Login Type 
                strSQL = "usp_CRM_SetDefaultMode " & m_lngEmployeeID & ",'MD','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                m_blnIsDefaultMode = True
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "RESET_DEFAULT_MODE"
                ' Login type filter added by harshada d on 22 11 2005 for checking the Login Type 
                strSQL = "usp_CRM_ResetDefaultMode	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "' "
                m_blnIsDefaultMode = False
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)


            Case "SET_DEFAULT_STATUS"
                ' setting the current status as default status
                'Added by TruptiK on 19-Mar-2008
                'Purpose:-Filter problem.
                If Trim(Request.Form("cboFilter") & "") <> "" Then
                    Session("strCRM_Filter_MD") = ""
                    m_lngFilterID = 0
                End If
                'End of addition by TruptiK
                If Trim(Request.Form("cboStatus") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultStatus	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboStatus") & "")) & "','MD'"
                Else
                    strSQL = "usp_CRM_SetDefaultStatus	" & m_lngEmployeeID & ",null,'MD'"
                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "SET_DEFAULT_LOCATION"
                ' set default location
                If Trim(Request.Form("cboLocation") & "") <> "" Then
                    'login Type condition added by harshada d on 22 11 2005 
                    strSQL = "usp_CRM_SetDefaultLocation	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboLocation") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                Else
                    'login Type condition added by harshada d on 22 11 2005 
                    strSQL = "usp_CRM_SetDefaultLocation	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "SET_DEFAULT_FILTER"
                ' set default filter
                If Trim(Request.Form("cboFilter") & "") <> "" Then
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboFilter") & "")) & "','MD','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    m_lngFilterID = CType(MyBase.GetFormValue("cboFilter"), Long)
                Else
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",null,'MD','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    m_lngFilterID = 0

                    Session("strCRM_Filter_MD") = ""

                End If

                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)


            Case "CLEAR_FILTERS"
                Session("strCRM_Filter_MD") = ""
                'Added by ShraddhaM to persist filters on 22,Apr 2009 for Whiziblesem8
                strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",null,'MD','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                m_lngFilterID = 0
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                'Ended by ShraddhaM

            Case "SET_DEFAULT_REQUESTORFILTER"
                ' set default date Filter 
                If Trim(Request.Form("txtRequestor") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultRequestorFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("txtRequestor") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','MD'"
                Else
                    strSQL = "usp_CRM_SetDefaultRequestorFilter	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','MD'"

                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

        End Select

    End Sub


    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for adding report to user Dashboards
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        ' Dim arrCSFunction() As String = {"AssignMultipleRequests_OnClick()", "AssignMultipleTasks_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_DASHBOARD')"}
        'Integrated by ArchanaN on 27 Apr 2007
        'SrikanthY on 05 mar 2007 Added new menuitem ShowReport

        'Comment by SuchitraP on 2-Sept-2008
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        'Dim arrCSFunction() As String = {"AssignMultipleRequests_OnClick()", "AssignMultipleTasks_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "ShowReport_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_MYDASHBOARD')"}

        'Modified by SuchitraP on 30-Aug-2008
        'Purpose:To Show Publish to KM and WF approvals link only when WF is enabled


        '--- Commeented by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
        ''''Call CommonFunction.General.GetWorkflowStatus()
        ''''strIsActive = CommonFunction.Application.IsActive
        '--- End comment purvaj

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "") <> "" Then
            m_strMode = Request.QueryString("Mode")
        ElseIf Not Request.Form("hidMode") Is Nothing Then
            m_strMode = Request.Form("hidMode")
        End If

        '--- Modified by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
        '--- Commeented by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
        ''''If strIsActive = True Then
        ''''    'Modified by ShraddhaM on 9,Sept 2008
        ''''    'Purpose : Added Request Approvals link For Line Manager Approval Functionality
        ''''    Dim arrMenu() As String = {"Request Approvals", "Workflow Approvals", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
        ''''    Dim arrMenuToolTip() As String = {"Request Approvals", "WorkflowApprovals", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        ''''    Dim arrCSFunction() As String = {"RequestApprovals_onClick()", "WorkflowApprovals_OnClick()", "AssignMultipleRequests_OnClick()", "AssignMultipleTasks_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "ShowReport_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_MYDASHBOARD')"}
        ''''    m_objMenu = New WebPage.Templates.StaticMenu
        ''''    m_strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
        ''''Else
        '--- End comment purvaj
        '--- "Request Approvals", "Workflow Approvals" links removed. These pages are now called from the left pane.
        'Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        Dim DeptName As String
        Dim StrSqlDeptName As String
        StrSqlDeptName = "usp_Sel_getDepartmentName " + CType(Session("intUserID"), String)
        DeptName = CommonFunction.General.CheckIsNothing(CType(CommonFunction.Data.GetDataScalar(StrSqlDeptName, True), String), "")

        'End Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        Dim arrMenu() As String = {"FAQs", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
        ''''"Request Approvals",
        Dim arrMenuToolTip() As String = {"Frequently Asked Questions", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        ''''"Request Approvals",
        Dim arrCSFunction() As String = {"Faq_OnClick('DB'," + CType(Session("intUserID"), String) + ",'" + DeptName + "')", "AssignMultipleRequests_OnClick()", "AssignMultipleTasks_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "ShowReport_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_MYDASHBOARD')"}
        'End Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        ''''"RequestApprovals_onClick()",
        m_objMenu = New WebPage.Templates.StaticMenu
        m_strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
        'End of modification by ShraddhaM 9,Sept 2008
        '--- Commeented by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
        ''''End If
        '--- End comment purvaj
        'End by SuchitraP
        '--- End modification purvaj

        'End of modification by SrikanthY  on 05 Mar 2007
        'Integration Ends

        Dim dr As IDataReader
        Dim strSQL As String

        'If Trim(Session("strCRM_Filter_MD").ToString & "") = "" And m_lngFilterID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" And UCase(Trim(m_strAction & "")) <> "CLEAR_FILTERS" Then
        If m_lngFilterID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" And UCase(Trim(m_strAction & "")) <> "CLEAR_FILTERS" Then
            m_lngFilterID = CType(GetDefault(m_lngEmployeeID, "DefaultFilter_MD"), Long)
        End If

        If UCase(Trim(m_strAction & "")) = "CLEAR_FILTERS" Then
            m_lngFilterID = 0
        End If


        ' Modifed By NitinVS on 22 July 3005 for PSPL ; To Allow Search Request
        ' if Requestid send through Search is not present then display message and close the window.

        If Not Request.QueryString("Search") Is Nothing Then
            Dim intRequestIDExists As Integer
            Dim strRequestExistsSQL As String
            Dim m_lngQueryID As Long
            Dim m_strFromWhere As String = "MD"


            If Not Request.QueryString("QueryID") Is Nothing Then
                m_lngQueryID = CType(Request.QueryString("QueryID"), Long)

                MyBase.InitializeResources("AppResources.CRM_Dashboard", "AppResources")

                strRequestExistsSQL = "usp_sel_tbl_PM_Query_Master_For_Search " + m_lngQueryID.ToString + " , " + m_lngEmployeeID.ToString + " , '" + m_strLoginType + "' , '" + m_strFromWhere + "'"

                intRequestIDExists = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strRequestExistsSQL, MyBase.UseSQL), "0"), "0"), Integer)

                If intRequestIDExists = 0 Then

                    Response.Write("<SCRIPT language=javascript>")
                    Response.Write(" alert('" + MyBase.GetResourceString("OUTOFSCOPE") + "'); ")
                    Response.Write("</SCRIPT>")
                Else
                    'window.open('CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&Search=1&QueryID=' + objtxtRequestId.value ,'_requestdetail','resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700'); 
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_GoOnClick = CommonFunctions.Security.Token.GetToken(m_lngQueryID.ToString + CType(m_lngEmployeeID, String) + "0" + "0")
                    Response.Write("<SCRIPT language=javascript>")
                    '' Response.Write(" window.open('CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&QueryID=" + m_lngQueryID.ToString + "','_requestdetail','resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700');  ")
                    'Page Number Added By ShraddhaM on 6,Aug 2007
                    Response.Write(" window.open('CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=MD&QueryID=" + m_lngQueryID.ToString + "&PageNumber=" + m_intPageNumber.ToString + "&PKToken=" + m_PKToken_GoOnClick + "','_requestdetail','resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700');  ")
                    'End of additon By ShraddhaM on 6,Aug 2007
                    Response.Write("</SCRIPT>")
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

                End If

            End If
        End If

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")


        ' End Modification By NitinVS on 22 July 3005 for PSPL ; To Allow Search Request

        'Commented by SuchitraP on 2-Sept-2008
        '' get the menu
        'm_objMenu = New WebPage.Templates.StaticMenu
        'm_strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
        'End by SuchitraP

        ' build the sql
        strSQL = "EXEC usp_CRM_Sel_AllRequests_MyDashboard " & m_lngEmployeeID

        ' is status specified
        If m_lngStatusID <> 0 Then
            strSQL = strSQL & "," & m_lngStatusID
        Else
            strSQL = strSQL & ",Null"
        End If

        ' if location is specified
        If m_lngLocationID <> 0 Then
            strSQL = strSQL & "," & m_lngLocationID
        Else
            strSQL = strSQL & ",Null"
        End If

        strSQL = strSQL & ",'" & m_strSortBy & "','" & m_strSortOrder & "'"

        ' get the filter
        If m_lngFilterID <> 0 Then
            dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_Filters " & m_lngFilterID, m_blnUseSQL)
            If dr.Read Then
                If Trim(dr("FilterText").ToString & "") <> "" Then
                    strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(Trim(dr("FilterText").ToString & "")) & "'"
                End If
            Else
                strSQL = strSQL & ",NULL"
            End If

            CommonFunctions.Data.DisposeDataReader(dr)
        Else
            strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(Session("strCRM_Filter_MD").ToString & "") & "'"
            'strSQL = strSQL & ",''"
        End If

        'Added by ShraddhaM on 27,Apr 2009 for Requestor Filter in WhizibleSem8 
        If strRequestor <> "" Then
            'strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(strRequestor.Trim()) & "'"
            strSQL = strSQL & " ,' CustomerID Like ''" & CommonFunctions.General.BuildQueryString(strRequestor.ToString()) & "%''' "

        Else
            strSQL = strSQL & ",NULL"
        End If

        'Ended by ShraddhaM


        'Code added by PrashantD on 6 Jun 2007 for CleanUp Activity
        m_dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "default", , , m_blnUseSQL)
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity

        MyBase.InitializeResources("AppResources.CRM_Dashboard", "AppResources")

        With Response
            .Write(m_strMenu)

            'Commented by mrugajaB on 30th Apr 2005
            '.Write("<div id=divList style='OVERFLOW:auto'>")

            'Integrated by MrugajaB on 30th Apr 2005 for WHizibleSEM SP3
            ' Hotfix ID.4.0.95-BF Jan 11 2005
            ' Rajanikant Khethawatt Added Width:100%
            ' .Write("<div id=divList style='OVERFLOW:auto;width:100%;'>")

            ' End Modification Jan 11 2005

            ' the option buttons
            Call WriteOptionButtons()

            ' the filters combo
            Call WriteFilterCombos(m_lngEmployeeID)

            ' paging
            Call WritePaging(strSQL)

            ' the grid goes here
            Call WriteGrid(strSQL)


            'Call DisplayGraphs(m_lngEmployeeID, MyBase.GetResourceString("GRAPHS_CAPTION"))


        End With
        'Code added by PrashantD on 6 Jun 2007 for CleanUp Activity
        m_dsGrid.Dispose() : m_dsGrid = Nothing
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity

        'Added by SuchitraP on 30-Aug-2008
        'Purpose:To Show Publish to KM and WF approvals link only when WF is enabled
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMode id=hidMode value=" + Request.QueryString("Mode") + ">")
        'End of addition by SuchitraP
    End Sub


    Private Function IsDefaultMode(ByVal EmployeeID As Long) As Boolean
        '=====================================================================
        ' Procedure Name        : IsDefaultMode
        ' Description           : to set the default mode for the page
        ' Purpose               : 
        ' Parameters Passed     : EmployeeID
        ' Returns               : true/false
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        IsDefaultMode = False
        ' get the default mode for the user
        'Login Type condition added by harshada d on 22 11 2005 
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & EmployeeID & ",'DefaultMode','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'", m_blnUseSQL)
        If dr.Read Then
            If UCase(Trim(dr("ItemValue").ToString & "")) = "MD" Then
                IsDefaultMode = True
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function


    Private Sub WriteGrid(ByVal SQL As String)
        '=====================================================================
        ' Procedure Name        : WriteGrid
        ' Description           : to write the filter combo boxes
        ' Purpose               : 
        ' Parameters Passed     : EmployeeID
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions 
        ' Modified By           : SantoshK (SubRequest is Changed To Request Type,added QuerID field)
        '=====================================================================
        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
        ' To store the departments accessible to the currently logged in person
        ' i.e the department for which he is a HRM OR He is a department head 

        'Moved follwing commented block in Initialize Method by PrashantD on 6 Jun 2007
        'Dim drAccessibleDepartments As IDataReader
        'Dim sbAccessibleDepartemnts As New System.Text.StringBuilder
        'Dim Counter As Integer = 0
        'sbAccessibleDepartemnts.Append("")
        ''m_arrAccessibleDepartments 
        'sbAccessibleDepartemnts.Append(" SELECT FunctionID FROM tbl_CRM_Function_CRMS Where CRMID = ")
        'sbAccessibleDepartemnts.Append(m_lngEmployeeID.ToString)
        'sbAccessibleDepartemnts.Append(" Union " + vbCrLf)
        'sbAccessibleDepartemnts.Append("select 	DepartmentID from tbl_pm_departmentmaster Where departmentHeadID = ")
        'sbAccessibleDepartemnts.Append(m_lngEmployeeID.ToString)

        'drAccessibleDepartments = CommonFunction.Data.GetDataReader(sbAccessibleDepartemnts.ToString, MyBase.UseSQL)

        'While drAccessibleDepartments.Read
        '    m_arrAccessibleDepartments(Counter) = CType(CommonFunction.Data.CheckIsDBNull(drAccessibleDepartments("FunctionID"), "0"), Integer)
        '    Counter += 1
        'End While

        'CommonFunction.Data.DisposeDataReader(drAccessibleDepartments)
        'End of move block by PrashantD on 6 Jun 2007

        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

        'Integrated by SavitaS on 17 Nov 2005 for IssueID 1936
        'Added by SavitaS on 17 Nov 2005 for WhizibleSemSP4 enhancement
        'Purpose: If "Split Request Type-Sub Type" combo is checked at corporate level then show
        '         Reqest and SubRequestType seperately on the list else show them together.

        ''Commented By GaneshG on 15 Nov 06
        ''Purpose : As we are not showing RequestType/SubRequestType on list, no need of following code
        ''If CommonFunction.Application.SplitRequestTypeSubType = True Then
        ''End Comment By GaneshG

        'Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "RequestType", "SubRequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", "AssignTo", "AssignTask", MyBase.GetResourceString("ASSIGN_ISSUE_LINK"), MyBase.GetResourceString("REJECT_LINK"), "Change Department", "Select"}
        'Modified By GaneshG on 14 Nov 06
        'Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "RequestType", "SubRequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", "AssignTo", "Select"}
        'Integrated by ArchanaN on 27 Apr 2007
        'Code Modified by SrikanthY on 5 Jan 07 ToDisplay Flag option on My Dashboard List 
        'Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "LastDiscussionThread"}



        'Dim arrActualCols() As String = {"Description", "FlagTo", "Attachments", "QueryID", "Subject", "CustomerID", "Priority", "Discussions", "LastDiscussionThread"}
        Dim arrActualCols() As String = {"Description", "QueryID", "FlagTo", "Attachments", "Subject", "CustomerID", "Priority", "Discussions", "LastDiscussionThread"}


        'Integration Ends
        'End Modification By GaneshG 

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Dim arrIgnoreHTMLEncode() As String = {"1"}

        'ended by Yogesh J for HTML encoding Date:05/10/15


        'integrated by harshadad on 19 dec 2005  for issue id 989 
        '==============='==============='==============='==============='==============='==============='===============
        'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue, to show link for the pin.gif to show the attachments on the e-Dashboard tab of Helpdesk
        '==============='==============='==============='==============='==============='==============='===============
        'Dim arrLink() As String = {"", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", ""}
        'Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", "ChangeDepartment_OnClick(QueryID)", ""}

        'Modified By GaneshG on 14 Nov 06
        'Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "", ""}
        '''''''Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "", "Discussion_OnClick(QueryID)", ""}
        Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "", "", "", ""}
        'End Modification By GaneshG 

        '==============='==============='==============='==============='==============='==============='===============
        'End of 'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue
        '==============='==============='==============='==============='==============='==============='===============
        'end of integration by harshada d on 19 dec 2005  for issue id 989 
        'Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "chkSelect"}

        'Modified By GaneshG on 14 Nov 06
        'Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "chkSelect"}
        Dim arrChkBox() As String = {"", "", "", "", "", ""}
        'End Modification By GaneshG 

        'Added By GaneshG on 14 Nov 06
        Dim arrstrTDStyle() As String = {"width='2%'", "width='5%'", "width='5%'", "width='2%' align=center ", "width='20%' align=left nowrap='false'", "width='6%'", "width='5%'", "width='5%'", "width='50%' align=left"}
        'End Addition By GaneshG

        Dim strQueryID_Caption As String
        Dim strSubject_Caption As String
        Dim strDescription_Caption As String
        Dim strAssignTo_Caption As String
        Dim strPriority_Caption As String
        Dim strExpectedResolvedDate_Caption As String
        Dim strCRMExpectedResolvedDate_Caption As String
        Dim strStatus_Caption As String

        'New Varibale defined By SantoshK after adding field in tbl_CRM_SubRequestType_Caption_Master
        'on 2 dec 2004
        Dim strRequestType_Caption As String
        'Modification Ends

        Dim strSubRequestType_Caption As String
        Dim strTargetLocation_Caption As String
        Dim strFunction_Caption As String
        Dim strSubmittedBy_Caption As String
        Dim strSubmittedDate_Caption As String
        Dim dr As IDataReader
        Dim ds As DataSet

        ' get the captions from the caption template	
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_SubRequestType_Caption_Master ", m_blnUseSQL)
        If dr.Read Then
            strSubject_Caption = dr("Subject").ToString & ""
            strAssignTo_Caption = dr("AssignTo").ToString & ""
            strPriority_Caption = dr("Priority").ToString & ""
            strExpectedResolvedDate_Caption = dr("ExpectedResolvedDate").ToString & ""
            strStatus_Caption = dr("Status").ToString & ""

            'Added By SantoshK on 2nd Dec 2004
            strRequestType_Caption = dr("RequestType").ToString & ""
            'Addition Ends

            strSubRequestType_Caption = dr("SubRequestType").ToString & ""
            strSubmittedBy_Caption = dr("SubmittedBy").ToString & ""
            strSubmittedDate_Caption = dr("SubmittedDate").ToString & ""
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        ' Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, "Discussions", strRequestType_Caption, strSubRequestType_Caption, strPriority_Caption, strSubmittedBy_Caption, strSubmittedDate_Caption, strExpectedResolvedDate_Caption, strStatus_Caption, strAssignTo_Caption, "Assign Task", "Assign Issue", "Reject", "Change Department", "Select"}

        'Modified By PrashantD on 21 May 2007 for CleanUp Activity
        'Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, strSubmittedBy_Caption, "Discussions", "Last Discussion"}
        'Dim arrUserFriendlyCols() As String = {"<IMG Border=0  SRC='../../Images/plus.gif'>", "Request ID", "<img src='../../Images/GrayFlag.gif'>", "<img src='../../Images/pin.gif'>", strSubject_Caption, strSubmittedBy_Caption, "Priority", "Discussions", "Last Discussion"}
        Dim arrUserFriendlyCols() As String = {"<IMG Border=0  SRC='../../Images/plus.gif'>", "Request ID", "<img src='../../Images/GrayFlag.gif'>", "<img src='../../Images/pin.gif'>", strSubject_Caption, strSubmittedBy_Caption, "Priority", "Discussions", "Last Discussion"}

        'End Modification By PrashantD

        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            'Modified By GaneshG on 14 Nov 06
            .NoOfDataColumns = arrUserFriendlyCols.Length  '6 '.NoOfDataColumns = 12
            .TDStyleArray = arrstrTDStyle
            'End Modification By GaneshG 
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .RowLinkArray = arrLink
            .CheckBoxIDArray = arrChkBox
            .PrimaryKey = "QueryID"
            .returnHTML = False
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            'Commented and added by PrashantD on 06 Jun 2007 for CleanUp Activity
            '.SQL = SQL
            .GridDataTable = m_dsGrid.Tables(0)
            'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity
            .UseSQL = m_blnUseSQL
            .CurrentPage = m_intPageNumber
            .PageSize = 20
            'Modifed By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 Regression IssueID 11491
            'Integrated by ArchanaN on 27 Apr 2007
            'Start_JG_9241_05-Jan-2007
            '.DIVID = "divList" '"divGrid"
            .DIVID = "divGrid"
            'End_JG_9241_05-Jan-2007
            'Integration Ends


            ' End Modification By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 Regression IssueID 11491

            'ADDED BY VIDYAJ FOR ISSUE ID - 
            'Commented By MrugajaB on 6th Jan,2005
            '.DIVStyle = "overflow:auto"
            'Modified By MrugajaB on 5th Jan,2005 for Jopasana Issue ID.14613, Hotfix ID.4.0.95-BF
            'Purpose:When help desk dashboard has more No. of requests ,only first few columns are displayed
            'Also scroll bar does not get displayed, so width of DIV tag is set to 100%
            .DIVStyle = "overflow:auto;width:100%"
            'End Addition
            ' Commented by shamkant S on 5 Nov 2015
            '.DIVHeight = 400 '300 '370
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .DrawGrid()
            m_intNoOfRows = .NoOfRowsInPage
        End With
        m_objGrid = Nothing

        ' total records
        Dim intNoOfRows As Integer
        'Code commented and Added by PrashantD on 6 Jun 2007 for CleanUp Activity
        'ds = CommonFunctions.Data.GetDataSet(SQL, "default", , , m_blnUseSQL)
        'intNoOfRows = ds.Tables(0).Rows.Count
        intNoOfRows = m_dsGrid.Tables(0).Rows.Count
        CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", False, "clsTREven")
        'ds.Dispose() : ds = Nothing
        'End of addition and comment by PrashantD on 6 Jun 2007 for CleanUp Activity

        ''End If
        'Integrated by ArchanaN on 27 Apr 2007
        'SrikanthY on 05 Mar 2007 Added Values into Sessions For The New Feature Show Report
        HttpContext.Current.Session.Add("HelpDeskSQL", SQL)
        HttpContext.Current.Session.Add("HelpDeskROWS", intNoOfRows)
        'End of Addition by SrikanthY on 05 Mar 2007

        'Integration Ends


        ''Commented By GaneshG on 15 Nov 06
        ''Purpose : As we are not showing RequestType/SubRequestType on list, no need of following code
        ''If CommonFunction.Application.SplitRequestTypeSubType = False Then
        ''    'End Integration by SavitaS on 17 Nov 2005 for IssueID 1936

        ''    ' Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "RequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", "AssignTo", "AssignTask", MyBase.GetResourceString("ASSIGN_ISSUE_LINK"), MyBase.GetResourceString("REJECT_LINK"), "Change Department", "Select"}
        ''    Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "RequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", "AssignTo", "Select"}

        ''    Dim arrIgnoreHTMLEncode() As String = {"1"}
        ''    'integrated by harshadad on 19 dec 2005  for issue id 989 
        ''    '==============='==============='==============='==============='==============='==============='===============
        ''    'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue, to show link for the pin.gif to show the attachments on the e-Dashboard tab of Helpdesk
        ''    '==============='==============='==============='==============='==============='==============='===============
        ''    'Dim arrLink() As String = {"", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", ""}
        ''    'Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", "ChangeDepartment_OnClick(QueryID,AssignTo)", "Select_OnClick(QueryID)"}
        ''    Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "Select_OnClick(QueryID)"}


        ''    '==============='==============='==============='==============='==============='==============='===============
        ''    'End of 'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue
        ''    '==============='==============='==============='==============='==============='==============='===============
        ''    'end of integration by harshada d on 19 dec 2005  for issue id 989 
        ''    'Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "chkSelect"}
        ''    Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "chkSelect"}

        ''    Dim strQueryID_Caption As String
        ''    Dim strSubject_Caption As String
        ''    Dim strDescription_Caption As String
        ''    Dim strAssignTo_Caption As String
        ''    Dim strPriority_Caption As String
        ''    Dim strExpectedResolvedDate_Caption As String
        ''    Dim strCRMExpectedResolvedDate_Caption As String
        ''    Dim strStatus_Caption As String

        ''    'New Varibale defined By SantoshK after adding field in tbl_CRM_SubRequestType_Caption_Master
        ''    'on 2 dec 2004
        ''    Dim strRequestType_Caption As String
        ''    'Modification Ends

        ''    Dim strSubRequestType_Caption As String
        ''    Dim strTargetLocation_Caption As String
        ''    Dim strFunction_Caption As String
        ''    Dim strSubmittedBy_Caption As String
        ''    Dim strSubmittedDate_Caption As String
        ''    Dim dr As IDataReader
        ''    Dim ds As DataSet


        ''    ' get the captions from the caption template	
        ''    dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_SubRequestType_Caption_Master ", m_blnUseSQL)
        ''    If dr.Read Then
        ''        strSubject_Caption = dr("Subject").ToString & ""
        ''        strAssignTo_Caption = dr("AssignTo").ToString & ""
        ''        strPriority_Caption = dr("Priority").ToString & ""
        ''        strExpectedResolvedDate_Caption = dr("ExpectedResolvedDate").ToString & ""
        ''        strStatus_Caption = dr("Status").ToString & ""

        ''        'Added By SantoshK on 2nd Dec 2004
        ''        strRequestType_Caption = dr("RequestType").ToString & ""
        ''        'Addition Ends

        ''        strSubRequestType_Caption = dr("SubRequestType").ToString & ""
        ''        strSubmittedBy_Caption = dr("SubmittedBy").ToString & ""
        ''        strSubmittedDate_Caption = dr("SubmittedDate").ToString & ""
        ''    End If
        ''    CommonFunctions.Data.DisposeDataReader(dr)

        ''    'Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, "Discussions", strRequestType_Caption, strPriority_Caption, strSubmittedBy_Caption, strSubmittedDate_Caption, strExpectedResolvedDate_Caption, strStatus_Caption, strAssignTo_Caption, "Assign Task", "Assign Issue", "Reject", "Change Department", "Select"}
        ''    Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, "Discussions", strRequestType_Caption, strPriority_Caption, strSubmittedBy_Caption, strSubmittedDate_Caption, strExpectedResolvedDate_Caption, strStatus_Caption, strAssignTo_Caption, "Select"}

        ''    m_objGrid = New WebPages.Template.GenericGrid
        ''    With m_objGrid
        ''        .NoOfDataColumns = 11
        ''        .UserFriendlyColumnArray = arrUserFriendlyCols
        ''        .ActualColumnArray = arrActualCols
        ''        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
        ''        .RowLinkArray = arrLink
        ''        .CheckBoxIDArray = arrChkBox
        ''        .PrimaryKey = "QueryID"
        ''        .returnHTML = False
        ''        .SortBy = m_strSortBy
        ''        .SortOrder = m_strSortOrder
        ''        .ClientSideSortFunctionName = "Sort_OnClick"
        ''        .SQL = SQL
        ''        .UseSQL = m_blnUseSQL
        ''        .CurrentPage = m_intPageNumber
        ''        .PageSize = 20
        ''        .DIVID = "divList" '"divGrid"

        ''        'ADDED BY VIDYAJ FOR ISSUE ID - 
        ''        'Commented By MrugajaB on 6th Jan,2005
        ''        '.DIVStyle = "overflow:auto"
        ''        'Modified By MrugajaB on 5th Jan,2005 for Jopasana Issue ID.14613, Hotfix ID.4.0.95-BF
        ''        'Purpose:When help desk dashboard has more No. of requests ,only first few columns are displayed
        ''        'Also scroll bar does not get displayed, so width of DIV tag is set to 100%
        ''        .DIVStyle = "overflow:auto;width:100%;"
        ''        'End Addition
        ''        .DIVHeight = 300 '370
        ''        .ColNameToolTipOnEachRow = True
        ''        .DrawGrid()
        ''        m_intNoOfRows = .NoOfRowsInPage
        ''    End With
        ''    m_objGrid = Nothing

        ''    ' total records
        ''    Dim intNoOfRows As Integer
        ''    ds = CommonFunctions.Data.GetDataSet(SQL, "default", , , m_blnUseSQL)
        ''    intNoOfRows = ds.Tables(0).Rows.Count
        ''    CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", False, "clsTREven")
        ''    ds.Dispose() : ds = Nothing
        ''End If
        ''End Comment By GaneshG 

        'CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()

        m_arrAccessibleDepartments = Nothing

    End Sub

    Private Sub WriteFilterCombos(ByVal EmployeeID As Long)
        '=====================================================================
        ' Procedure Name        : WriteFilterCombos
        ' Description           : to write the filter combo boxes
        ' Purpose               : 
        ' Parameters Passed     : EmployeeID
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================

        With Response

            'If Not Request.QueryString("SavedFilterID") Is Nothing Then
            '    If Request.Form("hidSaveAddFilterID") <> "" Then
            '        m_lngFilterID = Request.Form("hidSaveAddFilterID")
            '    End If


            'End If

            '.Write("<input type=hidden name=hidSaveAddFilterID id=hidSaveAddFilterID value='" + m_lngFilterID.ToString() + "'>")


            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            .Write("<table width='99.9%' class=clsTable cellpadding=0 cellspacing=0><tr class=clsTREven>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            ' combo box of  filters
            .Write("<td width='24%'>")
            .Write(MyBase.GetResourceString("FILTER_CAPTION"))
            CommonFunctions.HTMLControls.DrawComboBox("cboFilter", "usp_CRM_FilterListForCombo " & EmployeeID, 200, m_lngFilterID.ToString, "Onchange=javascript:cboFilter_OnChange()", True)
            .Write("</td>")
            ' combo box of  status
            '.Write("<td width='17%'>")
            .Write("<td width='20%'>")
            .Write(MyBase.GetResourceString("STATUS_CAPTION"))
            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_CRM_Get_RequestStatus", 140, m_lngStatusID.ToString, "Onchange=javascript:cboStatus_OnChange()", True)
            .Write("</td>")

            'Added by ShraddhaM on 24,Apr 2009 for Whiziblesem8 to add Requestor text filter

            '.Write("<td width='20%'>")
            'commented added by Shamkant S
            .Write("<td width='30%'>")
            'commented ended by Shamkant S
            .Write("Requestor : ")


            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtRequestor", "txtRequestor", , 140, 100, strRequestor_ForControl, ToBeInserted:="onkeypress=javascript:Requestor_keypress(event)", EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            .Write("</td>")

            .Write("<td width='24%'>")
            'drawMonthNameHeadings(sbHTML)
            .Write("</td>")
            'End of addition by ShraddhaM

            'Commented by ShraddhaM on 24,Apr 2009 for Whiziblesem8
            '' combo box of  location
            '.Write("<td width='30%'>")
            '.Write(MyBase.GetResourceString("LOCATION_CAPTION"))
            'CommonFunctions.HTMLControls.DrawComboBox("cboLocation", "usp_CRM_Get_TargetLocations " & m_lngDepartmentID, 200, m_lngLocationID.ToString, "Onchange=javascript:cboLocation_OnChange()", True)
            '.Write("</td>")
            'End of comment by ShraddhaM

            .Write("</tr></table>")
        End With
    End Sub

    Private Sub WriteOptionButtons()
        '=====================================================================
        ' Procedure Name        : WriteOptionButtons
        ' Description           : to write the option buttons available for user
        ' Purpose               : 
        ' Parameters Passed     : EmployeeID
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        With Response
            If Trim(m_strLoginType & "") = "E" Then
                ' option buttons on the page
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                .Write("<table width='99.9%' class=clsTable cellpadding=0 cellspacing=0><tr class=clsTREven>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                '--- Commented Bby purvaj on 10 Jul 2009 SEM 8.1 New UI Changes
                '''.Write("<TD  width='20%'><INPUT id=optMYDashboard name=optRequest type=radio value='MD' OnClick='JavaScript:optRequest_OnClick(0)' checked><b>" & MyBase.GetResourceString("MYEDASHBOARD_CAPTION") & "</b></TD>")

                '''If m_blnDashboardAccess Then
                '''    .Write("<TD  width='20%'><INPUT id=optDashboard name=optRequest type=radio value='DB' OnClick='JavaScript:optRequest_OnClick(1)' >" & MyBase.GetResourceString("EDASHBOARD_CAPTION") & "</TD>")
                '''End If

                '''.Write("<TD  width='20%'><INPUT id=optSubmitted name=optRequest type=radio value='SR' OnClick='JavaScript:optRequest_OnClick(2)'>" & MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION") & "</TD>")
                '''.Write("<TD  width='20%'><INPUT id=optAssigned name=optRequest type=radio value='AR' OnClick='JavaScript:optRequest_OnClick(3)'>" & MyBase.GetResourceString("ASSIGNED_REQUESTS_CAPTION") & "</TD>")
                '--- End Comment purvaj

                '--- Added By purvaj on 21 Jul 2009
                Response.Write("<TD width='60%' align='left'><B>My e-dashboard</B></TD>")
                '--- End addition purvaj

                ' set/reset default links
                ' Modified by NitinVS on 9 aug 2005 for WhizibleSEM SP4 IssueID 2 
                '.Write("<TD  width='20%' align=right>")

                'Issue List TextBox and Go button

                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                Dim strtxtResuestId As String = CommonFunctions.HTMLControls.DrawTextBox("txtRequestId", "txtRequestId", , 50, 8, , "Right", , False, False, , False, "onkeypress=txtRequestID_OnKeyPress(event,'MD')", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:05/10/15
                'Commented And Added By Chakshuta H on 13th-Oct-2015
                'Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0'>"
                Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0;display:none;'>"
                'End Of Commented And Added By Chakshuta H on 13th-Oct-2015

                Response.Write("<TD width='20%' noWrap><B>" + MyBase.GetResourceString("REQUESTLIST") + "</B>&nbsp;&nbsp;" + strtxtResuestId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href='javascript:GO_OnClick(""MD"")' TITLE='Search Request ID'><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;</TD>")

                Response.Write("<TD width='20%' noWrap align='right'>")

                ' End Modifcation by NitinVS on 22 July 2005 for PSPL, To Give a search facility 

                If m_blnIsDefaultMode = True Then
                    .Write("<A href='JavaScript:SetDefault_OnClick(1)' style='Text-decoration:None'><b>" & MyBase.GetResourceString("RESETDEFAULT_CAPTION") & "</B>")
                Else
                    .Write("<A href='JavaScript:SetDefault_OnClick(0)' style='Text-decoration:None'><b>" & MyBase.GetResourceString("SETASDEFAULT_CAPTION") & "</B>")
                End If
                .Write("</TD>")
                ' line 
                'Modified By Nitinvs on 7 Dec 2005 
                .Write("</TR><tr><td bgcolor=black colspan=15></td></tr></table>")
                ' End Modification By NitinVS on 7 Dec 2005 
            Else
                .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION")))
            End If
        End With
    End Sub

    Private Sub WritePaging(ByVal PagingSQL As String)
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To write the paging for the request grid
        ' Purpose               : 
        ' Parameters Passed     : SQL for paging
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             : NitinVS on 26 July 2005 for PSPL 
        '                         Inplace of Paging Search paging is implemented
        '=====================================================================
        Dim ds As DataSet
        Dim intRecordCount As Integer
        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , True, 20)
        Dim strPaging As String = ""
        Dim strSectionTag As String = "divGrid"
        Dim strFunctionName As String = "ShowHide_divGrid"
        '' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Search Paging is Implemented 
        PagingSQL = PagingSQL.Replace("usp_CRM_Sel_AllRequests_MyDashboard", "usp_CRM_Sel_AllRequestsCount_MyDashboard")
        'Code commented and added by PrashantD on 6 Jun 2007 for CleanUp Activity
        'm_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)
        m_intTotalNoOfRows = m_dsGrid.Tables(0).Rows.Count
        'End of addition by PrashantD on 6 Jun 2007 for CleanUp Activity

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If
        'Code commented and added by PrashantD on 24 May 2007 for CleanUp Activity
        'If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
        '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        'Else
        '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, m_intPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        'End If
        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        ' Commented And Edited by KIRAN K K For issue id:1943 25-11-15
        ' .strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<Img style='vertical-align: top;' Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        ' Commented And Edited End by KIRAN K K For issue id:1943 25-11-15 

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"

        ' Commented And Edited by KIRAN K K For issue id:1943 25-11-15
        ' strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"
        strPaging += "<Img style='vertical-align: top;' Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"
        ' Commented And Edited End by KIRAN K K For issue id:1943 25-11-15
        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            ' Commented And Edited by KIRAN K K For issue id:1943 25-11-15
            'strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", "margin-top:0px; vertical-align:Top", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            ' Commented And Edited End by KIRAN K K For issue id:1943 25-11-15

        Else
            ' Commented And Edited by KIRAN K K For issue id:1943 25-11-15
            ' strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", "margin-top:0px; vertical-align:Top", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            ' Commented And Edited End by KIRAN K K For issue id:1943 25-11-15

            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        ' Commented And Edited by KIRAN K K For issue id:1943 25-11-15
        '  strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<Img style='vertical-align: top;' Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        ' Commented And Edited End by KIRAN K K For issue id:1943 25-11-15

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        ' Commented And Edited by KIRAN K K For issue id:1943 25-11-15
        ' strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<Img style='vertical-align: top;' Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "


        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"
        'End of comment and addition by PrashantD on 24 May 2007 for CleanUp Activity

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A  href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        ' Commented And Edited End by KIRAN K K For issue id:1943 25-11-15
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15

        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)

        'ended by Yogesh J for HTML encoding Date:05/10/15

        '' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Search Paging is Implemented 


        If m_blnShowGrid Then
            ' the section title
            Response.Write(m_objSectionTitle.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
            Response.Write("<script language=javascript>" & m_objSectionTitle.ClientsideScript & "</script>")
            divGraphs.Attributes.Add("style", "overflow:auto" + vbCrLf)
        Else
            ' the section title
            Response.Write(m_objSectionTitle.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , "../../images/plus.gif", , , , , , False, False))
            Response.Write("<script language=javascript>" & m_objSectionTitle.ClientsideScript & "</script>")
            divGraphs.Attributes.Add("style", "overflow:auto;display:none" + vbCrLf)
        End If
        'Destroy the object
        m_objSectionTitle = Nothing


    End Sub

    Private Function GetDefault(ByVal EmployeeID As Long, ByVal DefaultType As String) As String
        '=====================================================================
        ' Procedure Name        : GetDefault
        ' Description           : to get the default settings for the user
        ' Purpose               : 
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the value of the default
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' Login Type condition added by harshada d on 22 11 2005 
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & EmployeeID & ",'" & CommonFunctions.General.BuildQueryString(DefaultType & "") & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'", m_blnUseSQL)
        If dr.Read Then
            If Trim(dr("ItemValue").ToString & "") <> "" Then
                GetDefault = dr("ItemValue").ToString & ""
            Else
                GetDefault = "0"
            End If
        Else
            GetDefault = "0"
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function GetEmployeeDepartment(ByVal EmployeeID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetEmployeeDepartment
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_EmployeeDepartment " & EmployeeID, m_blnUseSQL)
        If dr.Read Then
            GetEmployeeDepartment = CType(CommonFunctions.General.CheckIsNothing(dr("DepartmentID"), "0"), Long)
        Else
            GetEmployeeDepartment = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Sub DisplayGraphs(ByVal UserID As Long, Optional ByVal SectionName As String = "")
        '=====================================================================
        ' Procedure Name        : DisplayNoNeedleGraphs()
        ' Purpose               : To display all the graphs for the dashboard
        ' Description           : The procedure displays all the graphs for the
        '                         dashboard
        ' Parameters Passed     : Dashboard ID, User ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Graph.dll
        ' Author                : Rajanikant
        ' Created               : November 03,2003
        ' Revisions             :
        '=====================================================================
        Dim objQRB As QueryBuilders.cQuery
        Dim drGraphs As IDataReader
        Dim dr As IDataReader
        Dim drDetails As IDataReader
        Dim intRowCount As Integer
        Dim blnShowDrillDowns As Boolean
        Dim blnOracleDB As Boolean = False
        Dim strSQL As String
        Dim strGraphSQL As String
        Dim myGraph As Graph.Graph
        Dim cObjSectionTitle As WebPage.Templates.SectionTitle
        Dim strLeftSectionTitle As String = ""
        Dim strSectionTag As String = ""
        Dim strFunctionName As String = ""
        Dim blnPrinted As Boolean = False
        Dim intNoOfGraphElements As Integer = 5
        Dim lngConnectionID As Long
        Dim strConnectionString As String = ""
        Dim strImagePath As String
        Dim cell As New HtmlTableCell
        Dim row As New HtmlTableRow
        'addded by harshada d on 14 feb 2006 for helpdesk enhancements
        Dim strSQLAccessibleRequests As New System.Text.StringBuilder
        strSQLAccessibleRequests.Append(" WHERE(1 = 1)")
        strSQLAccessibleRequests.Append(" AND v_CRM_HelpDesk_Master.QueryID IN ")
        strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where v_CRM_HelpDesk_Master.FunctionID IN ")
        strSQLAccessibleRequests.Append("( SELECT DepartmentID FROM fnAccessibleDepts(" & m_lngEmployeeID & "")
        strSQLAccessibleRequests.Append(" ))")
        strSQLAccessibleRequests.Append("UNION")
        strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where ")
        'Modified by Manishk on 21st Feb 06 for SP 6 issueID 2352
        'strSQLAccessibleRequests.Append(" v_CRM_HelpDesk_Master.CustomerID = (SELECT CustomerShortName ")
        strSQLAccessibleRequests.Append(" v_CRM_HelpDesk_Master.CustomerID in (SELECT CustomerShortName ")
        'End of Modified by Manishk on 21st Feb 06 for SP 6 issueID 2352
        strSQLAccessibleRequests.Append("from fnAccessibleCustomers (" & m_lngEmployeeID & "")
        strSQLAccessibleRequests.Append(" ))))")

        'Added by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        'Purpose: Only Flagged Request data should disply on Graph
        'strSQLAccessibleRequests.Append(" AND v_CRM_HelpDesk_Master.QueryID IN ")
        'strSQLAccessibleRequests.Append(" (SELECT ContextID FROM tbl_PM_FlagForTracking WHERE UPPER(ContextType)=''HELPDESKREQUEST'' AND EmployeeID=" & m_lngEmployeeID & ")")
        'End of addition by PrashantSJ on 09 Nov 2006

        'strSQLAccessibleRequests.Append(" GROUP BY SubRequestType ")

        'end of addition by harshada d on 14 feb 2006 for helpdesk enhancements


        ' create a collapsible section for the graph type
        strLeftSectionTitle = SectionName
        strFunctionName = "ShowHide_divGraphs"
        strSectionTag = "divGraphs"

        Response.Write("<BR>")
        strSQL = "usp_CDB_Get_UserSettings	53," & UserID & ",2,1"

        drGraphs = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While drGraphs.Read
            If Not blnPrinted Then
                If m_blnShowOtherGraphs Then
                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName))
                    Response.Write("<script language=javascript>" & cObjSectionTitle.ClientsideScript & "</script>")
                    divGraphs.Attributes.Add("style", "overflow:auto" + vbCrLf)
                Else
                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , "../../images/plus.gif"))
                    Response.Write("<script language=javascript>" & cObjSectionTitle.ClientsideScript & "</script>")
                    divGraphs.Attributes.Add("style", "overflow:auto;display:none" + vbCrLf)
                End If
                'Destroy the object
                cObjSectionTitle = Nothing
                blnPrinted = True
            End If

            If CInt(drGraphs.Item("GraphTypeID")) <> 1 Then
                With tblGraphs
                    If intRowCount = 0 Then
                        row = New HtmlTableRow
                        .Rows.Add(row)
                    End If
                    intRowCount += 1
                    ' add row cells
                    cell = New HtmlTableCell
                    cell.Attributes.Add("width", "100%")
                    cell.Attributes.Add("align", "center")
                    cell.Attributes.Add("Valign", "middle")
                    ' hardcode the role-level to 1 to avoid any role level filters
                    objQRB = New QueryBuilders.cQuery(Session("strUserName").ToString, CType(Session("intPostID"), Long), CType(Session("intUserID"), Long), Session("LoginType").ToString, 1, CType(Session("IsCreatedByCustomer"), Boolean))
                    objQRB.QueryID = CLng(drGraphs("QueryID"))
                    objQRB.UseSQL = m_blnUseSQL

                    ' build query with filter for current function
                    strGraphSQL = objQRB.BuildQuery()
                    'addition by harshada d on 14 feb 2006 for helpdesk enhancements
                    '  strGraphSQL = Replace(strGraphSQL, " WHERE 1=1 ", " WHERE 1=1 AND  FunctionID = " & m_lngDepartmentID)
                    strGraphSQL = Replace(strGraphSQL, " WHERE 1=1 ", strSQLAccessibleRequests.ToString)
                    'end of addition by harshada d on 14 feb 2006 for helpdesk enhancements

                    'If Not IsDBNull(drGraphs("NoOfGraphElements")) Then
                    '    intNoOfGraphElements = CType(drGraphs("NoOfGraphElements"), Integer)
                    'Else
                    '    intNoOfGraphElements = 5
                    'End If

                    'strGraphSQL = "SELECT TOP " & intNoOfGraphElements & "  " & Right(Trim(strGraphSQL & ""), Len(Trim(strGraphSQL & "")) - 6)

                    blnShowDrillDowns = CBool(drGraphs.Item("ShowDrillDowns"))
                    If blnShowDrillDowns Then
                        strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Master  " & CType(drGraphs.Item("ItemID"), Long)
                        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                        If dr.Read Then
                            blnShowDrillDowns = True
                        Else
                            blnShowDrillDowns = False
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)
                    End If

                    ' in case there is an error in the graph item dont add it
                    Try
                        ' adding the chart here by calling the function
                        cell.Controls.Add(CreateGraph(CType(drGraphs.Item("ItemID"), Long), strGraphSQL, 0, 0, blnShowDrillDowns, strConnectionString))
                    Catch exc As Exception
                        cell.Attributes.Add("class", "clsTDOdd")
                        cell.Attributes.Add("border", "1")
                        cell.Attributes.Add("bordercolor", "black")
                        cell.InnerHtml = MyBase.GetResourceString("MSG_GRAPHNOTGENERATED")
                    End Try
                    row.Cells.Add(cell)
                    If intRowCount > 1 Then
                        intRowCount = 0
                    End If
                End With

            End If
        Loop
        CommonFunctions.Data.DisposeDataReader(drGraphs)
    End Sub

    Private Function CreateGraph(ByVal ItemID As Long, ByVal SQL As String, ByVal Height As Integer, ByVal Width As Integer, ByVal ShowDrillDowns As Boolean, ByVal ConnectionString As String, Optional ByRef ImagePath As String = "") As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : Graph Control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Noveber 07,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strBorderStyle As String = ""
        Dim strBorderColor As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim intUCL As Integer = 0
        Dim intLCL As Integer = 0
        Dim strUCLColor As String = ""
        Dim strLCLColor As String = ""
        Dim strPieLabelStyle As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim intGraphID As Integer
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim strTitleColor As String = ""
        Dim strPalleteStyle As String


        Dim intXAxisMax As Long = 0
        Dim intXAxisMin As Long = 0
        Dim intXAxisInterval As Long = 0

        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
        Dim blnShowHover As Boolean = True
        'check the application settings for hover on graphs
        objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject("EnableHoverForCDBMain")
        If Not objFrameworkSetting Is Nothing Then
            If UCase(Trim(objFrameworkSetting.Status & "")) = "Y" Then
                blnShowHover = True
            Else
                blnShowHover = False
            End If
        End If
        objFrameworkSetting = Nothing



        ' set the DB settings
        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_DashboardDetails 53", m_blnUseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("PalleteStyle")) Then
                strPalleteStyle = dr("PalleteStyle").ToString
            Else
                strPalleteStyle = "EARTHTONES"
            End If
            If Not IsDBNull(dr("GraphHeight")) Then
                Height = CType(dr("GraphHeight"), Integer)
            Else
                Height = 260
            End If
            If Not IsDBNull(dr("GraphWidth")) Then
                Width = CType(dr("GraphWidth"), Integer)
            Else
                Width = 492
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        ' get the item details
        strSQL = "EXEC usp_CDB_GetQueryDetails_ForItem  53," & ItemID & ",null,null,1"

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            strItemName = dr("ItemName").ToString : strBorderStyle = dr("BorderStyle").ToString
            strBorderColor = dr("BorderColor").ToString : strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString : strCaptionColor = dr("CaptionColor").ToString
            strTitleColor = dr("TitleColor").ToString
            If Not IsDBNull(dr("UCL")) Then
                intUCL = CType(dr("UCL"), Integer)
            End If
            strUCLColor = dr("UCLColor").ToString
            If Not IsDBNull(dr("LCL")) Then
                intLCL = CType(dr("LCL"), Integer)
            End If
            strLCLColor = dr("LCLColor").ToString
            If Not IsDBNull(dr("ShowLegends")) Then
                blnShowLegends = CType(dr("ShowLegends"), Boolean)
            End If
            If Not IsDBNull(dr("ShowExplodedPie")) Then
                blnShowExplodedPie = CType(dr("ShowExplodedPie"), Boolean)
            End If
            intGraphID = CType(dr("GraphTypeID"), Integer)

            If Not IsDBNull(dr("Enable3D")) Then
                blnEnable3D = CType(dr("Enable3D"), Boolean)
            End If
            lngEntityID = CType(dr("EntityID"), Long)
            strNomenclature = dr("Nomenclature").ToString
            strPieLabelStyle = dr("PieLabelStyle").ToString

            If Not IsDBNull(dr("XAxisMin")) Then
                intXAxisMin = CType(dr("XAxisMin"), Long)
            End If
            If Not IsDBNull(dr("XAxisMax")) Then
                intXAxisMax = CType(dr("XAxisMax"), Long)
            End If
            If Not IsDBNull(dr("XAxisInterval")) Then
                intXAxisInterval = CType(dr("XAxisInterval"), Long)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        ' default title color
        If Trim(strTitleColor & "") = "" Then strTitleColor = "white"

        ' create the grpah for the item values
        objGraph = New Graph.Graph
        objGraph.ConnectionString = ConnectionString
        objGraph.VirtualImagePath = "../../Images/" : objGraph.Enable3D = blnEnable3D
        objGraph.ChartType = GetChartType(ItemID, SQL, intGraphID, m_blnUseSQL)
        objGraph.BorderStyle = strBorderStyle
        objGraph.GraphTitle = strItemName : objGraph.TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
        objGraph.GraphTitleColor = strTitleColor
        objGraph.SQL = SQL : objGraph.Width = Width : objGraph.Height = Height
        objGraph.ShowExplodedPie = blnShowExplodedPie : objGraph.ChartBackColor = strChartBackColor
        objGraph.ChartAreaColor = strChartAreaColor : objGraph.PalleteStyle = strPalleteStyle
        If Not (intGraphID = 2 Or intGraphID = 7) Then
            objGraph.LegendColor = getColor(ItemID)
        End If
        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)

        objGraph.LegendCaptionColor = strCaptionColor : objGraph.LegendBorderColor = strCaptionColor
        objGraph.BorderColor = strBorderColor : objGraph.ShowLegends = blnShowLegends
        objGraph.BorderGradientColor = "WHITE"
        objGraph.BorderGradientStyle = "TOPBOTTOM"
        objGraph.ChartBackGradientColor = "WHITE"
        objGraph.ChartBackGradientStyle = "TOPBOTTOM"
        objGraph.ChartAreaGradientColor = "WHITE"
        If objGraph.ChartType(0) = "PIE" Or objGraph.ChartType(0) = "DOUGHNUT" Then
            objGraph.ChartAreaGradientStyle = "CENTER"
        Else
            objGraph.ChartAreaGradientStyle = "TOPBOTTOM"
        End If
        objGraph.PieChartLabelStyle = strPieLabelStyle


        ' if drill downs are present?
        If ShowDrillDowns Then
            If blnShowHover Then
                objGraph.DrillDownHoverPage = "CRM_DrillDown_Hover.aspx?DashboardID=53&FromWhere=&ItemID=" + ItemID.ToString + "&"
            End If
            objGraph.DrillDownClientSideFunctionName = "DrillDown_OnClick(" + ItemID.ToString + ","
        End If
        objGraph.EntityID = lngEntityID : objGraph.Nomenclature = strNomenclature
        If intGraphID <> 5 Then
            objGraph.LCL = intLCL : objGraph.LCLColor = strLCLColor
            objGraph.UCL = intUCL : objGraph.UCLColor = strUCLColor
        End If

        objGraph.YAxisMin = intXAxisMin
        If intXAxisMax <> 0 Then
            objGraph.YAxisMax = intXAxisMax
        End If
        If intXAxisInterval <> 0 Then
            objGraph.YAxisInterval = intXAxisInterval
        End If
        objGraph.XAxisInterval = 1
        ' return the graph control
        Return objGraph.GenerateChartControl()

    End Function

    Private Function GetChartType(ByVal ItemID As Long, ByVal strSQL As String, ByVal intGraphID As Integer, ByVal UseSQL As Boolean) As String()
        '=====================================================================
        ' Procedure Name        : GetChartType
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim ds As DataSet
        Dim intUBound As Integer
        Dim intX As Integer

        Dim dr As IDataReader
        Dim arr() As String = {}
        Dim intCount As Integer = 1
        Dim arrGraph() As String = {}

        ds = CommonFunctions.Data.GetDataSet(strSQL, "default", , , UseSQL)
        intUBound = ds.Tables(0).Columns.Count()
        ds.Dispose() : ds = Nothing


        strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + ItemID.ToString

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arrGraph(intCount)
            arrGraph(intCount) = dr("GraphID").ToString
            intCount += 1
        Loop
        CommonFunction.Data.DisposeDataReader(dr)

        Select Case intGraphID
            Case 2 'pie
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "PIE"
                Next
                Return arr
            Case 3 ' column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                                arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                            Else
                                arr(intX) = "COLUMN"
                            End If
                        Else
                            arr(intX) = "COLUMN"
                        End If
                    Else
                        arr(intX) = "COLUMN"
                    End If
                Next
                Return arr
            Case 4 ' line
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "LINE"
                        End If
                    Else
                        arr(intX) = "LINE"
                    End If
                Next
                Return arr
            Case 5 ' bar
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "BAR"
                Next
                Return arr
            Case 6 ' step
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STEPLINE"
                        End If
                    Else
                        arr(intX) = "STEPLINE"
                    End If
                Next
                Return arr
            Case 7 ' doughnut
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "DOUGHNUT"
                Next
                Return arr

            Case 8 ' CandleStick
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "CANDLESTICK"
                        End If
                    Else
                        arr(intX) = "CANDLESTICK"
                    End If
                Next
                Return arr

            Case 9 ' Spline
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINE"
                        End If
                    Else
                        arr(intX) = "SPLINE"
                    End If
                Next
                Return arr
            Case 10 ' Splin area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINEAREA"
                        End If
                    Else
                        arr(intX) = "SPLINEAREA"
                    End If
                Next
                Return arr

            Case 11 ' Area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "AREA"
                        End If
                    Else
                        arr(intX) = "AREA"
                    End If
                Next
                Return arr
            Case 12 ' stacked column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "RADAR"
                Next
                Return arr
            Case Else
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "COLUMN"
                Next
                Return arr
        End Select
    End Function

    Private Function getColor(ByVal ItemID As Long) As String()
        '=====================================================================
        ' Procedure Name        : GetColor
        ' Purpose               : To get the colors the sql
        ' Description           : 
        ' Parameters Passed     : item id
        ' Returns               : arr of string for color
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Dec 16,2003
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim intCount As Integer = 1
        Dim arr() As String = {}

        strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + ItemID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arr(intCount)
            arr(intCount) = dr("ColorName").ToString
            intCount += 1
        Loop
        CommonFunction.Data.DisposeDataReader(dr)

        Return arr
    End Function

    Private Function GetChartName(ByVal intGraphID As Integer) As String
        '=====================================================================
        ' Procedure Name        : GetChartName
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================

        Select Case intGraphID
            Case 2 : Return "PIE"
            Case 3 : Return "COLUMN"
            Case 4 : Return "LINE"
            Case 5 : Return "BAR"
            Case 6 : Return "STEPLINE"
            Case 7 : Return "DOUGHNUT"
            Case 8 : Return "CANDLESTICK"
            Case 9 : Return "SPLINE"
            Case 10 : Return "SPLINEAREA"
            Case 11 : Return "AREA"
            Case 12 : Return "STACKEDCOLUMN"
            Case Else : Return "COLUMN"
        End Select
    End Function


#Region "events"

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint

        'intTotalCol = intTotalCol + 1

        Select Case UCase(Trim(Args.DataField & ""))
            Case "ATTACHMENTS"
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.TDStyle = " NoWrap title='Attachments'"
            Case "DISCUSSIONS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif'>"
                Args.ApplyHTMLEncode = False

                ' Modified By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                'To show Assign Task Link conditionaly 

            Case "ASSIGN ISSUE"
                If m_blnShowAssignTaskInHelpDesk = False Then
                    Cancel = True
                End If

                'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                ' For Non HRM Column is not to be plotted 
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

            Case "ASSIGNTASK"
                If m_blnShowAssignTaskInHelpDesk = False Then
                    Cancel = True
                End If

                'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                ' For Non HRM Column is not to be plotted 
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

            Case "REJECT"
                If m_blnShowAssignTaskInHelpDesk = False Then
                    Cancel = True
                End If
                ' End Modification By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                ' To show Assign Task Link conditionaly  

                'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                ' For Non HRM Column is not to be plotted 
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                ''Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
            Case "CHANGE DEPARTMENT"
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                ''End of Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
                'Integrated by ArchanaN on 27 Apr 2007
                'Added by SrikanthY on 10 Jan 2007 to display image on Flag Column header
            Case "FLAGTO"
                Args.TDStyle = " NoWrap title='FlagTo'"
                Args.ApplySorting = False
                ' Args.ColumnName = "<IMG border=0 src='../../Images/grayflag.gif'>"
                Args.ApplyHTMLEncode = False
                'End of Addition by SrikanthY
                'Integration Ends

                'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
                'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
            Case "DESCRIPTION"

                Args.TDStyle = " title='Description'"
                Args.ApplySorting = False
                Args.ColumnName = ""
                Args.ApplyHTMLEncode = False
                'Ended by ShraddhaM

        End Select
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        ''ADDED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEST LIKE ...."14 Days Ago" below Subject
        m_strQueryid = CType(Args.DataReader("QueryID"), Integer)
        ''END ADDED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEST LIKE ...."14 Days Ago" below Subject
        'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
        'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
        If UCase(Trim(Args.DataField & "")) = "STATUS" Then
            Args.TDStyle = "style='border-bottom: 1pt solid gray;' id=Status" + CType(Args.DataReader("QueryID"), String)
        Else
            Args.TDStyle = "style='border-bottom: 1pt solid gray;'"
        End If
        'Ended by ShraddhaM

        Dim strTD As String

        'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
        ' Commented and moved the code to the case for field 'Change Department'
        'Dim drIfHRM As IDataReader
        'Dim blnIsHrmForQuery As Integer = 0
        'Dim strSQL As String = " SELECT CRMID FROM tbl_CRM_Function_CRMS Where CRMID = " & m_lngEmployeeID & " and FUNCTIONID IN ( SELECT FunctionID FROM tbl_CRM_Query_Master Where QueryID = " & Args.DataReader("QueryID").ToString & ")"
        'strSQL += " UNION ALL select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " & m_lngEmployeeID & " and DepartmentID IN ( SELECT FunctionID FROM tbl_CRM_Query_Master Where QueryID = " & Args.DataReader("QueryID").ToString & ")"
        'drIfHRM = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        'If drIfHRM.Read Then
        '    ' the change department link should be displyed
        '    blnIsHrmForQuery = 1
        'Else
        '    blnIsHrmForQuery = 0
        'End If
        'CommonFunction.Data.DisposeDataReader(drIfHRM)

        'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
        Select Case UCase(Trim(Args.DataField & ""))
            Case "SUBJECT"

                ''' truncate subject to length of 50
                'If Trim(Args.DataReader("Subject").ToString & "") <> "" Then
                '    If Len(Trim(Args.DataReader("Subject").ToString & "")) > 50 Then
                '        Args.DataFieldValue = "<A Href=""javascript:Query_OnClick(" & CType(Args.DataReader("QueryID"), Long) & ",'" & m_PKToken_Query_DT & "')title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Subject").ToString) & Chr(34) & ">" & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "...</A>"
                '        Args.ApplyHTMLEncode = False
                '        Args.TDStyle = " width=25% title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & ""
                '    Else
                '        Args.TDStyle = " width=25% title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & ""
                '    End If
                'End If

                '''' ParagD


                If Trim(Args.DataReader("Subject").ToString & "") <> "" Then
                    ''ADDED BY AMIT MAHADIK 0N 29 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                    '' m_strQueryid = CType(Args.DataReader("QueryID"), Integer) ''''''value set above
                    Dim SubmittedDate As DateTime
                    Dim strQueryForSubmittedDate As String = "SELECT SubmittedDate FROM tbl_CRM_Query_Master WHERE QueryID= " & m_strQueryid.ToString()
                    SubmittedDate = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQueryForSubmittedDate.ToString(), True), ""), ""), DateTime)
                    Dim intDateDiffInDays = DateDiff(DateInterval.Day, SubmittedDate, DateTime.Now)
                    Dim strInsertString = "Posted:" & intDateDiffInDays.ToString() & " days ago."
                    If intDateDiffInDays = 0 Then
                        strInsertString = "Posted:" & DateDiff(DateInterval.Hour, SubmittedDate, DateTime.Now).ToString() & " Hrs. ago."
                        If DateDiff(DateInterval.Hour, SubmittedDate, DateTime.Now) = 0 Then
                            strInsertString = "Posted:" & DateDiff(DateInterval.Minute, SubmittedDate, DateTime.Now).ToString() & " Mins. ago."
                        End If
                        ''ADDED BY AMIT MAHADIK 0N 26 July 2011
                    ElseIf intDateDiffInDays >= 60 Then
                        strInsertString = "Posted:" & DateDiff(DateInterval.Month, SubmittedDate, DateTime.Now).ToString() & " Months ago."
                        ''END ADDED BY AMIT MAHADIK 0N 26 July 2011
                    End If
                    ''END ADDED BY AMIT MAHADIK 0N 29 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                    'Added By GaneshG on 14 Nov 06
                    Dim sbTDTitle As New System.Text.StringBuilder
                    sbTDTitle.Append("")
                    sbTDTitle.Append("Description: " + Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description")).ToString) + vbCrLf)
                    sbTDTitle.Append("Request Type: " + Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestType")).ToString) + vbCrLf)

                    Try
                        Dim strobject As Object = Args.DataReader("SubRequestType")
                        sbTDTitle.Append("SubRequest Type: " + Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubRequestType")).ToString) + vbCrLf)
                    Catch ex As Exception
                    End Try

                    sbTDTitle.Append("Priority: " + Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Priority")).ToString) + vbCrLf)
                    sbTDTitle.Append("Requestor: " + Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CustomerID")).ToString) + vbCrLf)

                    If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubmittedDate")).ToString <> "" Then
                        sbTDTitle.Append("Requested On: " + CommonFunctions.Dates.CGetDate(CType(Args.DataReader("SubmittedDate"), Date)) + vbCrLf)
                    Else
                        sbTDTitle.Append("Requested On: " + vbCrLf)
                    End If

                    If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpectedResolvedDate")).ToString <> "" Then
                        sbTDTitle.Append("Exp. Date of Resolution: " + CommonFunctions.Dates.CGetDate(CType(Args.DataReader("ExpectedResolvedDate"), Date)) + vbCrLf)
                    Else
                        sbTDTitle.Append("Exp. Date of Resolution: " + vbCrLf)
                    End If

                    sbTDTitle.Append("Status: " + Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status")).ToString) + vbCrLf)
                    sbTDTitle.Append("Assign To: " + Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AssignTo")).ToString))
                    'End Addition By GaneshG

                    '''    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    If Len(Trim(Args.DataReader("Subject").ToString & "")) > 50 Then
                        Args.ApplyHTMLEncode = False
                        'Args.StringToBeInserted = "<TD vAlign=top Title='" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & "' style='width=25%' nowrap;>" _
                        '             & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "</A></TD>"

                        'Modified By GaneshG on 14 Nov 06
                        'Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & " style='width=25%' nowrap;>" _
                        'Modified By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 Issue 11446
                        'Added ... after the 50 characters to represent limited data 
                        ''Modified BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                        ''*******************************''PURPOSE: for whizible.glodyne.com (inhouse production site)****************************
                        Dim m_intRoleID As Integer
                        Dim strIsDisplayRequestAging As String
                        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
                        Dim strSQLIsDisplayRequestAging As String = "SELECT CustomFieldText1 FROM TBL_PM_ROLE WHERE ROLEID= " & m_intRoleID.ToString()
                        strIsDisplayRequestAging = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLIsDisplayRequestAging.ToString(), True), "0"), "0"), String)
                        If strIsDisplayRequestAging <> "" And strIsDisplayRequestAging = "0" Then
                            strInsertString = String.Empty ''PURPOSE: for whizible.glodyne.com (inhouse production site)
                        End If
                        ''**********************************************************
                        Args.StringToBeInserted = "<TD vAlign=top nowrap=false width='20%'  style='border-bottom: 1pt solid gray;' >" _
                                     & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "...</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        ''end Modified BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                        'End Modification By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 Issue 11446
                        'End Modification By GaneshG

                        Cancel = True
                    Else
                        'Modified By GaneshG on 14 Nov 06
                        'Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & " style='width=25%' nowrap;>" _
                        ''Modified BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                        ''*******************************''PURPOSE: for whizible.glodyne.com (inhouse production site)****************************
                        Dim m_intRoleID As Integer
                        Dim strIsDisplayRequestAging As String
                        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
                        Dim strSQLIsDisplayRequestAging As String = "SELECT CustomFieldText1 FROM TBL_PM_ROLE WHERE ROLEID= " & m_intRoleID.ToString()
                        strIsDisplayRequestAging = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLIsDisplayRequestAging.ToString(), True), "0"), "0"), String)
                        If strIsDisplayRequestAging <> "" And strIsDisplayRequestAging = "0" Then
                            strInsertString = String.Empty ''PURPOSE: for whizible.glodyne.com (inhouse production site)
                        End If
                        ''**********************************************************
                        Args.StringToBeInserted = "<TD vAlign=top nowrap=false width='20%' style='border-bottom: 1pt solid gray;' >" _
                                      & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Trim(Args.DataReader("Subject").ToString & "")) & "</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        ''end Modified BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                        'End Modification By GaneshG
                        Cancel = True
                    End If

                End If
                '''' END: ParagD

            Case "ATTACHMENTS"
                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                ''Args.ApplyHTMLEncode = False
                ''Args.TDStyle = " title='Attachments' "
                If Trim(Args.DataReader("Attachments").ToString & "") <> "" Then
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    '' Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                    Args.StringToBeInserted = "<TD vAlign=top width='2%' align=center title='Attachments' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                & "<A href=""JavaScript:Document_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Trim(Args.DataReader("Attachments").ToString & "") & "</A></TD>"

                    Cancel = True
                Else
                    Args.DataFieldValue = " "
                    Args.TDStyle = " title='Attachments' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' "
                End If
                '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

            Case "DISCUSSIONS"
                ' New discussion??
                If Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "" And Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "0" Then
                    If Not CType(Args.DataReader("IsDiscussionViewed"), Boolean) Then

                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        'Args.StringToBeInserted = "<TD NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                        'Cancel = True
                        Args.StringToBeInserted = "<TD vAlign=top width='5%' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                          & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A>" & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"

                        Cancel = True

                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    Else
                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        'Args.StringToBeInserted = "<TD NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        'Cancel = True
                        Args.StringToBeInserted = "<TD vAlign=top width='5%' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                         & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"

                        Cancel = True
                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    End If
                Else
                    ''Args.DataFieldValue = "<IMG border=0 src='../../Images/Discussions.gif' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "'>"
                    ''Args.ApplyHTMLEncode = False
                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    Args.StringToBeInserted = "<TD vAlign=top width='5%' style='border-bottom: 1pt solid gray;'>" _
                                                & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif' alt= " & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "></A></TD>"
                    Cancel = True
                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                End If

                ''Commented By GaneshG on 15 Nov 06
                ''Purpose : As we are not showing following links on list, no need of following code
                ''Case "ASSIGNTASK"
                ''    Cancel = True

                ''    'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                ''    ' if logged in user is non hrm do not show assign Task link 
                ''    If blnIsHRM = 1 Then

                ''        ' Modified By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                ''        'To show Assign Task Link conditionaly 

                ''        If m_blnShowAssignTaskInHelpDesk = True Then

                ''            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                ''            m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                ''            strTD = "<td >" & vbCrLf
                ''            If Trim(Args.DataReader("TaskAssignedToUserName").ToString & "") <> "" Then
                ''                If Trim(Args.DataReader("StatusID").ToString & "") <> "2" And Trim(Args.DataReader("StatusID").ToString & "") <> "7" Then
                ''                    '' START : Commented and Modified By ParagD 28-Sept-2006
                ''                    '' strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",1,'" & m_PKToken_Query_DT & "')" & Chr(34) & ">" & vbCrLf
                ''                    strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",1,'" & m_PKToken_Query_DT & "'," & Args.DataReader("TaskID").ToString & ")" & Chr(34) & ">" & vbCrLf
                ''                    '' END : Commented and Modified By ParagD 28-Sept-2006
                ''                    strTD += Server.HtmlEncode(Args.DataReader("TaskAssignedToUserName").ToString)
                ''                    strTD += "</A>" & vbCrLf
                ''                Else
                ''                    '' START : Commented and Modified By ParagD 28-Sept-2006
                ''                    ''strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",0,'" & m_PKToken_Query_DT & "')" & Chr(34) & ">" & vbCrLf
                ''                    strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",0,'" & m_PKToken_Query_DT & "'," & Args.DataReader("TaskID").ToString & ")" & Chr(34) & ">" & vbCrLf
                ''                    '' END : Commented and Modified By ParagD 28-Sept-2006
                ''                    '' End :  ParagD 28-Sept-2006
                ''                    strTD += Server.HtmlEncode(Args.DataReader("TaskAssignedToUserName").ToString)
                ''                    strTD += "</A>" & vbCrLf
                ''                End If
                ''            Else
                ''                If Trim(Args.DataReader("StatusID").ToString & "") <> "2" And Trim(Args.DataReader("StatusID").ToString & "") <> "7" Then
                ''                    strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & vbCrLf
                ''                    strTD += Args.DataReader("QueryID").ToString & ",'1','" & m_PKToken_Query_DT & "')" & Chr(34) & ">" & MyBase.GetResourceString("ASSIGN_TASK_LINK") & "</A>" & vbCrLf
                ''                End If
                ''            End If
                ''            strTD += "</td>" & vbCrLf
                ''            Args.StringToBeInserted = strTD

                ''        End If
                ''    End If

                ''    ' End Modification By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                ''    ' To show Assign Task Link conditionaly 

                ''Case "REJECT"

                ''    ' Modified By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                ''    If m_blnShowAssignTaskInHelpDesk = True Then

                ''        'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                ''        ' if logged in user is non hrm do not show assign issue link 
                ''        If blnIsHRM = 1 Then

                ''            ' hide reject link on following logic
                ''            If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "7" Then
                ''                ' ***NOTE StatusID #7 -> Rejected Queries
                ''                strTD = "<td></td>" & vbCrLf
                ''                Cancel = True
                ''                Args.StringToBeInserted = strTD
                ''            Else
                ''                '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''                m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                ''                Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None' nowrap;>" _
                ''                                              & "<A href=""JavaScript:Reject_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("REJECT_LINK") & "</A></TD>"

                ''                Cancel = True
                ''                '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''            End If
                ''            If Cancel = False Then
                ''                If Trim(Args.DataReader("TaskID").ToString & "") <> "" Or Trim(Args.DataReader("NoOfIssues").ToString & "") <> "0" Then
                ''                    strTD = "<td></td>" & vbCrLf
                ''                    Cancel = True
                ''                    Args.StringToBeInserted = strTD
                ''                Else
                ''                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                ''                    Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None' nowrap;>" _
                ''                                                  & "<A href=""JavaScript:Reject_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("REJECT_LINK") & "</A></TD>"

                ''                    Cancel = True
                ''                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''                End If
                ''            End If
                ''        Else
                ''            Cancel = True
                ''        End If ' End if blnIsHRM = 1  
                ''        'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                ''    Else
                ''        Cancel = True
                ''    End If

                ''Case "ASSIGN ISSUE"
                ''    If m_blnShowAssignTaskInHelpDesk = False Then
                ''        Cancel = True
                ''    Else
                ''        'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                ''        ' if logged in user is non hrm do not show assign issue link 
                ''        If blnIsHRM = 1 Then
                ''            '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''            m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                ''            Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None' nowrap;>" _
                ''                                              & "<A href=""JavaScript:AssignIssue_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("ASSIGN_ISSUE_LINK") & "</A></TD>"

                ''            Cancel = True
                ''            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''        Else
                ''            Cancel = True
                ''        End If
                ''        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                ''    End If
                ''    ' End Modification By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                ''    ''Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
                ''Case "CHANGE DEPARTMENT"

                ''    'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                ''    Dim blnIsHrmForQuery As Boolean = False
                ''    blnIsHrmForQuery = m_arrAccessibleDepartments.ContainsValue(Args.DataReader("FunctionID"))

                ''    'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                ''    If blnIsHRM = 0 Then
                ''        Cancel = True
                ''    ElseIf blnIsHrmForQuery = False Then
                ''        Cancel = True
                ''        Args.StringToBeInserted = "<td>Change Department</td>"
                ''    Else
                ''        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                ''        Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None' nowrap;>" _
                ''                                          & "<A href=""JavaScript:ChangeDepartment_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & "Change Department" & "</A></TD>"

                ''        Cancel = True
                ''        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                ''    End If
                ''    ''End of Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
                ''    'added for whiziblesem 6 issue id 1936 for 
                ''    'if the logged in person has access to view only request then the chkbox should be disabled
                ''Case "SELECT"
                ''    'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                ''    'Dim drIfHRM As IDataReader
                ''    Dim blnIsHrmForQuery As Boolean = False
                ''    blnIsHrmForQuery = m_arrAccessibleDepartments.ContainsValue(Args.DataReader("FunctionID"))

                ''    'Dim strSQL As String = " SELECT CRMID FROM tbl_CRM_Function_CRMS Where CRMID = " & m_lngEmployeeID & " and FUNCTIONID = " & Args.DataReader("FunctionID").ToString & ")"
                ''    'strSQL += " UNION  select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " & m_lngEmployeeID & " and DepartmentID = " & Args.DataReader("FunctionID").ToString & ")"
                ''    'drIfHRM = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                ''    'If drIfHRM.Read Then
                ''    ' the change department link should be displyed
                ''    'blnIsHrmForQuery = 1
                ''    ' Else
                ''    '    blnIsHrmForQuery = 0
                ''    'End If
                ''    'CommonFunction.Data.DisposeDataReader(drIfHRM)

                ''    'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                ''    If blnIsHrmForQuery = False Then
                ''        Args.IsCheckBoxDisabled = True
                ''    End If
                ''    If m_blnShowAssignTaskInHelpDesk = True Then
                ''        If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "3" Or Trim(Args.DataReader("Department").ToString & "") = "" Or (Trim(Args.DataReader("TaskID").ToString & "") <> "" Or Trim(Args.DataReader("NoOfIssues").ToString & "") <> "0") Then
                ''            Args.IsCheckBoxDisabled = True
                ''        End If
                ''    Else
                ''        If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "3" Or Trim(Args.DataReader("Department").ToString & "") = "" Then
                ''            Args.IsCheckBoxDisabled = True
                ''        End If
                ''    End If

                ''Case Else
                ''End Comment By GaneshG
                'Added by NitinVS on 30 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11364 
                'Integrated by ArchanaN on 27 Apr 2007
                'Added by SriaknthY on 05 Jan 2007 To Open Flags Screen From e-Dashboard List page
            Case "FLAGTO"

                m_Queryid = CType(Args.DataReader("QueryID"), Integer)
                'If CType(Args.DataReader("FlagTo"), Integer) = 1 Then
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "1" Then
                    m_FlagStatus = "Review"
                    'ElseIf CType(Args.DataReader("FlagTo"), Integer) = 0 Then
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "0" Then
                    m_FlagStatus = "Follow Up"
                Else
                    m_FlagStatus = "Flag To"
                End If

                Cancel = True
                ''Commented and Added by Yogesh J on 20-Jan-2016 to generate Token
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "L" Then
                   ' Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "G" Then
                    ' Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/GreenFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/GreenFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "S" Then
                    ' Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                    'Added By ShraddhaM on 7,Aug 2007
                    'To Display Black flag for Completed Flaged requests
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "B" Then
                    ' Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/BlackFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/BlackFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                    'End of Addition By ShraddhaM on 7,Aug 2007
                Else
                    ''Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/Blank.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/Blank.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                End If
                'End of Addition by SrikanthY


            Case "LASTDISCUSSIONTHREAD"
                Args.ApplyHTMLEncode = False
                'End Added by NitinVS on 30 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11364 
                'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
                'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page

            Case "DESCRIPTION"

                m_Queryid = CType(Args.DataReader("QueryID"), Integer)
                Args.TDStyle = " NoWrap title='Description'"
                Args.StringToBeInserted = "<TD id= " + m_Queryid.ToString() + " name=" + m_Queryid.ToString() + " vAlign=top title='Description' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:ShowDescription_onClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='Description' onclick="""" ID='imgSummaryShowHide" & CType(m_Queryid, String) & "' name='imgSummaryShowHide" & CType(m_Queryid, String) & "'></a></TD>"
                Cancel = True
                'Ended by ShraddhaM
        End Select
        ' commented by harshada d for whiziblesem 6 for issue id 1936 helpdesk enhancements
        'If Args.ColIndex = 13 Then

        '    ' Modified By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 

        '    If m_blnShowAssignTaskInHelpDesk = True Then
        '        If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "3" Or Trim(Args.DataReader("Department").ToString & "") = "" Or (Trim(Args.DataReader("TaskID").ToString & "") <> "" Or Trim(Args.DataReader("NoOfIssues").ToString & "") <> "0") Then
        '            Args.IsCheckBoxDisabled = True
        '        End If
        '    Else
        '        If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "3" Or Trim(Args.DataReader("Department").ToString & "") = "" Then
        '            Args.IsCheckBoxDisabled = True
        '        End If
        '    End If

        '    ' End Modification By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 

        'End If
        'end of commentation by harshada d for whiziblesem 6 for issue id 1936 helpdesk enhancements
    End Sub

    'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
    'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint

        m_Queryid = CType(Args.DataReader("QueryID"), Integer)
        intTotalCol = CType(Args.DataReader.Table.Columns.Count, Integer)
        Dim intAssignTo As Integer
        Dim TotalTimeSpent As String
        TotalTimeSpent = CType(Args.DataReader("TotalTimeSpent"), String)
        Dim status As String
        Dim statusID As String
        Dim RequestorType As String

        If IsDBNull(Args.DataReader("AssignToID")) Then
            intAssignTo = 0
        Else
            intAssignTo = CType(Args.DataReader("AssignToID"), Integer)
        End If

        status = Args.DataReader("Status").ToString()
        statusID = Args.DataReader("StatusID").ToString()

        RequestorType = Args.DataReader("LoginType")

        Args.StringToBeInserted = "<TR class=" + strClass + " id='Description" & CType(m_Queryid, String) & "' name='Description" & CType(m_Queryid, String) & "' width=99.9% style=""display:none"">"
        Args.StringToBeInserted += "<TD align=left colspan=" + intTotalCol.ToString() + ">"
        Args.StringToBeInserted += "<DIV id=Summary" & CType(m_Queryid, String) & " name=Summary" & CType(m_Queryid, String) & " style=""overflow:auto;display:none"">"

        Args.StringToBeInserted += "<TABLE ID='Description' cellspacing=0 cellpadding=0 Width=99.9% class=clsGridTable>"
        Args.StringToBeInserted += "<tr class=" + strClass + ">"
        Args.StringToBeInserted += "<td valign=top colspan='7' align='left' width=10%><b>Description</b> : "
        Args.StringToBeInserted += Server.HtmlEncode(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), ""), String))
        Args.StringToBeInserted += "</TD></TR>"

        Args.StringToBeInserted += "<TR class=" + strClass + " >"

        ' Added by VijayD on 11 Jun 2009 For HelpDesk StatusFlow Configuration
        Dim m_StatusFlowCount As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(m_Queryid, String) + "", MyBase.UseSQL), "0"), String)
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount" + CType(m_Queryid, String), "StatusFlowCount" + CType(m_Queryid, String), , , , m_StatusFlowCount, IsHidden:=True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus" + CType(m_Queryid, String), "txtOldStatus" + CType(m_Queryid, String), , , , status, IsHidden:=True, EnableHTMLEncode:=True))

        'ended by Yogesh J for HTML encoding Date:05/10/15
        Dim m_IntSubRequestID As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select SubRequestTypeID from tbl_CRM_Query_Master where queryID=" + CType(m_Queryid, String) + "", MyBase.UseSQL), "0"), String)

        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus" + CType(m_Queryid, String), "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "',2,'" + status + "'", DisplayNone:=True)) '--, displaynone:=True
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus" + CType(m_Queryid, String), "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "'," + "1", DisplayNone:=True)) ', displaynone:=True
        ' Addition End by VijayD on 11 Jun 2009

        'Assign To
        Args.StringToBeInserted += "<TD valign=middle align='left' id=AssignTo" + CType(m_Queryid, String) + " style='border-bottom: 1px solid gray;width:15%;'>"

        If CType(Args.DataReader("IsHRMOrDeptHead"), Boolean) = True And CType(Args.DataReader("StatusID"), Integer) <> 2 Then

            If intAssignTo = 0 Then
                Args.StringToBeInserted += "<A style='text-decoration:underline;' href=""javascript:AssignToMe_onClick(" + m_Queryid.ToString + " )"" ><Font color=red><B>Assign To me</B></Font></A>"
            ElseIf intAssignTo = CType(Session("intUserID"), Integer) Then
                Args.StringToBeInserted += "<B><Font color=red>Assigned To me</Font></B>"
            Else
                Args.StringToBeInserted += "<B><Font color=red>Assigned To : " + Args.DataReader("AssignToName").ToString() + "</Font></B>"
            End If
        Else
            If intAssignTo = CType(Session("intUserID"), Integer) Then
                Args.StringToBeInserted += "<B><Font color=red>Assigned To me</Font></B>"
            ElseIf intAssignTo = 0 Then
                Args.StringToBeInserted += "<B><Font color=red>Not Assigned</Font></B>"
            Else
                Args.StringToBeInserted += "<B><Font color=red>Assigned To : " + Args.DataReader("AssignToName").ToString() + "</Font></B>"
            End If
        End If

        Args.StringToBeInserted += "</TD>"

        'TotalTimeSpent
        '''PrashantSJ
        Args.StringToBeInserted += "<TD  align=left id=TotalTime" + CType(m_Queryid, String) + " style='border-bottom: 0px solid gray;display:none;' TotalTime=" + TotalTimeSpent.ToString() + ">"
        Args.StringToBeInserted += "<B><U><A onClick='ShowDetailActivity(event," + CType(m_Queryid, String) + ")' >Total Time Spent</A></U>&nbsp;:&nbsp;" + TotalTimeSpent.ToString() + "&nbsp;Hrs</B>&nbsp;&nbsp;"
        Args.StringToBeInserted += "</TD>"

        'Status Change
        If statusID = 2 Then
            Args.StringToBeInserted += "<TD  align=left  style='border-bottom: 1px solid gray;cursor:hand;width:25%;'>"

            Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15

            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , "disabled", True, EnableHTMLEncode:=True)
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle  >"

            Args.StringToBeInserted += "</TD>"

            'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
            'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
            'Args.StringToBeInserted += "</TD>"

        Else
            Args.StringToBeInserted += "<TD  align='left' style='border-bottom: 1px solid gray;width:25%;'  >"

            Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15

            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , " onclick=ShowStatus(" + m_Queryid.ToString + ",event) ", True, EnableHTMLEncode:=True)

            'ended by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' >"
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += "</TD>"

            'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
            'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
            'Args.StringToBeInserted += "</TD>"

        End If


        'Time Spent 'Time period
        Args.StringToBeInserted += "<TD id=TimeSpent" + CType(m_Queryid, String) + " align='left' style='border-bottom: 1px solid gray;width:25%;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + ">"

        Args.StringToBeInserted += "Time Spent&nbsp;"
        If statusID = 2 Then


            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , True, , , , , True, EnableHTMLEncode:=True)
        Else
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , , , , , , True, EnableHTMLEncode:=True)

        End If
        'ended by Yogesh J for HTML encoding Date:05/10/15


        Args.StringToBeInserted += "&nbsp;(Min)&nbsp;<A onClick='ShowDetailActivity(event," + CType(m_Queryid, String) + ")' ><img src='../../Images/cssImages/Link images/ViewHistory.gif' valign=middle  alt='Show Detail Time Spent' /></a></TD>"
        Args.StringToBeInserted += "<TD id=TimeSpent" + CType(m_Queryid, String) + " align='left' style='border-bottom: 1px solid gray;width:30%;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + ">Activity&nbsp;"
        'Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 250, 2000, , , "cursor:hand;", , , , , " onkeyup=SearchActivity(" + m_Queryid.ToString + ",event) onkeydown=processKeys(event)", True)
        If statusID = 2 Then
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , True, True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += "<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;' >"
        Else
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , , True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            Args.StringToBeInserted += "<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;'  onclick=SearchActivity(" + m_Queryid.ToString + ",event) >"
        End If

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidActivityID" + m_Queryid.ToString, "hidActivityID" + m_Queryid.ToString, , 50, 2000, , , , , , , True, , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15

        'Args.StringToBeInserted += "</B>"
        'Args.StringToBeInserted += CommonFunction.HTMLControls.DrawComboBox("cboTimeUnits", "select 'M','Minutes' UNION select 'H','Hours'", 80, ReturnAsHTML:=True)
        If statusID = 2 Then
            Args.StringToBeInserted += "</TD><TD id=TimeSpent" + CType(m_Queryid, String) + " align='left' style='border-bottom: 1px solid gray;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + "> <input  type=button id=btnSave" + CType(m_Queryid, String) + " onclick='SaveActivity_OnClick(" + m_Queryid.ToString + ")' value=""Save"" disabled />"
        Else
            Args.StringToBeInserted += "</TD><TD id=TimeSpent" + CType(m_Queryid, String) + " align='left' style='border-bottom: 1px solid gray;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + "><input  type=button id=btnSave" + CType(m_Queryid, String) + " onclick='SaveActivity_OnClick(" + m_Queryid.ToString + ")' value=""Save"" />"
        End If

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Args.StringToBeInserted += "&nbsp;" + CommonFunction.HTMLControls.DrawTextBox("txtSavingLable" + CType(m_Queryid, String), "txtSavingLable" + CType(m_Queryid, String), , , 100, "Saving....", , "width:80px;BACKGROUND-COLOR:#FFFF80;border-color:gray;display:none;", , True, "#FFFF80", returnHTML:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15

        Args.StringToBeInserted += "</TD>"

        'Requestor Details and Statistics 
        Args.StringToBeInserted += "<TD id=RequestorDtl" + CType(m_Queryid, String) + " align='left' style='border-bottom: 1px solid gray;width:15%;'>"
        Args.StringToBeInserted += "<B><U><A onClick='ShowRequestorDetails(event," + CType(m_Queryid, String) + ",""" + RequestorType + """)' >Requestor</A></U></B>"
        Args.StringToBeInserted += "&nbsp;&nbsp;&nbsp;&nbsp;<B><U><A onClick='ShowStatistics(event," + CType(m_Queryid, String) + ",""" + RequestorType + """)' >Statistics</A></U></B>"
        Args.StringToBeInserted += "</TD>"


        Args.StringToBeInserted += "</TR></Font>"

        Args.StringToBeInserted += "</TABLE></DIV>"
        Args.StringToBeInserted += "</TD></TR>"

        intTotalCol = 0

        If strClass = "clsTROdd" Then
            strClass = "clsTREven"
        Else
            strClass = "clsTROdd"
        End If

        count = count + 1

    End Sub



    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        Args.TableStyle = " cellpadding=0 cellspacing=0  style='border-right: 2px solid gray;border-left: 2px solid gray;border-top: 2px solid gray;'"
    End Sub

    'Ended by ShraddhaM

    Private Sub m_objSectionTitle_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle) Handles m_objSectionTitle.Initialize
        Args.clsTR = "clsTRMenu"
    End Sub
#End Region



    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
        If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS") Then
            'Dim dr As IDataReader
            'Dim lngCRMID As Long
            'dr = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID, m_blnUseSQL)

            'If dr.Read = False Then
            'lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
            ' If blnIsHRM = 0 Then
            Cancel = True
            'End If
            'End If
            'CommonFunctions.Data.DisposeDataReader(dr)
        End If

        'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

        'Addition by SuchitraP on 2-Sept-2008 
        'Purpose:To Show Publish to KM and WF approvals link only when WF is enabled
        If Not m_strMode Is Nothing And m_strMode <> "" Then
            If m_strMode = "DB" Then
                If Args.LinkName.ToUpper = "WORKFLOW APPROVALS" Then
                    Cancel = True
                End If
            End If
        End If

        'If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode").ToString.ToUpper(), "") <> "" Then
        '    If Request.QueryString("Mode").ToString.ToUpper() = "MD" Then
        '        If Args.LinkName.ToUpper = "PUBLISH TO KM" Then
        '            Cancel = True
        '        End If
        '    End If
        'End If
        'End by SuchitraP

    End Sub
End Class
