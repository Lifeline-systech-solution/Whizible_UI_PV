Imports System.Text
Public Class CRM_RequestList
    Inherits WebPages.Template.WhizTemplate

    Protected m_strMode As String = ""
    Private m_strAction As String = ""
    Private m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    Private m_blnIsDefaultMode As Boolean = False
    Private m_blnDashboardAccess As Boolean = False
    Protected m_FlagStatus As String
    Protected m_strSortBy As String
    Protected m_strSortOrder As String
    Protected m_intPageNumber As Integer = 1

    Protected m_intNoOfRows As Integer
    Private m_arrAccessibleDepartments As New Hashtable

    Protected m_strSQL As String = ""

    Private m_lngStatusID As Long = 0
    Private m_lngFilterID As Long = 0
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    ' Added By NitinVS on 26 July 2005 for PSPL 
    Private m_intTotalNoOfRows As Integer
    Private m_blnShowAssignTaskInHelpDesk As Boolean

    Protected m_lngDepartmentID As Long = 0
    ' End Addition By NitinVS on 26 July 2005 for PSPL 
    'Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
    ' added by harshada D for HelpDesk Patch on 30 Nov 2005
    Protected blnIsHRM As Integer = 0
    Protected m_intExposeToCust As Integer = 0
    ' end of addition by harshada D for HelpDesk Patch on 30 Nov 2005
    'End Integration by SavitaS

    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197	
    Protected m_PKToken_ADDNEW As String
    Protected m_PKToken_Go_Behalf_ADD As String
    Protected m_PKToken_Query_DT As String
    Protected m_PKToken_GoOnClick As String
    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
    'Added by SrikanthY on 28 Dec 2006
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Protected m_blnIsClient As Boolean = False
    Private m_dsGrid As DataSet
    Private m_blnSLAAccess As Boolean = False
    'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
    'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
    Private intTotalCol As Integer
    Private count As Integer = 1
    Private strClass As String = "clsTROdd"
    Private strAction As String
    Private iterator As Integer = 1
    Protected m_Queryid As Integer
    Private strSelectedValues As String
    Private strRequestor As String = ""
    Private strRequestor_ForControl As String = ""


    Private strSearchType As String
    Protected m_DateFilter As String = ""
    Private strTextSearch As String = ""
    Private strTextSearch_ForQuery As String = ""
    Protected m_AdvanceFilter As String = ""
    Protected m_SearchFilterName As String = ""
    Protected m_SearchFilterValue As String = ""
    ''ADDED BY AMIT MAHADIK ON 29 MAR 2011
    Protected m_objCFDS As DataSet
    Private m_strQueryid As String
    ''END ADDED BY AMIT MAHADIK ON 29 MAR 2011
    '####################################################################
    ' Abbreviations on page
    ' MODE
    'i)	AR -> Assigned Requests 
    'ii)SR -> Submitted Requests
    '#####################################################################

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
        If Session("strCRM_Filter_SR") Is Nothing Then
            Session("strCRM_Filter_SR") = ""
        End If
        If Session("strCRM_Filter_AR") Is Nothing Then
            Session("strCRM_Filter_AR") = ""
        End If
        ' mode of the page
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
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
            ' added by harshada for whiziblesem 6 helpdeskenhancemnts filters on list page not getting set on refreshing the same
        Else
            If Not Request.QueryString("StatusID") Is Nothing Then
                If Request.QueryString("StatusID") <> "" Then

                    m_lngStatusID = CType(Request.QueryString("StatusID"), Long)
                End If
            End If
            'end of addition by harshada d
        End If
        ' Modified By NitinVS on 4 Aug 2005 for WhizibleSEM SP4 IssueId 2 


        If UCase(Trim(m_strMode & "")) = "SR" And Trim(MyBase.GetFormValue("cboDepartment") & "") <> "" Then
            m_lngDepartmentID = CType(MyBase.GetFormValue("cboDepartment"), Long)
            ' added by harshada for whiziblesem 6 helpdeskenhancemnts filters on list page not getting set on refreshing the same
        Else
            If Not Request.QueryString("DepartmentID") Is Nothing Then
                If Request.QueryString("DepartmentID") <> "" Then
                    m_lngDepartmentID = CType(Request.QueryString("DepartmentID"), Long)
                End If
                'end of addition by harshada d
            End If
        End If
        ' End Modification By NitinVS on 4 Aug 2005 for WhizibleSEM SP4 IssueId 2 

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngLoginID = CType(Session("intLOGINID"), Long)

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        Call SetDefaultMode(m_lngEmployeeID)
        m_blnDashboardAccess = CheckDashboardAccess(m_lngEmployeeID)

        ' Added by SrikanthY on 28 Dec 2006 To Display Client Details on Request List Screen In case of Clients Login
        If m_strLoginType = "C" Then
            Call GetClientDetails()
        End If
        'End of Addition by SrikanthY
        'Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
        'added by harshada d  for Helpdesk patch on 30 Nov 2005
        Dim dr As IDataReader
        Dim strSQL As String
        Dim m_lngCRMID As Long
        blnIsHRM = 0



        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        ''Added by Manishk on 25th Feb 2006 for WhizibleSem SP 6 Issue 1936
        strSQL = "SELECT count(DepartmentID)AS CntExposeToCust FROM tbl_PM_DepartmentMaster Where ExposeToCustomer = 1 "
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(dr("CntExposeToCust"), "0"), Integer) > 0 Then
                m_intExposeToCust = 1
            End If
        End If
        ''End of Added by Manishk on 25th Feb 2006 for WhizibleSem SP 6 Issue 1936

        If m_lngCRMID <> 0 Then
            blnIsHRM = 1
        Else
            blnIsHRM = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        'Added following IF condition by PrashantD on 6 Jun 2007 for CleanUp Activity
        If m_lngCRMID = 0 Then
            strSQL = "select departmentHeadID FROM tbl_PM_DepartmentMaster where departmentHeadID = " & m_lngEmployeeID
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If dr.Read Then
                m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("departmentHeadID"), "0"), Long)
            End If
            If m_lngCRMID <> 0 Then
                blnIsHRM = 1
            Else
                blnIsHRM = 0
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If


        'End Modification by SavitaS 
        'end of addition by harshada d  for Helpdesk patch on 30 Nov 2005
        'End Integration by SavitaS on 22 Dec 2005
        'added by harshada d for issue id helpdesk issue id 1936 for retaining the filter on 28 th april 2006
        If Not Request.QueryString("FilterID") Is Nothing Then
            If Request.QueryString("FilterID") <> "" Then
                m_lngFilterID = CType(Request.QueryString("FilterID"), Long)
            End If
        End If
        'end of addition by harshada d for issue id 1936 on 28 th april 2006

        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        If CommonFunction.General.CheckIsNothing(Request.QueryString("PKToken"), "") <> "" Then
            m_PKToken_Go_Behalf_ADD = Request.QueryString("PKToken")
        Else
            m_PKToken_Go_Behalf_ADD = CommonFunctions.Security.Token.GetToken("0" + CType(m_lngEmployeeID, String) + "0" + "0")
        End If
        ''ADDED BY NILESH G ON 17/8/2016 PURPOSE : PKTOKEN GENERATION
        m_PKToken_ADDNEW = CommonFunctions.Security.Token.GetToken("" + CType(m_lngEmployeeID, String) + "0" + "0")
        ''END OF ADDED BY NILESH G ON 17/8/2016 PURPOSE : PKTOKEN GENERATION
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197 

        'Added by SandipL for SLA access check
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()

        objGlobal.TagID = 3821

        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        objAccessRights.GetAccess()

        m_blnSLAAccess = objAccessRights.View

        'added by bharat tekade
        m_blnShowAssignTaskInHelpDesk = CommonFunction.Application.ShowAssignTaskInHelpDesk
        'ended by bharat tekade
        'End addition by SandipL

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
        'Ended by ShraddhaM

        If strRequestor = "" And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_REQUESTORFILTER" Then
            strRequestor = GetDefault(m_lngEmployeeID, "DefaultRequestorFilter_" + UCase(Trim(m_strMode & "")))
            strRequestor_ForControl = strRequestor
            strRequestor = strRequestor.Replace("''", """")
            strRequestor = strRequestor.Replace("'", "''")
        End If
        If strRequestor = "0" Then
            strRequestor = ""
            strRequestor_ForControl = ""
        End If


        'Added by ShraddhaM for Filter in Whiziblesem8 on 7,Aug 2009

        If Trim(MyBase.GetFormValue("cboSelectSearch") & "") <> "" Then
            strSearchType = CType(MyBase.GetFormValue("cboSelectSearch"), String)
        Else
            strTextSearch = ""
            strSearchType = ""
        End If

        If Not Request.Form("cboSelectSearch") Is Nothing Then
            m_SearchFilterName = CommonFunction.Data.CheckIsDBNull(Request.Form("cboSelectSearch"), "").ToString()
        End If
        '        If m_SearchFilterName = "" OrElse UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_SEARCH_FILTER" Then
        If UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_SEARCH_FILTER" Then
            GetDefaultSearchFilters(m_lngEmployeeID, "DefaultSearchFilter_SR")

            If m_SearchFilterName = "Assigned To_SearchFilter_SR" Then
                strSearchType = "Assigned To"
            ElseIf m_SearchFilterName = "Subject_SearchFilter_SR" Then
                strSearchType = "Subject"
            ElseIf m_SearchFilterName = "Request Type_SearchFilter_SR" Then
                strSearchType = "Request Type"
            ElseIf m_SearchFilterName = "Sub Request Type_SearchFilter_SR" Then
                strSearchType = "Sub Request Type"
            ElseIf m_SearchFilterName = "Customer_SearchFilter_SR" Then
                strSearchType = "Customer"
            ElseIf m_SearchFilterName = "Employee_SearchFilter_SR" Then
                strSearchType = "Employee"
            ElseIf m_SearchFilterName = "Priority_SearchFilter_SR" Then
                strSearchType = "Priority"
            ElseIf m_SearchFilterName = "Severity_SearchFilter_SR" Then
                strSearchType = "Severity"
            ElseIf m_SearchFilterName = "Location_SearchFilter_SR" Then
                strSearchType = "Location"
            End If

            strTextSearch = m_SearchFilterValue


        End If

        Select Case strSearchType
            Case "Priority"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPriority"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPriority"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " PriorityID = " + strTextSearch

            Case "Assigned To"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboAssignedTo"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboAssignedTo"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " AssignToID = " + strTextSearch
            Case "Customer"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCustomer"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCustomer"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " CustomerId = ''" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strTextSearch)) + "'' AND LoginType = ''C'' "
            Case "Employee"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboEmployee"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboEmployee"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " CustomerId = ''" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strTextSearch)) + "'' AND LoginType = ''E'' "
            Case "Location"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboLocation"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboLocation"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " TargetLocationId = " + strTextSearch
            Case "Request Type"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboRequestType"), "")
                End If

                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboRequestType"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " RequestTypeId = " + strTextSearch
            Case "Sub Request Type"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSubRequestType"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSubRequestType"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " SubRequestTypeID = " + strTextSearch
            Case "Subject"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubject"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubject"), "")
                strTextSearch_ForQuery = strTextSearch
                strTextSearch_ForQuery = strTextSearch_ForQuery.Replace("%", "[%]")
                strTextSearch_ForQuery = strTextSearch_ForQuery.Replace("_", "[_]")
                If strTextSearch <> "" Then m_AdvanceFilter = " Subject Like ''%" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(strTextSearch_ForQuery)) + "%'' "
            Case "Severity"
                If strTextSearch Is Nothing OrElse strTextSearch = "" Then
                    strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSeverity"), "")
                End If
                'strTextSearch = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSeverity"), "")
                If strTextSearch <> "" Then m_AdvanceFilter = " SeverityID  = " + strTextSearch
            Case Else
                strTextSearch = ""
        End Select


        If m_lngStatusID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_STATUS" Then
            ' get the default status for the user
            m_lngStatusID = CType(GetDefault(m_lngEmployeeID, "DefaultStatus_" + UCase(Trim(m_strMode & ""))), Long)
        End If


        If Not Request.Form("cboDateFilter") Is Nothing Then
            m_DateFilter = CommonFunction.Data.CheckIsDBNull(Request.Form("cboDateFilter"), "").ToString()
        End If
        If m_DateFilter = "" And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_DATEFILTER" Then
            ' Commented and Modified by GaneshD on 08 Sep 2009 
            'm_DateFilter = GetDefault(m_lngEmployeeID, "DefaultDateFilter")
            m_DateFilter = GetDefault(m_lngEmployeeID, "DefaultDateFilter_ForSR")
            ' End of modification by GaneshD
        End If

        'Ended by ShraddhaM

        m_strSQL = "usp_Sel_Role_CustomField_CRM " + objGlobal.RoleLevel.ToString + "," + objGlobal.RoleID.ToString
        m_objCFDS = CommonFunction.Data.GetDataSet(m_strSQL, "CustomField", , , MyBase.UseSQL)


    End Sub

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
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String

        Select Case UCase(Trim(m_strAction & ""))
            Case "SET_DEFAULT_MODE"
                ' login type condition added by harshada d on 22 11 2005
                strSQL = "usp_CRM_SetDefaultMode " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(UCase(Trim(m_strMode & ""))) & "','" & CommonFunctions.General.BuildQueryString(UCase(Trim(m_strLoginType & ""))) & "'"
                m_blnIsDefaultMode = True
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "RESET_DEFAULT_MODE"
                ' login type condition added by harshada d on 22 11 2005
                strSQL = "usp_CRM_ResetDefaultMode	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(UCase(Trim(m_strLoginType & ""))) & "'"
                m_blnIsDefaultMode = False
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "DELETE"
                ' if there are some requests selected

                '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                If (m_PKToken_Go_Behalf_ADD <> "" And (CommonFunctions.Security.Token.ValidateToken("0" + CType(m_lngEmployeeID, String) + "0" + "0", m_PKToken_Go_Behalf_ADD) = True)) Then
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

                    ' Modified By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 
                    Dim strResult As String
                    ' deleting requests

                    If CType(Trim(Request.Form("chkDelete")), String) <> "" Then
                        strSQL = "usp_CRM_Delete_Requests '" & Trim(Request.Form("chkDelete") & "") & "'"
                        strResult = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), ""), "")
                        If strResult <> "" Then
                            Response.Write(" <SCRIPT> alert('" + strResult + "'); </SCRIPT>")
                        End If
                    End If
                    'CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                Else
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Delete", 0, 0, "RequestID", "0")
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '' END : Added By ParagD 14-Sept for whiziblesem SP7 issue ID.6197


            Case "SET_DEFAULT_STATUS"
                ' setting the current status as default status
                'Added by TruptiK on 19-Mar-2008
                'Purpose:-Filter problem.
                If Trim(Request.Form("cboFilter") & "") <> "" Then
                    Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))) = ""
                    m_lngFilterID = 0
                End If
                'End of addition by TruptiK on 19-Mar-2008
                If Trim(Request.Form("cboStatus") & "") <> "" Then
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultStatus	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboStatus") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strMode & "'") & CommonFunctions.General.BuildQueryString(m_strMode & "") & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
                Else
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultStatus	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strMode & "") & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"

                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            Case "SET_DEFAULT_FILTER"
                ' set default filter
                'Added by TruptiK on 19-Mar-2008
                'Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))) = ""
                'm_lngFilterID = 0
                'End of addition by TruptiK on 19-Mar-2008
                If Trim(Request.Form("cboFilter") & "") <> "" Then
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboFilter") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strMode & "") & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    m_lngFilterID = CType(MyBase.GetFormValue("cboFilter"), Long)
                Else
                    ' Login Type condition added by harshada d on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strMode & "") & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    m_lngFilterID = 0

                    If m_lngFilterID = 0 Then
                        Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))) = ""
                    End If

                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)


            Case "ESCALATE"
                '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                If (m_PKToken_Go_Behalf_ADD <> "" And (CommonFunctions.Security.Token.ValidateToken("0" + CType(m_lngEmployeeID, String) + "0" + "0", m_PKToken_Go_Behalf_ADD) = True)) Then
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197

                    If Trim(Request.QueryString("EscalateQueryID") & "") <> "" Then
                        lngEscalateQueryID = CType(Request.QueryString("EscalateQueryID"), Long)
                        ' change the status of the query to "Manually Escalated" (ID #5)		
                        'Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master
                        'strSQL = "usp_CRM_Update_Request_Status " & lngEscalateQueryID & ",'5'"
                        Dim strSessionUserName As String
                        strSessionUserName = CType(Session("strUserName"), String).Replace("'", "''")
                        strSQL = "usp_CRM_Update_Request_Status " & lngEscalateQueryID & ",'5','" & strSessionUserName & "'"
                        'End of Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master

                        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                        blnSendMail = False : blnShowPopup = False
                        ' send mail
                        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 44", m_blnUseSQL)
                        If dr.Read Then
                            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)

                        If blnSendMail Then
                            If blnShowPopup Then
                                With Response
                                    .Write("<script language=javascript>")
                                    .Write("window.open (""../General/SendEmail.aspx?MessageID=44&QueryID=" & lngEscalateQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                    .Write("</script>")
                                End With
                            Else
                                ' silent mail
                                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_44(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, lngEscalateQueryID)
                                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                            End If
                        End If
                    End If
                    '' START : Added By ParagD 14-Sept-2006 for whiziblesem SP7 issue ID.6197
                Else
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk : Escalate", 0, 0, "RequestID", "0")
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '' END : Added By ParagD 14-Sept for whiziblesem SP7 issue ID.6197

            Case "CLEAR_FILTERS"
                Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))) = ""
                'Added by ShraddhaM to persist filters on 22,Apr 2009 for Whiziblesem8
                strSQL = "usp_CRM_SetDefaultFilter	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strMode & "") & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                'Ended by Shraddha M
                m_lngFilterID = 0
            Case "SET_DEFAULT_DATEFILTER"
                ' Commented and modified by GaneshD on Sep 08 2009
                ' set default date Filter 
                'If Trim(Request.Form("cboDateFilter") & "") <> "" Then
                '    strSQL = "usp_CRM_SetDefaultDateFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboDateFilter") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                'Else
                '    strSQL = "usp_CRM_SetDefaultDateFilter	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

                'End If
                If Trim(Request.Form("cboDateFilter") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultDateFilterForSR	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("cboDateFilter") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                Else
                    strSQL = "usp_CRM_SetDefaultDateFilterForSR	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                ' End of modification by GaneshD on 08 Sep 2009



            Case "SET_DEFAULT_REQUESTORFILTER"
                ' set default date Filter 
                If Trim(Request.Form("txtRequestor") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultRequestorFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("txtRequestor") & "")) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','" & CommonFunctions.General.BuildQueryString(m_strMode & "") & "'"
                Else
                    strSQL = "usp_CRM_SetDefaultRequestorFilter	" & m_lngEmployeeID & ",null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','" & CommonFunctions.General.BuildQueryString(m_strMode & "") & "'"

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

                strSearchFilterName = strSearchFilterName + "_SearchFilter_SR"

                If Trim(Request.Form("cboSelectSearch") & "") <> "" Then
                    strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(strSearchFilterName) & "','" & CommonFunctions.General.BuildQueryString(strSearchFilterValue) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','SR'"
                    'strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(strSearchFilterName) & "','_SearchFilter_DB','" & CommonFunctions.General.BuildQueryString(strSearchFilterValue) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','DB'"
                Else
                    strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",null,null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','SR'"

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
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CRM_ON_BEHALF_OF_CUSTOMER_LIST"), MyBase.GetResourceString("MENU_ADDNEW"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CRM_ON_BEHALF_OF_CUSTOMER_LIST_TOOLTIP"), MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim strMenu As String
        'SrikanthY on 02 mar 2007 Added new menuitem ShowReport
        'Added by SrikanthY on 09 Jan 2007 To change the caption of on behalf of customer link For Helpdesk enhancements and to show that link to only HRMs
        If blnIsHRM = 1 Then
            'Added Show SLA Links by SandipL on 30 June 2007
            'Modified by ShraddhaM on 9,Sept 2008
            'Purpose : Added Request Approvals link For Line Manager Approval Functionality

            '--- Modified by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
            '--- "Request Approvals", "Show SLA" links removed. These pages are now called from the left pane.
            'Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
            'Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
            Dim DeptName As String = ""
            Dim StrSqlDeptName As String
            If UCase(Trim(m_strMode & "")) = "SR" Then
                DeptName = ""
            Else
                StrSqlDeptName = "usp_Sel_getDepartmentName " + CType(Session("intUserID"), String)
                DeptName = CommonFunction.General.CheckIsNothing(CType(CommonFunction.Data.GetDataScalar(StrSqlDeptName, True), String), "")
            End If



            'End Added by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)

            'Added view menu link by Bharat Tekade
            Dim arrMenu() As String = {"FAQs", "On Behalf Of Customer/Employee Requests", "Show SLA", MyBase.GetResourceString("MENU_ADDNEW"), MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
            ''''"Request Approvals", "Show SLA",
            Dim arrMenuToolTip() As String = {"Frequently Asked Questions", "Requests Posted On Behalf Of Customer/Employee", "Show SLA", MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP"), MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            ''''"Request Approvals", "Show SLA", 



            'End of addition by SrikanthY on 09 Jan 2007
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            Dim arrCSFunction() As String = {"Faq_OnClick('DB'," + CType(Session("intUserID"), String) + ",'" + DeptName + "')", "OnBehalfOfCustomerList_OnClick()", "ShowSLA_Onclick()", "AddNew_OnClick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "Delete_OnClick('" + MyBase.GetResourceString("DELETE_CONFIRM") + "')", "ShowReport_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_REQUESTLIST')"}
            'End Modified by Amit Mahadik on 19 August 2011 whizibleSEM 10.0 (FAQ)
            ''''"RequestApprovals_onClick()", 
            '--- End modification purvaj

            'End of modification by ShraddhaM 9,Sept 2008
            m_objMenu = New WebPage.Templates.StaticMenu
            'harshada 07 feb 2006 for helpdesk enhancements
            Select Case UCase(Trim(m_strMode & ""))
                Case "SR"
                    '--- Modified by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
                    'arrCSFunction(9) = "Help_OnClick('SUBMITTED_REQUESTS')"

                    ''Commented and Added by Yogesh J on 28-Oct-2015
                    ' arrCSFunction(8) = "Help_OnClick('SUBMITTED_REQUESTS')"
                    arrCSFunction(9) = "Help_OnClick('SUBMITTED_REQUESTS')"
                    'arrCSFunction(10) = "Help_OnClick('SUBMITTED_REQUESTS')"
                    ''End of Addition by  Yogesh J on 28-Oct-2015

                Case "AR"

                    'arrCSFunction(9) = "Help_OnClick('ASSIGNED_REQUESTS')"
                    arrCSFunction(9) = "Help_OnClick('ASSIGNED_REQUESTS')"
                    'arrCSFunction(10) = "Help_OnClick('ASSIGNED_REQUESTS')"
                    '--- End modification purvaj
            End Select
            'harshada 07 feb 2006 for helpdesk enhancements

            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
        Else
            'Added Counter and SLA Links by SandipL on 30 June 2007
            'Modified by ShraddhaM on 9,Sept 2008
            'Purpose : Added Request Approvals link For Line Manager Approval Functionality

            '--- Modified by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
            '--- "Request Approvals", "Show SLA" links removed. These pages are now called from the left pane.
            Dim arrMenu() As String = {"views", MyBase.GetResourceString("MENU_ADDNEW"), "Show SLA", MyBase.GetResourceString("MENU_FILTERS"), MyBase.GetResourceString("MENU_CLEARFILTERS"), MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH"), MyBase.GetResourceString("MENU_HELP")}
            ''''"Request Approvals", "Show SLA",
            Dim arrMenuToolTip() As String = {"views", MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP"), "Show SLA", MyBase.GetResourceString("MENU_FILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_CLEARFILTERS_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_IB_SHOWREPORT"), MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            ''''"Request Approvals", 
            'End of addition by SrikanthY
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            Dim arrCSFunction() As String = {"View_onClick(event)", "AddNew_OnClick()", "ShowSLA_Onclick()", "SetFilters_OnClick()", "ClearFilters_OnClick()", "Delete_OnClick('" + MyBase.GetResourceString("DELETE_CONFIRM") + "')", "ShowReport_OnClick()", "Refresh_OnClick()", "Help_OnClick('CRM_REQUESTLIST')"}

            'Ended by Bharat Tekade
            ''''"RequestApprovals_onClick()", 

            '--- End modification purvaj

            'End of modification by ShraddhaM 9,Sept 2008
            m_objMenu = New WebPage.Templates.StaticMenu
            'harshada 07 feb 2006 for helpdesk enhancements
            Select Case UCase(Trim(m_strMode & ""))
                Case "SR"
                    '--- Modified by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
                    'arrCSFunction(8) = "Help_OnClick('SUBMITTED_REQUESTS')"
                    'Modified By Chakshuta H on 15th-Jan-2016 Change srraysize from 7 to 8
                    arrCSFunction(8) = "Help_OnClick('SUBMITTED_REQUESTS')"
                    'End Of Modified By Chakshuta H on 15th-Jan-2016 Change srraysize from 7 to 8
                Case "AR"
                    'arrCSFunction(8) = "Help_OnClick('ASSIGNED_REQUESTS')"
                    'Modified By Chakshuta H on 15th-Jan-2016 Change srraysize from 7 to 8
                    arrCSFunction(8) = "Help_OnClick('ASSIGNED_REQUESTS')"
                    'End Of Modified By Chakshuta H on 15th-Jan-2016 Change srraysize from 7 to 8
                    '--- End modification purvaj
            End Select
            'harshada 07 feb 2006 for helpdesk enhancements

            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)

        End If
        'End of Modification by SrikanthY
        'End of modification by SrikanthY  on 02 Mar 2007
        Dim dr As IDataReader
        Dim strSQL As String


        'Added by PrashantD on 30 April 2007 for IssueID 12619
        'Purpose: Sorting set by user does not persist
        Dim strSortBy As String
        Dim strSortOrder As String
        If Request.QueryString("SortOrder") <> "" Then
            strSortOrder = Request.QueryString("SortOrder")
        Else
            strSortOrder = "DESC"
        End If
        If Request.QueryString("SortBy") <> "" Then
            strSortBy = Request.QueryString("SortBy")
        Else
            strSortBy = "SubmittedDate"
        End If
        CommonFunction.General.WriteHTML("<input type=Hidden name=hidSortBy id=hidSortBy value=" + strSortBy + ">")
        CommonFunction.General.WriteHTML("<input type=Hidden name=hidSortOrder id=hidSortOrder value=" + strSortOrder + ">")
        'End of modification by PrashantD on 30 April 2007

        ' Modified By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 
        ' if Requestid send through Search is not present then display message and close the window.

        If Not Request.QueryString("Search") Is Nothing Then
            Dim intRequestIDExists As Integer
            Dim strRequestExistsSQL As String
            Dim m_lngQueryID As Long


            If Not Request.QueryString("QueryID") Is Nothing Then
                m_lngQueryID = CType(Request.QueryString("QueryID"), Long)

                MyBase.InitializeResources("AppResources.CRM_RequestList", "AppResources")

                strRequestExistsSQL = "usp_sel_tbl_PM_Query_Master_For_Search " + m_lngQueryID.ToString + " , " + m_lngEmployeeID.ToString + " , '" + m_strLoginType + "' , '" + m_strMode + "'"

                intRequestIDExists = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strRequestExistsSQL, MyBase.UseSQL), "0"), "0"), Integer)

                If intRequestIDExists = 0 Then

                    Response.Write("<SCRIPT language=javascript>")
                    If m_strMode.ToUpper = "SR" Then
                        Response.Write(" alert('" + MyBase.GetResourceString("OUTOFSCOPE_SR") + "'); ")
                    Else
                        Response.Write(" alert('" + MyBase.GetResourceString("OUTOFSCOPE_AR") + "'); ")
                    End If
                    Response.Write("</SCRIPT>")
                Else
                    'window.open('CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&Search=1&QueryID=' + objtxtRequestId.value ,'_requestdetail','resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700'); 
                    Response.Write("<SCRIPT language=javascript>")
                    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_GoOnClick = CommonFunctions.Security.Token.GetToken(m_lngQueryID.ToString + CType(m_lngEmployeeID, String) + "0" + "0")
                    '' Response.Write(" window.open('CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=" + m_strMode + "&QueryID=" + m_lngQueryID.ToString + "','_requestdetail','resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700');  ")
                    'Page Number Added By ShraddhaM on 6,Aug 2007
                    Response.Write(" window.open('CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=" + m_strMode + "&QueryID=" + m_lngQueryID.ToString + "&PageNumber=" + m_intPageNumber.ToString + "&PKToken=" + m_PKToken_GoOnClick + "','_requestdetail','resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700');  ")
                    'End of addition By ShraddhaM on 6,Aug 2007
                    '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
                    Response.Write("</SCRIPT>")
                End If

            End If
        End If

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'END Modification By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 

        'If Trim(Session("strCRM_Filter_" & Trim(m_strMode & "")).ToString & "") = "" And m_lngFilterID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" And UCase(Trim(m_strAction & "")) <> "CLEAR_FILTERS" Then
        If m_lngFilterID = 0 And UCase(Trim(m_strAction & "")) <> "SET_DEFAULT_FILTER" And UCase(Trim(m_strAction & "")) <> "CLEAR_FILTERS" Then
            m_lngFilterID = CType(GetDefault(m_lngEmployeeID, "DefaultFilter_" & Trim(m_strMode & "")), Long)
        End If


        If UCase(Trim(m_strAction & "")) = "CLEAR_FILTERS" Then
            m_lngFilterID = 0
        End If


        ' build the sql
        If UCase(Trim(m_strMode & "")) = "SR" Then
            strSQL = "EXEC usp_CRM_Sel_User_SubmittedRequests '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
            'Addition by PrashantD on 18 Jun 2007 for CleanUp Activity
            strSQL += "," + m_intPageNumber.ToString
            'End of addition by PrashantD on 18  Jun 2007 for CleanUp Activity


            ' is status specified
            If m_lngStatusID <> 0 Then
                strSQL = strSQL & "," & m_lngStatusID & ""
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
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
            Else
                strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(Session("strCRM_Filter_SR").ToString & "") & "'"
                'strSQL = strSQL & ",''"
            End If

            'Modified By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 

            ' Added Filter for Department 

            If m_lngDepartmentID <> 0 Then
                strSQL = strSQL + " , " + m_lngDepartmentID.ToString
            Else
                strSQL = strSQL + ", null "
            End If

            'END Modification By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 
            'Added by ShraddhaM on 7,Aug 2009 for filters
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
            'Ended by ShraddhaM on 7,Aug 2009
        Else
            ' build the sql
            strSQL = "EXEC usp_CRM_Sel_User_AssignedRequests " & m_lngEmployeeID
            ' is status specified
            If m_lngStatusID <> 0 Then
                strSQL = strSQL & "," & m_lngStatusID & ""
            Else
                strSQL = strSQL & ",Null"
            End If
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
                strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(Session("strCRM_Filter_AR").ToString & "") & "'"
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


        End If


        MyBase.InitializeResources("AppResources.CRM_RequestList", "AppResources")

        'Code added by PrashantD on 6 Jun 2007 for CleanUp Activity
        m_dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "default", , , m_blnUseSQL)
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity
        'Added by bharat tekade
        strSelectedValues = CommonFunction.Data.GetDataScalar("usp_Sel_tbl_CRM_HelpDesk_Views " + Session("intUserID").ToString() + ",'SR'", MyBase.UseSQL)
        'Ended by bharat tekade

        If strSelectedValues Is Nothing Then
            If UCase(Trim(m_strMode & "")) = "SR" Then
                strSelectedValues = ",Department,Request Type,Requestor,Requested On,Exp. Date Of Resolution,Status,Show SLA,"
            Else
                strSelectedValues = ",Request Type,Priority,Product,Module/Component,Requestor,Requestor Name,Requested On,Exp. Date Of Resolution,Status,Show SLA,"
            End If
        End If


        With Response
            .Write(strMenu)

            CommonFunction.General.WriteHTML("<input type=hidden name=hidViewFields id=hidViewFields value='" + strSelectedValues + "'>")


            ' the option buttons
            Call WriteOptionButtons()

            ' the filters combo
            Call WriteFilterCombos(m_lngEmployeeID)

            ' paging
            Call WritePaging(strSQL)

            ' the grid goes here
            Call WriteGrid(strSQL)

            .Write(strMenu)
        End With
        'Code added by PrashantD on 6 Jun 2007 for CleanUp Activity
        m_dsGrid.Dispose() : m_dsGrid = Nothing
        'End of comment by PrashantD on 6 Jun 2007 for CleanUp Activity


    End Sub

    Private Sub SetDefaultMode(ByVal EmployeeID As Long)
        '=====================================================================
        ' Procedure Name        : SetDefaultMode
        ' Description           : to set the default mode for the page
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
        Dim dr As IDataReader
        ' get the default mode for the user
        ' Login Type condition by harshada d on 22 11 2005 
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & EmployeeID & ",'DefaultMode','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'", m_blnUseSQL)
        If dr.Read Then
            If Trim(m_strMode & "") <> "" Then
                ' is the current mode the default mode?
                If UCase(Trim(m_strMode & "")) = UCase(Trim(dr("ItemValue").ToString & "")) Then
                    m_blnIsDefaultMode = True
                End If
            Else
                m_blnIsDefaultMode = True
                m_strMode = dr("ItemValue").ToString & ""
            End If
        Else
            m_blnIsDefaultMode = False
            If Trim(m_strMode & "") = "" Then
                m_strMode = "SR"
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

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
        ' Revisions             :
        ' Modified By           : SantoshK (SubRequest is Changed To Request Type) 
        '                         NitinVS  (Added Department Column)
        '=====================================================================
        'Integrated by SavitaS for IssueID 1936
        'Added by SavitaS on 17 Nov 2005 for WhizibleSemSP4 enhancement 
        'Purpose: If "Split Request Type-Sub Type" combo is checked at corporate level then show
        '         Reqest and SubRequestType seperately on the list else show them together.

        'SrikanthY on 28 Feb 2007 To Conditionally Show/Hide product,Components details to user
        Dim DataColCount As Integer
        Dim ShowProduct As String
        ShowProduct = CType(CommonFunctions.Data.GetDataScalar("SELECT IsNull(EnableProductExecution,0) As Show FROM  tbl_PM_companyinformation ", MyBase.UseSQL), String)

        DataColCount = 13

        If ShowProduct = "1" Then
            ShowProduct = "True"
        End If

        'End of addition by SrikanthY

        'If CommonFunction.Application.SplitRequestTypeSubType = True Then

        ' Modified By NitinVs on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 Added Column for Department
        'Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "Department", "RequestType", "SubRequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", MyBase.GetResourceString("ESCALATE_LINK"), "Delete"}
        'Commented by SrikanthY on 28 Feb 2007 Moved Data from Array to Arraylist
        ''SrikanthY on 20 Dec 2006 modified code To dispaly Customer Name for HRMs
        ''Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "Department", "RequestType", "SubRequestType", "Priority", "Product", "Component", "CustomerID", "CustomerName", "SubmittedDate", "ExpectedResolvedDate", "Status", MyBase.GetResourceString("ESCALATE_LINK"), "Delete"}
        ''Dim arrIgnoreHTMLEncode() As String = {"1"}
        '''End of comments by SrikanthY on 28 Feb 2007
        'integrated by harshada d on 19 DEC 2005 for issue id 989 
        '================================================'================================================'================================================
        'Modified By ManishK on 21st Nov 2005 for No of attachments attached to Helpdesk Request
        '================================================'================================================'================================================
        'Dim arrLink() As String = {"", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "Escalate_OnClick(QueryID)", ""}

        ''Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "", "Escalate_OnClick(QueryID)", ""}
        'Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "", "Escalate_OnClick(QueryID)", ""}
        ''SrikanthY on 20 Dec 2006 modified code To dispaly Customer Name for HRMs
        ''Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "", "", "", "", "Escalate_OnClick(QueryID)", ""}
        '' END Addition
        '''End of comments by SrikanthY on 28 Feb 2007
        '================================================'================================================'================================================
        'End of Modified By ManishK on 21st Nov 2005 for No of attachments attached to Helpdesk Request
        '================================================'================================================'================================================
        'end of integration by harshada d on 19 DEC 2005 for issue id 989
        'Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "chkDelete"}
        ' End Modification By NitinVs on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 Added Column for Department
        Dim intNoOfRows As Integer
        Dim strQueryID_Caption As String
        Dim strSubject_Caption As String
        Dim strDescription_Caption As String
        Dim strAssignTo_Caption As String
        Dim strPriority_Caption As String
        Dim strExpectedResolvedDate_Caption As String
        Dim strCRMExpectedResolvedDate_Caption As String
        Dim strStatus_Caption As String


        'Modification By SantoshK on 2nd Dec 2004 after adding New field in table tbl_CRM_SubRequestType_Caption_Master
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
        '-----------------------------------
        'Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, "Discussions", "Department", strRequestType_Caption, strSubRequestType_Caption, strPriority_Caption, strSubmittedBy_Caption, strSubmittedDate_Caption, strExpectedResolvedDate_Caption, strStatus_Caption, "Escalate", "Delete"}
        'Added by SrikanthY on 28 Feb 2007 Moved Data from Arrays to Arraylists , so that the conditional ways to show or hide some columns will be easier
        Dim alActualColumns As New ArrayList
        Dim alLinks As New ArrayList
        Dim aluserfriendlycol As New ArrayList
        Dim alcheckbox As New ArrayList


        'Added by ShraddhaM on 1,Apr 2009
        alActualColumns.Add("Description") : alLinks.Add("ShowDescription_onClick()") : aluserfriendlycol.Add("") : alcheckbox.Add("")
        'Ended by ShraddhaM

        'Added by bharat tekade

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

                    'Commented  by Bharat Tekade on 19th-june-2014 
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
                    ''Commented by Dhanashri S on 18 Mar 2016 Purpose:To display 'Status' Column for the Customer i.e whose loginType is 'C'
                    '''Commented And Added By Vaijat K ON 08/02/2016
                    ''alActualColumns.Add("Status") : alLinks.Add("") : aluserfriendlycol.Add(strStatus_Caption) : alcheckbox.Add("")
                    'If m_strLoginType <> "C" Then
                    alActualColumns.Add("Status") : alLinks.Add("") : aluserfriendlycol.Add(strStatus_Caption) : alcheckbox.Add("")
                    'End If
                    ''End of Comment by Dhanashri S on 18 Mar 2016 Purpose:To display 'Status' Column for the Customer i.e whose loginType is 'C'
                Case "ASSIGNTO"
                    ''Commented And Added By Vaijat K ON 08/02/2016
                    'alActualColumns.Add("AssignTo") : alLinks.Add("") : aluserfriendlycol.Add(strAssignTo_Caption) : alcheckbox.Add("")
                    If m_strLoginType <> "C" Then
                        If m_strMode = "SR" Then
                            alActualColumns.Add("AssignTo") : alLinks.Add("") : aluserfriendlycol.Add(strAssignTo_Caption) : alcheckbox.Add("")
                        End If
                    End If
                    'Ended

                    'Ended by Bharat Tekade
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

        'Ended by bharat tekade
        'Code Commented by PrashantD for CleanUp Activity on 13 Jun 2007
        'alActualColumns.Add(MyBase.GetResourceString("ESCALATE_LINK")) : alLinks.Add("Escalate_OnClick(QueryID)") : aluserfriendlycol.Add("Escalate") : alcheckbox.Add("")
        'End of Commented by PrashantD for CleanUp Activity on 13 Jun 2007
        'Added by SandipL on 09 Jul 2007 - Request level SLA
        If m_blnSLAAccess = True Then
            alActualColumns.Add("Show SLA") : alLinks.Add("RequestSLA_OnClick(QueryID)") : aluserfriendlycol.Add("Show SLA") : alcheckbox.Add("")
        End If
        '''End addition by SandipL
        If m_strMode = "SR" Then
            alActualColumns.Add("Delete") : alLinks.Add("") : aluserfriendlycol.Add("Delete") : alcheckbox.Add("chkDelete")
        End If
        '-----------------------------------
        '===========================
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
        ''If m_blnSLAAccess = True Then
        ''    alActualColumns.Add("Show SLA") : alLinks.Add("RequestSLA_OnClick(QueryID)") : aluserfriendlycol.Add("Show SLA") : alcheckbox.Add("")
        ''End If
        'End addition by SandipL
        If m_strMode = "AR" Then
            'alActualColumns.Add("Select") : alLinks.Add("") : aluserfriendlycol.Add("Select") : alcheckbox.Add("chkSelect")
        End If
        '===========================
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Dim arrIgnoreHTMLEncode() As String = {"1"}
        'ended by Yogesh J for HTML encoding Date:06/10/15

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
            ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  
            'Modified by SiddharthS on 15 Feb 2005 for IssueID 15602.
            'Purpose : To display the proper value for the status column in a grid.
            '.NoOfDataColumns = 12

            'Added by bharat tekade
            If m_blnSLAAccess = True Then
                If m_strMode = "AR" Then
                    .NoOfDataColumns = arrUserFriendlyCols.Length - 1 'Added By Vaijat K ON 08/02/2016 For production issue
                Else
                    .NoOfDataColumns = arrUserFriendlyCols.Length - 2
                End If
            Else
                If m_strMode = "AR" Then
                    .NoOfDataColumns = arrUserFriendlyCols.Length 'Added By Vaijat K ON 15/02/2016 For production issue
                Else
                    .NoOfDataColumns = arrUserFriendlyCols.Length - 1
                End If
            End If
            'End by bharat tekade

            '.NoOfDataColumns = DataColCount
            'Modification ends.
            ' End Modification  By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  

            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .RowLinkArray = arrLink
            If UCase(Trim(m_strMode & "")) = "SR" Then
                .CheckBoxIDArray = arrchkbox
            End If
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



            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width:99.9%"
            'Commented by Shamkant S on 5 Nov 2015
            '.DIVHeight = 250 '300
            '.DIVHeight = 250 '300
            .DrawGrid()
            .EmptyValueReplacement = "-"
            intNoOfRows = .NoOfRowsInPage

        End With
        m_objGrid = Nothing

        ' total records
        ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  

        'ds = CommonFunctions.Data.GetDataSet(SQL, "default", , , m_blnUseSQL)
        'intNoOfRows = ds.Tables(0).Rows.Count
        'CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", False, "clsTREven")
        'ds.Dispose() : ds = Nothing
        CommonFunctions.General.WriteTotalRecordsHTML(m_intTotalNoOfRows, "Total Records:", False, "clsTREven")
        'SrikanthY on 02 Mar 2007 Added Values into Sessions For The New Feature Show Report
        HttpContext.Current.Session.Add("HelpDeskSQL", SQL)
        HttpContext.Current.Session.Add("HelpDeskROWS", m_intTotalNoOfRows)
        'End of Addition by SrikanthY on 02 Mar 2007
        ''''SrikanthY on 28 Feb 2007 Commented Belowcode ,since the logic of Split Requesttype is handled in above code
        ''''' End Modification  By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  
        ''''Else
        '''''End Integration by SavitaS for IssueID 1936
        ''''' Modified By NitinVs on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 Added Column for Department
        ''''Dim arrActualCols() As String = {"Attachments", "QueryID", "Subject", "Discussions", "Department", "RequestType", "Priority", "CustomerID", "SubmittedDate", "ExpectedResolvedDate", "Status", MyBase.GetResourceString("ESCALATE_LINK"), "Delete"}
        ''''Dim arrIgnoreHTMLEncode() As String = {"1"}
        '''''integrated by harshada d on 19 DEC 2005 for issue id 989 
        '''''================================================'================================================'================================================
        '''''Modified By ManishK on 21st Nov 2005 for No of attachments attached to Helpdesk Request
        '''''================================================'================================================'================================================
        '''''Dim arrLink() As String = {"", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "Escalate_OnClick(QueryID)", ""}

        ''''Dim arrLink() As String = {"Document_OnClick(QueryID)", "", "Query_OnClick(QueryID)", "Discussion_OnClick(QueryID)", "", "", "", "", "", "", "", "Escalate_OnClick(QueryID)", ""}

        '''''================================================'================================================'================================================
        '''''End of Modified By ManishK on 21st Nov 2005 for No of attachments attached to Helpdesk Request
        '''''================================================'================================================'================================================
        '''''end of integration by harshada d on 19 DEC 2005 for issue id 989
        ''''Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "chkDelete"}
        ''''' End Modification By NitinVs on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 Added Column for Department
        ''''Dim intNoOfRows As Integer
        ''''Dim strQueryID_Caption As String
        ''''Dim strSubject_Caption As String
        ''''Dim strDescription_Caption As String
        ''''Dim strAssignTo_Caption As String
        ''''Dim strPriority_Caption As String
        ''''Dim strExpectedResolvedDate_Caption As String
        ''''Dim strCRMExpectedResolvedDate_Caption As String
        ''''Dim strStatus_Caption As String

        '''''Modification By SantoshK on 2nd Dec 2004 after adding New field in table tbl_CRM_SubRequestType_Caption_Master
        ''''Dim strRequestType_Caption As String
        '''''Modification Ends

        ''''Dim strSubRequestType_Caption As String
        ''''Dim strTargetLocation_Caption As String
        ''''Dim strFunction_Caption As String
        ''''Dim strSubmittedBy_Caption As String
        ''''Dim strSubmittedDate_Caption As String
        ''''Dim dr As IDataReader
        ''''Dim ds As DataSet
        ''''' get the captions from the caption template	
        ''''dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_SubRequestType_Caption_Master ", m_blnUseSQL)
        ''''If dr.Read Then
        ''''    strSubject_Caption = dr("Subject").ToString & ""
        ''''    strAssignTo_Caption = dr("AssignTo").ToString & ""
        ''''    strPriority_Caption = dr("Priority").ToString & ""
        ''''    strExpectedResolvedDate_Caption = dr("ExpectedResolvedDate").ToString & ""
        ''''    strStatus_Caption = dr("Status").ToString & ""
        ''''    'Added By SantoshK on 2nd Dec 2004
        ''''    strRequestType_Caption = dr("RequestType").ToString & ""
        ''''    'Addition Ends
        ''''    strSubRequestType_Caption = dr("SubRequestType").ToString & ""
        ''''    strSubmittedBy_Caption = dr("SubmittedBy").ToString & ""
        ''''    strSubmittedDate_Caption = dr("SubmittedDate").ToString & ""
        ''''End If
        ''''CommonFunctions.Data.DisposeDataReader(dr)

        ''''Dim arrUserFriendlyCols() As String = {"<img src='../../Images/pin.gif'>", "Request ID", strSubject_Caption, "Discussions", "Department", strRequestType_Caption, strPriority_Caption, strSubmittedBy_Caption, strSubmittedDate_Caption, strExpectedResolvedDate_Caption, strStatus_Caption, "Escalate", "Delete"}
        ''''m_objGrid = New WebPages.Template.GenericGrid
        ''''With m_objGrid
        ''''    ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  
        ''''    'Modified by SiddharthS on 15 Feb 2005 for IssueID 15602.
        ''''    'Purpose : To display the proper value for the status column in a grid.
        ''''    '.NoOfDataColumns = 10
        ''''    .NoOfDataColumns = 11
        ''''    'Modification ends.
        ''''    ' End Modification  By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  

        ''''    .UserFriendlyColumnArray = arrUserFriendlyCols
        ''''    .ActualColumnArray = arrActualCols
        ''''    .IgnoreHTMLEncode = arrIgnoreHTMLEncode
        ''''    .RowLinkArray = arrLink
        ''''    If UCase(Trim(m_strMode & "")) = "SR" Then
        ''''        .CheckBoxIDArray = arrChkBox
        ''''    End If
        ''''    .PrimaryKey = "QueryID"
        ''''    .returnHTML = False

        ''''    .SortBy = m_strSortBy
        ''''    .SortOrder = m_strSortOrder
        ''''    .ClientSideSortFunctionName = "Sort_OnClick"
        ''''    .SQL = SQL
        ''''    .UseSQL = m_blnUseSQL

        ''''    .CurrentPage = m_intPageNumber
        ''''    .PageSize = 20

        ''''    .DIVID = "divList"
        ''''    .DIVStyle = "overflow:auto"
        ''''    .DIVHeight = 300
        ''''    .DrawGrid()
        ''''    intNoOfRows = .NoOfRowsInPage
        ''''End With
        ''''m_objGrid = Nothing

        ''''' total records
        ''''' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2  

        '''''ds = CommonFunctions.Data.GetDataSet(SQL, "default", , , m_blnUseSQL)
        '''''intNoOfRows = ds.Tables(0).Rows.Count
        '''''CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", False, "clsTREven")
        '''''ds.Dispose() : ds = Nothing
        ''''CommonFunctions.General.WriteTotalRecordsHTML(m_intTotalNoOfRows, "Total Records:", False, "clsTREven")

        ''''' End Modification  By NitinVS on 9 Aug 2005 for WhizibleSEM SP 4 IssueID 2 
        ''''End If
        'End of comments by srikanthy on 27 Feb 2007

        CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()

        'Commented and Added By Chakshuta H on 3rd-May-2017 Purpose::Nextgen Upgrade issue fixing
        'Response.Write("<div id='divATT' class='cxtMenu' style='width:300px;height:250px;overflow:auto;display:none;position:absolute;z-index:10000' >")
        Response.Write("<div id='divATT' class='cxtMenu' style='width:170px;height:250px;overflow:auto;display:none;position:absolute;z-index:10000' >")
        'End Of Commented and Added By Chakshuta H on 3rd-May-2017 Purpose::Nextgen Upgrade issue fixing
        'Response.Write("<div id='divATT' class='cxtMenu' style='width:300px;height:250px;overflow:auto;display:none;z-index:10000' >")
        Response.Write("</div>")

        Response.Write("<div id='divActivityDtls' style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;POSITION: absolute; TOP: 165px;Z-INDEX:19000'>")
        Response.Write("</div>")
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


            .Write("<table width='99.9%' class=clsTable cellpadding=0 cellspacing=0><tr class=clsTREven>")
            ' combo box of  filters
            .Write("<td width='26%'>")
            .Write(MyBase.GetResourceString("FILTER_CAPTION"))
            CommonFunctions.HTMLControls.DrawComboBox("cboFilter", "usp_CRM_FilterListForCombo " & EmployeeID, 200, m_lngFilterID.ToString, "Onchange=javascript:cboFilter_OnChange()", True)
            .Write("</td>")
            ' combo box of  status
            .Write("<td width='20%' nowrap>")
            .Write(MyBase.GetResourceString("STATUS_CAPTION"))
            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "usp_CRM_Get_RequestStatus", 140, m_lngStatusID.ToString, "Onchange=javascript:cboStatus_OnChange()", True)
            .Write("</td>")
            ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 
            ' Added Filter for Department in Submitted Request mode 
            If UCase(Trim(m_strMode & "")) = "SR" Then
                ' combo box of  Department
                'Commneted by ShraddhaM on 7,Aug 2009 to remove department filter  
                '.Write("<td width='30%'>")
                '.Write(MyBase.GetResourceString("DEPARTMENT_CAPTION"))
                ''Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
                ''Added By SavitaS on 25 Nov 2005 for WhizibleSemSP4 Enhancement
                ''Purpose: To show customers only those Departments which are made accessible to them 
                ''by setting "Expose To Customer" bit on Configuration->Department Master

                'If m_strLoginType <> "E" Then
                '    'CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", 200, m_lngDepartmentID.ToString, "Onchange=javascript:cboDepartment_OnChange()", True)
                '    CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "SELECT DepartmentID,Department FROM tbl_PM_DepartmentMaster WHERE ExposeToCustomer=1", 200, m_lngDepartmentID.ToString, "Onchange=javascript:cboDepartment_OnChange()", True)
                'Else
                '    'End Addition by SavitaS on 25 Nov 2005  
                '    CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_sel_tbl_PM_DepartmentMaster_list", 200, m_lngDepartmentID.ToString, "Onchange=javascript:cboDepartment_OnChange()", True)
                'End If
                ''End Integration by SavitaS  on 22 Dec 2005
                '.Write("</td>")
                'End of commnet by ShraddhaM

                'Added by ShraddhaM on 7,Aug 2009 for Whiziblesem9 to add filter

                .Write("<td nowrap width='20%'>")
                .Write(" Requested : ")
                .Write(CommonFunction.HTMLControls.DrawComboBox("cboDateFilter", "usp_SEL_tbl_CRM_DateFilter", 100, m_DateFilter, "onchange=javascript:cboDateFilter_OnChange()", True, True)) '
                .Write("</td>")

                .Write("<td nowrap >")
                .Write("Search ")
                CommonFunctions.HTMLControls.DrawComboBox("cboSelectSearch", "usp_SEL_CRM_SearchFields_Submitted", 120, strSearchType, "onchange=javascript:cboSearch_OnChange()", True)
                If strSearchType <> "" Then
                    .Write("&nbsp;<span id='searchfor' >for</span>&nbsp;")
                Else
                    .Write("&nbsp;<span id='searchfor' Style='display:none'>for</span>&nbsp;")
                End If

                'Priority
                If strSearchType = "Priority" OrElse m_SearchFilterName = "Priority_SearchFilter_SR" Then
                    CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_CRM_Get_RequestPriority", 100, strTextSearch)
                Else
                    CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_CRM_Get_RequestPriority", 100, , , , , , , , True)
                End If

                ''Assigned To
                'If strSearchType = "Assigned To" Then
                '    CommonFunctions.HTMLControls.DrawComboBox("cboAssignedTo", "usp_SEL_Tbl_PM_Employee", 150, strTextSearch)
                'Else
                '    CommonFunctions.HTMLControls.DrawComboBox("cboAssignedTo", "usp_SEL_Tbl_PM_Employee", 150, , , , , , , , True)
                'End If

                'Request Type
                If strSearchType = "Request Type" OrElse m_SearchFilterName = "Request Type_SearchFilter_SR" Then
                    CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_CRM_RequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, strTextSearch)

                Else
                    CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_CRM_RequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, , , , , , , , True)

                End If

                'subject
                If strSearchType = "Subject" OrElse m_SearchFilterName = "Subject_SearchFilter_SR" Then
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 150, 100, strTextSearch, EnableHTMLEncode:=True)
                Else
                    CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 150, 100, , , , , , , , , , , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If

                'Severity 
                If strSearchType = "Severity" OrElse m_SearchFilterName = "Severity_SearchFilter_SR" Then
                    CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "usp_CRM_Get_RequestSeverity", 100, strTextSearch)
                Else
                    CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "usp_CRM_Get_RequestSeverity", 100, , , , , , , , True)
                End If
                .Write("</td>")
                .Write("<td>")
                .Write("&nbsp;<a href='javascript:ApplyAdvancedFilter()'>Show</a>")

                .Write("</td>")

                'End of Addition By by ShraddhaM

            End If
            ' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 

            'Added by ShraddhaM on 24,Apr 2009 for Whiziblesem8 to add Requestor text filter
            If UCase(Trim(m_strMode & "")) = "AR" Then

                .Write("<td width='20%'>")
                .Write("Requestor : ")

                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                CommonFunctions.HTMLControls.DrawTextBox("txtRequestor", "txtRequestor", , 140, 100, strRequestor_ForControl, ToBeInserted:="onkeypress=javascript:Requestor_keypress(event)", EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                .Write("</td>")

                '.Write("<td width='34%'>")
                'drawMonthNameHeadings(sbHTML)
                '.Write("</td>")

            End If
            'End of addition by ShraddhaM

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
                .Write("<table width='99.9%' class=clsTable cellpadding=0 cellspacing=0><tr class=clsTREven>")
                'Modified By NitinVS on 13 Mar 2007 for WhizibleSEM SP8 IssueID 11455 
                'Added by PrashantSJ on 08 Nov 2006 For WhizibleSEM SP8 Enhacement Build 1
                'Purpose: To add new section called My e-Dashboard

                '--- Commented By purvaj on 10 Jul 2009 SEM 8.1 New UI Changes
                '''.Write("<TD  width='20%'><INPUT id=optMYDashboard name=optRequest type=radio value='MD' OnClick='JavaScript:optRequest_OnClick(0)' >" & MyBase.GetResourceString("MYEDASHBOARD_CAPTION") & "</TD>")

                '''If m_blnDashboardAccess = True Then
                '''    'End of addition by PrashantSJ on 08 Nov 2006
                '''    .Write("<TD  width='20%'><INPUT id=optDashboard name=optRequest type=radio value='DB' OnClick='JavaScript:optRequest_OnClick(1)'>" & MyBase.GetResourceString("EDASHBOARD_CAPTION") & "</TD>")

                '''End If

                '''If UCase(Trim(m_strMode & "")) = "SR" Then
                '''    .Write("<TD  width='20%'><INPUT id=optSubmitted name=optRequest type=radio value='SR' OnClick='JavaScript:optRequest_OnClick(2)' checked><b>" & MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION") & "</b></TD>")
                '''    .Write("<TD  width='20%'><INPUT id=optAssigned name=optRequest type=radio value='AR' OnClick='JavaScript:optRequest_OnClick(3)'>" & MyBase.GetResourceString("ASSIGNED_REQUESTS_CAPTION") & "</TD>")
                '''Else
                '''    .Write("<TD  width='20%'><INPUT id=optSubmitted name=optRequest type=radio value='SR' OnClick='JavaScript:optRequest_OnClick(2)' >" & MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION") & "</TD>")
                '''    .Write("<TD  width='20%'><INPUT id=optAssigned name=optRequest type=radio value='AR' OnClick='JavaScript:optRequest_OnClick(3)' checked><b>" & MyBase.GetResourceString("ASSIGNED_REQUESTS_CAPTION") & "</B></TD>")
                '''End If
                '--- End Comment PurvaJ
                '--- Added By purvaj on 21 Jul 2009
                If UCase(Trim(m_strMode & "")) = "SR" Then
                    Response.Write("<TD  width='60%' align='left'><B>My Requests (Submitted Requests)</B></TD>")
                Else
                    Response.Write("<TD  width='60%' align='left'><B>Inbox (Assigned Requests)</B></TD>")
                End If
                '--- End addition purvaj


                ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 
                'Issue List TextBox and Go button

                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Dim strtxtResuestId As String = CommonFunctions.HTMLControls.DrawTextBox("txtRequestId", "txtRequestId", , 50, 8, , "Right", , False, False, , False, "onkeypress=txtRequestID_OnKeyPress(event,'DB')", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                'Commented And Added By Chakshuta H on 13th-Oct-2015
                'Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0'>"
                Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0;display:none;'>"
                'End Of Commented And Added By Chakshuta H on 13th-Oct-2015
                Response.Write("<TD width='20%' noWrap  align='right'><B>" + MyBase.GetResourceString("REQUESTLIST") + "</B>&nbsp;&nbsp;" + strtxtResuestId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href='javascript:GO_OnClick(""DB"")' TITLE='Search Request ID '><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;</TD>")

                ' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2  

                ' set/reset default links
                .Write("<TD  width='20%' align=right>")
                If m_blnIsDefaultMode = True Then
                    .Write("<A href='JavaScript:SetDefault_OnClick(1)' style='Text-decoration:None'><b>" & MyBase.GetResourceString("RESETDEFAULT_CAPTION") & "</B>")
                Else
                    .Write("<A href='JavaScript:SetDefault_OnClick(0)' style='Text-decoration:None'><b>" & MyBase.GetResourceString("SETASDEFAULT_CAPTION") & "</B>")
                End If
                .Write("</TD>")

                ' line 
                .Write("</TR><tr><td bgcolor=black colspan=15></td></tr></table>")
            Else
                'modified by harshada d for helpdek issue id 1936
                '.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION")))
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Dim strtxtResuestId As String = CommonFunctions.HTMLControls.DrawTextBox("txtRequestId", "txtRequestId", , 50, 8, , "Right", , False, False, , False, "onkeypress=txtRequestID_OnKeyPress(event,'DB')", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                'Commented And Added By Chakshuta H on 13th-Oct-2015
                'Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0'>"
                Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0;display:none;'>"
                'End Of Commented And Added By Chakshuta H on 13th-Oct-2015
                Response.Write("<TABLE  Width='99.9%' cellspacing=0 class=clsTable>")
                Response.Write("<TR class=clsTRPageHeader><TD align=left> <b>" + MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION"))
                Response.Write("</b>")
                Response.Write("<TD noWrap align=left><B>" + MyBase.GetResourceString("REQUESTLIST") + "</B>&nbsp;&nbsp;" + strtxtResuestId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href='javascript:GO_OnClick(""DB"")' TITLE='Search Request ID '><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;</TD>")

                Response.Write("</TD></TR></TABLE>")
                'end of modified by harshada d for helpdek issue id 1936
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
        ' Revisions             : NitinVS on 25 July 2005 changed Pageing from list to search Mode
        '=====================================================================
        ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 

        'Dim ds As DataSet
        Dim intRecordCount As Integer
        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , True, 20)
        Dim strPaging As String = ""


        If UCase(Trim(m_strMode & "")) = "SR" Then
            PagingSQL = PagingSQL.Replace("usp_CRM_Sel_User_SubmittedRequests", "usp_CRM_Sel_User_SubmittedRequestsCount")
        Else
            PagingSQL = PagingSQL.Replace("usp_CRM_Sel_User_AssignedRequests", "usp_CRM_Sel_User_AssignedRequestsCount")
        End If

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
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15

        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"
        'End of comment and addition by PrashantD on 24 May 2007 for CleanUp Activity


        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        ' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 

        If Trim(strPaging & "") <> "" Then
            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
        End If
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
        ' login type condition added by harshada d on 22 11 2005 
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

    Private Sub SaveViewColumns()
        Dim strQuery As String
        Dim strSelectedValues As String
        Dim mode As String

        If Not Request.Form("chkField") Is Nothing And Request.Form("chkField") <> "" Then
            strSelectedValues = Request.Form("chkField").ToString()
        Else
            strSelectedValues = ""
        End If
        'Added by bharat tekade
        mode = Request.QueryString("Mode").ToUpper()

        strQuery = "usp_Ins_tbl_CRM_HelpDesk_Views " + Session("intUserID").ToString() + ",'" + strSelectedValues + "','SR'"
        'Ended by bharat tekade

        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub
#Region "events"
    Private Sub MenuLink_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If UCase(Trim(m_strMode & "")) = "AR" Then
            MyBase.InitializeResources("Resources.StandardMenu", "Resources")
            ' for "assigned requests" mode hide Add New/ Delete links
            'modified by harshada d for whiziblesem 6.0 for issue id 1936 for helpdesk enahncements
            'If Args.MenuColIndex = 0 Or Args.MenuColIndex = 1 Or Args.MenuColIndex = 4 Then
            'If Args.LinkName.ToUpper = "ON BEHALF OF CUSTOMER REQUESTS" Or Args.LinkName.ToUpper = "ADD NEW" Or Args.LinkName.ToUpper = "DELETE" Then

            'Modified by SrikanthY on 10 Jan 2007 Not to plot OnBehalf link if its called in AR Mode 
            If Args.LinkName.ToUpper = "ON BEHALF OF CUSTOMER/EMPLOYEE REQUESTS" Or Args.LinkName.ToUpper = "ADD NEW" Or Args.LinkName.ToUpper = "DELETE" Then
                Cancel = True
            End If
        ElseIf UCase(Trim(m_strMode & "")) = "SR" Then
            If m_strLoginType = "C" Or blnIsHRM = 0 Then
                If Args.LinkName.ToUpper = "ON BEHALF OF CUSTOMER/EMPLOYEE REQUESTS" Then
                    Cancel = True
                End If
            End If
        End If
        'end of modification by harshada d for whiziblesem 6.0 for issue id 1936 for helpdesk enahncements
        'end of modification by SrikanthY
        'Added by SandipL for SLA access on 30th June 2007
        If Args.FunctionName.ToUpper = "SHOWSLA_ONCLICK()" Then
            If m_blnSLAAccess = False Then
                Cancel = True
            End If
        End If
        'End addition by SandipL

        'Added by ShraddhaM on 9,Sept 2008
        'Purpose : Added Request Approvals link For Line Manager Approval Functionality
        If m_strLoginType = "C" Then
            If Args.LinkName.ToUpper = "REQUEST APPROVALS" Then
                Cancel = True
            End If

        End If
        'End of addition by ShraddhaM on 9,Sept 2008

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        'intTotalCol = intTotalCol + 1

        'Added by bharat tekade
        Select Case UCase(Trim(Args.DataField & ""))
            Case "ATTACHMENTS"
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.TDStyle = " NoWrap  title='Attachments'"
            Case "DISCUSSIONS"
                Args.ApplySorting = False
                Args.ColumnName = "<IMG border=0 src='../../Images/Discussions.gif'>"
                Args.ApplyHTMLEncode = False

                'Added by ShraddhaM on 1,Apr 2009
            Case "DESCRIPTION"

                Args.TDStyle = " title='Description'"
                Args.ApplySorting = False
                Args.ColumnName = ""
                Args.ApplyHTMLEncode = False
                'Ended by ShraddhaM
            Case "FLAGTO"

                If m_strLoginType = "C" And UCase(Trim(m_strMode & "")) = "SR" Then
                    Cancel = True
                Else
                    Args.TDStyle = " NoWrap title='FlagTo'"
                    Args.ApplySorting = False
                    ' Args.ColumnName = "<IMG border=0 src='../../Images/grayflag.gif'>"
                    Args.ApplyHTMLEncode = False
                End If
                'Added by vidyaK for Whiziblesem9 SP1 on 25 Aug 2010
            Case "APPROVALSTATUSIMAGE"
                Args.TDStyle = " align=center "
                'End Added by vidyaK for Whiziblesem9 SP1 on 25 Aug 2010

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



        End Select
        'Ended by bharat tekade

        'Added by bharat tekade
        'If UCase(Trim(m_strMode & "")) = "SR" Then
        '    'Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
        '    'Added by SavitaS on 14 dec 2005
        '    If m_strLoginType <> "E" Then
        '        Select Case Args.DataField.Trim.ToUpper
        '            Case "EXPECTEDRESOLVEDDATE"
        '                Cancel = True
        '                'Added by vidyaK for Whiziblesem9 SP1 on 25 Aug 2010
        '            Case "APPROVALSTATUSIMAGE"
        '                Cancel = True
        '                'End Added by vidyaK for Whiziblesem9 SP1 on 25 Aug 2010
        '        End Select
        '    End If
        '    'End Addition by SavitaS
        '    'End Integration by SavitaS  on 22 Dec 2005

        '    Select Case Args.DataField.Trim.ToUpper
        '        'Case "CUSTOMERID", "PRIORITY", "ESCALATE"
        '        Case "PRIORITY", "ESCALATE"
        '            Cancel = True
        '            ' Modified By NitinVS on 15 Feb 2007 for WhizibleSP9 IssueID 10293
        '        Case "CUSTOMERNAME"
        '            If m_strLoginType = "C" Then
        '            Else
        '                Cancel = False
        '            End If

        '        Case Else
        '    End Select
        'Else
        '    If Args.DataField.Trim.ToUpper = "DELETE" Then
        '        Cancel = True
        '    End If

        '    ' Modified By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 
        '    If Args.DataField.Trim.ToUpper = "DEPARTMENT" Then Cancel = True
        '    ' End Modification By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 

        'End If

        'Ended by bharat tekade

        'Added by ShraddhaM for whiziblesem8 on 14,Apr 2009 for Helpdesk view changes

        Dim strViewFields As String = ""
        Dim ColumnName As String

        'Added by bharat tekade

        'strViewFields = ",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"

        'If Not Request.Form("hidViewFields") Is Nothing And Request.Form("hidViewFields") <> "" And strSelectedValues Is Nothing Then
        '    strViewFields = Request.Form("hidViewFields") '",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"
        'Else
        strViewFields = strSelectedValues
        'End If




        ColumnName = Trim(Args.ColumnName & "").ToUpper()

        If strViewFields = "" Then
            strViewFields = ""
        End If

        If strViewFields <> "" Then
            strViewFields = strViewFields.ToUpper()

            If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "DELETE" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                If strViewFields.Contains("," + ColumnName + ",") = False Then
                    Cancel = True
                End If
            End If
        Else
            If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "DELETE" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                Cancel = True
            End If
        End If
        'Ended by bharat tekade

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

        'Added by VidyaK on 25 May 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)

        'Added by bharat tekade

        'If UCase(Trim(Args.DataField & "")) = "APPROVALSTATUSIMAGE" Then
        '    Dim strApprovalStatus As String
        '    Dim arrstatus() As String
        '    Dim arrComments(2) As String
        '    Dim iterator As Integer
        '    Dim strComment As String
        '    strApprovalStatus = Trim(Args.DataReader("APPROVALSTATUSIMAGE").ToString())
        '    Args.StringToBeInserted = "<TD vAlign=top align=center style='border-bottom: 1pt solid gray;' nowrap;>"
        '    If strApprovalStatus <> "" Then
        '        arrstatus = strApprovalStatus.Split(",")
        '        Args.StringToBeInserted += "<TABLE class='clsTable' cellspacing=0 cellpadding=0 border=0><TR style='clsTRBlank' Title=""" + Args.DataReader("ReportingToName").ToString() + """>"
        '        For iterator = 0 To arrstatus.Length - 1
        '            Cancel = True
        '            If arrstatus(iterator) = "G" Then
        '                Args.StringToBeInserted += "<TD align=center><IMG border=0 src='../../Images/InitiativeGreen.gif' /></TD>"
        '            ElseIf arrstatus(iterator) = "A" Then
        '                Args.StringToBeInserted += "<TD align=center><IMG border=0 src='../../Images/InitiativeGreen.gif' /></TD>"
        '            ElseIf arrstatus(iterator) = "Y" Then
        '                Args.StringToBeInserted += "<TD align=center><IMG border=0 src='../../Images/InitiativeYellow.gif' /></TD>"
        '            ElseIf arrstatus(iterator) = "R" Then
        '                Args.StringToBeInserted += "<TD align=center><IMG border=0 src='../../Images/InitiativeRed.gif' /></TD>"
        '            End If
        '        Next
        '        If iterator = 0 Then
        '            Args.StringToBeInserted += "<TD align=center></TD>"
        '        End If
        '        Args.StringToBeInserted += "</TR></Table>"
        '        Args.StringToBeInserted += "</td>"
        '    Else
        '        Cancel = True
        '        Args.StringToBeInserted += "&nbsp;NA</td>"
        '    End If
        'End If

        'Ended by bharat tekade

        'End Added by VidyaK on 25 May 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)

        Dim strViewFields As String = ""
        Dim ColumnName As String

        strViewFields = strSelectedValues

        Dim strTD As String

        'strViewFields = ",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"

        'If Not Request.Form("hidViewFields") Is Nothing And Request.Form("hidViewFields") <> "" And strSelectedValues Is Nothing Then
        '    strViewFields = Request.Form("hidViewFields") '",EXP DATE OF RESOLUTION,REQUEST TYPE,REQUESTOR NAME,STATUS,"
        'Else
        '    strViewFields = strSelectedValues
        'End If

        'Added by bharat tekade

        ''If UCase(Trim(m_strMode & "")) = "SR" Then
        ''    ' submitted requests
        ''    'Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
        ''    'Added by SavitaS on 14 dec 2005
        ''    If m_strLoginType <> "E" Then

        ''        Select Case Args.DataField.Trim.ToUpper
        ''            Case "EXPECTEDRESOLVEDDATE"
        ''                Cancel = True
        ''                'Added by vidyaK for Whiziblesem9 SP1 on 25 Aug 2010
        ''            Case "APPROVALSTATUSIMAGE"
        ''                Args.StringToBeInserted = ""
        ''                Cancel = True
        ''                'End Added by vidyaK for Whiziblesem9 SP1 on 25 Aug 2010
        ''        End Select
        ''    End If
        ''    'End Addition by SavitaS
        ''    'End Integration by SavitaS  on 22 Dec 2005

        ''    Select Case Args.DataField.Trim.ToUpper
        ''        'Case "CUSTOMERID", "PRIORITY", "ESCALATE"
        ''        Case "PRIORITY", "ESCALATE"
        ''            Cancel = True
        ''            ' Modified By NitinVS on 15 FEb 2007 for Whizible SP9 10293
        ''        Case "CUSTOMERNAME"
        ''            If m_strLoginType = "C" Then
        ''            Else
        ''                Cancel = True
        ''            End If

        ''        Case Else

        ''    End Select




        ' Modified By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 
        'If Trim(Args.CheckBoxId & "") <> "" Then
        '    If (Trim(Args.DataReader("AssignTo").ToString & "") <> "0" And Trim(Args.DataReader("AssignTo").ToString & "") <> "") Or Trim(Args.DataReader("TaskID").ToString & "") <> "" Or Trim(Args.DataReader("IssueID").ToString & "") <> "" Then
        '        Args.IsCheckBoxDisabled = True
        '    End If
        'End If
        ' End Modification By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 

        ''Else
        ''' Assigned Requests
        ''Select Case Args.DataField.Trim.ToUpper
        ''    Case "DELETE"
        ''        Cancel = True
        ''    Case "ESCALATE"
        ''        If Trim(Args.DataReader("StatusID").ToString) = "5" Or Trim(Args.DataReader("StatusID").ToString) = "2" Or Trim(Args.DataReader("StatusID").ToString) = "3" Then
        ''            Args.StringToBeInserted = "<TD></TD>"
        ''            Cancel = True
        ''        End If
        ''        ' Modified By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 
        ''    Case "DEPARTMENT"
        ''        Cancel = True
        ''        ' End Modification By NitinVS on 9 Aug 2005 for whizibleSEM SP4 IssueID 2 

        ''    Case Else
        ''End Select
        ''End If
        ''''ADDED BY AMIT MAHADIK 0N 29 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
        ''m_strQueryid = CType(Args.DataReader("QueryID"), Integer) '''THIS VALUE IS USED BELOW
        ''''END ADDED BY AMIT MAHADIK 0N 29 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject

        'Ended by bharat tekade

        'Added by bharat tekade
        Select Case UCase(Trim(Args.DataField & ""))
            Case "SUBJECT"
                ' truncate subject to length of 50
                ''If Trim(Args.DataReader("Subject").ToString & "") <> "" Then
                ''    If Len(Trim(Args.DataReader("Subject").ToString & "")) > 50 Then
                ''        Args.DataFieldValue = "<A Href='javascript:Query_OnClick(" & CType(Args.DataReader("QueryID"), Long) & ")' title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Subject").ToString) & Chr(34) & ">" & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "...</A>"
                ''        Args.ApplyHTMLEncode = False
                ''        Args.TDStyle = " width=25% title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & ""
                ''    Else
                ''        Args.TDStyle = " width=25% title=" & Chr(34) & Server.HtmlEncode(Args.DataReader("Description").ToString) & Chr(34) & ""
                ''    End If
                ''End If

                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

                ''ADDED BY AMIT MAHADIK 0N 29 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject
                'ADD BY BHARAT
                m_strQueryid = CType(Args.DataReader("QueryID"), Integer) ''''''value set above
                'END BY BHARAT
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
                If Trim(Args.DataReader("Subject").ToString & "") <> "" Then
                    If Len(Trim(Args.DataReader("Subject").ToString & "")) > 50 Then
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                        Args.StringToBeInserted = "<TD vAlign=top  style='width=25%;border-bottom: 1pt solid gray;' nowrap;>" _
                     & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">"
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
                        Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "...</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        ''END Modified BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEST LIKE ...."14 Days Ago" below Subject
                        'End Modification By NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 Issue 11446
                        Args.ApplyHTMLEncode = False
                        Cancel = True
                    Else
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")

                        Args.StringToBeInserted = "<TD vAlign=top  style='width=25%;border-bottom: 1pt solid gray;' nowrap;>" _
                     & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">"
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
                        Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Trim(Args.DataReader("Subject").ToString)) & "</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        ''END Modified BY AMIT MAHADIK 0N 28 MAR 2011 TO DISPALY TEXT LIKE ...."14 Days Ago" below Subject

                        Cancel = True
                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    End If
                End If
            Case "ATTACHMENTS"

                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                Args.ApplyHTMLEncode = False
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
                    'ADDED by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0
                    'PURPOSE: TO HIDE DISCUSSIONS FROM CUSTOMER WHICH ARE NOT MARKED AS SHOW TO CUSTOMER 
                    Dim strNoOfDiscussions As String
                    Dim strQueryNoOfDiscussions As String
                    strQueryNoOfDiscussions = "SELECT count(QueryID) from tbl_CRM_Query_Details WITH (NOLOCK) where QueryID = " & CType(Args.DataReader("QueryID"), String) & " AND ISSHOWTOCUSTOMER =1"

                    strNoOfDiscussions = Trim(Args.DataReader("NoOfDiscussions").ToString & "")

                    If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") = "C" Then
                        strNoOfDiscussions = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQueryNoOfDiscussions, MyBase.UseSQL), "0"), String)
                    End If
                    'END ADDED by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0

                    If Not CType(Args.DataReader("IsDiscussionViewed"), Boolean) Then

                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                        '' Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A> " & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"


                        'Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None' nowrap;>" _
                        '           & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"

                        'Modified By KapilGK On 18 Oct 2006 For Displaying "New" caption.
                        'MODIFIED BY by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0,ADDED VARIABLE :strNoOfDiscussions
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                   & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "','" + UCase(Trim(m_strMode & "")) + "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & strNoOfDiscussions & ")</A>" & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                        'END MODIFIED BY by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0,ADDED VARIABLE :strNoOfDiscussions
                        'End of Modification By KapilGK


                        Cancel = True
                    Else
                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                        '' Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & ")' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        ''Args.StringToBeInserted = "<TD  NoWrap><A href='JavaScript:Discussion_OnClick(" & Args.DataReader("QueryID").ToString & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')' title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "'  style='TEXT_DECORATION:None'><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        'MODIFIED BY by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0,ADDED VARIABLE :strNoOfDiscussions
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "','" + UCase(Trim(m_strMode & "")) + "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & strNoOfDiscussions & ")</A></TD>"
                        'END MODIFIED BY by Amit Mahadik on 18 Mar 2011 Purpose:Whizible SEM 10.0,ADDED VARIABLE :strNoOfDiscussions
                        Cancel = True
                    End If
                Else
                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    ''Args.DataFieldValue = "<IMG border=0 src='../../Images/Discussions.gif' alt='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "'>"
                    Args.StringToBeInserted = "<TD vAlign=top style='border-bottom: 1pt solid gray;'>" _
                                                & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "','" + UCase(Trim(m_strMode & "")) + "')""><IMG border=0 src='../../Images/Discussions.gif' alt= " & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "></A></TD>"
                    ''Args.ApplyHTMLEncode = False
                    Cancel = True
                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                End If

                'Added by ShraddhaM on 1,Apr 2009
            Case "DESCRIPTION"

                m_Queryid = CType(Args.DataReader("QueryID"), Integer)
                Args.TDStyle = " title='Description'"
                Args.StringToBeInserted = "<TD id= " + m_Queryid.ToString() + " name=" + m_Queryid.ToString() + " vAlign=top title='Description' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:ShowDescription_onClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='Description' onclick="""" ID='imgSummaryShowHide" & CType(m_Queryid, String) & "' name='imgSummaryShowHide" & CType(m_Queryid, String) & "'></a></TD>"
                Cancel = True
                'Ended by ShraddhaM
                'Case "SUBMITTEDDATE"
                '    Args.ShowTimeWithDate = True

                'Case "EXPECTEDRESOLVEDDATE"
                '    Args.ShowTimeWithDate = False

            Case "FLAGTO"

                If m_strLoginType = "C" And UCase(Trim(m_strMode & "")) = "SR" Then
                    Cancel = True
                Else
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
                    ''Commented and Added by Yogesh J on 18-Jan-2016 to generate Token
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "L" Then
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
                        'End of Addition By ShraddhaM on 7,Aug 2007
                    Else
                        ' Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../Images/GrayFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                        Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " ,'" + CommonFunctions.Security.Token.GetToken(CType(m_Queryid, String) + CType(m_lngEmployeeID, String) + "0" + "0") + "' )""><IMG Border=0  SRC='../../Images/GrayFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                    End If
                    ''End of addition by Yogesh J on on 18-Jan-2016 to generate Token
                End If
            Case Else
        End Select

        'Added by bharat tekade

        ColumnName = Trim(Args.ColumnName & "").ToUpper()

        If strViewFields <> "" Then
            strViewFields = strViewFields.ToUpper()

            If Args.DataField <> "DESCRIPTION" And ColumnName <> "DELETE" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                If strViewFields.Contains("," + ColumnName + ",") = False Then
                    Cancel = True
                End If
            End If
        Else
            If Args.DataField <> "DESCRIPTION" And ColumnName <> "DELETE" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../IMAGES/GRAYFLAG.GIF'>" Then
                Cancel = True
            End If

        End If

        If Args.DataField.ToLower().Contains("customfield") Then

            If m_objCFDS.Tables(0).Select("DatabaseFieldName='" + Args.DataField.ToString + "' AND TypeID=" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubRequestTypeID"), "0").ToString()).Length <= 0 Then
                Args.ReplacementValue = "-"
            End If
        End If

        'Ended by bharat tekade

        'Ended by ShraddhaM for whiziblesem8

    End Sub

    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        Args.TableStyle = " cellpadding=0 cellspacing=0  style='border-right: 2px solid gray;border-left: 2px solid gray;border-top: 2px solid gray;'"
    End Sub

    'Added by ShraddhaM on 6,Apr 2009 for Whiziblesem8
    'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint

        m_Queryid = CType(Args.DataReader("QueryID"), Integer)
        intTotalCol = CType(Args.DataReader.Table.Columns.Count, Integer)
        Dim intAssignTo As Integer
        Dim status As String
        Dim statusID As String
        Dim TotalTimeSpent As String
        Dim RequestorType As String

        TotalTimeSpent = CType(Args.DataReader("TotalTimeSpent"), String)
        status = Args.DataReader("Status").ToString()
        statusID = Args.DataReader("StatusID").ToString()

        RequestorType = Args.DataReader("LoginType")

        If IsDBNull(Args.DataReader("AssignToID")) Then
            intAssignTo = 0
        Else
            intAssignTo = CType(Args.DataReader("AssignToID"), Integer)
        End If

        Args.StringToBeInserted = "<TR class=" + strClass + " id='Description" & CType(m_Queryid, String) & "' name='Description" & CType(m_Queryid, String) & "' width=99.9% style=""display:none"">"

        ' Added by VijayD on 11 Jun 2009 For HelpDesk StatusFlow Configuration
        Dim m_StatusFlowCount As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(m_Queryid, String) + "", MyBase.UseSQL), "0"), String)
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount" + CType(m_Queryid, String), "StatusFlowCount" + CType(m_Queryid, String), , , , m_StatusFlowCount, IsHidden:=True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus" + CType(m_Queryid, String), "txtOldStatus" + CType(m_Queryid, String), , , , status, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        Dim m_IntSubRequestID As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select SubRequestTypeID from tbl_CRM_Query_Master where queryID=" + CType(m_Queryid, String) + "", MyBase.UseSQL), "0"), String)

        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus" + CType(m_Queryid, String), "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "',2,'" + status + "'", DisplayNone:=True)) '--, displaynone:=True
        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus" + CType(m_Queryid, String), "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "'," + "1", DisplayNone:=True)) ', displaynone:=True
        ' Addition End by VijayD on 11 Jun 2009

        Args.StringToBeInserted += "<TD align=left colspan=" + intTotalCol.ToString() + ">"
        Args.StringToBeInserted += "<DIV id=Summary" & CType(m_Queryid, String) & " name=Summary" & CType(m_Queryid, String) & " style=""overflow:auto;display:none"">"

        Args.StringToBeInserted += "<TABLE ID='Description' cellspacing=0 cellpadding=0 Width=99.9% class=clsGridTable>"
        Args.StringToBeInserted += "<tr class=" + strClass + ">"
        Args.StringToBeInserted += "<td valign='top' colspan='7' align='left' ><b>Description </b>: "
        'Commented and Added By Bharat T on 30th-Nov-2015
        'Args.StringToBeInserted += CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), ""), String)
        Args.StringToBeInserted += CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(Args.DataReader("Description")), ""), String)
        'End of Commented and Added By Bharat T on 30th-Nov-2015
        Args.StringToBeInserted += "</TD></TR>"

        If UCase(Trim(m_strMode & "")) = "AR" Then

            Args.StringToBeInserted += "<TR class=" + strClass + " >"

            'TotalTimeSpent

            Args.StringToBeInserted += "<TD  align=left id=TotalTime" + CType(m_Queryid, String) + " style='border-bottom: 0px solid gray;display:none;' TotalTime=" + TotalTimeSpent.ToString() + ">"
            Args.StringToBeInserted += "<B><U><A onClick='ShowDetailActivity(event," + CType(m_Queryid, String) + ")' >Total Time Spent</A></U>&nbsp;:&nbsp;" + TotalTimeSpent.ToString() + "&nbsp;Hrs</B>&nbsp;&nbsp;"
            Args.StringToBeInserted += "</TD>"


            'Status Change
            If statusID = 2 Then
                Args.StringToBeInserted += "<TD  align=left  style='border-bottom: 1px solid gray;cursor:hand;width:25%;'>"

                Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , "disabled", True, EnableHTMLEncode:=True)
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle  >"

                Args.StringToBeInserted += "</TD>"

                'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
                'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
                'Args.StringToBeInserted += "</TD>"

            Else
                Args.StringToBeInserted += "<TD  align='left' style='border-bottom: 1px solid gray;width:25%;'  >"

                Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , " onclick=ShowStatus(" + m_Queryid.ToString + ",event) ", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' >"
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += "</TD>"

                'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
                'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
                'Args.StringToBeInserted += "</TD>"

            End If


            'Time Spent 'Time period
            Args.StringToBeInserted += "<TD id=TimeSpent" + CType(m_Queryid, String) + " align='right' style='text-align:right;border-bottom: 1px solid gray;width:25%;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + ">"

            Args.StringToBeInserted += "Time Spent&nbsp;"
            If statusID = 2 Then
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , True, , , , , True, EnableHTMLEncode:=True)
            Else
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , , , , , , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            End If


            Args.StringToBeInserted += "&nbsp;(Min)&nbsp;<A onClick='ShowDetailActivity(event," + CType(m_Queryid, String) + ")' ><img src='../../Images/cssImages/Link images/ViewHistory.gif' valign=middle  alt='Show Detail Time Spent' /></a></TD>"
            'Args.StringToBeInserted += "<TD id=TimeSpent" + CType(m_Queryid, String) + " align='right' style='text-align:right;border-bottom: 1px solid gray;width:20%;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + ">Activity&nbsp;"
            Args.StringToBeInserted += "<TD id=TimeSpent" + CType(m_Queryid, String) + " align='right' style='text-align:right;border-bottom: 1px solid gray;width:30%;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + ">Activity&nbsp;"
            'Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 250, 2000, , , "cursor:hand;", , , , , " onkeyup=SearchActivity(" + m_Queryid.ToString + ",event) onkeydown=processKeys(event)", True)
            If statusID = 2 Then
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , True, True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += "<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;'    >"
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidActivityID" + m_Queryid.ToString, "hidActivityID" + m_Queryid.ToString, , 50, 2000, , , , , , , True, , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            Else
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , , True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += "<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;'  onclick=SearchActivity(" + m_Queryid.ToString + ",event) >"
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidActivityID" + m_Queryid.ToString, "hidActivityID" + m_Queryid.ToString, , 50, 2000, , , , , , , True, , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            End If

           

            'Args.StringToBeInserted += "</B>"
            'Args.StringToBeInserted += CommonFunction.HTMLControls.DrawComboBox("cboTimeUnits", "select 'M','Minutes' UNION select 'H','Hours'", 80, ReturnAsHTML:=True)
            If statusID = 2 Then
                Args.StringToBeInserted += "</TD><TD id=TimeSpent" + CType(m_Queryid, String) + " align='right' style='text-align:right;border-bottom: 1px solid gray;width:10%;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + "> <input  type=button id=btnSave" + CType(m_Queryid, String) + " onclick='SaveActivity_OnClick(" + m_Queryid.ToString + ")' value=""Save"" disabled/>"
            Else
                Args.StringToBeInserted += "</TD><TD id=TimeSpent" + CType(m_Queryid, String) + " align='right' style='text-align:right;border-bottom: 1px solid gray;width:10%;' TodaysTotalTimeSpent=" + Args.DataReader("TodaysTotalTimeSpent").ToString() + "><input  type=button id=btnSave" + CType(m_Queryid, String) + " onclick='SaveActivity_OnClick(" + m_Queryid.ToString + ")' value=""Save"" />"
            End If
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            Args.StringToBeInserted += "&nbsp;" + CommonFunction.HTMLControls.DrawTextBox("txtSavingLable" + CType(m_Queryid, String), "txtSavingLable" + CType(m_Queryid, String), , , 100, "Saving....", , "width:80px;BACKGROUND-COLOR:#FFFF80;border-color:gray;display:none;", , True, "#FFFF80", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            Args.StringToBeInserted += "</TD>"

            'Requestor Details and Statistics 
            Args.StringToBeInserted += "<TD id=RequestorDtl" + CType(m_Queryid, String) + " align='left' style='border-bottom: 1px solid gray;width:15%;'>"
            Args.StringToBeInserted += "<B><U><A onClick='ShowRequestorDetails(event," + CType(m_Queryid, String) + ",""" + RequestorType + """)' >Requestor</A></U></B>"
            Args.StringToBeInserted += "&nbsp;&nbsp;&nbsp;&nbsp;<B><U><A onClick='ShowStatistics(event," + CType(m_Queryid, String) + ",""" + RequestorType + """)' >Statistics</A></U></B>"

            Args.StringToBeInserted += "</TD>"


            Args.StringToBeInserted += "</TR></Font>"

        ElseIf UCase(Trim(m_strMode & "")) = "SR" Then

            If m_strLoginType = "E" Then

                Args.StringToBeInserted += "<TR class=" + strClass + " >"
                'Assign To
                Args.StringToBeInserted += "<TD valign=middle align='left' id=AssignTo" + CType(m_Queryid, String) + " style='border-bottom: 1px solid gray;width:15%;'>"
                If intAssignTo = CType(Session("intUserID"), Integer) Then
                    Args.StringToBeInserted += "<B><Font color=red>Assigned To me</Font></B>"
                ElseIf intAssignTo = 0 Then
                    Args.StringToBeInserted += "<B><Font color=red>Not Assigned</Font></B>"
                Else
                    Args.StringToBeInserted += "<B><Font color=red>Assigned To : " + Args.DataReader("AssignToName").ToString() + "</Font></B>"
                End If

                Args.StringToBeInserted += "</TD>"

                'Status Change
                If statusID = 2 Then
                    Args.StringToBeInserted += "<TD  align=left  style='border-bottom: 1px solid gray;cursor:hand;width:50%;'>"

                    Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , "disabled", True, EnableHTMLEncode:=True)
                    'Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 100, 50, statusID, , , , True, , , "disabled", True)
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                     Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle  >"

                    Args.StringToBeInserted += "</TD>"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidoldStatusID" + m_Queryid.ToString, "hidoldStatusID" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , , , True, , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
                    'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
                    'Args.StringToBeInserted += "</TD>"

                Else
                    Args.StringToBeInserted += "<TD  align='left' style='border-bottom: 1px solid gray;width:50%;'  >"

                    Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , " onclick=ShowStatus(" + m_Queryid.ToString + ",event) ", True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' >"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "</TD>"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidoldStatusID" + m_Queryid.ToString, "hidoldStatusID" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
                    'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
                    'Args.StringToBeInserted += "</TD>"

                    Args.StringToBeInserted += "<TD align='left' style='border-bottom: 1px solid gray;'><input  type=button id=btnSave onclick='SaveActivity_OnClick(" + m_Queryid.ToString + ")' value=""Save"" />"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "&nbsp;" + CommonFunction.HTMLControls.DrawTextBox("txtSavingLable" + CType(m_Queryid, String), "txtSavingLable" + CType(m_Queryid, String), , , 100, "Saving....", , "width:80px;BACKGROUND-COLOR:#FFFF80;border-color:gray;display:none;", , True, "#FFFF80", returnHTML:=True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "</TD>"

                End If


                Args.StringToBeInserted += "</TR>"
            Else
                'Status Change
                Args.StringToBeInserted += "<TR class=" + strClass + " >"

                'Status Change
                If statusID = 2 Then
                    Args.StringToBeInserted += "<TD  align=left  style='border-bottom: 1px solid gray;cursor:hand;width:50%;'>"

                    Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , "disabled", True, EnableHTMLEncode:=True)
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle  >"
                    
                    Args.StringToBeInserted += "</TD>"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidoldStatusID" + m_Queryid.ToString, "hidoldStatusID" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
                    'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
                    'Args.StringToBeInserted += "</TD>"

                Else
                    Args.StringToBeInserted += "<TD  align='left' style='border-bottom: 1px solid gray;width:50%;'  >"

                    Args.StringToBeInserted += "&nbsp;Change Status&nbsp;"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , " onclick=ShowStatus(" + m_Queryid.ToString + ",event) ", True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' >"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "</TD>"
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("hidoldStatusID" + m_Queryid.ToString, "hidoldStatusID" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    'Args.StringToBeInserted += "<TD align=left nowrap style='border-bottom: 1px solid gray;cursor:hand;'>"
                    'Args.StringToBeInserted += "<IMG src='../../Images/selection.gif' onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' ></B>&nbsp;&nbsp;&nbsp;&nbsp;"
                    'Args.StringToBeInserted += "</TD>"

                    Args.StringToBeInserted += "<TD align='left' style='border-bottom: 1px solid gray;'><input  type=button id=btnSave onclick='SaveActivity_OnClick(" + m_Queryid.ToString + ")' value=""Save"" /> "
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "&nbsp;" + CommonFunction.HTMLControls.DrawTextBox("txtSavingLable" + CType(m_Queryid, String), "txtSavingLable" + CType(m_Queryid, String), , , 100, "Saving....", , "width:80px;BACKGROUND-COLOR:#FFFF80;border-color:gray;display:none;", , True, "#FFFF80", returnHTML:=True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    Args.StringToBeInserted += "</TD>"

                End If


                Args.StringToBeInserted += "</TR>"

            End If
        End If



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
#End Region
    ' Added by SrikanthY on 28 Dec 2006 To Display Client Details on Request List Screen In case of Clients Login
    Private Sub GetClientDetails()
        Dim strSQL As String
        Dim drClient As IDataReader
        strSQL = "USP_SEL_TBL_PM_LOGIN_CLIENTDETAILS " & CType(m_lngLoginID, String)
        drClient = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If drClient.Read Then
            m_strLoginName = CType(CommonFunctions.Data.CheckIsDBNull(drClient("LOGINNAME"), ""), String)
            m_blnIsClient = CType(CommonFunctions.Data.CheckIsDBNull(drClient("ISCREATEDBYCUSTOMER"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(drClient)
    End Sub
    'End of Addition by SrikanthY


    Private Sub m_objGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGrid.ColumnHeaderTR_BeforePrint

    End Sub

    'Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateShowSLATokenSR(FilterID As String) As String
        Dim m_PKToken_ShowSLASR As String
        'm_PKToken_ShowSLASR = CommonFunctions.Security.Token.GetToken(CType(FilterID, String) + "0" + "0")
        'of Comment and Added By Sanyogeeta R ON 16-Aug-2016 For PkToken Validation 
        m_PKToken_ShowSLASR = CommonFunctions.Security.Token.GetToken(CType(FilterID, String) + HttpContext.Current.Session("intUserID").ToString() + "0" + "0")
        'End of Comment and Addition  By Sanyogeeta R ON 16-Aug-2016 For PkToken Validation 
        Return m_PKToken_ShowSLASR
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateFlagToken_RequestList(ProjectID As String, ContextID As String) As String
        Dim m_PKToken_FlagToken_RequestList As String
        m_PKToken_FlagToken_RequestList = CommonFunctions.Security.Token.GetToken(CType(ProjectID, String) + CType(ContextID, String) + "0" + "0")
        Return m_PKToken_FlagToken_RequestList
    End Function
    'eND Of Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 
End Class
