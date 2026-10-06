Imports System.Web.HttpUtility
Imports System.Text
Public Class CRM_Dashboard
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

    Private m_lngDeptID As Long = 0

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
    'Integrated by ArchanaN on 27 Apr 2007
    'Added by SriaknthY on 05 Jan 2006 To integrate Flag Tracking screen on e-Dashboard list  
    Protected m_FlagStatus As String
    Protected m_Queryid As Integer
    'Integration Ends
    Private m_dsGrid As DataSet
    Protected m_filterID As Integer = 0
    Private m_strFilterText As String
    'Added by SandipL for SLA Access
    Private m_blnSLAAccess As Boolean = False
    'End addition by SandipL

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
    Private strSelectedValues As String
    Protected m_strGanttView As String = "2"
    Protected GantView_StartDt As Date
    Protected GantView_EndDt As Date
    Protected MonDiff As Integer = 1
    Protected drMonthHead As IDataReader
    Protected dsWeekHead As DataSet
    Private m_dsWeek As DataSet
    Protected sbHTML As StringBuilder
    Protected m_strSQL As String = ""
    Private m_strPeriod As String = ""
    Protected dtTempStartDate As String = ""
    Protected dtTempEndDate As String = ""
    Private strTextSearch As String = ""
    Private strTextSearch_ForQuery As String = ""
    Private strSearchType As String
    Protected m_DateFilter As String = ""
    Protected m_SearchFilterName As String = ""
    Protected m_SearchFilterValue As String = ""

    Private arrStartDates_MonthWise As ArrayList
    Private arrEndDates_MonthWise As ArrayList
    Private arrRVerticals As String = ""
    Private arrRightVerticals() As String
    Private arrLVerticals As String = ""
    Private arrLeftVerticals() As String
    Private strVertRightRBs As String = ""
    Private arrVertRightRB() As String
    Private strVertLeftLBs As String = ""
    Private arrVertLeftLB() As String
    Private RB_validateDT As Date
    Private GanttStartDate As String
    Private GanttEndDate As String
    Protected m_AdvanceFilter As String = ""
    'Ended by ShraddhaM
    Protected m_blnHRM As Boolean = False
    Protected m_objCFDS As DataSet
    Private m_strQueryid As String

 

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

        If Not Request.QueryString("Apply") Is Nothing And Request.QueryString("Apply") <> "" Then
            strAction = Request.QueryString("Apply").ToString()
        End If

        If strAction = "APPLYVIEW" Then
            Call SaveViewColumns()
        End If

        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If



    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ''MyBase.ApplySecurity(False, 2)
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
    End Sub

    ''Added by Nilesh Gundecha on 19/1/2015 for URL blocking issue
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(Queryid As String, EmployeeID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(Queryid, String) + CType(EmployeeID, String) + "0" + "0")
        Return m_PKToken_Request_Multiple

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_RequestSLA(Queryid As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken("True" + CType(Queryid, String) + "0" + "0")
        Return m_PKToken_Request_Multiple

    End Function

    ''endded by Nilesh Gundecha on 19/1/2015 for URL blocking issue

    'Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateShowSLAToken(FilterID As String) As String
        Dim m_PKToken_ShowSLA As String
        m_PKToken_ShowSLA = CommonFunctions.Security.Token.GetToken(CType(FilterID, String) + "0" + "0")
        Return m_PKToken_ShowSLA
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateShowCounterToken(FilterID As String) As String
        Dim m_PKToken_ShowCounterA As String
        m_PKToken_ShowCounterA = CommonFunctions.Security.Token.GetToken(CType(FilterID, String) + "0" + "0")
        Return m_PKToken_ShowCounterA
    End Function
    'End Of Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 

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
        ' Mode of the  page

        Dim dtTempDate As Date

        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode").ToString.ToUpper() = "MD" Then
                Server.Transfer("CRM_MyDashboard.aspx", True)
            End If
        End If

        If Session("strCRM_Filter_DB") Is Nothing Then
            Session("strCRM_Filter_DB") = ""
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

        If Trim(MyBase.GetFormValue("cboLocation") & "") <> "" Then
            m_lngLocationID = CType(MyBase.GetFormValue("cboLocation"), Long)
            'Uncommented By ShradddhaM on 25,July 2007
            '//HelpDesk - e-Dashboard-> Filter value does not persist
            'Added By KapilGK on 19 Oct 2006 
        Else
            If Request.QueryString("LocationID") <> "" Then
                m_lngLocationID = CType(Request.QueryString("LocationID"), Long)
            End If
            'End of Addition By KapilGK On 19 Oct 2006
            'End of Uncommented By ShradddhaM on 25,July 2007
        End If

        'Added By Bharat Tekade

        If Trim(MyBase.GetFormValue("cboDepartment") & "") <> "" Then
            m_lngDeptID = CType(MyBase.GetFormValue("cboDepartment"), Long)
            'Uncommented By ShradddhaM on 25,July 2007
            '//HelpDesk - e-Dashboard-> Filter value does not persist
            'Added By KapilGK on 19 Oct 2006 
        Else
            If Request.QueryString("DepartmentID") <> "" Then
                m_lngDeptID = CType(Request.QueryString("DepartmentID"), Long)
            End If
            'End of Addition By KapilGK On 19 Oct 2006
            'End of Uncommented By ShradddhaM on 25,July 2007
        End If

        'Ended By Bharat Tekade

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        m_blnIsDefaultMode = IsDefaultMode(m_lngEmployeeID)
        m_lngDepartmentID = GetEmployeeDepartment(m_lngEmployeeID)


        m_blnHRM = CType(CommonFunction.Data.GetDataScalar("usp_CRM_CheckCRMAccess " + m_lngEmployeeID.ToString, MyBase.UseSQL), Boolean)


        If m_lngStatusID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_STATUS" Then
            ' get the default status for the user
            m_lngStatusID = CType(GetDefault(m_lngEmployeeID, "DefaultStatus_DB"), Long)
        End If

        If m_lngLocationID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_LOCATION" Then
            ' get the default location for the user
            m_lngLocationID = CType(GetDefault(m_lngEmployeeID, "DefaultLocation"), Long)
        End If

        'added by bharat
        If m_lngDeptID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_DEPARTMENT" Then
            ' get the default Department for the user
            m_lngDeptID = CType(GetDefault(m_lngEmployeeID, "DefaultDepartment"), Long)
        End If

        'ended by bharat





        If Trim(Session("strCRM_Filter_DB").ToString & "") = "" Then
            'added by harshada d for issue id helpdesk issue id 1936 for retaining the filter on 28 th april 2006
            If Not Request.QueryString("FilterID") Is Nothing Then
                If Request.QueryString("FilterID") <> "" Then
                    m_lngFilterID = CType(Request.QueryString("FilterID"), Long)
                End If

            End If

            'end of addition by harshada d for issue id 1936 on 28 th april 2006
            If Trim(m_lngFilterID & "") = "" And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" Then
                ' get the default filter for the user
                m_lngFilterID = CType(GetDefault(m_lngEmployeeID, "DefaultFilter_DB"), Long)
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
        blnIsHRM = 0
        'Following Code is commented by PrashantD on 6 Jun 2007 for CleanUp Activity
        'Added by Manishk on 25th Feb 06 For SP 6 issue
        'Dim dr As IDataReader
        'Dim strSQL As String
        'Dim lngCRMID As Long


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
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity

        'End Added by Manishk on 25th Feb 06 For SP 6 issue
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

        drAccessibleDepartments = CommonFunction.Data.GetDataReader(sbAccessibleDepartemnts.ToString, MyBase.UseSQL)

        If drAccessibleDepartments.Read Then
            m_arrAccessibleDepartments(Counter) = CType(CommonFunction.Data.CheckIsDBNull(drAccessibleDepartments("FunctionID"), "0"), Integer)
            Counter += 1
            blnIsHRM = 1
        End If
        While drAccessibleDepartments.Read
            m_arrAccessibleDepartments(Counter) = CType(CommonFunction.Data.CheckIsDBNull(drAccessibleDepartments("FunctionID"), "0"), Integer)
            Counter += 1
        End While

        CommonFunction.Data.DisposeDataReader(drAccessibleDepartments)
        'end of move by PrashantD on 6 Jun 2007
        'Added by SandipL for SLA access check
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()

        objGlobal.TagID = 3821

        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        objAccessRights.GetAccess()

        m_blnSLAAccess = objAccessRights.View
        'End addition by SandipL        

        If Trim(MyBase.GetFormValue("cboSelectSearch") & "") <> "" Then
            strSearchType = CType(MyBase.GetFormValue("cboSelectSearch"), String)
        Else
            strTextSearch = ""
            strSearchType = ""
        End If

        If Not Request.Form("cboSelectSearch") Is Nothing Then
            m_SearchFilterName = CommonFunction.Data.CheckIsDBNull(Request.Form("cboSelectSearch"), "").ToString()
        End If

        'If m_SearchFilterName = "" OrElse UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_SEARCH_FILTER" Then
        If UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_SEARCH_FILTER" Then
            GetDefaultSearchFilters(m_lngEmployeeID, "DefaultSearchFilter_DB")

            If m_SearchFilterName = "Assigned To_SearchFilter_DB" Then
                strSearchType = "Assigned To"
            ElseIf m_SearchFilterName = "Subject_SearchFilter_DB" Then
                strSearchType = "Subject"
            ElseIf m_SearchFilterName = "Request Type_SearchFilter_DB" Then
                strSearchType = "Request Type"
            ElseIf m_SearchFilterName = "Sub Request Type_SearchFilter_DB" Then
                strSearchType = "Sub Request Type"
            ElseIf m_SearchFilterName = "Customer_SearchFilter_DB" Then
                strSearchType = "Customer"
            ElseIf m_SearchFilterName = "Employee_SearchFilter_DB" Then
                strSearchType = "Employee"
            ElseIf m_SearchFilterName = "Priority_SearchFilter_DB" Then
                strSearchType = "Priority"
            ElseIf m_SearchFilterName = "Severity_SearchFilter_DB" Then
                strSearchType = "Severity"
            ElseIf m_SearchFilterName = "Location_SearchFilter_DB" Then
                strSearchType = "Location"
            End If

            strTextSearch = m_SearchFilterValue


        End If

        'Added by ShraddhaM for Requestor Filter in Whiziblesem8 on 27,Apr 2009   

        Select Case strSearchType
            Case "Priority"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPriority"), "")
                End If
                If strTextSearch <> "" Then m_AdvanceFilter = " PriorityID = " + strTextSearch

            Case "Assigned To"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboAssignedTo"), "")
                End If
                If strTextSearch <> "" Then m_AdvanceFilter = " AssignToID = " + strTextSearch
            Case "Customer"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCustomer"), "")
                End If

                If strTextSearch <> "" Then m_AdvanceFilter = " CustomerId = ''" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strTextSearch)) + "'' AND LoginType = ''C'' "
            Case "Employee"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboEmployee"), "")
                End If

                If strTextSearch <> "" Then m_AdvanceFilter = " CustomerId = ''" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strTextSearch)) + "'' AND LoginType = ''E'' "
            Case "Location"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboLocation"), "")
                End If

                If strTextSearch <> "" Then m_AdvanceFilter = " TargetLocationId = " + strTextSearch
            Case "Request Type"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboRequestType"), "")
                End If

                If strTextSearch <> "" Then m_AdvanceFilter = " RequestTypeId = " + strTextSearch
            Case "Sub Request Type"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSubRequestType"), "")
                End If

                If strTextSearch <> "" Then m_AdvanceFilter = " SubRequestTypeID = " + strTextSearch
            Case "Subject"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubject"), "")
                End If
                strTextSearch_ForQuery = strTextSearch
                strTextSearch_ForQuery = strTextSearch_ForQuery.Replace("%", "[%]")
                strTextSearch_ForQuery = strTextSearch_ForQuery.Replace("_", "[_]")
                If strTextSearch <> "" Then m_AdvanceFilter = " Subject Like ''%" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strTextSearch_ForQuery)) + "%'' "
            Case "Severity"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSeverity"), "")
                End If

                If strTextSearch <> "" Then m_AdvanceFilter = " SeverityID  = " + strTextSearch
            Case Else
                strTextSearch = ""
        End Select


        'If Not Request.QueryString("GanttStartDate") Is Nothing And Request.QueryString("GanttStartDate") <> "" Then
        '    GanttStartDate = Request.QueryString("GanttStartDate").ToString()
        '    GanttEndDate = Request.QueryString("GanttEndDate").ToString()
        'End If

        If Not Request.Form("cboDateFilter") Is Nothing Then
            m_DateFilter = CommonFunction.Data.CheckIsDBNull(Request.Form("cboDateFilter"), "").ToString()
        End If
        If m_DateFilter = "" And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_DATEFILTER" Then
            m_DateFilter = GetDefault(m_lngEmployeeID, "DefaultDateFilter")
        End If

        'Ended by ShraddhaM

        ''Added by ShraddhaM on 24,Apr 2009 for Whiziblesem8
        'If m_strGanttView = "2" Then
        '    m_strSQL = "usp_Sel_CalenderYear_Weeks_ForHelpDeskGantt "

        '    If Not Request.Form("hidGanttStartDate") Is Nothing And m_strPeriod.ToUpper = "PREV" Then
        '        m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, -56, CType(Request.Form("hidGanttStartDate"), Date))) & "'"
        '    ElseIf Not Request.Form("hidGanttEndDate") Is Nothing And m_strPeriod.ToUpper = "NEXT" Then
        '        m_strSQL &= "'" & CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, -27, CType(Request.Form("hidGanttEndDate"), Date))) & "'"
        '    Else
        '        m_strSQL &= "'" & CType("1-" + MonthName(Date.Today.Month) + "-" + Date.Today.Year.ToString, Date) & "'"
        '    End If

        '    m_strSQL &= "," & CommonFunction.Application.StartingDayofweek.ToString

        '    dsWeekHead = CommonFunction.Data.GetDataSet(m_strSQL, "Week", , , MyBase.UseSQL)

        '    For Each drRow As DataRow In dsWeekHead.Tables(0).Rows
        '        dtTempStartDate = CType(CommonFunction.Data.CheckIsDBNull(drRow("MinStartDate")), String)
        '        dtTempEndDate = CType(CommonFunction.Data.CheckIsDBNull(drRow("MaxEndDate")), String)
        '        Exit For
        '    Next

        'End If

        'If Not Request.Form("hidGanttStartDate") Is Nothing And Not Request.Form("hidGanttEndDate") Is Nothing Then
        '    'If dtTempStartDate = "" And dtTempEndDate = "" Then
        '    GantView_StartDt = CType(Request.Form("hidGanttStartDate"), Date)
        '    GantView_EndDt = CType(Request.Form("hidGanttEndDate"), Date)
        '    'End If
        'Else
        '    If dtTempStartDate <> "" And dtTempEndDate <> "" Then
        '        GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
        '        GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
        '    Else
        '        GantView_StartDt = CType("1-" + MonthName(DateAdd(DateInterval.Month, -1, Date.Now).Month) + "-" + DateAdd(DateInterval.Month, -1, Date.Now).Year.ToString, Date)
        '        dtTempDate = DateAdd(DateInterval.Month, MonDiff - 1, GantView_StartDt)
        '        GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(dtTempDate.Year, dtTempDate.Month)) - 1, dtTempDate)
        '    End If
        'End If

        'If m_strPeriod.ToUpper = "PREV" Then
        '    If m_strGanttView = "1" Then
        '        GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(GantView_StartDt.Year, GantView_StartDt.Month)) - 1, GantView_StartDt) ''DateAdd(DateInterval.Day, -1, GantView_StartDt)
        '        GantView_StartDt = DateAdd(DateInterval.Month, -(MonDiff - 1), GantView_EndDt)
        '        GantView_StartDt = CType("1-" + MonthName(GantView_StartDt.Month) + "-" + GantView_StartDt.Year.ToString, Date)
        '    ElseIf m_strGanttView = "2" Then
        '        GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
        '        GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
        '    End If
        'ElseIf m_strPeriod.ToUpper = "NEXT" Then
        '    If m_strGanttView = "1" Then
        '        GantView_StartDt = CType("1-" + MonthName(GantView_EndDt.Month) + "-" + GantView_EndDt.Year.ToString, Date) ''DateAdd(DateInterval.Day, 1, GantView_EndDt)
        '        dtTempDate = DateAdd(DateInterval.Month, MonDiff - 1, GantView_StartDt)
        '        GantView_EndDt = DateAdd(DateInterval.Day, (Date.DaysInMonth(dtTempDate.Year, dtTempDate.Month)) - 1, dtTempDate)
        '    ElseIf m_strGanttView = "2" Then
        '        GantView_StartDt = CType(CommonFunction.Dates.GetDate(CType(dtTempStartDate, Date)), Date)
        '        GantView_EndDt = CType(CommonFunction.Dates.GetDate(CType(dtTempEndDate, Date)), Date)
        '    End If
        'End If
        ''Ended by ShraddhaM

        m_strSQL = "usp_Sel_Role_CustomField_CRM " + objGlobal.RoleLevel.ToString + "," + objGlobal.RoleID.ToString
        m_objCFDS = CommonFunction.Data.GetDataSet(m_strSQL, "CustomField", , , MyBase.UseSQL)

    End Sub


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
                strSQL = "usp_CRM_SetDefaultMode " & m_lngEmployeeID & ",'DB','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
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
                    Session("strCRM_Filter_DB") = ""
                    m_lngFilterID = 0
                End If
                'm_lngFilterID = 0
                If Trim(Request.Form("cboStatus") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultStatus	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboStatus") & "")) & "','DB'"
                Else
                    strSQL = "usp_CRM_SetDefaultStatus	" & m_lngEmployeeID & ",null,'DB'"
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

                'added by bharat 

            Case "SET_DEFAULT_DEPARTMENT"
                ' set default location
                If Trim(Request.Form("cboDepartment") & "") <> "" Then
                    'login Type condition added by harshada d on 22 11 2005 
                    strSQL = "usp_CRM_SetDefaultDepartment	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboDepartment") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                Else
                    'login Type condition added by harshada d on 22 11 2005 
                    strSQL = "usp_CRM_SetDefaultDepartment	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                'end bharat




            Case "SET_DEFAULT_FILTER"
                ' set default filter
                If Trim(Request.Form("cboFilter") & "") <> "" Then
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboFilter") & "")) & "','DB','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    m_lngFilterID = CType(MyBase.GetFormValue("cboFilter"), Long)
                Else
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",null,'DB','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    m_lngFilterID = 0
                    Session("strCRM_Filter_DB") = ""
                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)


            Case "CLEAR_FILTERS"
                Session("strCRM_Filter_DB") = ""
                'm_lngFilterID = 0
                ' Login Type condition added by harshada d on 22 11 2005
                strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",null,'DB','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                m_lngFilterID = 0
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "SET_DEFAULT_DATEFILTER"
                ' set default date Filter 
                If Trim(Request.Form("cboDateFilter") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultDateFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboDateFilter") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                Else
                    strSQL = "usp_CRM_SetDefaultDateFilter	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "SET_DEFAULT_SEARCH_FILTER"
                ' set default date Filter 
                Dim strSearchFilterName As String
                Dim strSearchFilterValue As String

                strSearchFilterName = Trim(Request.Form("cboSelectSearch") & "")

                If strSearchFilterName.ToUpper() = "ASSIGNED TO" Then
                    strSearchFilterValue = Request.Form("cboAssignedTo").ToString()
                ElseIf strSearchFilterName.ToUpper() = "SUBJECT" Then
                    strSearchFilterValue = Request.Form("txtSubject").ToString()
                ElseIf strSearchFilterName.ToUpper() = "REQUEST TYPE" Then
                    strSearchFilterValue = Request.Form("cboRequestType").ToString()
                ElseIf strSearchFilterName.ToUpper() = "SUB REQUEST TYPE" Then
                    strSearchFilterValue = Request.Form("cboSubRequestType").ToString()
                ElseIf strSearchFilterName.ToUpper() = "CUSTOMER" Then
                    strSearchFilterValue = Request.Form("cboCustomer").ToString()
                ElseIf strSearchFilterName.ToUpper() = "EMPLOYEE" Then
                    strSearchFilterValue = Request.Form("cboEmployee").ToString()
                ElseIf strSearchFilterName.ToUpper() = "PRIORITY" Then
                    strSearchFilterValue = Request.Form("cboPriority").ToString()
                ElseIf strSearchFilterName.ToUpper() = "SEVERITY" Then
                    strSearchFilterValue = Request.Form("cboSeverity").ToString()
                ElseIf strSearchFilterName.ToUpper() = "LOCATION" Then
                    strSearchFilterValue = Request.Form("cboLocation").ToString()

                End If

                strSearchFilterName = strSearchFilterName + "_SearchFilter_DB"

                If Trim(Request.Form("cboSelectSearch") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(strSearchFilterName) & "','" & CommonFunctions.General.BuildQueryString(strSearchFilterValue) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','DB'"
                    'strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(strSearchFilterName) & "','_SearchFilter_DB','" & CommonFunctions.General.BuildQueryString(strSearchFilterValue) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','DB'"
                Else
                    strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",null,null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','DB'"

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
        ' Revisions             : NitinVS on 9 May 2007 for WhizibleSEM Whizible 7.0 
        '=====================================================================

        'This is CSL specific menu aray
        'These 3 lines should be uncommented while releasing for CSL site
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SUPPORT_DASHBOARD"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SUPPORT_DASHBOARD"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        'Dim arrCSFunction() As String = {"SupportDashboard_OnClick()", "AssignMultipleRequests_OnClick()", "AssignMultipleTasks_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_DASHBOARD')"}

        '21 June 2007 SandipL -- Added Show SLA Link
        '03 July 2008 SuchitraP -- Added Publish to KM Link and Workflow approvals link
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
        ''''    Dim arrMenu() As String = {"Views", "HelpDesk Analysis", "Request Approvals", "Workflow Approvals", "Show SLA", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")} ' 
        ''''    Dim arrMenuToolTip() As String = {"Views", "HelpDesk Analysis", "Request Approvals", "Workflow Approvals", "Show SLA", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")} '"Show HelpDesk Dashboard",
        ''''    Dim arrCSFunction() As String = {"View_onClick(event)", "ShowHelpDeskGraph_Onclick()", "RequestApprovals_onClick()", "WorkflowApprovals_OnClick()", "ShowSLA_Onclick()", "AssignMultipleRequests_OnClick()", "AssignMultipleTasks_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "ShowReport_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_DASHBOARD')"} '
        ''''    m_objMenu = New WebPage.Templates.StaticMenu
        ''''    m_strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
        ''''Else
        '--- End comment purvaj
        '--- "Request Approvals", "Workflow Approvals", "Show SLA", "Show HelpDesk Dashboard", links removed. These pages are now called from the left pane.
        'Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        Dim DeptName As String
        Dim StrSqlDeptName As String
        StrSqlDeptName = "usp_Sel_getDepartmentName " + CType(Session("intUserID"), String)
        DeptName = CommonFunction.General.CheckIsNothing(CType(CommonFunction.Data.GetDataScalar(StrSqlDeptName, True), String), "")

        'End Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        Dim arrMenu() As String = {"FAQs", "Views", "Show SLA", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")} '"Show HelpDesk Dashboard",
        ''''"Request Approvals", "Show SLA",, "Show HelpDesk Dashboard",
        Dim arrMenuToolTip() As String = {"Frequently Asked Questions", "Views", "Show SLA", MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")} ' "Show HelpDesk Dashboard",
        ''''"Request Approvals", "Show SLA","Show HelpDesk Dashboard"
        Dim arrCSFunction() As String = {"Faq_OnClick('DB'," + CType(Session("intUserID"), String) + ",'" + DeptName + "')", "View_onClick(event)", "ShowSLA_Onclick()", "AssignMultipleRequests_OnClick()", "AssignMultipleTasks_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "ShowReport_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_DASHBOARD')"} ' "ShowHelpDeskGraph_Onclick()",
        'END Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
        ''''"RequestApprovals_onClick()", "ShowSLA_Onclick()","ShowHelpDeskGraph_Onclick()",
        m_objMenu = New WebPage.Templates.StaticMenu
        m_strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
        'End of modification by ShraddhaM on 9,Sept 2008
        '--- Commeented by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
        ''''End If
        '--- End comment purvaj
        'End by SuchitraP
        '--- End modification purvaj

        'Added by PrashantD on 30 April 2007 for IssueID 12619
        'Purpose: Sorting set by user does not persist
        Dim strSortBy As String
        Dim strSortOrder As String
        If CommonFunction.General.CheckIsNothing(Request.QueryString("SortOrder"), "") <> "" Then
            strSortOrder = Request.QueryString("SortOrder")
        Else
            strSortOrder = "DESC"
        End If
        If CommonFunction.General.CheckIsNothing(Request.QueryString("SortBy"), "") <> "" Then
            strSortBy = Request.QueryString("SortBy")
        Else
            strSortBy = "SubmittedDate"
        End If
        If strSortBy = "" Then
            strSortBy = "SubmittedDate"
        End If

        If strSortOrder = "" Then
            strSortOrder = "DESC"
        End If

        CommonFunction.General.WriteHTML("<input type=Hidden name=hidSortBy id=hidSortBy value=" + strSortBy + ">")
        CommonFunction.General.WriteHTML("<input type=Hidden name=hidSortOrder id=hidSortOrder value=" + strSortOrder + ">")
        'End of modification by PrashantD on 30 April 2007


        Dim dr As IDataReader
        Dim strSQL As String
        Dim strPaginSQL As String


        ''If Trim(Session("strCRM_Filter_DB").ToString & "") = "" And m_lngFilterID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" And UCase(Trim(m_strAction & "")) <> "CLEAR_FILTERS" Then
        If m_lngFilterID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" And UCase(Trim(m_strAction & "")) <> "CLEAR_FILTERS" Then
            m_lngFilterID = CType(GetDefault(m_lngEmployeeID, "DefaultFilter_DB"), Long)
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
            'Added by PrashantD on 07 Aug 2008
            Dim m_strQueryID As String
            'End of Addition and comment by PrashantD on 07 Aug 2008

            Dim m_strFromWhere As String = "DB"

            'Added by KanchanH on 1-Dec-2008 for RequestID-17029.
            Dim intHasAccess As Integer
            'End of addition by KanchanH on 1-Dec-2008 for RequestID-17029.

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
                    Response.Write(" window.open('CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&QueryID=" + m_lngQueryID.ToString + "&PageNumber=" + m_intPageNumber.ToString + "&PKToken=" + m_PKToken_GoOnClick + "','_requestdetail','resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700');  ")
                    'End of addition By ShraddhaM on 6,Aug 2007
                    Response.Write("</SCRIPT>")
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

                End If

            End If
        End If

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")


        ' End Modification By NitinVS on 22 July 3005 for PSPL ; To Allow Search Request

        'Commented by SuchitraP on 30-Aug-2008
        '' get the menu
        'm_objMenu = New WebPage.Templates.StaticMenu
        'm_strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
        'End of comment by SuchitraP

        ' build the sql
        strSQL = "EXEC usp_CRM_Sel_AllRequests " & m_lngEmployeeID

        If m_intPageNumber > 0 Then
            strSQL = strSQL + "," + m_intPageNumber.ToString
        Else
            strSQL = strSQL + ",0"
        End If

        ' is status specified
        If m_lngStatusID <> 0 Then
            strSQL = strSQL & "," & m_lngStatusID
        Else
            strSQL = strSQL & ",Null"
        End If
        'Uncommented By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
        '''Commented by Dhanashri S on 23 Feb 2015
        'Added by bharat

        If m_lngDeptID <> 0 Then
            strSQL = strSQL & "," & m_lngDeptID
        Else
            strSQL = strSQL & ",Null"
        End If

        'End bharat
        'End of Comment by Dhanashri S on 23 Feb 2015
        'End Of Uncommented By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing

        '' if location is specified
        'If m_lngLocationID <> 0 Then
        '    strSQL = strSQL & "," & m_lngLocationID
        'Else
        '    strSQL = strSQL & ",Null"
        'End If
        strSQL = strSQL & ",Null"

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
            strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(Session("strCRM_Filter_DB").ToString & "") & "'"
            'strSQL = strSQL & ",''"
        End If

        'Added by ShraddhaM on 27,Apr 2009 for Requestor Filter in WhizibleSem8 
        'If strTextSearch <> "" Then
        '    strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(strTextSearch.Trim()) & "'"
        '    strSQL = strSQL & ",'" & strSearchType & "'"
        'Else
        '    strSQL = strSQL & ",NULL,NULL"
        'End If

        'If GanttStartDate <> "" Then
        '    strSQL = strSQL & ",'" & GanttStartDate & "'"
        '    strSQL = strSQL & ",'" & GanttEndDate & "'"

        'End If

        If m_DateFilter <> "" Then
            strSQL = strSQL + "," + m_DateFilter
        Else
            strSQL = strSQL + ", Null "
        End If

        If m_AdvanceFilter <> "" Then
            strSQL += ",'" + m_AdvanceFilter + "'"
        Else
            strSQL += ",Null"
        End If

        strPaginSQL = strSQL

        'Added By Amol Changle On: 24 Jul 2009
        'Purpose: To show custom fields on list
        strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), "0").ToString()
        strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strLoginType"), "E").ToString() + "'"
        'End Addition

        'Ended by ShraddhaM

        MyBase.InitializeResources("AppResources.CRM_Dashboard", "AppResources")
        'Code added by PrashantD on 6 Jun 2007 for CleanUp Activity
        m_dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "default", , , m_blnUseSQL)
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity

        strSelectedValues = CommonFunction.Data.GetDataScalar("usp_Sel_tbl_CRM_HelpDesk_Views " + Session("intUserID").ToString() + ",'DB'", MyBase.UseSQL)

        If strSelectedValues Is Nothing Then
            strSelectedValues = ",Request Type,Priority,Product,Module/Component,Requestor,Requestor Name,Requested On,Exp. Date Of Resolution,status,Assign To,Last Updated,Show SLA,"
        End If

        With Response
            .Write(m_strMenu)

            'Commented by mrugajaB on 30th Apr 2005
            '.Write("<div id=divList style='OVERFLOW:auto'>")

            'Integrated by MrugajaB on 30th Apr 2005 for WHizibleSEM SP3
            ' Hotfix ID.4.0.95-BF Jan 11 2005
            ' Rajanikant Khethawatt Added Width:100%
            'commented by Shamkant S
            .Write("<div id=divList style='OVERFLOW:auto;width:99.99%;'>")
            '.Write("<div id=divList style='width:99.99%;'>")
            ' End Modification Jan 11 2005

            ' the option buttons
            '''Commented And Added By Vaijat K ON 07/12/2015 Issue ID-2422
            '.Write("<table width='99.9%' class=clsTable cellpadding=0 cellspacing=0 >")
            .Write("<table width='99.9%' class=clsTable cellpadding=0 cellspacing=0 style='table-layout: fixed;' >")
            '''End Added By Vaijat K ON 07/12/2015 Issue ID-2422
            .Write("<tr class=clsTREven>")
            .Write("<td >")
            Call WriteOptionButtons()
            .Write("</td >")
            .Write("</tr >")
            ' the filters combo

            .Write("<tr class=clsTREven>")
            .Write("<td >")
            Call WriteFilterCombos(m_lngEmployeeID)
            .Write("</td >")
            .Write("</tr >")
            ' paging
            .Write("<tr class=clsTREven>")
            .Write("<td >")
            Call WritePaging(strPaginSQL)
            .Write("</td >")
            .Write("</tr >")

            .Write("<tr class=clsTREven>")
            .Write("<td >")
            ' the grid goes here
            Call WriteGrid(strSQL)
            .Write("</td >")
            .Write("</tr >")

            .Write("</table>")

            '  .Write(m_strMenu)
            'The call for function DisplayGraphs should be commented for CSL

            'Commented by MrugajaB on 21st Nov 2006 for Whiziblesem SP8 
            'Purpose:To Remove the graphs displayed on e-dashboard page as graphs are not relevant with the requests getting displayed on e-dashbaord page
            'Call DisplayGraphs(m_lngEmployeeID, MyBase.GetResourceString("GRAPHS_CAPTION"))
            'End Comment


        End With

        'Code added by PrashantD on 6 Jun 2007 for CleanUp Activity
        m_dsGrid.Dispose() : m_dsGrid = Nothing
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity

        'Added by SuchitraP on 30-Aug-2008
        'Purpose:To Show Publish to KM and WF approvals link only when WF is enabled
        CommonFunction.General.WriteHTML("<input type=hidden name=hidMode id=hidMode value=" + Request.QueryString("Mode") + ">")
        'End of addition by SuchitraP

        CommonFunction.General.WriteHTML("<input type=hidden name=hidViewFields id=hidViewFields value='" + strSelectedValues + "'>")



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
            If UCase(Trim(dr("ItemValue").ToString & "")) = "DB" Then
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

        'Integrated by ArchanaN on 27 Apr 2007
        'SrikanthY on 28 Feb 2007 To Conditionally Show/Hide product,Components details to user
        Dim DataColCount As Integer = 13
        Dim ShowProduct As String
        'ShowProduct = CType(CommonFunctions.Data.GetDataScalar("SELECT IsNull(EnableProductExecution,0) As Show FROM  tbl_PM_companyinformation ", MyBase.UseSQL), String)
        If CommonFunction.Application.EnableProductExecution = True Then
            ShowProduct = "True"
        Else
            ShowProduct = "False"
        End If
        'End of addition by SrikanthY

        'Integration Ends

        'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

        'Integrated by SavitaS on 17 Nov 2005 for IssueID 1936
        'Added by SavitaS on 17 Nov 2005 for WhizibleSemSP4 enhancement
        'Purpose: If "Split Request Type-Sub Type" combo is checked at corporate level then show
        '         Reqest and SubRequestType seperately on the list else show them together.
        ' Modified By NitinVS on 9 May 2007 for Whizible 7.0 
        'If CommonFunction.Application.SplitRequestTypeSubType = True Then

        '    Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "RequestType", "SubRequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", "AssignTo", "AssignTask", MyBase.GetResourceString("ASSIGN_ISSUE_LINK"), MyBase.GetResourceString("REJECT_LINK"), "Change Department", "Select"}
        '    Dim arrIgnoreHTMLEncode() As String = {"1"}
        '    'integrated by harshadad on 19 dec 2005  for issue id 989 
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue, to show link for the pin.gif to show the attachments on the e-Dashboard tab of Helpdesk
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'Dim arrLink() As String = {"", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", ""}
        '    Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", "ChangeDepartment_OnClick(QueryID)", ""}
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'End of 'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'end of integration by harshada d on 19 dec 2005  for issue id 989 
        '    Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "chkSelect"}


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

        'Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, "Discussions", strRequestType_Caption, strSubRequestType_Caption, strPriority_Caption, strSubmittedBy_Caption, strSubmittedDate_Caption, strExpectedResolvedDate_Caption, strStatus_Caption, strAssignTo_Caption, "Assign Task", "Assign Issue", "Reject", "Change Department", "Select"}

        'Added by SrikanthY on 28 Feb 2007 Moved Data from Arrays to Arraylists , so that the conditional ways to show or hide some columns will be easier
        Dim alActualColumns As New ArrayList
        Dim alLinks As New ArrayList
        Dim aluserfriendlycol As New ArrayList
        Dim alcheckbox As New ArrayList

        'Added by ShraddhaM on 1,Apr 2009 for Whiziblesem8
        'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
        alActualColumns.Add("Description") : alLinks.Add("ShowDescription_onClick()") : aluserfriendlycol.Add("") : alcheckbox.Add("")
        'Ended by ShraddhaM
        'Added and commented by PrashantD on 23 May 2007 for CleanUp Activity       
        'alActualColumns.Add("FlagTo") : alLinks.Add("") : aluserfriendlycol.Add("<img src='../../Images/GrayFlag.gif'>") : alcheckbox.Add("")

        'alActualColumns.Add("Attachments") : alLinks.Add("Document_OnClick(QueryID)") : aluserfriendlycol.Add("<img src='../../Images/pin.gif'>") : alcheckbox.Add("")
        'alActualColumns.Add("Discussions") : alLinks.Add("Discussion_OnClick(QueryID)") : aluserfriendlycol.Add("Discussions") : alcheckbox.Add("")

        dr = CommonFunction.Data.GetDataReader("usp_Sel_GetCorporateView_HelpDeskDB", MyBase.UseSQL)
        Dim strColumn As String
        While dr.Read
            strColumn = dr(0).ToString
            Select Case strColumn.ToUpper
                Case "QUERYID"
                    alActualColumns.Add("QueryID") : alLinks.Add("") : aluserfriendlycol.Add("Request ID") : alcheckbox.Add("")
                    'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
                    'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
                    alActualColumns.Add("FlagTo") : alLinks.Add("") : aluserfriendlycol.Add("<img src='../../Images/GrayFlag.gif'>") : alcheckbox.Add("")
                    alActualColumns.Add("Attachments") : alLinks.Add("Document_OnClick(QueryID)") : aluserfriendlycol.Add("<img src='../../Images/pin.gif'>") : alcheckbox.Add("")
                    alActualColumns.Add("Discussions") : alLinks.Add("Discussion_OnClick(QueryID)") : aluserfriendlycol.Add("Discussions") : alcheckbox.Add("")
                    'Ended by ShraddhaM
                Case "SUBJECT"
                    alActualColumns.Add("Subject") : alLinks.Add("Query_OnClick(QueryID)") : aluserfriendlycol.Add(strSubject_Caption) : alcheckbox.Add("")

                Case "REQUESTTYPE"
                    alActualColumns.Add("RequestType") : alLinks.Add("") : aluserfriendlycol.Add(strRequestType_Caption) : alcheckbox.Add("")
                Case "SUBREQUESTTYPE"
                    If CommonFunction.Application.SplitRequestTypeSubType = True Then
                        alActualColumns.Add("SubRequestType") : alLinks.Add("") : aluserfriendlycol.Add(strSubRequestType_Caption) : alcheckbox.Add("")
                    End If
                Case "PRIORITY"
                    alActualColumns.Add("Priority") : alLinks.Add("") : aluserfriendlycol.Add(strPriority_Caption) : alcheckbox.Add("")
                Case "PRODUCT"
                    If ShowProduct = "True" Then
                        alActualColumns.Add("Product") : alLinks.Add("") : aluserfriendlycol.Add("Product") : alcheckbox.Add("")
                    End If
                Case "COMPONENT"
                    If ShowProduct = "True" Then
                        alActualColumns.Add("Component") : alLinks.Add("") : aluserfriendlycol.Add("Module/Component") : alcheckbox.Add("")
                    End If
                Case "CUSTOMERID"
                    alActualColumns.Add("CustomerID") : alLinks.Add("") : aluserfriendlycol.Add(strSubmittedBy_Caption) : alcheckbox.Add("")
                Case "CUSTOMERNAME"
                    alActualColumns.Add("CustomerName") : alLinks.Add("") : aluserfriendlycol.Add("Requestor Name") : alcheckbox.Add("")
                Case "SUBMITTEDDATE"
                    alActualColumns.Add("SubmittedDate") : alLinks.Add("") : aluserfriendlycol.Add(strSubmittedDate_Caption) : alcheckbox.Add("")

                    alActualColumns.Add("LastUpdatedDate") : alLinks.Add("") : aluserfriendlycol.Add("Last Updated") : alcheckbox.Add("")


                Case "EXPECTEDRESOLVEDDATE"
                    alActualColumns.Add("ExpectedResolvedDate") : alLinks.Add("") : aluserfriendlycol.Add(strExpectedResolvedDate_Caption) : alcheckbox.Add("")
                Case "STATUS"
                    alActualColumns.Add("Status") : alLinks.Add("") : aluserfriendlycol.Add(strStatus_Caption) : alcheckbox.Add("")
                Case "ASSIGNTO"
                    alActualColumns.Add("AssignTo") : alLinks.Add("") : aluserfriendlycol.Add(strAssignTo_Caption) : alcheckbox.Add("")
                    'Case "ASSIGNTASK"
                    '    alActualColumns.Add("AssignTask") : alLinks.Add("AssignTask_OnClick(QueryID)") : aluserfriendlycol.Add("Assign Task") : alcheckbox.Add("")
                    'Case "ASSIGN ISSUE"
                    '    alActualColumns.Add("Assign Issue") : alLinks.Add("AssignIssue_OnClick(QueryID)") : aluserfriendlycol.Add("Assign Issue") : alcheckbox.Add("")
                    'Case "REJECT"
                    '    alActualColumns.Add("Reject") : alLinks.Add("Reject_OnClick(QueryID)") : aluserfriendlycol.Add("Reject") : alcheckbox.Add("")
                    'Case "Change Department"
                    '    alActualColumns.Add("Change Department") : alLinks.Add("ChangeDepartment_OnClick(QueryID)") : aluserfriendlycol.Add("Change Department") : alcheckbox.Add("")

            End Select

        End While

        CommonFunction.Data.DisposeDataReader(dr)

        'Added By Amol Changle On: 24 Jul 2009
        'Purpose: To show custom fields on list
        Dim strActualFieldName As String
        Dim strUserFriendlyFieldName As String
        dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_CustomFields_Master 0,NULL,1,NULL,'Help-Desk'," + m_lngEmployeeID.ToString(), True)
        While dr.Read()
            strActualFieldName = CommonFunctions.Data.CheckIsDBNull(dr("DatabaseFieldName")).ToString()
            strUserFriendlyFieldName = CommonFunctions.Data.CheckIsDBNull(dr("UserGivenCaption"), strActualFieldName).ToString()
            If ("," + strSelectedValues + ",").Contains(",$" + strUserFriendlyFieldName + ",") And strActualFieldName <> "" Then
                alActualColumns.Add(strActualFieldName) : alLinks.Add("") : aluserfriendlycol.Add("$" + strUserFriendlyFieldName) : alcheckbox.Add("")
            End If
        End While
        CommonFunction.Data.DisposeDataReader(dr)
        'End Addition

        'Added by SandipL on 09 Jul 2007 - Request level SLA
        If m_blnSLAAccess = True Then
            alActualColumns.Add("Show SLA") : alLinks.Add("RequestSLA_OnClick(QueryID)") : aluserfriendlycol.Add("Show SLA") : alcheckbox.Add("")
        End If
        'End addition by SandipL

        alActualColumns.Add("Select") : alLinks.Add("") : aluserfriendlycol.Add("Select") : alcheckbox.Add("chkSelect")



        ''alActualColumns.Add("QueryID") : alLinks.Add("") : aluserfriendlycol.Add("Request ID") : alcheckbox.Add("")

        ''alActualColumns.Add("Subject") : alLinks.Add("Query_OnClick(QueryID)") : aluserfriendlycol.Add(strSubject_Caption) : alcheckbox.Add("")

        ''alActualColumns.Add("Discussions") : alLinks.Add("Discussion_OnClick(QueryID)") : aluserfriendlycol.Add("Discussions") : alcheckbox.Add("")

        ''alActualColumns.Add("RequestType") : alLinks.Add("") : aluserfriendlycol.Add(strRequestType_Caption) : alcheckbox.Add("")

        ''If CommonFunction.Application.SplitRequestTypeSubType = True Then
        ''    alActualColumns.Add("SubRequestType") : alLinks.Add("") : aluserfriendlycol.Add(strSubRequestType_Caption) : alcheckbox.Add("")
        ''    DataColCount += 1
        ''End If

        ''alActualColumns.Add("Priority") : alLinks.Add("") : aluserfriendlycol.Add(strPriority_Caption) : alcheckbox.Add("")

        ''If ShowProduct = "True" Then
        ''    alActualColumns.Add("Product") : alLinks.Add("") : aluserfriendlycol.Add("Product") : alcheckbox.Add("")

        ''    alActualColumns.Add("Component") : alLinks.Add("") : aluserfriendlycol.Add("Module/Component") : alcheckbox.Add("")
        ''    DataColCount += 2
        ''End If

        ''alActualColumns.Add("CustomerID") : alLinks.Add("") : aluserfriendlycol.Add(strSubmittedBy_Caption) : alcheckbox.Add("")

        ''alActualColumns.Add("CustomerName") : alLinks.Add("") : aluserfriendlycol.Add("Requestor Name") : alcheckbox.Add("")

        ''alActualColumns.Add("SubmittedDate") : alLinks.Add("") : aluserfriendlycol.Add(strSubmittedDate_Caption) : alcheckbox.Add("")

        ''alActualColumns.Add("ExpectedResolvedDate") : alLinks.Add("") : aluserfriendlycol.Add(strExpectedResolvedDate_Caption) : alcheckbox.Add("")

        ''alActualColumns.Add("Status") : alLinks.Add("") : aluserfriendlycol.Add(strStatus_Caption) : alcheckbox.Add("")

        '''Added by SrikanthY on 24 Mar 2007 to display Latest Issue Details on e-Dashboard
        '''alActualColumns.Add("LastIssue") : alLinks.Add("") : aluserfriendlycol.Add("Last Issue") : alcheckbox.Add("")
        '''alActualColumns.Add("LastIssueStatus") : alLinks.Add("") : aluserfriendlycol.Add("Last Issue Status") : alcheckbox.Add("")
        '''End of Addition by SrikanthY on 24 Mar 2007

        ''alActualColumns.Add("AssignTo") : alLinks.Add("") : aluserfriendlycol.Add(strAssignTo_Caption) : alcheckbox.Add("")

        ''alActualColumns.Add("AssignTask") : alLinks.Add("AssignTask_OnClick(QueryID)") : aluserfriendlycol.Add("Assign Task") : alcheckbox.Add("")

        ''alActualColumns.Add(MyBase.GetResourceString("ASSIGN_ISSUE_LINK")) : alLinks.Add("AssignIssue_OnClick(QueryID)") : aluserfriendlycol.Add("Assign Issue") : alcheckbox.Add("")

        ''alActualColumns.Add(MyBase.GetResourceString("REJECT_LINK")) : alLinks.Add("Reject_OnClick(QueryID)") : aluserfriendlycol.Add("Reject") : alcheckbox.Add("")

        ''alActualColumns.Add("Change Department") : alLinks.Add("ChangeDepartment_OnClick(QueryID)") : aluserfriendlycol.Add("Change Department") : alcheckbox.Add("")

        ''alActualColumns.Add("Select") : alLinks.Add("") : aluserfriendlycol.Add("Select") : alcheckbox.Add("chkSelect")
        'End of addition and comment by PrashantD on 23 May 2007 for CleanUp Activity

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        'Dim arrIgnoreHTMLEncode() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15

        Dim arrActualCols(alActualColumns.Count - 1) As String
        Dim arrLink(alLinks.Count - 1) As String
        Dim arrUserFriendlyCols(aluserfriendlycol.Count - 1) As String
        Dim arrchkbox(alcheckbox.Count - 1) As String

        alActualColumns.CopyTo(arrActualCols)
        alLinks.CopyTo(arrLink)
        aluserfriendlycol.CopyTo(arrUserFriendlyCols)
        alcheckbox.CopyTo(arrchkbox)

        alActualColumns = Nothing
        alLinks = Nothing
        aluserfriendlycol = Nothing
        alcheckbox = Nothing
        'End of Addition by SrikanthY on 28 Feb 2007

        m_objGrid = New WebPages.Template.GenericGrid



        With m_objGrid
            '.NoOfDataColumns = 12
            '.NoOfDataColumns = 15
            If m_blnSLAAccess = True Then
                .NoOfDataColumns = arrUserFriendlyCols.Length - 2
            Else
                .NoOfDataColumns = arrUserFriendlyCols.Length - 1
            End If

            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .RowLinkArray = arrLink
            .CheckBoxIDArray = arrchkbox
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
            .DIVID = "divGrid"
            .DIVStyle = "overflow:auto;width:100%"
            'Commented by shamkant S on 6 Nov 2015
            '  .DIVHeight = 330
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
        'intNoOfRows = m_dsGrid.Tables(0).Rows.Count
        'Commented And Added By Vaijat K ON 09/02/2016
        'intNoOfRows = m_intTotalNoOfRows
        intNoOfRows = m_intNoOfRows
        'Ended
        'ds.Dispose() : ds = Nothing
        'End of addition and comment by PrashantD on 6 Jun 2007 for CleanUp Activity
        CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", False, "clsTREven")

        'SrikanthY on 02 Mar 2007 Added Values into Sessions For The New Feature Show Report
        HttpContext.Current.Session.Add("HelpDeskSQL", SQL)
        HttpContext.Current.Session.Add("HelpDeskROWS", intNoOfRows)

        'SrikanthY on 28 Feb 2007 Commented Belowcode ,since the logic of Split Requesttype is handled in above code
        'End If

        'If CommonFunction.Application.SplitRequestTypeSubType = False Then
        '    'End Integration by SavitaS on 17 Nov 2005 for IssueID 1936

        '    Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "RequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", "AssignTo", "AssignTask", MyBase.GetResourceString("ASSIGN_ISSUE_LINK"), MyBase.GetResourceString("REJECT_LINK"), "Change Department", "Select"}
        '    Dim arrIgnoreHTMLEncode() As String = {"1"}
        '    'integrated by harshadad on 19 dec 2005  for issue id 989 
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue, to show link for the pin.gif to show the attachments on the e-Dashboard tab of Helpdesk
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'Dim arrLink() As String = {"", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", ""}
        '    Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "AssignTask_OnClick(QueryID)", "AssignIssue_OnClick(QueryID)", "Reject_OnClick(QueryID)", "ChangeDepartment_OnClick(QueryID,AssignTo)", "Select_OnClick(QueryID)"}
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'End of 'Modified by ManishK on 21st Nov 2005 For no of attachments attached to the issue
        '    '==============='==============='==============='==============='==============='==============='===============
        '    'end of integration by harshada d on 19 dec 2005  for issue id 989 
        '    Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "chkSelect"}
        '    Dim strQueryID_Caption As String
        '    Dim strSubject_Caption As String
        '    Dim strDescription_Caption As String
        '    Dim strAssignTo_Caption As String
        '    Dim strPriority_Caption As String
        '    Dim strExpectedResolvedDate_Caption As String
        '    Dim strCRMExpectedResolvedDate_Caption As String
        '    Dim strStatus_Caption As String

        '    'New Varibale defined By SantoshK after adding field in tbl_CRM_SubRequestType_Caption_Master
        '    'on 2 dec 2004
        '    Dim strRequestType_Caption As String
        '    'Modification Ends

        '    Dim strSubRequestType_Caption As String
        '    Dim strTargetLocation_Caption As String
        '    Dim strFunction_Caption As String
        '    Dim strSubmittedBy_Caption As String
        '    Dim strSubmittedDate_Caption As String
        '    Dim dr As IDataReader
        '    Dim ds As DataSet


        '    ' get the captions from the caption template	
        '    dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_SubRequestType_Caption_Master ", m_blnUseSQL)
        '    If dr.Read Then
        '        strSubject_Caption = dr("Subject").ToString & ""
        '        strAssignTo_Caption = dr("AssignTo").ToString & ""
        '        strPriority_Caption = dr("Priority").ToString & ""
        '        strExpectedResolvedDate_Caption = dr("ExpectedResolvedDate").ToString & ""
        '        strStatus_Caption = dr("Status").ToString & ""

        '        'Added By SantoshK on 2nd Dec 2004
        '        strRequestType_Caption = dr("RequestType").ToString & ""
        '        'Addition Ends

        '        strSubRequestType_Caption = dr("SubRequestType").ToString & ""
        '        strSubmittedBy_Caption = dr("SubmittedBy").ToString & ""
        '        strSubmittedDate_Caption = dr("SubmittedDate").ToString & ""
        '    End If
        '    CommonFunctions.Data.DisposeDataReader(dr)

        '    Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, "Discussions", strRequestType_Caption, strPriority_Caption, strSubmittedBy_Caption, strSubmittedDate_Caption, strExpectedResolvedDate_Caption, strStatus_Caption, strAssignTo_Caption, "Assign Task", "Assign Issue", "Reject", "Change Department", "Select"}

        '    m_objGrid = New WebPages.Template.GenericGrid
        '    With m_objGrid
        '        .NoOfDataColumns = 11
        '        .UserFriendlyColumnArray = arrUserFriendlyCols
        '        .ActualColumnArray = arrActualCols
        '        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
        '        .RowLinkArray = arrLink
        '        .CheckBoxIDArray = arrChkBox
        '        .PrimaryKey = "QueryID"
        '        .returnHTML = False
        '        .SortBy = m_strSortBy
        '        .SortOrder = m_strSortOrder
        '        .ClientSideSortFunctionName = "Sort_OnClick"
        '        .SQL = SQL
        '        .UseSQL = m_blnUseSQL
        '        .CurrentPage = m_intPageNumber
        '        .PageSize = 20
        '        .DIVID = "divGrid"

        '        'ADDED BY VIDYAJ FOR ISSUE ID - 
        '        'Commented By MrugajaB on 6th Jan,2005
        '        '.DIVStyle = "overflow:auto"
        '        'Modified By MrugajaB on 5th Jan,2005 for Jopasana Issue ID.14613, Hotfix ID.4.0.95-BF
        '        'Purpose:When help desk dashboard has more No. of requests ,only first few columns are displayed
        '        'Also scroll bar does not get displayed, so width of DIV tag is set to 100%
        '        .DIVStyle = "overflow:auto;width:100%;"
        '        'End Addition
        '        .DIVHeight = 380
        '        .ColNameToolTipOnEachRow = True
        '        .DrawGrid()
        '        m_intNoOfRows = .NoOfRowsInPage
        '    End With
        '    m_objGrid = Nothing

        '    ' total records
        '    Dim intNoOfRows As Integer
        '    ds = CommonFunctions.Data.GetDataSet(SQL, "default", , , m_blnUseSQL)
        '    intNoOfRows = ds.Tables(0).Rows.Count
        '    CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", False, "clsTREven")
        '    ds.Dispose() : ds = Nothing
        'End If
        'End of comments by srikanthy on 27 Feb 2007
        m_arrAccessibleDepartments = Nothing

        'Response.Write("<div id='divATT' class='cxtMenu' style='overflow:auto;display:none;position:absolute;z-index:10000' >")
        'Response.Write("</div")

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

        sbHTML = New StringBuilder
        'Dim objGanttChart_Month As cGanttChart_Generic

        With Response

            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            '.Write("<div id='divFiltercontent' style='width:99.99%;height:8%;overflow:auto'>")
            .Write("<table width='99.9%' class=clsTable cellpadding=0 cellspacing=0><tr class=clsTREven>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            ' combo box of  filters
            .Write("<td nowrap>")
            .Write(MyBase.GetResourceString("FILTER_CAPTION"))
            CommonFunctions.HTMLControls.DrawComboBox("cboFilter", "usp_CRM_FilterListForCombo " & EmployeeID, 200, m_lngFilterID.ToString, "Onchange=javascript:cboFilter_OnChange()", True)
            CommonFunctions.General.WriteHTML("<A Href='JavaScript:ShowCounter_Onclick()' ><IMG width=30px height=18px align='top' border=0 src='../../Images/Counters.gif' title='Show Counters' /></A>")
            .Write("</td>")
            ' combo box of  status
            .Write("<td nowrap>")
            .Write(MyBase.GetResourceString("STATUS_CAPTION"))
            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_CRM_Get_RequestStatus", 120, m_lngStatusID.ToString, "Onchange=javascript:cboStatus_OnChange()", True)
            .Write("</td>")

            ''Commented By Aniruddh Gujar on 14 Aug 2014 To Remove filter
            '''Added By Bharat Tekade
            ''' combo box for department
            ''.Write("<td nowrap>")
            ''.Write(" Department : ")
            ''CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_tbl_DepartmentMaster_Filter", 120, m_lngDeptID.ToString, "Onchange=javascript:cboDepartment_OnChange()", True)
            ''.Write("</td>")

            '''Ended By Bharat Tekade
            ''End of Commented By Aniruddh Gujar on 14 Aug 2014 To Remove filter



            'Added by ShraddhaM on 24,Apr 2009 for Whiziblesem8 to add Requestor text filter

            .Write("<td nowrap>")
            .Write(" Requested : ")
            .Write(CommonFunction.HTMLControls.DrawComboBox("cboDateFilter", "usp_SEL_tbl_CRM_DateFilter", 100, m_DateFilter, "onchange=javascript:cboDateFilter_OnChange()", True, True)) '
            .Write("</td>")

            .Write("<td nowrap >")
            .Write("Search ")
            CommonFunctions.HTMLControls.DrawComboBox("cboSelectSearch", "usp_SEL_CRM_SearchFields", 100, strSearchType, "onchange=javascript:cboSearch_OnChange()", True)
            If strSearchType <> "" Then
                .Write("&nbsp;<span id='searchfor' >for</span>&nbsp;")
            Else
                .Write("&nbsp;<span id='searchfor' Style='display:none'>for</span>&nbsp;")
            End If


            'Priority
            If strSearchType = "Priority" OrElse m_SearchFilterName = "Priority_SearchFilter_DB" Then
                CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_CRM_Get_RequestPriority", 150, strTextSearch)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_CRM_Get_RequestPriority", 150, , , , , , , , True)
            End If

            'Assigned To
            If strSearchType = "Assigned To" OrElse m_SearchFilterName = "Assigned To_SearchFilter_DB" Then
                CommonFunctions.HTMLControls.DrawComboBox("cboAssignedTo", "usp_SEL_Tbl_PM_Employee", 150, strTextSearch)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboAssignedTo", "usp_SEL_Tbl_PM_Employee", 150, , , , , , , , True)
            End If


            'Customer
            If strSearchType = "Customer" OrElse m_SearchFilterName = "Customer_SearchFilter_DB" Then
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "USP_sel_Requestor_Filter " + m_lngEmployeeID.ToString() + ", '" + m_strUserName + "','" + m_strLoginType + "', 'C'", 150, strTextSearch)
                CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "USP_sel_Requestor_Filter " + m_lngEmployeeID.ToString() + ", '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "', 'C'", 150, strTextSearch)
                'End of comment and modification by SuchitraP on 28-May-2009 
            Else
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "USP_sel_Requestor_Filter  " + m_lngEmployeeID.ToString() + ", '" + m_strUserName + "','" + m_strLoginType + "', 'C'", 150, , , , , , , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "USP_sel_Requestor_Filter  " + m_lngEmployeeID.ToString() + ", '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "', 'C'", 150, , , , , , , , True)
                'End of comment and modification by SuchitraP on 28-May-2009 
            End If


            'Employee
            If strSearchType = "Employee" OrElse m_SearchFilterName = "Employee_SearchFilter_DB" Then
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "USP_sel_Requestor_Filter  " + m_lngEmployeeID.ToString() + ",'" + m_strUserName + "','" + m_strLoginType + "', 'E'", 150, strTextSearch)
                CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "USP_sel_Requestor_Filter  " + m_lngEmployeeID.ToString() + ",'" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "', 'E'", 150, strTextSearch)
                'End of comment and modification by SuchitraP on 28-May-2009 
            Else
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "USP_sel_Requestor_Filter  " + m_lngEmployeeID.ToString() + ",'" + m_strUserName + "','" + m_strLoginType + "', 'E'", 150, , , , , , , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "USP_sel_Requestor_Filter  " + m_lngEmployeeID.ToString() + ",'" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "', 'E'", 150, , , , , , , , True)
                'End of comment and modification by SuchitraP on 28-May-2009 
            End If

            'Location
            If strSearchType = "Location" OrElse m_SearchFilterName = "Location_SearchFilter_DB" Then
                CommonFunctions.HTMLControls.DrawComboBox("cboLocation", "usp_CRM_Get_TargetLocations 0", 150, strTextSearch)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboLocation", "usp_CRM_Get_TargetLocations 0", 150, , , , , , , , True)
            End If

            'Request Type
            If strSearchType = "Request Type" OrElse m_SearchFilterName = "Request Type_SearchFilter_DB" Then
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_CRM_RequestType_Filter '" + m_strUserName + "','" + m_strLoginType + "'", 150, strTextSearch)
                CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_CRM_RequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, strTextSearch)
                'End of comment and modification by SuchitraP on 28-May-2009 
            Else
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_CRM_RequestType_Filter '" + m_strUserName + "','" + m_strLoginType + "'", 150, , , , , , , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_CRM_RequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, , , , , , , , True)
                'End of comment and modification by SuchitraP on 28-May-2009 
            End If

            'Sub Request Type
            If strSearchType = "Sub Request Type" OrElse m_SearchFilterName = "Sub Request Type_SearchFilter_DB" Then
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", "usp_CRM_SubRequestType_Filter '" + m_strUserName + "','" + m_strLoginType + "'", 150, strTextSearch)
                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", "usp_CRM_SubRequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, strTextSearch)
                'End of comment and modification by SuchitraP on 28-May-2009 
            Else
                'Comment and modification by SuchitraP on 28-May-2009 
                'Purpose:When logged in user contained single quote in Username ,When clicked on e-dashboard,page crash occured
                'CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", "usp_CRM_SubRequestType_Filter '" + m_strUserName + "','" + m_strLoginType + "'", 150, , , , , , , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", "usp_CRM_SubRequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, , , , , , , , True)
                'End of comment and modification by SuchitraP on 28-May-2009 
            End If

            'subject
            If strSearchType = "Subject" OrElse m_SearchFilterName = "Subject_SearchFilter_DB" Then
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 150, 100, strTextSearch, EnableHTMLEncode:=True)
            Else
                CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 150, 100, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
            End If
            'ended by Yogesh J for HTML encoding Date:05/10/15
            'Severity
            If strSearchType = "Severity" OrElse m_SearchFilterName = "Severity_SearchFilter_DB" Then
                CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "usp_CRM_Get_RequestSeverity", 150, strTextSearch)
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "usp_CRM_Get_RequestSeverity", 150, , , , , , , , True)
            End If
            .Write("</td>")
            .Write("<td>")
            ''Added and commented by PrashantSJ on 19th Aug 09 Purpose: SEM 9.0  
            '.Write("&nbsp;<a href=# onclick='ApplyAdvancedFilter()'>Show</a>")
            .Write("&nbsp;<a  onclick='ApplyAdvancedFilter()' style='cursor:hand;text-decoration:underline;'>Show</a>")
            ''End of addition and commented by PrashantSJ on 19th Aug 09 Purpose: SEM 9.0 

            .Write("</td>")

            'End of Addition By by ShraddhaM

            .Write("</tr></table>")

            ' .Write("</div>")

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
                '''.Write("<TD  width='20%'><INPUT id=optMYDashboard name=optRequest type=radio value='MD' OnClick='JavaScript:optRequest_OnClick(0)'>" & MyBase.GetResourceString("MYEDASHBOARD_CAPTION") & "</TD>")
                '''.Write("<TD  width='20%'><INPUT id=optDashboard name=optRequest type=radio value='DB' OnClick='JavaScript:optRequest_OnClick(1)' checked><b>" & MyBase.GetResourceString("EDASHBOARD_CAPTION") & "</b></TD>")

                '''.Write("<TD  width='20%'><INPUT id=optSubmitted name=optRequest type=radio value='SR' OnClick='JavaScript:optRequest_OnClick(2)'>" & MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION") & "</TD>")
                '''.Write("<TD  width='20%'><INPUT id=optAssigned name=optRequest type=radio value='AR' OnClick='JavaScript:optRequest_OnClick(3)'>" & MyBase.GetResourceString("ASSIGNED_REQUESTS_CAPTION") & "</TD>")
                '--- End Comment purvaj

                ' set/reset default links
                ' Modified by NitinVS on 9 aug 2005 for WhizibleSEM SP4 IssueID 2 
                '.Write("<TD  width='20%' align=right>")

                '--- Added By purvaj on 21 Jul 2009
                Response.Write("<TD  width='80%' align='left'><B>e-dashboard</B></TD>")
                '--- End addition purvaj

                'Issue List TextBox and Go button
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                Dim strtxtResuestId As String = CommonFunctions.HTMLControls.DrawTextBox("txtRequestId", "txtRequestId", , 50, 8, , "Right", , False, False, , False, "onkeypress=txtRequestID_OnKeyPress(event,'DB')", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:05/10/15
                'Commented And Added By Chakshuta H on 13th-Oct-2015
                'Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0'>"
                Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0;display:none;'>"
                'End Of Commented And Added By Chakshuta H on 13th-Oct-2015

                Response.Write("<TD width='20%' noWrap><B>" + MyBase.GetResourceString("REQUESTLIST") + "</B>&nbsp;&nbsp;" + strtxtResuestId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href='javascript:GO_OnClick(""DB"")' TITLE='Search Request ID'><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;</TD>")

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
        PagingSQL = PagingSQL.Replace("usp_CRM_Sel_AllRequests", "usp_CRM_Sel_AllRequestsCount")

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)

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
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"

        'End of comment and addition by PrashantD on 24 May 2007 for CleanUp Activity

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"

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

    Private Sub GetDefaultSearchFilters(ByVal EmployeeID As Long, ByVal DefaultType As String)
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
                m_SearchFilterName = dr("ItemName").ToString & ""
                m_SearchFilterValue = dr("ItemValue").ToString & ""
            Else
                m_SearchFilterName = "0"
                m_SearchFilterValue = "0"
            End If
        Else
            m_SearchFilterName = "0"
            m_SearchFilterValue = "0"
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

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

        CommonFunctions.Data.DisposeDataReader(dr)
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

    Private Sub SaveViewColumns()
        Dim strQuery As String
        Dim strSelectedValues As String
        Dim mode As String

        If Not Request.Form("chkField") Is Nothing And Request.Form("chkField") <> "" Then
            strSelectedValues = Request.Form("chkField").ToString()
        Else
            strSelectedValues = ""
        End If

        mode = Request.QueryString("Mode").ToUpper()
        strQuery = "usp_Ins_tbl_CRM_HelpDesk_Views " + Session("intUserID").ToString() + ",'" + strSelectedValues + "','DB'"

        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub

     
    Private Sub drawMonthNameHeadings(ByRef objStringBuilder As System.Text.StringBuilder)

        If m_strGanttView = "1" Then

            Dim Iterator As Integer
            Dim StartYear As Integer
            Dim StartMonth As Integer
            Iterator = 1

            StartYear = GantView_StartDt.Year
            StartMonth = GantView_StartDt.Month

            While Iterator <= MonDiff

                objStringBuilder.Append("<TD id='Month" + StartMonth.ToString + "' align=center width=20% class='clsTDBlankNew'>  " + vbCrLf)
                If m_strGanttView = "2" Then
                    objStringBuilder.Append(GetWeekHeading(StartMonth, StartYear) + vbCrLf)
                Else
                    objStringBuilder.Append(MonthName(StartMonth, True) + " (" + StartYear.ToString + " )" + vbCrLf)
                End If

                If StartMonth = 12 Then
                    StartMonth = 1
                    StartYear += 1
                Else
                    StartMonth = StartMonth + 1
                End If
                Iterator += 1

                objStringBuilder.Append("</TD>" + vbCrLf)
            End While
        ElseIf m_strGanttView = "2" Then
            For Each drRow As DataRow In dsWeekHead.Tables(0).Rows
                objStringBuilder.Append("<TD id='Week' align=center width=5% class='clsTDBlankNew'>  " + vbCrLf)
                objStringBuilder.Append(CommonFunction.Data.CheckIsDBNull(drRow("WeekHeading")) + vbCrLf)
                objStringBuilder.Append("</TD>" + vbCrLf)
            Next
        End If

        Response.Write(objStringBuilder)

    End Sub
    Private Function GetWeekHeading(ByVal intMonth As Integer, ByVal intYear As Integer) As String
        Dim sbWeekHead As New StringBuilder("")
        Dim sQuery As String = ""

        sQuery = "usp_Sel_WeekNumbers_ForGanttChart " & intMonth.ToString & "," & intYear.ToString
        drMonthHead = CommonFunction.Data.GetDataReader(sQuery, MyBase.UseSQL)


        sbWeekHead.Append("<TABLE class='clsGridTable' cellpadding=0 cellspacing=1 width=100% >" + vbCrLf)
        sbWeekHead.Append("<TR class='clsTRBlank'>" + vbCrLf)
        ''style='border-right:black 1px outset;'
        While drMonthHead.Read
            sbWeekHead.Append("<TD width='4%' colsapn='7' class='clsTDBlankNew' >")
            sbWeekHead.Append(CommonFunction.Data.CheckIsDBNull(drMonthHead("WeekNumber")).ToString)
            sbWeekHead.Append("</TD>")
        End While

        sbWeekHead.Append("</TR>")
        sbWeekHead.Append("</TABLE>")

        CommonFunction.Data.DisposeDataReader(drMonthHead)

        Return sbWeekHead.ToString

        sbWeekHead = Nothing
    End Function


#Region "events"

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint

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
                'Integrated by ShraddhaM on 13,Nov 2007
                'Added by PrajaktaR on 12th Nov 2007
                'Purpose : The page crashes when clicked on sort for Assign Issue Column, Sorting removed.
                Args.ApplySorting = False
                'END : Added by PrajaktaR on 12th Nov 2007
                'End of integration by ShraddhaM
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
                'Added by ShraddhaM on 13,Nov 2007 to remove sorting from AssignTask 
                Args.ApplySorting = False
                'End of addition by ShraddhaM on 13,Nov 2007 to remove sorting from AssignTask 

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
                'Added by ShraddhaM on 13,Nov 2007 to remove sorting from Reject  
                Args.ApplySorting = False
                'End of addition by ShraddhaM on 13,Nov 2007 to remove sorting from Reject 
                ''Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
            Case "CHANGE DEPARTMENT"
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                ''End of Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
                'Integrated by ArchanaN on 27 Apr 2007
                'Added by SrikanthY to display image on Flag Column header
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

                'Ended by ShraddhaM 
               
        End Select


        'Added by ShraddhaM for whiziblesem8 on 14,Apr 2009 for Helpdesk view changes

        Dim strViewFields As String = ""
        Dim ColumnName As String

        'strViewFields = ",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"

        'If Not Request.Form("hidViewFields") Is Nothing Then
        '    strViewFields = Request.Form("hidViewFields") '",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"
        'Else
        strViewFields = strSelectedValues
        'End If


        ColumnName = Trim(Args.ColumnName & "").ToUpper()

        If strViewFields <> "" Then
            strViewFields = strViewFields.ToUpper()


            If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                If strViewFields.Contains("," + ColumnName + ",") = False Then
                    Cancel = True
                End If
            End If
        Else
            If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                Cancel = True
            End If

        End If

        'Ended by ShraddhaM for whiziblesem8

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
        'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
        If UCase(Trim(Args.DataField & "")) = "STATUS" Then
            Args.TDStyle = "style='border-bottom: 1pt solid gray;' id=Status" + CType(Args.DataReader("QueryID"), String)
        ElseIf UCase(Trim(Args.DataField & "")) = "QUERYID" Then
            Args.TDStyle = "style='border-bottom: 1pt solid gray;width:35px;' align=right "
        Else
            Args.TDStyle = "style='border-bottom: 1pt solid gray;'"
        End If

        'Ended by ShraddhaM

        'Added by ShraddhaM for whiziblesem8 on 14,Apr 2009 for Helpdesk view changes

        Dim strViewFields As String = ""
        Dim ColumnName As String

        'strViewFields = ",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"

        'If Not Request.Form("hidViewFields") Is Nothing Then
        '    strViewFields = Request.Form("hidViewFields") '",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"
        'Else
        strViewFields = strSelectedValues
        'End If


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

                'Removed tooltip because on list page description is displayed by ShraddhaM on 1,Apr 2009
                ''ADDED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                m_strQueryid = CType(Args.DataReader("QueryID"), Integer)
                Dim SubmittedDate As DateTime

                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''Dim strQueryForSubmittedDate As String = "SELECT SubmittedDate FROM tbl_CRM_Query_Master WHERE QueryID= " & m_strQueryid.ToString()
                Dim strQueryForSubmittedDate As String = "usp_sel_tbl_CRM_Query_Master_SubmittedDate '" & m_strQueryid.ToString() & "'"
                ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

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
                ''END ADDED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                If Trim(Args.DataReader("Subject").ToString & "") <> "" Then

                    '''    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    If Len(Trim(Args.DataReader("Subject").ToString & "")) > 50 Then
                        Args.ApplyHTMLEncode = False
                        'Args.StringToBeInserted = "<TD vAlign=top Title='" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & "' style='width=25%' nowrap;>" _
                        '             & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "</A></TD>"
                        'Modified By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 Issue 11446
                        'Added ... after the 50 characters to represent limited data 
                        'Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & " style='width=25%;border-bottom: 1pt solid gray;' nowrap; >" _
                        ''MODIFIED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE .... "14 Days Ago" below Subject
                        ''*******************************''PURPOSE: for whizible.glodyne.com (inhouse production site)****************************
                        Dim m_intRoleID As Integer
                        Dim strIsDisplayRequestAging As String
                        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)

                        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''Dim strSQLIsDisplayRequestAging As String = "SELECT CustomFieldText1 FROM TBL_PM_ROLE WHERE ROLEID= " & m_intRoleID.ToString()
                        Dim strSQLIsDisplayRequestAging As String = "usp_sel_TBL_PM_ROLE_CustomFieldText1 " & m_intRoleID.ToString()
                        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        strIsDisplayRequestAging = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLIsDisplayRequestAging.ToString(), True), "0"), "0"), String)
                        If strIsDisplayRequestAging <> "" And strIsDisplayRequestAging = "0" Then
                            strInsertString = String.Empty ''PURPOSE: for whizible.glodyne.com (inhouse production site)
                        End If
                        ''**********************************************************
                        Args.StringToBeInserted = "<TD vAlign=top style='width=25%;border-bottom: 1pt solid gray;' nowrap; >" _
                                     & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "...</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        ''end MODIFIED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE .... "14 Days Ago" below Subject
                        'End Modification By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 Issue 11446

                        Cancel = True
                    Else
                        ''MODIFIED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE .... "14 Days Ago" below Subject
                        ''*******************************''PURPOSE: for whizible.glodyne.com (inhouse production site)****************************
                        Dim m_intRoleID As Integer
                        Dim strIsDisplayRequestAging As String
                        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)

                        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''Dim strSQLIsDisplayRequestAging As String = "SELECT CustomFieldText1 FROM TBL_PM_ROLE WHERE ROLEID= " & m_intRoleID.ToString()
                        Dim strSQLIsDisplayRequestAging As String = "usp_sel_TBL_PM_ROLE_CustomFieldText1 " & m_intRoleID.ToString()
                        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        strIsDisplayRequestAging = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLIsDisplayRequestAging.ToString(), True), "0"), "0"), String)
                        If strIsDisplayRequestAging <> "" And strIsDisplayRequestAging = "0" Then
                            strInsertString = String.Empty ''PURPOSE: for whizible.glodyne.com (inhouse production site)
                        End If
                        ''**********************************************************
                        Args.StringToBeInserted = "<TD vAlign=top style='width=25%;border-bottom: 1pt solid gray;' nowrap;>" _
                                      & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Trim(Args.DataReader("Subject").ToString & "")) & "</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        ''end MODIFIED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE .... "14 Days Ago" below Subject
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
                    Args.StringToBeInserted = "<TD vAlign=top title='Attachments' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
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
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                          & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A>" & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"

                        Cancel = True

                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    Else
                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        'Args.StringToBeInserted = "<TD NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        'Cancel = True
                        'DELETED by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                         & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        'END DELETED by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0

                        'ADDED by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0
                        Dim strNoOfDiscussions As String
                        Dim strQueryNoOfDiscussions As String

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''strQueryNoOfDiscussions = "SELECT count(QueryID) from tbl_CRM_Query_Details WITH (NOLOCK) where QueryID = " & CType(Args.DataReader("QueryID"), String) & " AND ISSHOWTOCUSTOMER =1"
                        strQueryNoOfDiscussions = "usp_sel_tbl_CRM_Query_Details_QueryID " & CType(Args.DataReader("QueryID"), String)
                        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        strNoOfDiscussions = Trim(Args.DataReader("NoOfDiscussions").ToString & "")

                        If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") = "C" Then
                            strNoOfDiscussions = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQueryNoOfDiscussions, MyBase.UseSQL), "0"), String)
                        End If
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                                                 & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & strNoOfDiscussions & ")</A></TD>"

                        'END ADDED by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0

                        Cancel = True
                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    End If
                Else
                    ''Args.DataFieldValue = "<IMG border=0 src='../../Images/Discussions.gif' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "'>"
                    ''Args.ApplyHTMLEncode = False
                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    Args.StringToBeInserted = "<TD vAlign=top style='border-bottom: 1pt solid gray;'>" _
                                                & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif' alt= " & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "></A></TD>"
                    Cancel = True
                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                End If
            Case "ASSIGNTASK"

                If strViewFields <> "" Then
                    strViewFields = strViewFields.ToUpper()
                    ColumnName = Trim(Args.ColumnName & "").ToUpper()

                    'If Args.DataField <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                    If strViewFields.Contains("," + ColumnName + ",") = False Then
                        Cancel = True
                    Else

                        Cancel = True

                        'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                        ' if logged in user is non hrm do not show assign Task link 
                        If blnIsHRM = 1 Then

                            ' Modified By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                            'To show Assign Task Link conditionaly 

                            If m_blnShowAssignTaskInHelpDesk = True Then

                                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                                m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                                strTD = "<td vAlign=top align=left style='border-bottom: 1pt solid gray;' >" & vbCrLf
                                If Trim(Args.DataReader("TaskAssignedToUserName").ToString & "") <> "" Then
                                    If Trim(Args.DataReader("StatusID").ToString & "") <> "2" And Trim(Args.DataReader("StatusID").ToString & "") <> "7" Then
                                        '' START : Commented and Modified By ParagD 28-Sept-2006
                                        '' strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",1,'" & m_PKToken_Query_DT & "')" & Chr(34) & ">" & vbCrLf
                                        strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",1,'" & m_PKToken_Query_DT & "'," & Args.DataReader("TaskID").ToString & ")" & Chr(34) & ">" & vbCrLf
                                        '' END : Commented and Modified By ParagD 28-Sept-2006
                                        strTD += Server.HtmlEncode(Args.DataReader("TaskAssignedToUserName").ToString)
                                        strTD += "</A>" & vbCrLf
                                    Else
                                        '' START : Commented and Modified By ParagD 28-Sept-2006
                                        ''strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",0,'" & m_PKToken_Query_DT & "')" & Chr(34) & ">" & vbCrLf
                                        strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("QueryID").ToString & ",0,'" & m_PKToken_Query_DT & "'," & Args.DataReader("TaskID").ToString & ")" & Chr(34) & ">" & vbCrLf
                                        '' END : Commented and Modified By ParagD 28-Sept-2006
                                        '' End :  ParagD 28-Sept-2006
                                        strTD += Server.HtmlEncode(Args.DataReader("TaskAssignedToUserName").ToString)
                                        strTD += "</A>" & vbCrLf
                                    End If
                                Else
                                    If Trim(Args.DataReader("StatusID").ToString & "") <> "2" And Trim(Args.DataReader("StatusID").ToString & "") <> "7" Then
                                        strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & vbCrLf
                                        strTD += Args.DataReader("QueryID").ToString & ",'1','" & m_PKToken_Query_DT & "')" & Chr(34) & ">" & MyBase.GetResourceString("ASSIGN_TASK_LINK") & "</A>" & vbCrLf
                                    End If
                                End If
                                strTD += "</td>" & vbCrLf
                                Args.StringToBeInserted = strTD

                            End If
                        End If

                    End If
                    'End If

                Else
                    Cancel = True

                    ' End Modification By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                    ' To show Assign Task Link conditionaly 

                End If



            Case "REJECT"

                If strViewFields <> "" Then
                    strViewFields = strViewFields.ToUpper()
                    ColumnName = Trim(Args.ColumnName & "").ToUpper()

                    'If Args.DataField <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                    If strViewFields.Contains("," + ColumnName + ",") = False Then
                        Cancel = True
                    Else

                        ' Modified By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                        If m_blnShowAssignTaskInHelpDesk = True Then

                            'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                            ' if logged in user is non hrm do not show assign issue link 
                            If blnIsHRM = 1 Then

                                ' hide reject link on following logic
                                If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "7" Then
                                    ' ***NOTE StatusID #7 -> Rejected Queries
                                    strTD = "<td style='border-bottom: 1pt solid gray;'></td>" & vbCrLf
                                    Cancel = True
                                    Args.StringToBeInserted = strTD
                                Else
                                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                                    Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                                  & "<A href=""JavaScript:Reject_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("REJECT_LINK") & "</A></TD>"

                                    Cancel = True
                                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                                End If
                                If Cancel = False Then
                                    If Trim(Args.DataReader("TaskID").ToString & "") <> "" Or Trim(Args.DataReader("NoOfIssues").ToString & "") <> "0" Then
                                        strTD = "<td style='border-bottom: 1pt solid gray;'></td>" & vbCrLf
                                        Cancel = True
                                        Args.StringToBeInserted = strTD
                                    Else
                                        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                                        Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                                      & "<A href=""JavaScript:Reject_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("REJECT_LINK") & "</A></TD>"

                                        Cancel = True
                                        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                                    End If
                                End If
                            Else
                                Cancel = True
                            End If ' End if blnIsHRM = 1  
                            'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                        Else
                            Cancel = True
                        End If
                    End If
                    'End If
                Else
                    Cancel = True
                End If 'end of view if
            Case "ASSIGN ISSUE"

                If strViewFields <> "" Then
                    strViewFields = strViewFields.ToUpper()
                    ColumnName = Trim(Args.ColumnName & "").ToUpper()

                    'If Args.DataField <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                    If strViewFields.Contains("," + ColumnName + ",") = False Then
                        Cancel = True
                    Else

                        If m_blnShowAssignTaskInHelpDesk = False Then
                            Cancel = True
                        Else
                            'Added BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                            ' if logged in user is non hrm do not show assign issue link 
                            'If blnIsHRM = 1 Then
                            '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                            'm_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                            'Args.StringToBeInserted = "<TD  vAlign=top align=left  style='TEXT_DECORATION:None' nowrap;>" _ & "<A href=""JavaScript:AssignIssue_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("ASSIGN_ISSUE_LINK") & "</A></TD>"

                            'Cancel = True
                            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                            ' Else
                            'Cancel = True
                            'End If*/
                            'Integrated by ArchanaN on 27 Apr 2007
                            If blnIsHRM = 1 Then
                                '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                                Dim blnIsHrmForQuery As Boolean = False
                                blnIsHrmForQuery = m_arrAccessibleDepartments.ContainsValue(Args.DataReader("FunctionID"))

                                m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                                If blnIsHrmForQuery = True Then
                                    Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                                  & "<A href=""JavaScript:AssignIssue_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("ASSIGN_ISSUE_LINK") & "(" & CType(Args.DataReader("IssueCount"), Long) & ")" & "</A></TD>"

                                    Cancel = True
                                Else
                                    Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                                      & "<A href=""JavaScript:AssignIssue_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("ASSIGN_ISSUE_LINK") & "</A></TD>"

                                    Cancel = True
                                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                                End If
                            Else
                                Cancel = True
                            End If
                            'End Addition By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                            ' Integration Ends
                        End If

                    End If
                    'End If
                Else
                    Cancel = True

                    ' End Modification By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                    ''Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
                End If 'End of view if

            Case "CHANGE DEPARTMENT"

                'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609
                Dim blnIsHrmForQuery As Boolean = False
                blnIsHrmForQuery = m_arrAccessibleDepartments.ContainsValue(Args.DataReader("FunctionID"))

                'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                If blnIsHRM = 0 Then
                    Cancel = True
                ElseIf blnIsHrmForQuery = False Then
                    Cancel = True
                    Args.StringToBeInserted = "<td>Change Department</td>"
                Else
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                    Args.StringToBeInserted = "<TD  vAlign=top align=left  style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                      & "<A href=""JavaScript:ChangeDepartment_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & "Change Department" & "</A></TD>"

                    Cancel = True
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                End If
                ''End of Added by Manishk on 25th Feb 2006 for WhizibleSem Sp 6
                'added for whiziblesem 6 issue id 1936 for 
                'if the logged in person has access to view only request then the chkbox should be disabled
            Case "SELECT"
                'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                'Dim drIfHRM As IDataReader
                Dim blnIsHrmForQuery As Boolean = False
                blnIsHrmForQuery = m_arrAccessibleDepartments.ContainsValue(Args.DataReader("FunctionID"))

                'Dim strSQL As String = " SELECT CRMID FROM tbl_CRM_Function_CRMS Where CRMID = " & m_lngEmployeeID & " and FUNCTIONID = " & Args.DataReader("FunctionID").ToString & ")"
                'strSQL += " UNION  select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " & m_lngEmployeeID & " and DepartmentID = " & Args.DataReader("FunctionID").ToString & ")"
                'drIfHRM = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                'If drIfHRM.Read Then
                ' the change department link should be displyed
                'blnIsHrmForQuery = 1
                ' Else
                '    blnIsHrmForQuery = 0
                'End If
                'CommonFunction.Data.DisposeDataReader(drIfHRM)

                'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

                If blnIsHrmForQuery = False Then
                    Args.IsCheckBoxDisabled = True
                End If
                If m_blnShowAssignTaskInHelpDesk = True Then
                    If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "3" Or Trim(Args.DataReader("Department").ToString & "") = "" Or (Trim(Args.DataReader("TaskID").ToString & "") <> "" Or Trim(Args.DataReader("NoOfIssues").ToString & "") <> "0") Then
                        Args.IsCheckBoxDisabled = True
                    End If
                Else
                    If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "3" Or Trim(Args.DataReader("Department").ToString & "") = "" Then
                        Args.IsCheckBoxDisabled = True
                    End If
                End If
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
                    ' Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "G" Then
                    ' Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/GreenFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/GreenFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "S" Then
                    '  Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                    'Added By ShraddhaM on 7,Aug 2007
                    'To Display Black flag for Completed Flaged requests
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "B" Then
                    ' Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/BlackFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/BlackFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    ''End of addition by Yogesh J on 20-Jan-2016
                    'End of Addition By ShraddhaM on 7,Aug 2007
                Else
                    ' Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/GrayFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/GrayFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                End If
                'End of Addition by SrikanthY
                'Integration Ends

                'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
                'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
            Case "DESCRIPTION"

                m_Queryid = CType(Args.DataReader("QueryID"), Integer)
                Args.TDStyle = " NoWrap title='Description'"
                Args.StringToBeInserted = "<TD id= " + m_Queryid.ToString() + " name=" + m_Queryid.ToString() + " vAlign=top title='Description' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:ShowDescription_onClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='Description' onclick="""" ID='imgSummaryShowHide" & CType(m_Queryid, String) & "' name='imgSummaryShowHide" & CType(m_Queryid, String) & "'></a></TD>"
                Cancel = True
                'Ended by ShraddhaM
                'Case "SUBMITTEDDATE"
                '    Args.ShowTimeWithDate = True
                'Case "LastUpdatedDate"
                '    Args.ShowTimeWithDate = True
                'Case "EXPECTEDRESOLVEDDATE"
                '    Args.ShowTimeWithDate = False

                '''''''    ''ADDED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEST LIKE .... 14 Days Ago below Request ID
                '''''''Case "QUERYID"
                '''''''    Dim SubmittedDate As DateTime
                '''''''    Dim strQueryID As String = Args.DataReader("QueryID").ToString()
                '''''''    Dim strQueryForSubmittedDate As String = "SELECT SubmittedDate FROM tbl_CRM_Query_Master WHERE QueryID= " & strQueryID.ToString()
                '''''''    SubmittedDate = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQueryForSubmittedDate.ToString(), True), ""), ""), DateTime)
                '''''''    Dim intDateDiffInDays = DateDiff(DateInterval.Day, SubmittedDate, DateTime.Today)
                '''''''    Args.StringToBeInserted = "<td  vAlign=top style='border-bottom: 1pt solid gray;width:35px;' align=right  title='Request ID'>" + strQueryID + "</BR>" + intDateDiffInDays.ToString() + " days ago." + "</td>"
                '''''''    Cancel = True
                '''''''    ''END ADDED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEST LIKE .... 14 Days Ago below Request ID

                ''ADDED BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEST LIKE .... 14 Days Ago below Request ID

            Case Else


        End Select


        ColumnName = Trim(Args.ColumnName & "").ToUpper()
        If strViewFields <> "" Then
            strViewFields = strViewFields.ToUpper()


            If Args.DataField <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                If strViewFields.Contains("," + ColumnName + ",") = False Then
                    Cancel = True
                End If
            End If
        Else
            If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                Cancel = True
            End If

        End If

        'Ended by ShraddhaM for whiziblesem8



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


        'Added By Amol Changle On: 18 Aug 2009
        'Purpose: To hide data, when custom field is accessible by role, but not by type 

        If Args.DataField.ToLower().Contains("customfield") Then
            'Dim strSQL As New StringBuilder()
            'Dim dr As IDataReader
            'Dim IsCustomFieldAssigned As String = "0"

            'strSQL.Append("usp_Sel_tbl_PM_CustomFields_Master 0,'")
            'strSQL.Append(Args.DataField)
            'strSQL.Append("',1,")
            'strSQL.Append(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubRequestTypeID"), "0").ToString())
            'strSQL.Append(",'Help-Desk',")
            'strSQL.Append(m_lngEmployeeID.ToString())

            'dr = CommonFunctions.Data.GetDataReader(strSQL.ToString(), True)

            'If dr.Read() Then
            '    IsCustomFieldAssigned = CommonFunctions.Data.CheckIsDBNull(dr("IsCustomFieldAssigned"), "0").ToString()
            'End If

            'CommonFunctions.Data.DisposeDataReader(dr)

            'If IsCustomFieldAssigned = "0" Then
            '    Args.ReplacementValue = "-"
            'End If
            If m_objCFDS.Tables(0).Select("DatabaseFieldName='" + Args.DataField.ToString + "' AND TypeID=" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubRequestTypeID"), "0").ToString()).Length <= 0 Then
                Args.ReplacementValue = "-"
            End If

        End If
        'End Addition


    End Sub

    Private Sub m_objSectionTitle_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle) Handles m_objSectionTitle.Initialize
        Args.clsTR = "clsTRMenu"
    End Sub
#End Region



    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'Modified BY NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

        'This is CSL specific menu aray
        'This  line should be uncommented while releasing for CSL site
        'If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS") Or Args.LinkName = MyBase.GetResourceString("MENU_SUPPORT_DASHBOARD") Then
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights

        If Args.FunctionName.ToUpper = "SHOWSLA_ONCLICK()" Then

            If m_blnSLAAccess = False Then
                Cancel = True
            End If
        End If


        If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNMULTIPLEREQUESTS") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNMULTIPLETASKS") Then
            'Dim dr As IDataReader
            'Dim lngCRMID As Long
            'dr = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID, m_blnUseSQL)

            'If dr.Read = False Then
            'lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
            If blnIsHRM = 0 Then
                Cancel = True
            End If
            'End If
            'CommonFunctions.Data.DisposeDataReader(dr)
        End If

        'End Modification By NitinVS on 28 Sep 2006 for WhizibleSEM 7.0 IssueID 6609

        'Addition by SuchitraP on 30-Aug-2008 
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

    'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
    'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        'Modified By NitinVS on 5 May 2009
        ' The event fires for all rows starting from 1 page to current page. 
        ' ex. if current page no is 10 then the event fires for all rows from page 1 to 10 
        ' we need to add the details only for current page 
        If m_intPageNumber = -1 Or (count > ((m_intPageNumber - 1) * 20) And count <= (m_intPageNumber * 20)) Then


            m_Queryid = CType(Args.DataReader("QueryID"), Integer)
            intTotalCol = CType(Args.DataReader.Table.Columns.Count, Integer)
            Dim intAssignTo As Integer
            Dim TotalTimeSpent As String
            TotalTimeSpent = CType(Args.DataReader("TotalTimeSpent"), String)
            Dim status As String
            Dim statusID As String
            Dim IsHRMorDeptHead As Boolean
            Dim RequestorType As String
            Dim sbHTML As New StringBuilder

            IsHRMorDeptHead = CType(Args.DataReader("IsHRMOrDeptHead"), Boolean)
            status = Args.DataReader("Status").ToString()
            statusID = Args.DataReader("StatusID").ToString()

            'If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CustomerName"), ""), String) <> "" Then
            'If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("LoginType"), ""), String) <> "" Then
            RequestorType = Args.DataReader("LoginType")
            'Else
            'RequestorType = Args.DataReader("LoginType")
            'End If

            If IsDBNull(Args.DataReader("AssignToID")) Then
                intAssignTo = 0
            Else
                intAssignTo = CType(Args.DataReader("AssignToID"), Integer)
            End If

            sbHTML.Append("<TR class=").Append(strClass).Append(" id='Description").Append(CType(m_Queryid, String)).Append("' name='Description").Append(CType(m_Queryid, String)).Append("' width=99.9% style=""display:none"">")
            sbHTML.Append("<TD align=left colspan=").Append(intTotalCol.ToString()).Append(">")
            sbHTML.Append("<DIV id=Summary").Append(CType(m_Queryid, String)).Append(" name=Summary").Append(CType(m_Queryid, String)).Append(" style=""overflow:auto;display:none;width=99.9%;"">")

            sbHTML.Append("<TABLE ID='Description'  Width=99.9% class=clsGridTable cellspacing=0 cellpadding=0>")
            sbHTML.Append("<tr class=").Append(strClass).Append(">")
            sbHTML.Append("<td valign=top colspan='7' align='left'><b>Description </b> :")

            sbHTML.Append(CType(HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "")), String))
            sbHTML.Append("</TD></TR>")

            'sbHTML.Append("<TR class=").Append(strClass).Append(" >")
            sbHTML.Append("<TR style='white-space:nowrap' class=").Append(strClass).Append(" >")
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
            sbHTML.Append("<TD valign=middle align='left' id=AssignTo").Append(CType(m_Queryid, String)).Append(" style='border-bottom: 1px solid gray;width:15%;'>")

            If IsHRMorDeptHead = True Then

                If intAssignTo = 0 Then
                    sbHTML.Append("<A href=""javascript:AssignToMe_onClick(").Append(m_Queryid.ToString).Append(" )"" ><Font color=red><B>Assign To me</B></Font></A>")
                ElseIf intAssignTo = CType(Session("intUserID"), Integer) Then
                    sbHTML.Append("<B><Font color=red>Assigned To me</Font></B>")
                Else
                    sbHTML.Append("<B><Font color=red>Assigned To : ").Append(Args.DataReader("AssignToName").ToString()).Append("</Font></B>")
                End If
            Else
                If intAssignTo = CType(Session("intUserID"), Integer) Then
                    sbHTML.Append("<B><Font color=red>Assigned To me</Font></B>")
                ElseIf intAssignTo = 0 Then
                    sbHTML.Append("<B><Font color=red>Not Assigned</Font></B>")
                Else
                    sbHTML.Append("<B><Font color=red>Assigned To : ").Append(Args.DataReader("AssignToName").ToString()).Append("</Font></B>")
                End If
            End If

            sbHTML.Append("</TD>")

            'TotalTimeSpent

            sbHTML.Append("<TD  align=left id=TotalTime").Append(CType(m_Queryid, String)).Append(" style='border-bottom: 0px solid gray;display:none;' TotalTime=").Append(TotalTimeSpent.ToString()).Append(">")
            sbHTML.Append("<B><U><A onClick='ShowDetailActivity(event,").Append(CType(m_Queryid, String)).Append(")' >Total Time Spent</A></U>&nbsp;:&nbsp;").Append(TotalTimeSpent.ToString()).Append("&nbsp;Hrs</B>")
            sbHTML.Append("</TD>")

            'Status Change
            If statusID = 2 And m_blnHRM = 0 Then 'IsHRMorDeptHead = False Then
                sbHTML.Append("<TD  align=left  style='border-bottom: 1px solid gray;cursor:hand;width:25%;'>")

                sbHTML.Append("&nbsp;Change Status&nbsp;")

                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , "disabled", True, EnableHTMLEncode:=True))
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append("<IMG id=imgStatus").Append(m_Queryid.ToString).Append(" src='../../Images/selection.gif' valign=middle align=absMiddle  >")

                sbHTML.Append("</TD>")

                'sbHTML.Append( "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>")
                'sbHTML.Append("<IMG src='../../Images/selection.gif' ></B>&nbsp;&nbsp;&nbsp;&nbsp;")
                'sbHTML.Append("</TD>")

            Else
                sbHTML.Append("<TD  align='left' style='border-bottom: 1px solid gray;width:25%;'  >")

                sbHTML.Append("&nbsp;Change Status&nbsp;")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , " onclick=ShowStatus(" + m_Queryid.ToString + ",event) ", True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append("<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' >")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append("</TD>")

                'sbHTML.Append("<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>")
                'sbHTML.Append("<IMG src='../../Images/selection.gif' onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' ></B>&nbsp;&nbsp;&nbsp;&nbsp;")
                'sbHTML.Append("</TD>")

            End If


            'Time Spent 'Time period
            sbHTML.Append("<TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;width:20%;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append(">")

            sbHTML.Append("Time Spent&nbsp;")
            If statusID = 2 Then


                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , True, , , , , True, EnableHTMLEncode:=True))
            Else
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , , , , , , True, EnableHTMLEncode:=True))

                'ended by Yogesh J for HTML encoding Date:05/10/15
            End If


            sbHTML.Append("&nbsp;(Min)&nbsp;<A onClick='ShowDetailActivity(event,").Append(CType(m_Queryid, String)).Append(")' ><img src='../../Images/cssImages/Link images/ViewHistory.gif' valign=middle  alt='Show Detail Time Spent' /></a></TD>")
            sbHTML.Append("<TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;width:25%;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append(">Activity&nbsp;")
            'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 250, 2000, , , "cursor:hand;", , , , , " onkeyup=SearchActivity(" + m_Queryid.ToString + ",event) onkeydown=processKeys(event)", True))
            If statusID = 2 Then
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , True, True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append("<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;' disabled onclick=SearchActivity(" + m_Queryid.ToString + ",event) >")

            Else
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , , True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                sbHTML.Append("<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;'  onclick=SearchActivity(" + m_Queryid.ToString + ",event) >")

            End If
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidActivityID" + m_Queryid.ToString, "hidActivityID" + m_Queryid.ToString, , 50, 2000, , , , , , , True, , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15

            'sbHTML.Append("</B>")
            'sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("cboTimeUnits", "select 'M','Minutes' UNION select 'H','Hours'", 80, ReturnAsHTML:=True))
            If statusID = 2 Then
                sbHTML.Append("</TD><TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append("> <input  type=button id=btnSave" + m_Queryid.ToString + " onclick='SaveActivity_OnClick(").Append(m_Queryid.ToString).Append(")' value=""Save""  disabled  /> ")
            Else
                sbHTML.Append("</TD><TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append("><input  type=button id=btnSave" + m_Queryid.ToString + " onclick='SaveActivity_OnClick(").Append(m_Queryid.ToString).Append(")' value=""Save"" />")
            End If

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            sbHTML.Append("&nbsp;").Append(CommonFunction.HTMLControls.DrawTextBox("txtSavingLable" + CType(m_Queryid, String), "txtSavingLable" + CType(m_Queryid, String), , , 100, "Saving....", , "width:80px;BACKGROUND-COLOR:#FFFF80;border-color:gray;display:none;", , True, "#FFFF80", returnHTML:=True, EnableHTMLEncode:= True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
            sbHTML.Append("</TD>")

            'Requestor Details and Statistics 
            sbHTML.Append("<TD id=RequestorDtl").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;width:15%;'>")
            sbHTML.Append("<B><U><A onClick='ShowRequestorDetails(event,").Append(CType(m_Queryid, String)).Append(",""").Append(RequestorType).Append(""")' >Requestor</A></U></B>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<B><U><A onClick='ShowStatistics(event,").Append(CType(m_Queryid, String)).Append(",""").Append(RequestorType).Append(""")' >Statistics</A></U></B>")

            sbHTML.Append("</TD>")

            sbHTML.Append("</TR></Font>")

            sbHTML.Append("</TABLE></DIV>")
            sbHTML.Append("</TD></TR>")

            intTotalCol = 0

            Args.StringToBeInserted += sbHTML.ToString()
            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If

            sbHTML = Nothing

        End If
        count = count + 1
        'End Modification By NitinVS on 5 May 2009
    End Sub

    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        Args.TableStyle = " cellpadding=0 cellspacing=0  style='border-right: 2px solid gray;border-left: 2px solid gray;border-top: 2px solid gray;'"
    End Sub
    'Ended by ShraddhaM

    Private Sub m_objSectionTitle_Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks) Handles m_objSectionTitle.Section_Title_Before_Link_Print

    End Sub
End Class
