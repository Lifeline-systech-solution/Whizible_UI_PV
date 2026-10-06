Imports System.IO
Imports System.IO.Compression
Imports System.Xml
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Linq
Public Class CRM_UnCategorizedRequestList
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Private WithEvents m_objGridAttachment As WebPages.Template.GenericGrid
    Private m_blnUseSQL As Boolean
    Protected m_strMode As String = ""
    Private m_strAction As String = ""
    Protected m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Private m_blnSLAAccess As Boolean = False
    Private strSelectedValues As String
    Private m_intTotalNoOfRows As Integer
    Private m_dsGrid As DataSet
    Private m_blnShowAssignTaskInHelpDesk As Boolean
    Protected blnIsHRM As Integer = 0
    Protected m_objCFDS As DataSet
    Private m_strQueryid As String
    Protected m_PKToken_Query_DT As String
    Protected m_Queryid As Integer
    Protected m_FlagStatus As String
    Protected m_strSQL As String = ""
    Private intTotalCol As Integer
    Private count As Integer = 1
    Private strClass As String = "clsTREven"
    Protected m_intPageNumber As Integer = 1
    Private m_lngStatusID As Long = 0
    Protected m_strSortBy As String
    Protected m_strSortOrder As String
    Protected m_lngFilterID As Long = 0
    Protected m_lngFilterNewID As String = "0"
    Protected m_lngDepartmentID As Long = 0
    Protected m_DateFilter As String = ""
    Protected m_AdvanceFilter As String = ""
    Private strRequestor As String = ""
    Protected m_blnHRM As Boolean = False
    Protected m_intNoOfRows As Integer
    Private m_arrAccessibleDepartments As New Hashtable
    Protected m_SearchFilterName As String = ""
    Protected m_SearchFilterValue As String = ""
    Protected m_intNoOfRecordInGrid As Int16 = 20
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected m_bitApproveAccess As Boolean = False
    Protected m_bitAssignToAccess As Boolean = False
    ''Added By Vidya Jadhav ON 6 Nov 2017 For Import Functionality
    Private m_objOLEConnection As OleDbConnection
    Private m_objOLEAdapter As OleDbDataAdapter
    Private m_objOLECommand As OleDbCommand
    Private m_objOLEDataReader As OleDbDataReader
    Private m_objDataSet As DataSet
    Private m_arrSourceColumns As String()
    Protected strSQLEmployeeImage As String = ""
    Protected Shared m_strEmployeeImagePath As String = ""
    Protected strEmployeeImagePath As String = ""
    Protected dtEmployeeImage As DataTable
    ''End Of Added By Vidya Jadhav ON 6 Nov 2017 For Import Functionality
    Protected m_strPageFlag As String = ""
    Protected m_strLoadFilterID As String = ""
    Protected m_strStatusFilterID As String = ""
    Protected m_strDateFilterID As String = ""
    Protected Shared strEmployeeImage As String = ""
    Protected m_LoadFilterID As String = ""
    Public Property ZipFile As Object
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        InitializeData()
        If Request.Params("Mode") = "ProcessFile" Then
            ' the system file name
            Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""
            If Request.Files.Count > 0 Then
                strOriginalFileName = Request.Files(0).FileName
                strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension
                If (strFileExtension = ".xls" Or strFileExtension = ".xlsx") Then
                    'Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("~/Attachments/CRM"), strFileName)
                    Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Attachments/CRM/"), strFileName)
                    ' Save the uploaded file to "UploadedFiles" folder
                    Request.Files(0).SaveAs(fileSavePath)
                    strSQLQuery = "usp_NG2_Ins_tbl_NG2_CRM_RequestAttachments '" & strOriginalFileName & "','" & strFileName & "'," & Session("intUserID") & ""
                    strAttachmentID = CommonFunctions.Data.GetDataScalar(strSQLQuery, True)
                    'Reading Of file
                    ReadExcelData(strAttachmentID, fileSavePath, strOriginalFileName)
                End If
            End If
        ElseIf Request.Params("Mode") = "ValidateFile" Then
            ' the system file name
            Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""
            Dim strSelectedRequestID As String = ""
            Dim strRequestIds As String = ""
            strAttachmentID = CommonFunctions.General.CheckIsNothing(Request.Params("AttachmentID"), "0")
            strSelectedRequestID = CommonFunctions.General.CheckIsNothing(Request.Params("SelectedRequestIDs"), "0")
            strRequestIds = CommonFunctions.General.CheckIsNothing(Request.Params("strRequestIds"), "0")
            If Request.Files.Count > 0 Then
                strOriginalFileName = Request.Files(0).FileName
                strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension
                If (strFileExtension = ".xls" Or strFileExtension = ".xlsx") Then
                    'Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("~/Attachments/CRM"), strFileName)
                    Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Attachments/CRM/"), strFileName)
                    ' Save the uploaded file to "UploadedFiles" folder
                    Request.Files(0).SaveAs(fileSavePath)
                    'strSQLQuery = "usp_NG2_Ins_tbl_NG2_CRM_RequestAttachments '" & strOriginalFileName & "','" & strFileName & "'," & Session("intUserID") & ""
                    'strAttachmentID = CommonFunctions.Data.GetDataScalar(strSQLQuery, True)
                    'Reading Of file
                    '' ValidateExcelData(strAttachmentID, fileSavePath, strOriginalFileName, strSelectedRequestID)
                End If
            End If
        ElseIf Request.Params("Mode") = "ValidateExcelToSelect" Then
            ' the system file name
            Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""
            Dim strRequestIds As String = ""
            strAttachmentID = CommonFunctions.General.CheckIsNothing(Request.Params("AttachmentID"), "0")
            strRequestIds = CommonFunctions.General.CheckIsNothing(Request.Params("strRequestIds"), "0")
            If Request.Files.Count > 0 Then
                strOriginalFileName = Request.Files(0).FileName
                strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension
                If (strFileExtension = ".xls" Or strFileExtension = ".xlsx") Then
                    'Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("~/Attachments/CRM"), strFileName)
                    Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Attachments/CRM/"), strFileName)
                    ' Save the uploaded file to "UploadedFiles" folder
                    Request.Files(0).SaveAs(fileSavePath)
                    'strSQLQuery = "usp_NG2_Ins_tbl_NG2_CRM_RequestAttachments '" & strOriginalFileName & "','" & strFileName & "'," & Session("intUserID") & ""
                    'strAttachmentID = CommonFunctions.Data.GetDataScalar(strSQLQuery, True)
                    'Reading Of file
                    '' ValidateExcelDataToSelect(strAttachmentID, fileSavePath, strOriginalFileName)
                End If
            End If
        End If
        strSQLEmployeeImage = "usp_NG2_SEL_tbl_RM_EmployeeMaintenance_Attachment " & Session("intUserID") & ",'" & Session("LoginType") & "'"
        dtEmployeeImage = CommonFunctions.Data.GetDataTable(strSQLEmployeeImage, True)
        For i As Integer = 0 To dtEmployeeImage.Rows.Count - 1
            strEmployeeImagePath = CommonFunctions.Data.CheckIsDBNull(dtEmployeeImage.Rows(i)("SystemFileName").ToString, "")
        Next
        Dim strEmployeeFilePath As String = ""
        Dim k As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
        strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, k - 1)
        strEmployeeImage = strEmployeeImage.Replace("\", "/")
        If Not strEmployeeImagePath Is Nothing Then
            strEmployeeFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), strEmployeeImagePath)
        End If
        If File.Exists(strEmployeeFilePath) = False Or CommonFunctions.General.CheckIsNothing(strEmployeeImagePath) = "" Then
            strEmployeeImage = strEmployeeImage + "/Images/Photo/no-photo.png"
        Else
            strEmployeeImage = strEmployeeImage + "/Images/Photo/" + strEmployeeImagePath
        End If
        'If strEmployeeImagePath = "" Then
        '    m_strEmployeeImagePath = "../../img/1920/no-photo.png"
        'Else
        '    m_strEmployeeImagePath = "../../Images/Photo/" & strEmployeeImagePath & ""
        'End If
    End Sub
    Private Sub InitializeData()
        '=====================================================================
        ' Procedure Name        : InitializeData
        ' Description           : For Initialzing Page Data
        ' Created Date           : 4th-OCT-2017
        '=====================================================================
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngLoginID = CType(Session("intLOGINID"), Long)
        'Code For SLA Access
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()
        objGlobal.TagID = 3821
        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        objAccessRights.GetAccess()
        m_blnSLAAccess = objAccessRights.View
        'End of Code For SLA Access
        m_blnShowAssignTaskInHelpDesk = CommonFunction.Application.ShowAssignTaskInHelpDesk
        Dim m_lngCRMID As Long
        Dim dr As IDataReader
        Dim strSQL As String
        strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If m_lngCRMID <> 0 Then
            blnIsHRM = 1
        Else
            blnIsHRM = 0
        End If
        MyBase.InitializeResources("AppResources.CRM_RequestList", "AppResources")
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
        If Not HttpContext.Current.Request.QueryString("Mode") Is Nothing Then
            m_strMode = HttpContext.Current.Request.QueryString("Mode").ToString
        End If
        If Not HttpContext.Current.Request.QueryString("SortBy") Is Nothing Then
            m_strSortBy = HttpContext.Current.Request.QueryString("SortBy").ToString
        Else
            m_strSortBy = "SUBMITTEDDATE"
        End If
        ' Sort order of the page
        If Not HttpContext.Current.Request.QueryString("SortOrder") Is Nothing Then
            m_strSortOrder = HttpContext.Current.Request.QueryString("SortOrder").ToString
        Else
            m_strSortOrder = "DESC"
        End If
        If Not HttpContext.Current.Request.QueryString("PageFlag") Is Nothing Then
            m_strPageFlag = HttpContext.Current.Request.QueryString("PageFlag").ToString
        Else
            m_strPageFlag = ""
        End If
        If Not HttpContext.Current.Request.QueryString("StatusFilterID") Is Nothing Then
            m_strStatusFilterID = HttpContext.Current.Request.QueryString("StatusFilterID").ToString
        Else
            m_strStatusFilterID = ""
        End If
        If Not HttpContext.Current.Request.QueryString("DateFilterID") Is Nothing Then
            m_strDateFilterID = HttpContext.Current.Request.QueryString("DateFilterID").ToString
        Else
            m_strDateFilterID = ""
        End If
        If Not HttpContext.Current.Request.QueryString("Mode") Is Nothing Then
            m_strMode = HttpContext.Current.Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        If m_strMode = "RequestListPageBack" Then
            If Not HttpContext.Current.Request.QueryString("PageNumber") Is Nothing Then
                m_intPageNumber = CInt(HttpContext.Current.Request.QueryString("PageNumber"))
            Else
                m_intPageNumber = 1
            End If
        End If
        If Not HttpContext.Current.Request.QueryString("LoadFilterID") Is Nothing Then
            m_strLoadFilterID = HttpContext.Current.Request.QueryString("LoadFilterID").ToString
        Else
            m_strLoadFilterID = "0"
        End If
        If UCase(Trim(m_strMode & "")) = "SR" And Trim(MyBase.GetFormValue("cboDepartment") & "") <> "" Then
            m_lngDepartmentID = CType(MyBase.GetFormValue("cboDepartment"), Long)
            ' added by harshada for whiziblesem 6 helpdeskenhancemnts filters on list page not getting set on refreshing the same
        Else
            If Not HttpContext.Current.Request.QueryString("DepartmentID") Is Nothing Then
                If HttpContext.Current.Request.QueryString("DepartmentID") <> "" Then
                    m_lngDepartmentID = CType(HttpContext.Current.Request.QueryString("DepartmentID"), Long)
                End If
                'end of addition by harshada d
            End If
        End If
        m_strSQL = "usp_Sel_Role_CustomField_CRM " + objGlobal.RoleLevel.ToString + "," + objGlobal.RoleID.ToString
        m_objCFDS = CommonFunction.Data.GetDataSet(m_strSQL, "CustomField", , , MyBase.UseSQL)
        m_blnHRM = CType(CommonFunction.Data.GetDataScalar("usp_CRM_CheckCRMAccess " + m_lngEmployeeID.ToString, MyBase.UseSQL), Boolean)
        ''Get Default Filter for page from the database and prepare where and conditon
        GetDefaultSearchFilters(m_lngEmployeeID, "DefaultSearchFilter_DB")
        Select Case m_SearchFilterName.ToUpper
            Case "PRIORITY"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " PriorityID = " + m_SearchFilterValue
            Case "ASSIGNED TO"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " AssignToID = " + m_SearchFilterValue
            Case "CUSTOMER"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " CustomerId = ''" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(m_SearchFilterValue)) + "'' AND LoginType = ''C'' "
            Case "EMPLOYEE"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " CustomerId = ''" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(m_SearchFilterValue)) + "'' AND LoginType = ''E'' "
            Case "LOCATION"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " TargetLocationId = " + m_SearchFilterValue
            Case "REQUEST TYPE"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " RequestTypeId = " + m_SearchFilterValue
            Case "SUB REQUEST TYPE"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " SubRequestTypeID = " + m_SearchFilterValue
            Case "SUBJECT"
                m_SearchFilterValue = m_SearchFilterValue.Replace("%", "[%]")
                m_SearchFilterValue = m_SearchFilterValue.Replace("_", "[_]")
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " Subject Like ''%" + CommonFunction.General.BuildQueryString(CommonFunction.General.BuildQueryString(m_SearchFilterValue)) + "%'' "
            Case "SEVERITY"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " SeverityID  = " + m_SearchFilterValue
            Case "REQUEST ID"
                If m_SearchFilterValue <> "" Then m_AdvanceFilter = " QueryID  = ''" + m_SearchFilterValue + "''"
            Case Else
                m_AdvanceFilter = ""
        End Select
        ''End of Get Default Filter for page from the database and prepare where and conditon
        'If m_strLoginType = "C" Then
        '    m_lngFilterID = CType(GetDefault(m_lngEmployeeID, "DefaultFilter_SR"), Long)
        'Else
        '    m_lngFilterID = CType(GetDefault(m_lngEmployeeID, "DefaultFilter_DB"), Long)
        'End If
        If m_strMode = "RequestListPageBack" Then
            m_lngFilterNewID = m_strLoadFilterID
        Else
            m_lngFilterNewID = GetDefault_New(m_lngEmployeeID, "DefaultFilter_RequestListNewPage")
        End If
        strSQL = "Exec Usp_NG2_CheckAccess_For_ApproveReject " & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_bitApproveAccess = CType(CommonFunctions.Data.CheckIsDBNull(dr("ApproveRejectAccess"), 0), Boolean)
            m_bitAssignToAccess = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignToAccess"), 0), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub
    Protected Function WritePaging(PageNumber As Integer, ByVal strFlag As String, Optional ByVal GridParameter As Object = Nothing) As String
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To plot pagination of the grid
        ' Created Date           : 8th-OCT-2017
        '=====================================================================
        Dim strPagingHTML As New StringBuilder("")
        Dim strSQL As String
        m_intPageNumber = PageNumber
        'If Not GridParameter Is Nothing Then
        '    strSQL = GetGridSQL(GridParameter)
        'Else
        '    strSQL = GetGridSQL()
        'End If
        strSQL = "usp_NG2_sel_tbl_NG2_UnCategorizedTickets"
        'm_dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "default", , , MyBase.UseSQL)
        m_intTotalNoOfRows = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataTable(strSQL, True).Rows.Count, 0)
        If Math.Ceiling(m_intTotalNoOfRows / m_intNoOfRecordInGrid) < m_intPageNumber Then
            m_intPageNumber = 1
        End If
        strPagingHTML.Append("<ul class='pagination'>")
        strPagingHTML.Append("<li>")
        strPagingHTML.Append("<a href='#' data-toggle='tooltip' data-placement='left' title='First Page' onclick=FirstPage(1);>")
        strPagingHTML.Append("<span>&laquo;</span>")
        strPagingHTML.Append("</a>")
        strPagingHTML.Append("<a href='#' data-toggle='tooltip' data-placement='left' title='Previous Page' onclick=PreviousePage(" & m_intPageNumber - 1 & ");>	")
        strPagingHTML.Append("<span >&#8249;</span>")
        'strPagingHTML.Append("<span class='sr-only'>Previous</span>")
        strPagingHTML.Append("</a>")
        strPagingHTML.Append("</li>")
        If m_intPageNumber <> 0 And m_intPageNumber <> -1 Then
            If m_intTotalNoOfRows > 0 Then
                strPagingHTML.Append("<li><a style='background: #c0c0c0;color:#000;font-weight:600;' href='#'>" & ((m_intNoOfRecordInGrid * m_intPageNumber) - m_intNoOfRecordInGrid + 1).ToString & " - " & (IIf(m_intNoOfRecordInGrid * m_intPageNumber > m_intTotalNoOfRows, m_intTotalNoOfRows, m_intNoOfRecordInGrid * m_intPageNumber)).ToString & " of " & (Math.Ceiling(m_intTotalNoOfRows)).ToString & "</a></li>	")
            Else
                strPagingHTML.Append("<li><a style='background: #c0c0c0;color:#000;font-weight:600;' href='#'>" & ((m_intNoOfRecordInGrid * m_intPageNumber) - m_intNoOfRecordInGrid).ToString & " - " & (IIf(m_intNoOfRecordInGrid * m_intPageNumber > m_intTotalNoOfRows, m_intTotalNoOfRows, m_intNoOfRecordInGrid * m_intPageNumber)).ToString & " of " & (Math.Ceiling(m_intTotalNoOfRows)).ToString & "</a></li>	")
            End If
        End If
        strPagingHTML.Append("<li>")
        strPagingHTML.Append("<a href='#' data-toggle='tooltip' data-placement='left' title='Next Page' onclick=NextPage(" & m_intPageNumber + 1 & ");>")
        strPagingHTML.Append("<span>&#8250;</span>")
        strPagingHTML.Append("</a>")
        strPagingHTML.Append("<a href='#' data-toggle='tooltip' data-placement='left' title='Last Page' onclick=LastPage(" & (Math.Ceiling(m_intTotalNoOfRows / m_intNoOfRecordInGrid)) & ");>")
        strPagingHTML.Append("<span>&raquo;</span>")
        'strPagingHTML.Append("<span class='sr-only'>Next</span>")
        strPagingHTML.Append("</a>")
        strPagingHTML.Append("</li>")
        strPagingHTML.Append("</ul>")
        strPagingHTML.Append("<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / m_intNoOfRecordInGrid)).ToString + ">")
        strPagingHTML.Append("<input type=hidden id=hdnCurrentPage value=" & m_intPageNumber.ToString & ">")
        If strFlag = "" Then
            CommonFunction.General.WriteHTML(strPagingHTML.ToString)
        Else
            Return strPagingHTML.ToString
        End If
    End Function
    Protected Function DrawPageGrid(ByVal strFlag As String, Optional ByVal GridParameter As Object = Nothing) As String
        '=====================================================================
        ' Procedure Name        : DrawPageGrid
        ' Description           : To plot Page grid
        ' Created Date           : 8th-OCT-2017
        '=====================================================================
        Dim strSQL As String = ""
        Dim strPageHTML As New StringBuilder("")
        'If Not GridParameter Is Nothing Then
        '    strSQL = GetGridSQL(GridParameter)
        'Else
        '    strSQL = GetGridSQL()
        'End If
        m_dsGrid = CommonFunctions.Data.GetDataSet("usp_NG2_sel_tbl_NG2_UnCategorizedTickets", "default", , , MyBase.UseSQL)
        If strFlag = "" Then
            strPageHTML.Append(WriteGrid(strSQL))
            m_dsGrid.Dispose() : m_dsGrid = Nothing
        Else
            strPageHTML.Append(WriteGrid(strSQL))
            m_dsGrid.Dispose() : m_dsGrid = Nothing
        End If
        If strFlag = "" Then
            CommonFunction.General.WriteHTML(strPageHTML.ToString)
        Else
            Return strPageHTML.ToString
        End If
    End Function
    Private Function GetGridSQL(Optional ByVal GridParameter As Object = Nothing) As String
        '=====================================================================
        ' Procedure Name        : GetGridSQL
        ' Description           : For GETTING  Request List SQL
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Dim strSQL As String = ""
        Dim dr As IDataReader
        Dim strPaginSQL As String
        Dim strFilterQueryText As String = ""
        If GridParameter Is Nothing Then
            ' build the sql
            strSQL = "EXEC usp_NG_CRM_Sel_AllRequests " & m_lngEmployeeID
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
            If m_lngDepartmentID <> 0 Then
                strSQL = strSQL & "," & m_lngDepartmentID
            Else
                strSQL = strSQL & ",Null"
            End If
            strSQL = strSQL & ",Null"
            strSQL = strSQL & ",'" & m_strSortBy & "','" & m_strSortOrder & "'"
            If m_strMode = "RequestListPageBack" Then
                If (IsNumeric(m_strStatusFilterID)) Then
                    If m_strStatusFilterID <> "0" Then
                        m_lngFilterID = CType(m_strStatusFilterID, Integer)
                    Else
                        If (IsNumeric(m_lngFilterNewID)) Then
                            m_lngFilterID = CType(m_lngFilterNewID, Integer)
                        Else
                            m_lngFilterID = "0"
                        End If
                    End If
                End If
            Else
                If (IsNumeric(m_lngFilterNewID)) Then
                    m_lngFilterID = CType(m_lngFilterNewID, Integer)
                End If
            End If
            ' get the filter
            If m_lngFilterID <> 0 Then
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_Filters " & m_lngFilterID & "," & Session("intUserID"), m_blnUseSQL)
            Else
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_Filters 0," & Session("intUserID"), m_blnUseSQL)
            End If
            '' Commented by Vaijat K ON 01/12/2017 For Issue ID - 9536
            If dr.Read Then
                If Trim(dr("FilterText").ToString & "") <> "" Then
                    strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(Trim(dr("FilterText").ToString & "")) & "'"
                    strFilterQueryText = CommonFunctions.General.BuildQueryString(Trim(dr("FilterText").ToString))
                    m_LoadFilterID = CommonFunctions.General.BuildQueryString(Trim(dr("FilterID").ToString & ""))
                End If
            Else
                strSQL = strSQL & ",NULL"
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
            'Else
            '    strSQL = strSQL & ",''"
            '    '" & CommonFunctions.General.BuildQueryString(Session("strCRM_Filter_DB").ToString & "") & "
            '    'strSQL = strSQL & ",''"
            'End If
            If m_strMode = "RequestListPageBack" Then
                If m_strDateFilterID <> "" Then
                    strSQL = strSQL + "," + m_strDateFilterID
                Else
                    strSQL = strSQL + ", Null "
                End If
            Else
                If m_DateFilter <> "" Then
                    strSQL = strSQL + "," + m_DateFilter
                Else
                    strSQL = strSQL + ", Null "
                End If
            End If
            If m_AdvanceFilter <> "" Then
                strSQL += ",'" + m_AdvanceFilter + "'"
            Else
                strSQL += ",Null"
            End If
            strPaginSQL = strSQL
            'Purpose: To show custom fields on list
            strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), "0").ToString()
            strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "E").ToString() + "'"
            If m_strMode = "RequestListPageBack" Then
                strSQL += ",'" & m_strPageFlag & "'"
            Else
                If (IsNumeric(m_lngFilterNewID)) Then
                    If strFilterQueryText = "" Then
                        strSQL += ",'DefaultSR'"
                    Else
                        strSQL += ",'All'"
                    End If
                Else
                    If (HttpContext.Current.Session("LoginType") = "C") Then
                        strSQL += ",'" & m_lngFilterNewID & "'"
                    Else
                        strSQL += ",'" & m_lngFilterNewID & "'"
                    End If
                End If
            End If
            strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString() + "'"
            'End Addition
        Else
            ' build the sql
            strSQL = "EXEC usp_NG_CRM_Sel_AllRequests " & CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "").ToString()
            If CInt(GridParameter("PageNumber")) > 0 Then
                strSQL = strSQL + "," + CInt(GridParameter("PageNumber")).ToString
            Else
                strSQL = strSQL + ",0"
            End If
            ' is status specified
            If CInt(GridParameter("StatusID")) <> 0 Then
                strSQL = strSQL & "," & CInt(GridParameter("StatusID"))
            Else
                strSQL = strSQL & ",Null"
            End If
            If CInt(GridParameter("DepartmentID")) <> 0 Then
                strSQL = strSQL & "," & CInt(GridParameter("DepartmentID"))
            Else
                strSQL = strSQL & ",Null"
            End If
            strSQL = strSQL & ",Null"
            strSQL = strSQL & ",'" & GridParameter("SortBy") & "','" & GridParameter("SortOrder") & "'"
            If (GridParameter("IsDefaultFilter") = "True") Then
                If (IsNumeric(m_lngFilterNewID)) Then
                    m_lngFilterID = CType(m_lngFilterNewID, Integer)
                End If
            Else
                m_lngFilterID = GridParameter("FilterID")
            End If
            ' get the filter
            If GridParameter("FilterQuery") = "" Then
                dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_Filters " & m_lngFilterID & "," & Session("intUserID"), m_blnUseSQL)
                If dr.Read Then
                    If Trim(dr("FilterText").ToString & "") <> "" Then
                        strSQL = strSQL & ",'" & CommonFunctions.General.BuildQueryString(Trim(dr("FilterText").ToString & "")) & "'"
                    End If
                Else
                    strSQL = strSQL & ",NULL"
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
            Else
                strSQL = strSQL & ",'" & GridParameter("FilterQuery") & "'"
                'strSQL = strSQL & ",''"
            End If
            If GridParameter("DateFilter") <> "" Then
                strSQL = strSQL + "," + GridParameter("DateFilter")
            Else
                strSQL = strSQL + ", Null "
            End If
            'If GridParameter("AdvanceFilter") <> "" Then
            '    strSQL += ",'" + GridParameter("AdvanceFilter") + "'"
            'Else
            '    strSQL += ",Null"
            'End If
            If m_AdvanceFilter <> "" Then
                strSQL += ",'" + m_AdvanceFilter + "'"
            Else
                strSQL += ",Null"
            End If
            strPaginSQL = strSQL
            'Purpose: To show custom fields on list
            strSQL += "," + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intPostID"), "0").ToString()
            strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("LoginType"), "E").ToString() + "'"
            'strSQL += ",'" + CommonFunctions.General.CheckIsNothing(GridParameter("PageMode"), "").ToString() + "'"
            If (GridParameter("IsDefaultFilter") = "True") Then
                If (IsNumeric(m_lngFilterNewID)) Then
                    strSQL += ",'All'"
                Else
                    If (HttpContext.Current.Session("LoginType") = "C") Then
                        strSQL += ",'" & m_lngFilterNewID & "'"
                    Else
                        strSQL += ",'" & m_lngFilterNewID & "'"
                    End If
                End If
            Else
                strSQL += ",'" + CommonFunctions.General.CheckIsNothing(GridParameter("PageMode"), "").ToString() + "'"
            End If
            strSQL += ",'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString() + "'"
            'End Addition
        End If
        Return strSQL
    End Function
    Private Function WriteGrid(ByVal SQL As String) As String
        '=====================================================================
        ' Procedure Name        : WriteGrid
        ' Description           : to write the filter combo boxes
        ' Author                : Bharat T.
        ' Created               : Oct 06,2017
        '=====================================================================
        Dim DataColCount As Integer = 13
        Dim ShowProduct As String
        If CommonFunction.Application.EnableProductExecution = True Then
            ShowProduct = "True"
        Else
            ShowProduct = "False"
        End If
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
        Dim strGridHTML As New StringBuilder("")
        ' get the captions from the caption template	
        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_SubRequestType_Caption_Master ", m_blnUseSQL)
        If dr.Read Then
            strSubject_Caption = dr("Subject").ToString & ""
            strAssignTo_Caption = dr("AssignTo").ToString & ""
            strPriority_Caption = dr("Priority").ToString & ""
            strExpectedResolvedDate_Caption = dr("ExpectedResolvedDate").ToString & ""
            strStatus_Caption = dr("Status").ToString & ""
            strRequestType_Caption = dr("RequestType").ToString & ""
            strSubRequestType_Caption = dr("SubRequestType").ToString & ""
            strSubmittedBy_Caption = dr("SubmittedBy").ToString & ""
            strSubmittedDate_Caption = dr("SubmittedDate").ToString & ""
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        Dim alActualColumns As New ArrayList
        Dim alLinks As New ArrayList
        Dim aluserfriendlycol As New ArrayList
        Dim alcheckbox As New ArrayList
        Dim alTdStyle As New ArrayList
        'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
        alActualColumns.Add("RequestID") : alLinks.Add("") : aluserfriendlycol.Add("Reference ID") : alcheckbox.Add("") : alTdStyle.Add("")
        alActualColumns.Add("Subject") : alLinks.Add("") : aluserfriendlycol.Add("Subject") : alcheckbox.Add("") : alTdStyle.Add("")
        alActualColumns.Add("Description") : alLinks.Add("") : aluserfriendlycol.Add("Description") : alcheckbox.Add("") : alTdStyle.Add("")
        alActualColumns.Add("SubmittedDate") : alLinks.Add("") : aluserfriendlycol.Add("SubmittedDate") : alcheckbox.Add("") : alTdStyle.Add("")
        alActualColumns.Add("Email") : alLinks.Add("") : aluserfriendlycol.Add("Email") : alcheckbox.Add("") : alTdStyle.Add("")
        alActualColumns.Add("CCMails") : alLinks.Add("") : aluserfriendlycol.Add("CC Mails") : alcheckbox.Add("") : alTdStyle.Add("")
        alActualColumns.Add("Attachments") : alLinks.Add("") : aluserfriendlycol.Add("Attachments") : alcheckbox.Add("") : alTdStyle.Add("")
        alActualColumns.Add("") : alLinks.Add("") : aluserfriendlycol.Add("EditRequest") : alcheckbox.Add("") : alTdStyle.Add("")
        'Dim arrIgnoreHTMLEncode() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        Dim arrActualCols(alActualColumns.Count - 1) As String
        Dim arrLink(alLinks.Count - 1) As String
        Dim arrUserFriendlyCols(aluserfriendlycol.Count - 1) As String
        Dim arrchkbox(alcheckbox.Count - 1) As String
        Dim arrTdStyle(alTdStyle.Count - 1) As String
        alActualColumns.CopyTo(arrActualCols)
        alLinks.CopyTo(arrLink)
        aluserfriendlycol.CopyTo(arrUserFriendlyCols)
        alcheckbox.CopyTo(arrchkbox)
        alTdStyle.CopyTo(arrTdStyle)
        alActualColumns = Nothing
        alLinks = Nothing
        aluserfriendlycol = Nothing
        alcheckbox = Nothing
        alTdStyle = Nothing
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .NoOfDataColumns = arrUserFriendlyCols.Length - 1
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .RowLinkArray = arrLink
            .TDStyleArray = arrTdStyle
            '.CheckBoxIDArray = arrchkbox
            .PrimaryKey = "RequestID"
            .returnHTML = True
            '.SortBy = m_strSortBy
            '.SortOrder = m_strSortOrder
            '.ClientSideSortFunctionName = "Sort_OnClick"
            '.SQL = SQL
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = m_blnUseSQL
            .CurrentPage = m_intPageNumber
            .PageSize = m_intNoOfRecordInGrid
            .DIVID = "divGrid"
            .DIVStyle = "overflow:auto;width:100%"
            '  .DIVHeight = 330
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            strGridHTML.Append(.DrawGrid())
            m_intNoOfRows = .NoOfRowsInPage
        End With
        m_objGrid = Nothing
        ' total records
        Dim intNoOfRows As Integer
        intNoOfRows = m_intNoOfRows
        'strGridHTML.Append(CommonFunctions.General.WriteTotalRecordsHTML(intNoOfRows, "Total Records:", True, "clsTREven"))
        SQL = SQL.Replace("usp_NG_CRM_Sel_AllRequests", "usp_NG_CRM_Sel_AllRequests_ExportReport")
        HttpContext.Current.Session.Add("HelpDeskSQL", SQL)
        HttpContext.Current.Session.Add("HelpDeskROWS", intNoOfRows)
        m_arrAccessibleDepartments = Nothing
        Return strGridHTML.ToString
    End Function
    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case UCase(Trim(Args.DataField & ""))
            Case "ATTACHMENTS"
                Cancel = True
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.TDStyle = "   title='Attachments'"
                Args.StringToBeInserted = "<th><i class='fa fa-paperclip' aria-hidden='true' data-toggle='tooltip' data-placement='bottom' title='Attachments'  ></i></th>"
            Case "EMAIL"
                Cancel = True
                Args.StringToBeInserted = "<th><label data-toggle='tooltip' data-placement='bottom' title='" & Args.ColumnName & "'>" & Args.ColumnName & "<label></th>"
            Case "CCMAILS"
                Cancel = True
                Args.StringToBeInserted = "<th><label data-toggle='tooltip' data-placement='bottom' title='" & Args.ColumnName & "'>" & Args.ColumnName & "<label></th>"
            Case "DISCUSSIONS"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th><i class='fa fa-comments-o' aria-hidden='true' data-toggle='tooltip' data-placement='bottom' title='Discussions'></i></th>"
            Case "ASSIGN ISSUE"
                If m_blnShowAssignTaskInHelpDesk = False Then
                    Cancel = True
                End If
                ' For Non HRM Column is not to be plotted 
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                'Purpose : The page crashes when clicked on sort for Assign Issue Column, Sorting removed.
                Args.ApplySorting = False
            Case "ASSIGNTASK"
                If m_blnShowAssignTaskInHelpDesk = False Then
                    Cancel = True
                End If
                ' For Non HRM Column is not to be plotted 
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                Args.ApplySorting = False
            Case "REJECT"
                If m_blnShowAssignTaskInHelpDesk = False Then
                    Cancel = True
                End If
                ' To show Assign Task Link conditionaly  
                ' For Non HRM Column is not to be plotted 
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
                Args.ApplySorting = False
            Case "CHANGE DEPARTMENT"
                If blnIsHRM = 0 Then
                    Cancel = True
                End If
            Case "FLAGTO"
                If m_strLoginType = "C" Then
                    Cancel = True
                Else
                    Cancel = True
                    Args.TDStyle = " NoWrap title='FlagTo'"
                    Args.ApplySorting = False
                    Args.ApplyHTMLEncode = False
                    Args.StringToBeInserted = "<th><i class='fa fa-flag-o'  aria-hidden='true' data-toggle='tooltip' data-placement='bottom' title='Flag' ></i></th>"
                End If
                'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
            Case "DESCRIPTION"
                Cancel = True
                Args.StringToBeInserted = "<th><label data-toggle='tooltip' data-placement='bottom' title='" & Args.ColumnName & "'>" & Args.ColumnName & "<label></th>"
        End Select
        'Dim strViewFields As String = ""
        'Dim ColumnName As String
        'strViewFields = strSelectedValues
        'ColumnName = Trim(Args.ColumnName & "").ToUpper()
        'If strViewFields <> "" Then
        '    strViewFields = strViewFields.ToUpper()
        '    If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/GRAYFLAG.GIF'>" Then
        '        If strViewFields.Contains("," + ColumnName + ",") = False And ColumnName <> "ASSIGNED TO" And ColumnName <> "MODULE / COMPONENT" And ColumnName <> "ID" Then
        '            Cancel = True
        '        End If
        '    End If
        'Else
        '    If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/GRAYFLAG.GIF'>" Then
        '        Cancel = True
        '    End If
        'End If
        '*******************************Bharat*******************************************
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th><input type=checkbox name=chkSelectHeader id=chkSelectHeader data-toggle='tooltip' title='Select/Clear all' onclick=""SelectAllRequests();"" /></th>"
        End If
        If Args.ColumnName.ToUpper = "EDITREQUEST" Then
            Cancel = True
            Args.StringToBeInserted = "<th><i class='fa fa-download fadownLoad' aria-hidden='true' data-placement='bottom' data-toggle='tooltip' title='Convert Request'></i></th>"
        End If
        If Args.DataField.ToUpper = "SUBMITTEDDATE" Then
            If Cancel = False Then
                Cancel = True
                ''Commented And Added By Vaijat K ON 29/11/2017 For Issue ID - 9554 
                ''Args.StringToBeInserted = "<th IsDateColumn=1  >Requested On</th>" 'class='sortingApplied'
                Args.StringToBeInserted = "<th IsDateColumn=1  ><label data-toggle='tooltip' data-placement='bottom' title='Requested On'>Requested On<label></th>" 'class='sortingApplied'
                ''End of Commented And Added By Vaijat K ON 29/11/2017 For Issue ID - 9554 
            End If
        End If
        ''Added By Vaijat K ON 29/11/2017 For Issue ID - 9554 
        If Args.DataField = "RequestID" Or Args.DataField = "Subject" Or Args.DataField = "RequestType" Or Args.DataField = "SubRequestType" Or Args.DataField = "Priority" Or Args.DataField = "CustomerID" Or Args.DataField = "LastUpdatedDate" Or Args.DataField = "Status" Or Args.DataField = "AssignTo" Or Args.DataField = "Show SLA" Then
            If Cancel = False Then
                Cancel = True
                Args.StringToBeInserted = "<th><label data-toggle='tooltip' data-placement='bottom' title='" & Args.ColumnName & "'>" & Args.ColumnName & "<label></th>"
            End If
        End If
        ''End Added By Vaijat K ON 29/11/2017 For Issue ID - 9554 
        '******************************Bharat********************************************
    End Sub
    Private Sub m_objGrid1_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If UCase(Trim(Args.DataField & "")) = "STATUS" Then
            Args.TDStyle = "style='border-bottom: 1pt solid gray;' id=Status" + CType(Args.DataReader("RequestID"), String)
        ElseIf UCase(Trim(Args.DataField & "")) = "RequestID" Then
            Args.TDStyle = "style='border-bottom: 1pt solid gray;width:35px;' align=right "
        Else
            Args.TDStyle = "style='border-bottom: 1pt solid gray;'"
        End If
        Dim strViewFields As String = ""
        Dim ColumnName As String
        strViewFields = strSelectedValues
        Dim strTD As String
        Select Case UCase(Trim(Args.DataField & ""))
            Case "SUBJECT"
                m_strQueryid = CType(Args.DataReader("RequestID"), Integer)
                Dim SubmittedDate As DateTime
                Dim strQueryForSubmittedDate As String = "usp_sel_tbl_NG2_UnCategorizedTickets_SubmittedDate '" & m_strQueryid.ToString() & "'"
                SubmittedDate = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQueryForSubmittedDate.ToString(), True), ""), ""), DateTime)
                Dim intDateDiffInDays = DateDiff(DateInterval.Day, SubmittedDate, DateTime.Now)
                Dim strInsertString = "Posted:" & intDateDiffInDays.ToString() & " days ago."
                If intDateDiffInDays = 0 Then
                    strInsertString = "Posted:" & DateDiff(DateInterval.Hour, SubmittedDate, DateTime.Now).ToString() & " Hrs. ago."
                    If DateDiff(DateInterval.Hour, SubmittedDate, DateTime.Now) = 0 Then
                        strInsertString = "Posted:" & DateDiff(DateInterval.Minute, SubmittedDate, DateTime.Now).ToString() & " Mins. ago."
                    End If
                ElseIf intDateDiffInDays >= 60 Then
                    strInsertString = "Posted:" & DateDiff(DateInterval.Month, SubmittedDate, DateTime.Now).ToString() & " Months ago."
                End If
                If Trim(Args.DataReader("Subject").ToString & "") <> "" Then
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("RequestID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    If Len(Trim(Args.DataReader("Subject").ToString & "")) > 50 Then
                        Args.ApplyHTMLEncode = False
                        ''*******************************''PURPOSE: for whizible.glodyne.com (inhouse production site)****************************
                        Dim m_intRoleID As Integer
                        Dim strIsDisplayRequestAging As String
                        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
                        Dim strSQLIsDisplayRequestAging As String = "usp_sel_TBL_PM_ROLE_CustomFieldText1 " & m_intRoleID.ToString()
                        strIsDisplayRequestAging = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLIsDisplayRequestAging.ToString(), True), "0"), "0"), String)
                        If strIsDisplayRequestAging <> "" And strIsDisplayRequestAging = "0" Then
                            strInsertString = String.Empty ''PURPOSE: for whizible.glodyne.com (inhouse production site)
                        End If
                        ''**********************************************************
                        Dim strMaxHTML As String = ""
                        If Args.DataReader("Subject").ToString().Length > 20 Then
                            strMaxHTML = Args.DataReader("Subject").ToString().Substring(0, 20) & "..."
                        Else
                            strMaxHTML = Args.DataReader("Subject").ToString()
                        End If
                        Args.StringToBeInserted = "<TD vAlign=top style='width=25%;border-bottom: 1pt solid gray;text-align:left !important' nowrap; ><label  data-toggle='tooltip' title='" & Args.DataReader("Subject").ToString() & "'>" _
                              & Server.HtmlEncode(Left(Trim(strMaxHTML & ""), 50)) & "</label></br></br><font color='brown' style='FONT-SIZE: 9px' data-toggle='tooltip' title='" & strMaxHTML & "'>" & strInsertString & "</font>" & "</TD>"
                        ' & "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Left(Trim(Args.DataReader("Subject").ToString & ""), 50)) & "...</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        Cancel = True
                    Else
                        ''*******************************''PURPOSE: for whizible.glodyne.com (inhouse production site)****************************
                        Dim m_intRoleID As Integer
                        Dim strIsDisplayRequestAging As String
                        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
                        Dim strSQLIsDisplayRequestAging As String = "usp_sel_TBL_PM_ROLE_CustomFieldText1 " & m_intRoleID.ToString()
                        strIsDisplayRequestAging = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLIsDisplayRequestAging.ToString(), True), "0"), "0"), String)
                        If strIsDisplayRequestAging <> "" And strIsDisplayRequestAging = "0" Then
                            strInsertString = String.Empty ''PURPOSE: for whizible.glodyne.com (inhouse production site)
                        End If
                        ''**********************************************************
                        Dim strMaxHTML As String = ""
                        If Args.DataReader("Subject").ToString().Length > 20 Then
                            strMaxHTML = Args.DataReader("Subject").ToString().Substring(0, 20) & "..."
                        Else
                            strMaxHTML = Args.DataReader("Subject").ToString()
                        End If
                        Args.StringToBeInserted = "<TD vAlign=top style='width=25%;border-bottom: 1pt solid gray;text-align:left !important' nowrap;><label  data-toggle='tooltip' title='" & Args.DataReader("Subject").ToString() & "'>" _
                            & Server.HtmlEncode(Trim(strMaxHTML & "")) & "</label></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        '& "<A href=""JavaScript:Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & Server.HtmlEncode(Trim(Args.DataReader("Subject").ToString & "")) & "</A></br></br><font color='brown' style='FONT-SIZE: 9px'>" & strInsertString & "</font>" & "</TD>"
                        Cancel = True
                    End If
                End If
            Case "ATTACHMENTS"
                Args.ApplyHTMLEncode = False
                If Trim(Args.DataReader("Attachments").ToString & "") <> "" Then
                    Cancel = True
                    Args.StringToBeInserted = "<td><button data-toggle='tooltip' title='Attachments' onclick=""ShowAttachment(" & CType(Args.DataReader("RequestID"), String) & ")"" type='button' class='btn btn-default' data-toggle='tooltip' title='Attachment'><i class='fa fa-paperclip' aria-hidden='true'></i></td>"
                Else
                    Args.DataFieldValue = " "
                    'Args.TDStyle = " style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' "
                    Args.StringToBeInserted = "<td><button data-toggle='tooltip' title='Attachments'  type='button' class='btn btn-default' data-toggle='tooltip' title='Attachment'><i class='fa fa-paperclip' aria-hidden='true'></i></td>"
                End If
                'document.getElementById('id03').style.display='block'
            Case "DISCUSSIONS"
                ' New discussion??
                If Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "" And Trim(Args.DataReader("NoOfDiscussions").ToString & "") <> "0" Then
                    If Not CType(Args.DataReader("IsDiscussionViewed"), Boolean) Then
                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("RequestID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                        'Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                        '                                  & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A>" & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & "</TD>"
                        Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("NEW_DISCUSSION_TOOLTIP") & "'><button type='button' class='btn btn-default' data-toggle='tooltip' title='Discussion'><i class='fa fa-comments-o' aria-hidden='true'><span>" & Trim(Args.DataReader("NoOfDiscussions").ToString) & "</span></i></button>" & MyBase.GetResourceString("NEW_DISCUSSION_CAPTION") & " </TD>"
                        Cancel = True
                    Else : m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("RequestID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                        'Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                        '                                 & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("RequestID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & Trim(Args.DataReader("NoOfDiscussions").ToString & "") & ")</A></TD>"
                        Args.StringToBeInserted = "<TD vAlign=top><button type='button' class='btn btn-default' data-toggle='tooltip' title='Discussion'><i class='fa fa-comments-o' aria-hidden='true'><span>" & Trim(Args.DataReader("NoOfDiscussions").ToString) & "</span></i></button></td>"
                        Dim strNoOfDiscussions As String
                        Dim strQueryNoOfDiscussions As String
                        strQueryNoOfDiscussions = "usp_sel_tbl_CRM_Query_Details_QueryID " & CType(Args.DataReader("RequestID"), String)
                        strNoOfDiscussions = Trim(Args.DataReader("NoOfDiscussions").ToString & "")
                        If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") = "C" Then
                            strNoOfDiscussions = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQueryNoOfDiscussions, MyBase.UseSQL), "0"), String)
                        End If
                        'Args.StringToBeInserted = "<TD vAlign=top title='" & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                        '                                                         & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif'> (" & strNoOfDiscussions & ")</A></TD>"
                        Args.StringToBeInserted = "<TD vAlign=top > <button type='button' class='btn btn-default' data-toggle='tooltip' title='Discussion'> <i class='fa fa-comments-o' aria-hidden='true'><span style='background:#008000;'>" & strNoOfDiscussions & "</span></i></button></td>"
                        Cancel = True
                    End If
                Else
                    'm_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    'Args.StringToBeInserted = "<TD vAlign=top style='border-bottom: 1pt solid gray;'>" _
                    '                            & "<A href=""JavaScript:Discussion_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')""><IMG border=0 src='../../Images/Discussions.gif' alt= " & MyBase.GetResourceString("DISCUSSIONS_CAPTION") & "></A></TD>"
                    Args.StringToBeInserted = "<TD vAlign=top> <button type='button' class='btn btn-default' data-toggle='tooltip' title='Discussion'> <i class='fa fa-comments-o' aria-hidden='true'><span style='background:#008000;'>0</span></i></button></td>"
                    Cancel = True
                End If
            Case "ASSIGNTASK"
                If strViewFields <> "" Then
                    strViewFields = strViewFields.ToUpper()
                    ColumnName = Trim(Args.ColumnName & "").ToUpper()
                    If strViewFields.Contains("," + ColumnName + ",") = False Then
                        Cancel = True
                    Else
                        Cancel = True
                        ' if logged in user is non hrm do not show assign Task link 
                        If blnIsHRM = 1 Then
                            'To show Assign Task Link conditionaly 
                            If m_blnShowAssignTaskInHelpDesk = True Then
                                m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("RequestID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                                strTD = "<td vAlign=top align=left style='border-bottom: 1pt solid gray;' >" & vbCrLf
                                If Trim(Args.DataReader("TaskAssignedToUserName").ToString & "") <> "" Then
                                    If Trim(Args.DataReader("StatusID").ToString & "") <> "2" And Trim(Args.DataReader("StatusID").ToString & "") <> "7" Then
                                        strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("RequestID").ToString & ",1,'" & m_PKToken_Query_DT & "'," & Args.DataReader("TaskID").ToString & ")" & Chr(34) & ">" & vbCrLf
                                        strTD += Server.HtmlEncode(Args.DataReader("TaskAssignedToUserName").ToString)
                                        strTD += "</A>" & vbCrLf
                                    Else
                                        strTD += "<A href=" & Chr(34) & "JavaScript:AssignTask_OnClick(" & Args.DataReader("RequestID").ToString & ",0,'" & m_PKToken_Query_DT & "'," & Args.DataReader("TaskID").ToString & ")" & Chr(34) & ">" & vbCrLf
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
                End If
            Case "REJECT"
                If strViewFields <> "" Then
                    strViewFields = strViewFields.ToUpper()
                    ColumnName = Trim(Args.ColumnName & "").ToUpper()
                    If strViewFields.Contains("," + ColumnName + ",") = False Then
                        Cancel = True
                    Else
                        ' Modified By NitinVS on 25 July 2005 for whizibleSEM SP4 IssueID 2 
                        If m_blnShowAssignTaskInHelpDesk = True Then
                            ' if logged in user is non hrm do not show assign issue link 
                            If blnIsHRM = 1 Then
                                ' hide reject link on following logic
                                If Trim(Args.DataReader("StatusID").ToString & "") = "2" Or Trim(Args.DataReader("StatusID").ToString & "") = "7" Then
                                    ' ***NOTE StatusID #7 -> Rejected Queries
                                    strTD = "<td style='border-bottom: 1pt solid gray;'></td>" & vbCrLf
                                    Cancel = True
                                    Args.StringToBeInserted = strTD
                                Else
                                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                                    Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                                  & "<A href=""JavaScript:Reject_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("REJECT_LINK") & "</A></TD>"
                                    Cancel = True
                                End If
                                If Cancel = False Then
                                    If Trim(Args.DataReader("TaskID").ToString & "") <> "" Or Trim(Args.DataReader("NoOfIssues").ToString & "") <> "0" Then
                                        strTD = "<td style='border-bottom: 1pt solid gray;'></td>" & vbCrLf
                                        Cancel = True
                                        Args.StringToBeInserted = strTD
                                    Else
                                        m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                                        Args.StringToBeInserted = "<TD vAlign=top style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                                      & "<A href=""JavaScript:Reject_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & MyBase.GetResourceString("REJECT_LINK") & "</A></TD>"
                                        Cancel = True
                                    End If
                                End If
                            Else
                                Cancel = True
                            End If ' End if blnIsHRM = 1  
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
                    If strViewFields.Contains("," + ColumnName + ",") = False Then
                        Cancel = True
                    Else
                        If m_blnShowAssignTaskInHelpDesk = False Then
                            Cancel = True
                        Else
                            If blnIsHRM = 1 Then
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
                                End If
                            Else
                                Cancel = True
                            End If
                        End If
                    End If
                    'End If
                Else
                    Cancel = True
                End If 'End of view if
            Case "CHANGE DEPARTMENT"
                Dim blnIsHrmForQuery As Boolean = False
                blnIsHrmForQuery = m_arrAccessibleDepartments.ContainsValue(Args.DataReader("FunctionID"))
                If blnIsHRM = 0 Then
                    Cancel = True
                ElseIf blnIsHrmForQuery = False Then
                    Cancel = True
                    Args.StringToBeInserted = "<td>Change Department</td>"
                Else
                    m_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                    Args.StringToBeInserted = "<TD  vAlign=top align=left  style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;>" _
                                                      & "<A href=""JavaScript:ChangeDepartment_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken_Query_DT) & "')"">" & "Change Department" & "</A></TD>"
                    Cancel = True
                End If
                'if the logged in person has access to view only request then the chkbox should be disabled
            Case "SELECT"
                Dim blnIsHrmForQuery As Boolean = False
                blnIsHrmForQuery = m_arrAccessibleDepartments.ContainsValue(Args.DataReader("FunctionID"))
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
            Case "FLAGTO"
                If m_strLoginType = "C" Then
                    Cancel = True
                Else
                    m_Queryid = CType(Args.DataReader("RequestID"), Integer)
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "1" Then
                        m_FlagStatus = "Review"
                    ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "0" Then
                        m_FlagStatus = "Follow Up"
                    Else
                        m_FlagStatus = "Flag To"
                    End If
                    Cancel = True
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "L" Then
                        Args.StringToBeInserted = "<TD vAlign=top align=center  style='TEXT_DECORATION:None;' nowrap;><button data-toggle='tooltip' title='Flag' onclick=""javascript:Flag_OnClick(" & m_Queryid & ")"" type=button class='btn btn-default'><i class='fa fa-flag' style='color:red !important;' aria-hidden='true' style='font-size: 16px;'></i></button></TD>"
                    ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "G" Then
                        Args.StringToBeInserted = "<TD vAlign=top align=center  style='TEXT_DECORATION:None;' nowrap;><button data-toggle='tooltip' title='Flag' onclick=""javascript:Flag_OnClick(" & m_Queryid & ")"" type=button class='btn btn-default'><i class='fa fa-flag' style='color:green !important;' aria-hidden='true' style='font-size: 16px;'></i></button></TD>"
                    ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "S" Then
                        Args.StringToBeInserted = "<TD vAlign=top align=center  style='TEXT_DECORATION:None;' nowrap;><button data-toggle='tooltip' title='Flag' onclick=""javascript:Flag_OnClick(" & m_Queryid & ")"" type=button class='btn btn-default'><i class='fa fa-flag' style='color:orange !important;' aria-hidden='true' style='font-size: 16px;'></i></button></TD>"
                        'To Display Black flag for Completed Flaged requests
                    ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "B" Then
                        Args.StringToBeInserted = "<TD vAlign=top align=center  style='TEXT_DECORATION:None;' nowrap;><button data-toggle='tooltip' title='Flag' onclick=""javascript:Flag_OnClick(" & m_Queryid & ")"" type=button class='btn btn-default'><i class='fa fa-flag' style='color:black !important;' aria-hidden='true' style='font-size: 16px;'></i></button></TD>"
                    Else
                        Args.StringToBeInserted = "<TD vAlign=top align=center  style='TEXT_DECORATION:None;' nowrap;><button data-toggle='tooltip' title='Flag' onclick=""javascript:Flag_OnClick(" & m_Queryid & ")"" type=button class='btn btn-default'><i class='fa fa-flag-o' style='' aria-hidden='true' style='font-size: 16px;'></i></button></TD>"
                    End If
                End If
                'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
            Case "DESCRIPTION"
                Cancel = True
                Args.StringToBeInserted = "<td>"
                Dim strDescription As String = CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.DataField), "")
                ''Added by Usha Pandit on 15.01.2019 for mail description display issue on list page if mail contains XML/HTML tags
                If Not strDescription Is Nothing Then
                    strDescription = strDescription.Trim()
                    If strDescription = "" Then
                        strDescription = Regex.Replace(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("HTMLDescription"), ""), "<.*?>", String.Empty)
                    End If
                End If
                ''End of Added by Usha Pandit on 15.01.2019 for mail description display issue on list page if mail contains XML/HTML tags
                If strDescription.Length > 50 Then
                    Args.StringToBeInserted &= "<div class='tt_large' data-toggle='tooltip' data-placement='right' title='" & strDescription & "'>" & strDescription.Substring(0, 50) & "...</div>"
                Else
                    Args.StringToBeInserted &= strDescription
                End If
                Args.StringToBeInserted &= "</td>"
                'm_Queryid = CType(Args.DataReader("RequestID"), Integer)
                'Args.TDStyle = " NoWrap title='Description'"
                ''  Args.StringToBeInserted = "<TD id= " + m_Queryid.ToString() + " name=" + m_Queryid.ToString() + " vAlign=top title='Description' style='TEXT_DECORATION:None;border-bottom: 1pt solid gray;' nowrap;><a href=""javascript:ShowDescription_onClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../../Images/plus.gif' Collapse='N' title='Description' onclick="""" ID='imgSummaryShowHide" & CType(m_Queryid, String) & "' name='imgSummaryShowHide" & CType(m_Queryid, String) & "'></a></TD>"
                ' ''Commented And Added By Vaijat K ON 29/11/2017 For Issue ID - 9572 
                ' ''Args.StringToBeInserted = "<TD id= " + m_Queryid.ToString() + " name=" + m_Queryid.ToString() + " vAlign=top title='Description' style='TEXT_DECORATION:None;' nowrap; data-toggle='collapse' data-target='#Summary" & CType(m_Queryid, String) & "' class='accordion-toggle collapsed'>" & _
                'Args.StringToBeInserted = "<TD id= " + m_Queryid.ToString() + " name=" + m_Queryid.ToString() + " vAlign=top title='Description' style='TEXT_DECORATION:None;' nowrap; onclick=toggleDiv(this,'#Summary" & CType(m_Queryid, String) & "') class='accordion-toggle collapsed'>" & _
                ' "<button class='btn btn-default btn-xs'><span class='glyphicon glyphicon-plus'></span><span class='glyphicon glyphicon-minus' style='display:none'></span></button></TD>"
                ''End of Commented And Added By Vaijat K ON 29/11/2017 For Issue ID - 9572 
                Cancel = True
            Case "EMAIL"
                Cancel = True
                Args.StringToBeInserted = "<td><label data-toggle='tooltip' title='From Email ID'>" & Args.DataReader(Args.DataField) & "<label></td>"
            Case "CCMAILS"
                Cancel = True
                Args.StringToBeInserted = "<td><label data-toggle='tooltip' title='CC Email IDs'>" & Args.DataReader(Args.DataField) & "<label></td>"
            Case "SUBMITTEDDATE"
                Cancel = True
                Args.StringToBeInserted = "<td><label data-toggle='tooltip' title='Submitted Date'>" & Args.DataReader(Args.DataField) & "<label></td>"
            Case Else
        End Select
        'ColumnName = Trim(Args.ColumnName & "").ToUpper()
        'If strViewFields <> "" Then
        '    strViewFields = strViewFields.ToUpper()
        '    If Args.DataField <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/GRAYFLAG.GIF'>" Then
        '        If strViewFields.Contains("," + ColumnName + ",") = False And ColumnName <> "ASSIGNED TO" And ColumnName <> "MODULE / COMPONENT" And ColumnName <> "ID" Then
        '            Cancel = True
        '        End If
        '    End If
        'Else
        '    If Args.DataField.ToUpper() <> "DESCRIPTION" And ColumnName <> "SELECT" And ColumnName <> "REQUEST ID" And ColumnName <> "SUBJECT" And ColumnName <> "<IMG BORDER=0 SRC='../../../IMAGES/DISCUSSIONS.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/PIN.GIF'>" And ColumnName <> "<IMG SRC='../../../IMAGES/GRAYFLAG.GIF'>" Then
        '        Cancel = True
        '    End If
        'End If
        '*******************************Bharat*******************************************
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Dim statusID As String = ""
            statusID = Args.DataReader("StatusID").ToString()
            If statusID = "2" Then
                Args.StringToBeInserted = "<td><input type=checkbox name=chkSelect id='chkSelect_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID")) & "' value='" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID")) & "' disabled=true onclick=""ListCheckboxClick(this);"" /></td>"
            Else
                Args.StringToBeInserted = "<td><input type=checkbox name=chkSelect id='chkSelect_" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID")) & "' value='" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID")) & "' onclick=""ListCheckboxClick(this);"" /></td>"
            End If
        End If
        If Args.ColumnName.ToUpper = "EDITREQUEST" Then
            Cancel = True
            Dim strEditRequestSQL As String = ""
            Dim strHasEditAccess As String = "True"
            'strEditRequestSQL = "Usp_NG2_chk_RequestEditDetailsAccess " & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RequestID")) & "," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("LoginType") & "'"
            'strHasEditAccess = CommonFunctions.Data.GetDataScalar(strEditRequestSQL, m_blnUseSQL)
            ''Commented And Added By Vaijat K ON 13/12/2017 For assigning id to button
            'Args.StringToBeInserted = "<td><button type='button' class='btn btn-default' data-toggle='tooltip' title='Edit' onclick=""Query_OnClick('" & CType(Args.DataReader("QueryID"), String) & "','" & strHasEditAccess & "')""><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>"
            Args.StringToBeInserted = "<td><button type='button' id='btnEdit_" & CType(Args.DataReader("RequestID"), String) & "' class='btn btn-default' data-toggle='tooltip' title='Convert Request' onclick=""Query_OnClick('" & CType(Args.DataReader("RequestID"), String) & "','" & strHasEditAccess & "')""><i class='fa fa-download fadownLoad' aria-hidden='true'></i></button></td>"
            ''ENd of Commented And Added By Vaijat K ON 13/12/2017 For assigning id to button
        End If
        If Args.DataField.ToUpper = "CUSTOMERID" Then
            Cancel = True
            If HttpContext.Current.Session("LoginType") <> "C" Then
                '' <A onClick='ShowRequestorDetails(event," + CType(m_Queryid, String) + ",""" + RequestorType + """)' >Requestor</A>
                Args.StringToBeInserted = "<td><a href='#' data-toggle='tooltip' title='" & Args.ColumnName & "' onClick='ShowRequestorDetails(event," + CType(m_Queryid, String) + ",""" + Args.DataReader("LoginType") + """)'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CUSTOMERID")) & " </a></td>"
            Else
                Args.StringToBeInserted = "<td><a href='#' data-toggle='tooltip' title='" & Args.ColumnName & "'>" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CUSTOMERID")) & " </a></td>"
            End If
        End If
        '******************************Bharat********************************************
        'Purpose: To hide data, when custom field is accessible by role, but not by type 
        If Args.DataField.ToLower().Contains("customfield") Then
            If m_objCFDS.Tables(0).Select("DatabaseFieldName='" + Args.DataField.ToString + "' AND TypeID=" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SubRequestTypeID"), "0").ToString()).Length <= 0 Then
                Args.ReplacementValue = "-"
            End If
        End If
        ''Added By Vaijat K ON 29/11/2017 For Issue ID - 9554 
        If Args.DataField = "RequestID" Or Args.DataField = "RequestType" Or Args.DataField = "SubRequestType" Or Args.DataField = "Priority" Or Args.DataField = "CustomerID" Or Args.DataField = "LastUpdatedDate" Or Args.DataField = "Status" Or Args.DataField = "AssignTo" Or Args.DataField = "CustomerID" Or Args.DataField = "SubmittedDate" Then
            If Cancel = False Then
                Cancel = True
                Args.StringToBeInserted = "<td><label data-toggle='tooltip' title='" & Args.ColumnName & "'>" & Args.DataReader(Args.DataField) & "<label></td>"
            End If
        End If
        ''End Added By Vaijat K ON 29/11/2017 For Issue ID - 9554 
    End Sub
    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        Args.TableStyle = " cellpadding=0 cellspacing=0  style='' "
    End Sub
    'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        ' The event fires for all rows starting from 1 page to current page. 
        ' ex. if current page no is 10 then the event fires for all rows from page 1 to 10 
        ' we need to add the details only for current page 
        'If m_intPageNumber = -1 Or (count > ((m_intPageNumber - 1) * m_intNoOfRecordInGrid) And count <= (m_intPageNumber * m_intNoOfRecordInGrid)) Then
        '    m_Queryid = CType(Args.DataReader("RequestID"), Integer)
        '    intTotalCol = CType(Args.DataReader.Table.Columns.Count, Integer)
        '    Dim intAssignTo As Integer
        '    Dim TotalTimeSpent As String
        '    TotalTimeSpent = CType(Args.DataReader("TotalTimeSpent"), String)
        '    Dim status As String
        '    Dim statusID As String
        '    Dim IsHRMorDeptHead As Boolean
        '    Dim RequestorType As String
        '    Dim sbHTML As New StringBuilder
        '    Dim IsApprovalRequired As Boolean = False
        '    Dim strApprovalStatus As String = ""
        '    IsHRMorDeptHead = CType(Args.DataReader("IsHRMOrDeptHead"), Boolean)
        '    status = Args.DataReader("Status").ToString()
        '    statusID = Args.DataReader("StatusID").ToString()
        '    IsApprovalRequired = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsApprovalRequired"), 0)
        '    strApprovalStatus = CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ApprovalStatus"), "")
        '    RequestorType = Args.DataReader("LoginType")
        '    If IsDBNull(Args.DataReader("AssignToID")) Then
        '        intAssignTo = 0
        '    Else
        '        intAssignTo = CType(Args.DataReader("AssignToID"), Integer)
        '    End If
        '    sbHTML.Append("<TR class='").Append(strClass & "'").Append(" id='Description").Append(CType(m_Queryid, String)).Append("' name='Description").Append(CType(m_Queryid, String)).Append("' width=99.9% style="""">") 'display:none
        '    sbHTML.Append("<TD align=left colspan=").Append(intTotalCol.ToString()).Append(" class='hiddenRow'>")
        '    sbHTML.Append("<DIV id=Summary").Append(CType(m_Queryid, String)).Append(" name=Summary").Append(CType(m_Queryid, String)).Append(" class=""accordian-body collapse"" style=""overflow:auto;width=99.9%;display:none"">")  ''display:none;
        '    sbHTML.Append("<TABLE ID='Description'  Width=99.9% class=clsGridTable cellspacing=0 cellpadding=0>")
        '    ''Request Description Row
        '    sbHTML.Append("<tr class=").Append(strClass).Append(">")
        '    sbHTML.Append("<td valign=top colspan='7' align='left' style='text-align:left;'><b>Description </b> :")
        '    sbHTML.Append(CType(HttpUtility.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Description"), "")), String))
        '    sbHTML.Append("</TD></TR>")
        '    ''End of Request Description Row
        '    sbHTML.Append("<TR style='white-space:nowrap' class=").Append(strClass).Append(" >")
        '    Dim m_StatusFlowCount As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(m_Queryid, String) + "", MyBase.UseSQL), "0"), String)
        '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount" + CType(m_Queryid, String), "StatusFlowCount" + CType(m_Queryid, String), , , , m_StatusFlowCount, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '    sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus" + CType(m_Queryid, String), "txtOldStatus" + CType(m_Queryid, String), , , , status, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        '    Dim m_IntSubRequestID As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select SubRequestTypeID from tbl_CRM_Query_Master where queryID=" + CType(m_Queryid, String) + "", MyBase.UseSQL), "0"), String)
        '    sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("CmbStatus" + CType(m_Queryid, String), "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "',2,'" + status + "'", , , , , True, DisplayNone:=True)) '--, displaynone:=True
        '    sbHTML.Append(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus" + CType(m_Queryid, String), "Exec usp_CRM_ValidateCRMStatus '" + m_IntSubRequestID + "'," + "1", ReturnAsHTML:=True, DisplayNone:=True)) ', displaynone:=True
        '    If HttpContext.Current.Session("LoginType") = "E" Then
        '        'Assign To
        '        sbHTML.Append("<TD valign=middle align='left' id=AssignTo").Append(CType(m_Queryid, String)).Append(" style='border-bottom: 1px solid gray;width:15%;'>")
        '        If IsHRMorDeptHead = True Then
        '            If intAssignTo = 0 Then
        '                If IsApprovalRequired = True And strApprovalStatus = "A" Then
        '                    sbHTML.Append("<A href=""javascript:AssignToMe_onClick(").Append(m_Queryid.ToString).Append(" )"" ><Font color=red><B>Assign To me</B></Font></A>")
        '                ElseIf IsApprovalRequired = True And strApprovalStatus <> "A" Then
        '                    sbHTML.Append("<B><Font color=red>Not Assigned</Font></B>")
        '                Else
        '                    sbHTML.Append("<A href=""javascript:AssignToMe_onClick(").Append(m_Queryid.ToString).Append(" )"" ><Font color=red><B>Assign To me</B></Font></A>")
        '                End If
        '            ElseIf intAssignTo = CType(Session("intUserID"), Integer) Then
        '                sbHTML.Append("<B><Font color=red>Assigned To me</Font></B>")
        '            Else
        '                sbHTML.Append("<B><Font color=red>Assigned To : ").Append(Args.DataReader("AssignToName").ToString()).Append("</Font></B>")
        '            End If
        '        Else
        '            If intAssignTo = CType(Session("intUserID"), Integer) Then
        '                sbHTML.Append("<B><Font color=red>Assigned To me</Font></B>")
        '            ElseIf intAssignTo = 0 Then
        '                sbHTML.Append("<B><Font color=red>Not Assigned</Font></B>")
        '            Else
        '                sbHTML.Append("<B><Font color=red>Assigned To : ").Append(Args.DataReader("AssignToName").ToString()).Append("</Font></B>")
        '            End If
        '        End If
        '        sbHTML.Append("</TD>")
        '        'TotalTimeSpent
        '        sbHTML.Append("<TD  align=left id=TotalTime").Append(CType(m_Queryid, String)).Append(" style='border-bottom: 0px solid gray;display:none;' TotalTime=").Append(TotalTimeSpent.ToString()).Append(">") ''display:none
        '        sbHTML.Append("<B><U><A onClick='ShowDetailActivity(event,").Append(CType(m_Queryid, String)).Append(")' >Total Time Spent</A></U>&nbsp;:&nbsp;").Append(TotalTimeSpent.ToString()).Append("&nbsp;Hrs</B>")
        '        sbHTML.Append("</TD>")
        '    End If
        '    'Status Change
        '    If statusID = 2 And (m_blnHRM = 0 Or m_blnHRM = False) Then 'IsHRMorDeptHead = False Then
        '        sbHTML.Append("<TD  align=left  style='border-bottom: 1px solid gray;cursor:hand;width:25%;'>")
        '        sbHTML.Append("&nbsp;Change Status&nbsp;")
        '        'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , "disabled", True, EnableHTMLEncode:=True))
        '        sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtStatus" + m_Queryid.ToString, "usp_CRM_Get_RequestStatus " & m_Queryid.ToString & "," & HttpContext.Current.Session("intPostID") & "", 150, statusID, "disabled=true", ReturnAsHTML:=True))
        '        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True))
        '        'sbHTML.Append("<IMG id=imgStatus").Append(m_Queryid.ToString).Append(" src='../../Images/selection.gif' valign=middle align=absMiddle  >")
        '        sbHTML.Append("</TD>")
        '    Else
        '        sbHTML.Append("<TD  align='left' style='border-bottom: 1px solid gray;width:25%;'  >")
        '        sbHTML.Append("&nbsp;Change Status&nbsp;")
        '        'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtStatus" + m_Queryid.ToString, "txtStatus" + m_Queryid.ToString, , 100, 50, status, , , , True, , , " onclick=ShowStatus(" + m_Queryid.ToString + ",event) ", True, EnableHTMLEncode:=True))
        '        'sbHTML.Append("<IMG id=imgStatus" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absMiddle onclick=ShowStatus(" + m_Queryid.ToString + ",event) style='cursor:hand;' >")
        '        If (m_blnHRM = 0 Or m_blnHRM = False) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AssignTo")).ToString()) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CustomerID")).ToString()) Then
        '            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtStatus" + m_Queryid.ToString, "usp_CRM_Get_RequestStatus " & m_Queryid.ToString & "," & HttpContext.Current.Session("intPostID") & "", 150, statusID, "disabled=true", ReturnAsHTML:=True))
        '            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True))
        '        Else
        '            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtStatus" + m_Queryid.ToString, "usp_CRM_Get_RequestStatus " & m_Queryid.ToString & "," & HttpContext.Current.Session("intPostID") & "", 150, statusID, "", ReturnAsHTML:=True))
        '            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidStatus" + m_Queryid.ToString, "hidStatus" + m_Queryid.ToString, , 10, 2000, statusID, , , , , , True, , True, EnableHTMLEncode:=True))
        '        End If
        '        sbHTML.Append("</TD>")
        '    End If
        '    'Time Spent 'Time period
        '    'Added By Bharat T on 27th-Oct-2017 for customer should not show activity and time textbox
        '    If HttpContext.Current.Session("LoginType") <> "C" Then
        '        sbHTML.Append("<TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;width:20%;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append(">")
        '        sbHTML.Append("Time Spent(Min)&nbsp;")
        '        If statusID = 2 Then
        '            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , True, , , , , True, EnableHTMLEncode:=True))
        '        Else
        '            If (m_blnHRM = 0 Or m_blnHRM = False) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AssignTo")).ToString()) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CustomerID")).ToString()) Then
        '                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , True, , , , , True, EnableHTMLEncode:=True))
        '            Else
        '                sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtTime" + m_Queryid.ToString, "txtTime" + m_Queryid.ToString, , 50, 10, , "right", , , , , , , True, EnableHTMLEncode:=True))
        '            End If
        '        End If
        '        'sbHTML.Append("&nbsp;(Min)&nbsp;<A onClick='ShowDetailActivity(event,").Append(CType(m_Queryid, String)).Append(")' ><img src='../../Images/cssImages/Link images/ViewHistory.gif' valign=middle  alt='Show Detail Time Spent' /></a></TD>")
        '        sbHTML.Append("<span><i class=""fa fa-hourglass-end"" aria-hidden='true'></i></span>")
        '        sbHTML.Append("<TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;width:25%;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append(">Activity&nbsp;")
        '        If statusID = 2 Then
        '            'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , True, True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True))
        '            'sbHTML.Append("<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;' disabled onclick=SearchActivity(" + m_Queryid.ToString + ",event) >")
        '            sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtActivity" + m_Queryid.ToString, "usp_Sel_tbl_CRM_Query_Activity", 200, , "disabled=true", ReturnAsHTML:=True))
        '        Else
        '            'sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtActivity" + m_Queryid.ToString, "txtActivity" + m_Queryid.ToString, , 200, 2000, , , , , True, , , " onclick=SearchActivity(" + m_Queryid.ToString + ",event)", True, EnableHTMLEncode:=True))
        '            'sbHTML.Append("<IMG id=imgActivity" + m_Queryid.ToString + " src='../../Images/selection.gif' valign=middle align=absBottom  style='cursor:hand;'  onclick=SearchActivity(" + m_Queryid.ToString + ",event) >")
        '            If (m_blnHRM = 0 Or m_blnHRM = False) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AssignTo")).ToString()) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CustomerID")).ToString()) Then
        '                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtActivity" + m_Queryid.ToString, "usp_Sel_tbl_CRM_Query_Activity", 200, , "disabled=true", True, ReturnAsHTML:=True))
        '            Else
        '                sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("txtActivity" + m_Queryid.ToString, "usp_Sel_tbl_CRM_Query_Activity", 200, , "", True, ReturnAsHTML:=True))
        '            End If
        '        End If
        '        sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidActivityID" + m_Queryid.ToString, "hidActivityID" + m_Queryid.ToString, , 50, 2000, , , , , , , True, , True, EnableHTMLEncode:=True))
        '    End If
        '    'End of Added By Bharat T on 27th-Oct-2017 for customer should not show activity and time textbox
        '    ''Commented and added by Yogesh Jalamkar button UI issue
        '    'If statusID = 2 Then
        '    '    sbHTML.Append("</TD><TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append("> <input  type=button id=btnSave" + m_Queryid.ToString + " onclick='SaveActivity_OnClick(").Append(m_Queryid.ToString).Append(")' value=""Save""  disabled  /> ")
        '    'Else
        '    '    sbHTML.Append("</TD><TD id=TimeSpent").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append("><input  type=button id=btnSave" + m_Queryid.ToString + " onclick='SaveActivity_OnClick(").Append(m_Queryid.ToString).Append(")' value=""Save"" />")
        '    'End If
        '    If statusID = 2 Then
        '        sbHTML.Append("</TD><TD id=TimeSpent ").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;text-align:left !important' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append("> <button  type=button id=btnSave" + m_Queryid.ToString + " onclick='SaveActivity_OnClick(").Append(m_Queryid.ToString).Append(")' class='btn btn-default save'  style='width:85px' disabled=true> Save </button>")
        '    Else
        '        If (m_blnHRM = 0 Or m_blnHRM = False) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AssignTo")).ToString()) And (m_strUserName <> CommonFunctions.Data.CheckIsDBNull(Args.DataReader("CustomerID")).ToString()) Then
        '            sbHTML.Append("</TD><TD id=TimeSpent ").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray; text-align:left !important' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append("><button  type=button id=btnSave" + m_Queryid.ToString + " onclick='SaveActivity_OnClick(").Append(m_Queryid.ToString).Append(")' class='btn btn-default save' style='width:85px' disabled=true>Save </button>")
        '        Else
        '            sbHTML.Append("</TD><TD id=TimeSpent ").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray; text-align:left !important' TodaysTotalTimeSpent=").Append(Args.DataReader("TodaysTotalTimeSpent").ToString()).Append("><button  type=button id=btnSave" + m_Queryid.ToString + " onclick='SaveActivity_OnClick(").Append(m_Queryid.ToString).Append(")' class='btn btn-default save' style='width:85px' >Save </button>")
        '        End If
        '    End If
        '    ''End of addition by Yogesh Jalamkar
        '    sbHTML.Append("&nbsp;").Append(CommonFunction.HTMLControls.DrawTextBox("txtSavingLable" + CType(m_Queryid, String), "txtSavingLable" + CType(m_Queryid, String), , , 100, "Saving....", , "width:80px;BACKGROUND-COLOR:#FFFF80;border-color:gray;display:none;", , True, "#FFFF80", returnHTML:=True, EnableHTMLEncode:=True)) ''display:none
        '    sbHTML.Append("</TD>")
        '    'Requestor Details and Statistics 
        '    'sbHTML.Append("<TD id=RequestorDtl").Append(CType(m_Queryid, String)).Append(" align='left' style='border-bottom: 1px solid gray;width:15%;'>")
        '    'sbHTML.Append("<B><U><A onclick='ShowRequestorDetails(" & CType(m_Queryid, String) & "," & RequestorType & ") >Requestor</A></U></B>")
        '    ''sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<B><U><A onClick='ShowStatistics(event,").Append(CType(m_Queryid, String)).Append(",""").Append(RequestorType).Append(""")' >Statistics</A></U></B>")
        '    'sbHTML.Append("</TD>")
        '    'sbHTML.Append("<TD id=RequestorDtl" + CType(m_Queryid, String) + " align='left' style='border-bottom: 1px solid gray;width:15%;'>")
        '    '  sbHTML.Append("<B><U><A onClick='ShowRequestorDetails(event," + CType(m_Queryid, String) + ",""" + RequestorType + """)' >Requestor</A></U></B>")
        '    '  sbHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<B><U><A onClick='ShowStatistics(event," + CType(m_Queryid, String) + ",""" + RequestorType + """)' >Statistics</A></U></B>")
        '    '  sbHTML.Append("</TD>")
        '    sbHTML.Append("</TR></Font>")
        '    sbHTML.Append("</TABLE></DIV>")
        '    sbHTML.Append("</TD></TR>")
        '    intTotalCol = 0
        '    Args.StringToBeInserted += sbHTML.ToString()
        '    'If strClass = "clsTROdd" Then
        '    strClass = "clsTREven"
        '    'Else
        '    '    strClass = "clsTROdd"
        '    'End If
        '    sbHTML = Nothing
        'End If
        'count = count + 1
    End Sub
    Private Function GetDefault(ByVal EmployeeID As Long, ByVal DefaultType As String) As String
        '=====================================================================
        ' Procedure Name        : GetDefault
        ' Description           : to get the default settings for the user        
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the value of the default
        ' Author                : Bharat T.
        ' Created               : Oct 25,2017        
        '=====================================================================
        Dim dr As IDataReader
        ' Login Type condition added by harshada d on 22 11 2005 
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & EmployeeID & ",'" & CommonFunctions.General.BuildQueryString(DefaultType & "") & "','" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Session("LoginType")) & "'", m_blnUseSQL)
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
    Private Function GetDefault_New(ByVal EmployeeID As Long, ByVal DefaultType As String) As String
        '=====================================================================
        ' Procedure Name        : GetDefault
        ' Description           : to get the default settings for the user        
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the value of the default
        ' Author                : Bharat T.
        ' Created               : Oct 25,2017        
        '=====================================================================
        Dim dr As IDataReader
        ' Login Type condition added by harshada d on 22 11 2005 
        dr = CommonFunction.Data.GetDataReader("Usp_NG2_Sel_tbl_NG2_CRM_RequestDefaultFilter	" & EmployeeID & ",'" & CommonFunctions.General.BuildQueryString(DefaultType & "") & "','" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Session("LoginType")) & "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dr.Read Then
            If Trim(dr("ItemValue").ToString & "") <> "" Then
                GetDefault_New = dr("ItemValue").ToString & ""
            Else
                GetDefault_New = "0"
            End If
        Else
            GetDefault_New = "0"
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function
    Private Sub GetDefaultSearchFilters(ByVal EmployeeID As Long, ByVal DefaultType As String)
        '=====================================================================
        ' Procedure Name        : GetDefaultSearchFilters
        ' Description           : Get Default search filter value for the page
        ' Created Date           : 9th-OCT-2017
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(DefaultType & "") & "','" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Session("LoginType")) & "'", True)
        If dr.Read Then
            If Trim(dr("ItemValue").ToString & "") <> "" Then
                m_SearchFilterName = dr("ItemName").ToString & ""
                m_SearchFilterValue = dr("ItemValue").ToString & ""
                m_SearchFilterName = Trim(m_SearchFilterName.Replace("_SearchFilter_DB", ""))
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
    Protected Sub GenerateTrackingDtls(ByVal FlagParameters As Object)
        '=====================================================================
        ' Procedure Name        : GenerateTrackingDtls
        ' Description           : to flagged existing request.
        ' Created Date           : 10th-OCT-2017
        '=====================================================================
        Dim strSQL As String
        strSQL = "exec usp_ins_TrackingDtls '" & CType(Session("intUserID"), String) & "','HelpDeskRequest','" & FlagParameters("RequestID") & "','" & FlagParameters("ProjectID") & "','" & FlagParameters("FlagTo") & "','" & CDate(FlagParameters("DueDate")).ToString & "','" & FlagParameters("IsComplete") & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        'CommonFunctions.General.WriteHTML("<SCRIPT language=Javascript>alert('Tracking Details Saved Successfully');</SCRIPT>")
    End Sub
    Protected Sub ClearTrackingDtls(ByVal strUniqueID As String)
        '=====================================================================
        ' Procedure Name        : ClearTrackingDtls
        ' Description           : To clear existing request flagged details
        ' Created Date           : 10th-OCT-2017
        '=====================================================================
        Dim strSQL As String
        strSQL = "exec usp_del_TrackingDtls '" & strUniqueID & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    End Sub
    Protected Function AssignToResourceList() As String
        '=====================================================================
        ' Procedure Name        : AssignToResourceList
        ' Description           : For Plotting Assign To employee list
        ' Created Date           : 24th-OCT-2017
        '=====================================================================
        Dim dtTable As DataTable
        Dim dtTable1 As DataTable
        Dim strListHTML As New StringBuilder("")
        Dim strEmployeeImage As String = ""
        Dim intEmployeeID As Integer = 0
        dtTable = CommonFunction.Data.GetDataTable("Usp_NG2_Sel_V_tbl_PM_Resource_Selection ", True)
        strListHTML.Append("<a class='dropdown-item' href='#' onclick=""AssignToListClick('')"" > &nbsp; </a>" & vbCrLf)
        For Each drRow As DataRow In dtTable.Rows
            intEmployeeID = CInt(CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeID"), "0"))
            strEmployeeImage = GetEmployeeImagePath(intEmployeeID)
            strListHTML.Append("<a class='dropdown-item' href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeID"), "") & "' name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "' onclick=""AssignToListClick(this)"" >" & vbCrLf)
            strListHTML.Append("<img id='imgUser" & intEmployeeID.ToString & "' src='" & strEmployeeImage & "' alt='No Image' style='height:30px;width:30px;border-radius:50%;' /> &nbsp; ")
            strListHTML.Append(CommonFunction.Data.CheckIsDBNull(drRow.Item("EmployeeName"), "") & "</a>" & vbCrLf)
        Next
        CommonFunctions.General.WriteHTML(strListHTML.ToString)
    End Function
    Protected Function StatusList() As String
        '=====================================================================
        ' Procedure Name        : StatusList
        ' Description           : For Plotting Request Status list
        ' Created Date           : 24th-OCT-2017
        '=====================================================================
        Dim dtTable As DataTable
        Dim dtTable1 As DataTable
        Dim strListHTML As New StringBuilder("")
        dtTable = CommonFunction.Data.GetDataTable("usp_CRM_Get_RequestStatus NULL ", True)
        strListHTML.Append("<a class='dropdown-item' href='#' onclick=""RequestStautsClick('')"" > &nbsp; </a>" & vbCrLf)
        For Each drRow As DataRow In dtTable.Rows
            strListHTML.Append("<a class='dropdown-item' href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("StatusID"), "") & "' name='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("Status"), "") & "' onclick=""RequestStautsClick(this)"" >" & CommonFunction.Data.CheckIsDBNull(drRow.Item("Status"), "") & "</a>" & vbCrLf)
        Next
        CommonFunctions.General.WriteHTML(strListHTML.ToString)
    End Function
    Protected Function GetAdvanceFilterControl(ByVal ControlName As String, ByVal count As String) As String
        '=====================================================================
        ' Procedure Name        : GetAdvanceFilterControl
        ' Description           : Get advance filter control dynamically
        ' Created Date           : 10th-OCT-2017
        '=====================================================================
        Dim strSQL As String = ""
        Dim strControlHTML As New StringBuilder("")
        Select Case True
            Case Trim(ControlName).ToUpper = "CLOSEDDATE", Trim(ControlName).ToUpper = "CREATEDDATE", Trim(ControlName).ToUpper = "CRMEXPECTEDRESOLVEDDATE", Trim(ControlName).ToUpper = "EXPECTEDRESOLVEDDATE", Trim(ControlName).ToUpper = "SUBMITTEDDATE", Trim(ControlName).ToUpper = "LASTUPDATEDDATE"
                ' date
                'strControlHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("FilterControl_filterRowCount", "FilterControl_filterRowCount", , , , , "frmRequestListNew", returnHTML:=True))
                strControlHTML.Append("<div class='col-md-2' style='padding-right:0px;'>")
                strControlHTML.Append("<input type='text' class='form-control' id='FilterControl_filterRowCount' placeholder='" & ControlName & "' onfocus=""$('#FilterControl_filterRowCount').datepicker();$('#FilterControl_filterRowCount').datepicker('show');""> ")
                strControlHTML.Append("<i class='fa fa-calendar' onclick=""$('#FilterControl_filterRowCount').datepicker();$('#FilterControl_filterRowCount').datepicker('show');"" style='top:-21px;position:relative;float:left;right:-204px;'></i>")
                strControlHTML.Append("</div>")
            Case Trim(ControlName).ToUpper = "SUBREQUESTTYPE"
                ' sub request type combo
                strSQL = "usp_CRM_Filters_SubRequestType_ForCombo " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "ASSIGNTO"
                ' sub request type combo
                strSQL = "Usp_NG2_Sel_V_tbl_PM_Resource_Selection 'UserName'"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "CUSTOMERID"
                ' submitted by(all users)
                strSQL = "usp_CRM_Filters_SubmittedBy_ForCombo " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , m_strUserName, "class='form-control value'", , ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "STATUS"
                ' status
                strSQL = "usp_CRM_Filters_Status_ForCombo"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "PRIORITY"
                ' priotity
                strSQL = "usp_CRM_Filters_Priority_ForCombo"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "TARGETLOCATION"
                ' target location
                strSQL = "usp_CRM_Filters_TargetLocations_ForCombo  " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "PARAMETERNAME"
                ' feedback
                strSQL = "usp_CRM_Filters_Feedback_ForCombo"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "RATING"
                ' rating
                strSQL = "usp_CRM_Filters_FeedbackRating_ForCombo"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "REQUESTTYPE"
                'Added Request Type Filter
                'Request type combo
                strSQL = "usp_CRM_Filters_RequestType_ForCombo  " & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "LOGINTYPE"
                ' Login Type 
                strSQL = "usp_CRM_Filters_LoginType_ForCombo"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "PRODUCT"
                ' Product 
                strSQL = "usp_sel_tbl_PRD_ProductVersion_forCRM NULL,'" + Session("LoginType").ToString + "'," + Session("intUserId").ToString
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, 300, , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "COMPONENT"
                ' Component
                strSQL = "usp_sel_tbl_PRD_Component_forCRM NULL,NULL,'" + Session("LoginType").ToString + "'," + Session("intUserId").ToString
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, 300, , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "SEVERITY"
                ' Severity 
                strSQL = "usp_sel_tbl_CRM_Severity_forCRM "
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "DEPARTMENT"
                'Department
                strSQL = "usp_sel_Tbl_PM_DepartmentMaster_ForCRM Null , " + m_lngEmployeeID.ToString() + " , '" + m_strLoginType + "'"
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, , , "class='form-control value'", ReturnAsHTML:=True))
            Case Trim(ControlName).ToUpper = "CUSTOMERNAME"
                'Client
                strSQL = "usp_sel_tbl_PM_Customer_forCRM " & "'" & CommonFunctions.General.BuildQueryString(m_strLoginType & "") & "'," & m_lngEmployeeID
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", strSQL, 300, , "class='form-control value'", ReturnAsHTML:=True))
            Case (Trim(ControlName.ToLower).IndexOf("customfieldcombo") <> -1)
                '**********************************************************************
                'Purpose: To plot TDs for Custom combo fields
                Dim drCustomFields As IDataReader
                Dim strDatabaseFieldName As String
                Dim strUserGivenCaption As String
                drCustomFields = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_CustomFields_Master 0,'" & ControlName & "',1,NULL,'Help-Desk'", True)
                While drCustomFields.Read()
                    strDatabaseFieldName = CommonFunctions.Data.CheckIsDBNull(drCustomFields("DatabaseFieldName")).ToString()
                    strUserGivenCaption = CommonFunctions.Data.CheckIsDBNull(drCustomFields("UserGivenCaption")).ToString()
                    If strDatabaseFieldName.ToLower().Contains("customfieldcombo") Then
                        '.Write("<td id=TD" + strDatabaseFieldName + "  align=left NoWrap style='Display:None'>" & strUserGivenCaption & vbCrLf)
                        strControlHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("FilterControl_filterRowCount", "usp_Sel_tbl_PM_CustomFields_Details '" + strDatabaseFieldName + "',0,1,'Help-Desk'", , , "class='form-control value'", ReturnAsHTML:=True))
                        '.Write("</td>")
                    End If
                End While
                CommonFunctions.Data.DisposeDataReader(drCustomFields)
                '**********************************************************************
            Case (Trim(ControlName.ToLower).IndexOf("customfielddate") <> -1)
                ' date
                'strControlHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("FilterControl_filterRowCount", "FilterControl_filterRowCount", , , , , "frmRequestListNew", returnHTML:=True))
                strControlHTML.Append("<div class='col-md-2' style='padding-right:0px;'>")
                strControlHTML.Append("<input type='text' class='form-control' id='FilterControl_filterRowCount' placeholder='" & ControlName & "' onfocus=""$('#FilterControl_filterRowCount').datepicker();$('#FilterControl_filterRowCount').datepicker('show');""> ")
                strControlHTML.Append("<i class='fa fa-calendar' onclick=""$('#FilterControl_filterRowCount').datepicker();$('#FilterControl_filterRowCount').datepicker('show');"" style='top:-21px;position:relative;float:left;right:-185px;'></i>")
                strControlHTML.Append("</div>")
            Case Else
                'Value
                strControlHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("FilterControl_filterRowCount", "FilterControl_filterRowCount", "form-control value", 100, , returnHTML:=True, EnableHTMLEncode:=True))
        End Select
        strControlHTML = strControlHTML.Replace("filterRowCount", count)
        Return strControlHTML.ToString
    End Function
    Protected Function SaveAdvanceFilter(ByVal FilterQuery As String, ByVal FilterName As String)
        '=====================================================================
        ' Procedure Name        : SaveAdvanceFilter
        ' Description           : To save advance filter 
        ' Created Date           : 10th-OCT-2017
        '=====================================================================
        Dim strSQL As String = ""
        Dim dr As IDataReader
        Dim strResult As String = ""
        ' insert the NEW filter
        strSQL = "usp_NG2_CRM_Insert_Filter	" & HttpContext.Current.Session("intUserID")
        strSQL = strSQL & ",'" & FilterName & "'"
        strSQL = strSQL & ",'" & FilterQuery & "'"
        strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
        'dr = CommonFunctions.Data.GetDataReader(strSQL, True)
        'If dr.Read Then
        '    m_lngFilterID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FilterID"), "0"), Long)
        'End If
        Return strResult.ToString
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function
    Private Function WriteAttachmentGrid(ByVal QueryID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteAttachmentGrid()	
        ' Purpose               : Plot Grid for request attachments
        ' Author                : Bharat T.
        ' Created               : Oct 13, 2017
        '=====================================================================
        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer
        Dim strSortBy, strSortOrder As String
        Dim strGridHTML As New StringBuilder("")
        '--- Set the TD style array
        Dim arrWidthArray() As String = {"", "align=left style='width:60%;'", "align=left style='width:20%;'", "align=left style='width:20%;'"}
        'Purpose : To have the Original file name for attachment
        Dim arrstrRowLinkField() As String = {"", "Document_OnClick_For_CRM(SystemFileName,OriginalFileName)", "", ""}
        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add("File Icon")
        arrColHeadingsList.Add("File Name")
        arrColHeadingsList.Add("Uploaded By")
        arrColHeadingsList.Add("Upload Date")
        'arrColHeadingsList.Add(MyBase.GetResourceString("CAP_DESCRIPTION"))
        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("")
        arrColNamesList.Add("OriginalFileName")
        arrColNamesList.Add("AttachedBy")
        arrColNamesList.Add("DateAttached")
        'arrColNamesList.Add("Description")
        'If Not Request.QueryString("sortby") Is Nothing Then
        '    strSortBy = Request.QueryString("sortby")
        'Else
        '    strSortBy = "DateAttached"
        'End If
        'If Not Request.QueryString("sortorder") Is Nothing Then
        '    strSortOrder = Request.QueryString("sortorder")
        'Else
        '    strSortOrder = "DESC"
        'End If
        ''--- Display the Page Caption 
        'CommonFunctions.General.WriteHTML("<br>")
        'WebPages.Template.PageCaption.GetPageCaptions(, "")
        'CommonFunctions.General.WriteHTML("<br>")
        '--- Display the list of records for the selected Employee
        strSQLQuery = "EXEC usp_NG2_sel_tbl_NG2_UnCategorizedTickets_Attachments " + CommonFunctions.General.CheckIsNothing(QueryID, "")
        'strSQLQuery += " ,NULL , '-1'"
        'strSQLQuery += ", 'DateAttached', 'DESC','" & Session("LoginType") & "'"
        '/*Changed By Yasmin on 18th july 2018*/
        m_objGridAttachment = New WebPages.Template.GenericGrid
        With m_objGridAttachment
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 4
            .RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto;height:225px;"
            '.ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = "divAttachment"
            .SQL = strSQLQuery
            '.ColNameToolTipOnEachRow = True
            .UseSQL = True
            '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
            '.SortBy = strSortBy
            '.SortOrder = strSortOrder
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With
        intRecordCount = m_objGridAttachment.NoOfRows
        m_objGridAttachment = Nothing
        strGridHTML.Append("<BR><TABLE class=clsGridTable border=0 cellpadding=0 cellspacing=0 width='99.9%' style='border:0px !important;'>")
        strGridHTML.Append("<TR ><TD width='100%' align='right' style='text-align:right;'>")
        strGridHTML.Append("Total Records " + CStr(intRecordCount) + " </TD></TR></TABLE>")
        Return strGridHTML.ToString
    End Function
    Private Sub m_objGridAttachment_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridAttachment.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper = "FILE ICON" Then
            Cancel = True
            Args.StringToBeInserted = "<th></th>"
        End If
    End Sub
    Private Sub m_objGridAttachment_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridAttachment.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "FILE ICON" Then
            Cancel = True
            Args.StringToBeInserted = "<td><i class='fa fa-file-text-o' aria-hidden='true'></i></td>"
        End If
        If Args.DataField.ToUpper = "ORIGINALFILENAME" Then
            Cancel = True
            Args.StringToBeInserted = "<td valign=top align=left style='width:60%;' >"
            Args.StringToBeInserted += "<a  href=""JavaScript:Document_OnClick_For_CRM('" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SystemFileName")) & "','" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OriginalFileName")) & "')"">" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader("OriginalFileName")) & ""
            Args.StringToBeInserted += "<i class='fa fa-download' aria-hidden='true' data-toggle='tooltip' title='Download'></i>"
            Args.StringToBeInserted += "</a></td>"
        End If
    End Sub
    Private Function GenerateZipFileStructure(QueryID)
        Dim drAttachment As IDataReader
        Dim strSystemfileName As String
        Dim strFilePath_Old As String = ""
        Dim strFilePath_New As String = ""
        Dim sourceFile As String = ""
        Dim destFile As String = ""
        Dim strArchiveFileName As String
        drAttachment = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_Documents_Attached_For_CRM_Uncategorized " & QueryID & " ,NULL , '-1', 'DateAttached', 'DESC'", True)
        strFilePath_Old = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Attachments/CRM"))
        strFilePath_New = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Attachments/CRM/ZIPFile/Request_" & QueryID & ""))
        While drAttachment.Read
            strSystemfileName = CommonFunctions.Data.CheckIsDBNull(drAttachment("SystemFileName"))
            If (strSystemfileName <> "") Then
                Try
                    'Added By Bharat T on 10th-Aug-2017 to create folder structre if not exists
                    Dim strDirectoryPath As String = System.IO.Path.GetDirectoryName(strFilePath_New)
                    If (Not System.IO.Directory.Exists(strDirectoryPath)) Then
                        System.IO.Directory.CreateDirectory(strDirectoryPath)
                    End If
                    'End of Added By Bharat T on 10th-Aug-2017 to create folder structre if not exists
                    sourceFile = System.IO.Path.Combine(strFilePath_Old, strSystemfileName)
                    destFile = System.IO.Path.Combine(strFilePath_New, strSystemfileName)
                    System.IO.File.Copy(sourceFile, destFile, True)
                Catch ex As Exception
                End Try
            End If
        End While
        'Path of zip file to be created with file name
        strArchiveFileName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../../Attachments/CRM/ZIPFile")) & "Request_" & QueryID & ".zip"
        'Check if already zip file exists if exists the delete and create new 
        Try
            If (File.Exists(strArchiveFileName)) Then
                File.Delete(strArchiveFileName)
            End If
            ZipFile.CreateFromDirectory(strFilePath_New, strArchiveFileName)
        Catch ex As Exception
        End Try
        Return strArchiveFileName
    End Function
    Private Function performApproveRejectAction(ByVal dataParamter As Object)
        Dim arrRequestList() As String
        Dim strQuery As String = ""
        Dim strSQL As String = ""
        Dim strRequestCanNotApproved As String = ""
        Dim arrRequestCanNotApproved As String()
        arrRequestList = CType(dataParamter("strQueryIDList"), String).Split(",")
        strSQL = "Usp_NG2_Validate_Requests 'PERFORMAPPROVEREJECT'," & HttpContext.Current.Session("intUserID") & ",'" & CType(dataParamter("strQueryIDList"), String) & "','" & HttpContext.Current.Session("LoginType") & "'"
        strRequestCanNotApproved = CommonFunctions.Data.GetDataScalar(strSQL, True)
        'If (strRequestCanNotApproved <> "") Then
        '    arrRequestCanNotApproved = strRequestCanNotApproved.Split(",")
        'End If
        If Not strRequestCanNotApproved Is Nothing Then
            arrRequestCanNotApproved = strRequestCanNotApproved.Split(",")
        Else
            strRequestCanNotApproved = ""
            arrRequestCanNotApproved = strRequestCanNotApproved.Split(",")
        End If
        Dim AList As ArrayList = New ArrayList(arrRequestCanNotApproved)
        'Added By  Dipali V On 2nd jun 2020 For crash issue ID 24609
        Dim commented As String = dataParamter("strApproveRejectComment").ToString()
        commented = commented.Replace("'", "''")
        'End of Added By  Dipali V On 2nd jun 2020 For crash issue ID 24609
        For Each queryID As String In arrRequestList
            Try
                If (AList.Contains(queryID) = False) Then
                    strQuery = "usp_UPD_Request_ApprovalStatus " + queryID + ",'" + dataParamter("strAction") + "','" + commented + "'," + HttpContext.Current.Session("intUserID").ToString()
                    CommonFunction.Data.InsertOrUpdateData(strQuery, True)
                End If
            Catch ex As Exception
            End Try
        Next
    End Function
    Private Sub AssignRequestToSelf(ByVal QueryID As String)
        '=====================================================================
        ' Procedure Name        : AssignRequestToSelf()	
        ' Purpose               : To Assign help request to self.
        ' Description           : same as above
        ' Parameters Passed     : QueryID       
        ' Author                : Bharat T.
        ' Created               : 24,Oct 2017
        '=====================================================================
        Dim strQuery As String
        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String
        strQuery = "usp_INS_tbl_CRM_Query_Master_AssignToSelf " + QueryID + "," + Session("intUserID").ToString()
        CommonFunction.Data.InsertOrUpdateData(strQuery, True)
        ' Assign To change mail
        blnSendMail = False : blnShowPopup = False
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 43", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If blnSendMail Then
            If blnShowPopup Then
                'With Response
                '    .Write("<script language=javascript>")
                '    .Write("window.open (""../General/SendEmail.aspx?MessageID=43&MultipleRequests=0&QueryID=" & QueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                '    .Write("</script>")
                'End With
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, QueryID.ToString, False)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            Else
                ' silent mail
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, QueryID.ToString, False)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If
        End If
        'Response.Clear()
        'Response.Write("Assign$_$" + QueryID)
    End Sub
    Private Sub AssignRequestToEmployee(ByVal QueryID As String, ByVal strEmployeeID As String)
        '=====================================================================
        ' Procedure Name        : AssignRequestToEmployee()	
        ' Purpose               : To Assign help request to given employee id.
        ' Description           : same as above
        ' Parameters Passed     : QueryID  , EmployeeID     
        ' Author                : Bharat T.
        ' Created               : 9th-Nov-2017
        '=====================================================================
        Dim strQuery As String
        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String
        strQuery = "usp_INS_tbl_CRM_Query_Master_AssignToSelf " + QueryID + "," + strEmployeeID.ToString()
        CommonFunction.Data.InsertOrUpdateData(strQuery, True)
        ' Assign To change mail
        blnSendMail = False : blnShowPopup = False
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 43", True)
        If dr.Read Then
            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        If blnSendMail Then
            If blnShowPopup Then
                'With Response
                '    .Write("<script language=javascript>")
                '    .Write("window.open (""../General/SendEmail.aspx?MessageID=43&MultipleRequests=0&QueryID=" & QueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                '    .Write("</script>")
                'End With
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, QueryID.ToString, False)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            Else
                ' silent mail
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, QueryID.ToString, False)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If
        End If
        'Response.Clear()
        'Response.Write("Assign$_$" + QueryID)
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	        
        ' Author                : Bharat T.
        ' Created               : Oct 13, 2017
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
    Public Shared Function ShowHelpDeskFeedbackDiv() As String
        '=====================================================================
        ' Procedure Name        : ShowHelpDeskFeedbackDiv
        ' Description           : To save request flag details
        ' Created Date           :  Bharat T On 14th Nov 2017
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim FeedbackID As String
        Dim ParameterName As String
        Dim Rating As String
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_NG2_SEL_tbl_CRM_Feedback ", True)
        strHTML.Append("<div class='divfeedback'>")
        strHTML.Append("<table class='tblfeedback'>")
        strHTML.Append("<tbody>")
        strHTML.Append("<tr>")
        While dr.Read
            FeedbackID = CType(CommonFunctions.General.CheckIsNothing(dr("FeedbackID"), ""), String)
            ParameterName = CType(CommonFunctions.General.CheckIsNothing(dr("ParameterName"), ""), String)
            Rating = CType(CommonFunctions.General.CheckIsNothing(dr("Rating"), ""), String)
            '/strHTML.Append("<td>")
            If Rating = "1" Then
                strHTML.Append("<td><label class='clslabel'>Satisfactory</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Satisfactory'></i></span></label>")
                'strHTML.Append("<td><span><i class='fa fa-star-o' aria-hidden='true' title='Satisfactory'></i></span>")
                strHTML.Append("<input type=hidden id=Ratingone name=Ratingone value='" & FeedbackID & "' /></td>")
            ElseIf Rating = "5" Then
                strHTML.Append("<td><label class='clslabel'>Fair</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Fair'></i><i class='fa fa-star checked1' aria-hidden='true' title='Fair'></i></span></label>")
                strHTML.Append("<input type=hidden id=Ratingtwo name=Ratingtwo value='" & FeedbackID & "' /></td>")
            ElseIf Rating = "8" Then
                strHTML.Append("<td><label class='clslabel'>Good</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Good'></i><i class='fa fa-star checked1' aria-hidden='true' title='Good'></i><i class='fa fa-star checked1' aria-hidden='true' title='Good'></i></span></label>")
                strHTML.Append("<input type=hidden id=Ratingthree name=Ratingthree value='" & FeedbackID & "' /></td>")
            ElseIf Rating = "10" Then
                strHTML.Append("<td><label class='clslabel'>Excellent</label>&nbsp;&nbsp;<label><span><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i><i class='fa fa-star checked1' aria-hidden='true' title='Excellent'></i></span></label>")
                strHTML.Append("<input type=hidden id=RatingFour name=RatingFour value='" & FeedbackID & "' /></td>")
            End If
        End While
        '      <div class="row">
        '  <div class="col-lg-12">
        '    <div class="star-rating">
        '      <span class="fa fa-star-o" data-rating="1"></span>
        '      <span class="fa fa-star-o" data-rating="2"></span>
        '      <span class="fa fa-star-o" data-rating="3"></span>
        '      <span class="fa fa-star-o" data-rating="4"></span>
        '      <span class="fa fa-star-o" data-rating="5"></span>
        '      <input type="hidden" name="whatever1" class="rating-value" value="2.56">
        '    </div>
        '  </div>
        '</div>
        CommonFunctions.Data.DisposeDataReader(dr)
        strHTML.Append("</tr>")
        strHTML.Append("<tr>")
        strHTML.Append("<td><label class='clslabel'>Rate us :-</label>&nbsp;&nbsp;<label>")
        strHTML.Append("</td>")
        strHTML.Append("<td colspan='3'>")
        strHTML.Append("<span class='fa fa-star' onclick='Putrating(1)' id='firstrating' data-rating='1' title='Satisfactory'></span>&nbsp;")
        strHTML.Append("<span class='fa fa-star' onclick='Putrating(5)' id='Secondrating' data-rating='5' title='Fair'></span>&nbsp;")
        strHTML.Append("<span class='fa fa-star' onclick='Putrating(8)' id='Thirdrating' data-rating='8' title='Good'></span>&nbsp;")
        strHTML.Append("<span class='fa fa-star' onclick='Putrating(10)' id='Foruthrating' data-rating='10' title='Excellent'></span>&nbsp;")
        'strHTML.Append("<span class='fa fa-star'></span>&nbsp;")
        ' strHTML.Append("&nbsp;&nbsp;&nbsp;&nbsp;<span id='SpnRatingMsg'></span>")
        strHTML.Append("</td>")
        'strHTML.Append("<td><span><i class='fa fa-star-o' aria-hidden='true' title='Satisfactory' onclick='Putrating(1)' id='firstrating' data-rating='1'></i></span></td><td><span><i class='fa fa-star-o' aria-hidden='true' title='Fair' onclick='Putrating(5)'  id='Secondrating' data-rating='5'></i></span></td><td><span><i class='fa fa-star-o' aria-hidden='true' title='Good' onclick='Putrating(8)' id='Thirdrating' data-rating='8'></i></span></td><td><span><i class='fa fa-star-o' aria-hidden='true' title='Excellent' onclick='Putrating(10)' id='Foruthrating' data-rating='10'></i></span></td>")
        strHTML.Append("</tr>")
        strHTML.Append("<tr>")
        strHTML.Append("<td colspan='3'>")
        strHTML.Append("<div style='text-align:center'>")
        strHTML.Append("<span id='SpnRatingMsg'></span>")
        strHTML.Append("</div>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("<tr>")
        strHTML.Append("<td colspan='3'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-5' for='Feedback' style='font-weight:normal!important' id='lblfeedback'>Feedback Comment *</label>")
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cbFeekback", "usp_CRM_Get_Feedback_ForCombo", 188, , "class='form-control' onblur=""javascript:GetRating()"" ", True, True, , , , , ))
        strHTML.Append(" <div class='col-sm-10'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtSubmitCommentsDiv", "txtSubmitCommentsDiv", , "form-control", , , , , 330, , , , , , , , , , "", True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</td>")
        strHTML.Append("</tr>")
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='col-md-12'>")
        'strHTML.Append("<div class="" style='width:37% ; background-color:white'>")
        'strHTML.Append("<p class='help'></p>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("<div class='row' id='btngroupcnlsave'>")
        strHTML.Append("<div class='col-xs-12' id='btngroupcnlsave1'>")
        strHTML.Append("<button type='button' class='btn btn-default' onclick='SubmitOK_Onclick()' id='' title='Submit FeedBack'>Submit</button>")
        strHTML.Append("<button type='button' class='btn btn-default' onclick='CancelFeedback()' id='' style='margin-left:4px' title='Cancel'>Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        CommonFunctions.General.WriteHTML(strHTML.ToString)
    End Function
#Region "Jquery AJAX Web Methods"
    <System.Web.Services.WebMethod>
    Public Shared Function GetSerachFilterValues(ByVal Mode As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Mode = Utilities.Security.SecurityBuilder.CheckUserInput(Mode, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetSerachFilterValues
        ' Description           : For getting serach filter value list
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try
            Dim dtTable As DataTable
            Dim dtTable1 As DataTable
            Dim strListHTML As New StringBuilder("")
            'If (Mode = "All") Then
            dtTable = CommonFunction.Data.GetDataTable("usp_NG2_SEL_CRM_SearchFields ", True)
            'dtTable1 = CommonFunction.Data.GetDataTable("usp_SEL_CRM_SearchFields_Submitted ", True)
            strListHTML.Append("<a class='dropdown-item' href='#' onclick=""SerachFilterList_Click('')"" > &nbsp; </a>" & vbCrLf)
            For Each drRow As DataRow In dtTable.Rows
                If HttpContext.Current.Session("LoginType") = "C" Then
                    If drRow("FieldType") = "Subject" Or drRow("FieldType") = "Request Type" Or drRow("FieldType") = "Priority" Or drRow("FieldType") = "Severity" Or drRow("FieldType") = "Request ID" Then
                        strListHTML.Append("<a class='dropdown-item' href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item(0), "") & "' onclick=""SerachFilterList_Click('" & CommonFunction.Data.CheckIsDBNull(drRow.Item(0), "") & "')"" >" & CommonFunction.Data.CheckIsDBNull(drRow.Item(1), "") & "</a>" & vbCrLf)
                    End If
                Else
                    strListHTML.Append("<a class='dropdown-item' href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item(0), "") & "' onclick=""SerachFilterList_Click('" & CommonFunction.Data.CheckIsDBNull(drRow.Item(0), "") & "')"" >" & CommonFunction.Data.CheckIsDBNull(drRow.Item(1), "") & "</a>" & vbCrLf)
                End If
            Next
            'End If
            Return strListHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetLoadFilterValues() As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetLoadFilterValues
        ' Description           : For getting Load Filter values
        ' Created Date           : 12th-OCT-2017
        '=====================================================================
        Try
            Dim dtTable As DataTable
            Dim dtTable1 As DataTable
            Dim strListHTML As New StringBuilder("")
            Dim strListHTML1 As New StringBuilder("")
            Dim strIsDefault As String = ""
            Dim strFilterID As String = ""
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList()
            Dim strNewFilterID As String = ""
            'If (Mode = "All") Then
            dtTable = CommonFunction.Data.GetDataTable("usp_sel_tbl_CRM_Filters  null," & HttpContext.Current.Session("intUserID") & ",'FilterName','ASC','-1'", True)
            'dtTable1 = CommonFunction.Data.GetDataTable("usp_SEL_CRM_SearchFields_Submitted ", True)
            strListHTML.Append("<a class='dropdown-item' href='#' onclick=""LoadFilterClick(this,'')"" > &nbsp; </a>" & vbCrLf)
            strNewFilterID = objCRMRequestListNew.GetDefault_New(HttpContext.Current.Session("intUserID"), "DefaultFilter_RequestListNewPage")
            For Each drRow As DataRow In dtTable.Rows
                strIsDefault = CommonFunction.Data.CheckIsDBNull(drRow.Item("IsDefault_DB"), "")
                strFilterID = CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterID"), "")
                'm_lngFilterNewID
                If (strFilterID = strNewFilterID) Then
                    strListHTML.Append("<a class='dropdown-item clsFilterDefault' href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterID"), "") & "' onclick=""LoadFilterClick(this,'SavedLoadFilter2')"" >" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterName"), "") & "</a>" & vbCrLf)
                    strListHTML1.Append("<li class='dropdown-item clsFilterDefault' ><input type='checkbox' name='clsFilter' data-toggle='tooltip' title='Set As Default' onclick=""SetDefault_SavedFilter('" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterID"), "") & "')"" checked=true  /> &nbsp; <a  href='#' id='savedID_" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterID"), "") & "' onclick=""LoadFilterClick(this,'')"" >" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterName"), "") & "</a></li>" & vbCrLf)
                Else
                    strListHTML.Append("<a class='dropdown-item' href='#' id='" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterID"), "") & "' onclick=""LoadFilterClick(this,'SavedLoadFilter2')"" >" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterName"), "") & "</a>" & vbCrLf)
                    strListHTML1.Append("<li class='dropdown-item' ><input type='checkbox' name='clsFilter' data-toggle='tooltip' title='Set As Default' onclick=""SetDefault_SavedFilter('" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterID"), "") & "')"" /> &nbsp; <a  href='#' id='savedID_" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterID"), "") & "' onclick=""LoadFilterClick(this,'')"" >" & CommonFunction.Data.CheckIsDBNull(drRow.Item("FilterName"), "") & "</a></li>" & vbCrLf)
                End If
            Next
            'End If
            Return strListHTML.ToString & "####" & strListHTML1.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetSerachFilterControl(ByVal FieldType As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        FieldType = Utilities.Security.SecurityBuilder.CheckUserInput(FieldType, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetSerachFilterControl
        ' Description           : For plotting serach filter on control select
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try
            Dim strControl As New StringBuilder("")
            Dim m_lngEmployeeID As Long = CType(HttpContext.Current.Session("intUserID"), Long)
            Dim m_strUserName As String = HttpContext.Current.Session("strUserName").ToString
            Dim m_strLoginType As String = HttpContext.Current.Session("LoginType").ToString
            Dim m_lngLoginID As Long = CType(HttpContext.Current.Session("intLOGINID"), Long)
            If FieldType.ToUpper = "PRIORITY" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_CRM_Get_RequestPriority", 150, , " class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "ASSIGNED TO" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboAssignedTo", "usp_SEL_Tbl_PM_Employee", 150, , "class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "CUSTOMER" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "USP_sel_Requestor_Filter " + m_lngEmployeeID.ToString() + ", '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "', 'C'", 150, , "class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "EMPLOYEE" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "USP_sel_Requestor_Filter  " + m_lngEmployeeID.ToString() + ",'" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "', 'E'", 150, , "class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "LOCATION" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboLocation", "usp_CRM_Get_TargetLocations 0", 150, , " class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "REQUEST TYPE" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", "usp_CRM_RequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, , "class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "SUB REQUEST TYPE" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", "usp_CRM_SubRequestType_Filter '" + CommonFunction.General.BuildQueryString(m_strUserName) + "','" + m_strLoginType + "'", 150, , "class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "SUBJECT" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", "clsTextBox form-control", 150, 100, ToBeInserted:="class='clsTextBox form-control'", returnHTML:=True, EnableHTMLEncode:=True))
            ElseIf FieldType.ToUpper = "SEVERITY" Then
                strControl.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", "usp_CRM_Get_RequestSeverity", 150, , "class='form-control'", ReturnAsHTML:=True))
            ElseIf FieldType.ToUpper = "REQUEST ID" Then
                'strControl.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestID", "txtRequestID", , 150, 100, ToBeInserted:="class='form-control' type='number' ", returnHTML:=True, EnableHTMLEncode:=True))
                strControl.Append("<input type='number' name='txtRequestID' id='txtRequestID' class='clsTextBox form-control' style='width:150px  ; text-align:Left' maxlength='10' value=''>")
            End If
            Return strControl.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid0
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim PageNumber As Integer
            PageNumber = GridParameter("PageNumber")
            objCRMRequestListNew.m_intPageNumber = PageNumber
            objCRMRequestListNew.InitializeData()
            strGridHTML.Append(objCRMRequestListNew.DrawPageGrid("AJAXRefresh", GridParameter))
            strGridHTML.Append("#$Paging$#")
            strGridHTML.Append(objCRMRequestListNew.WritePaging(PageNumber, "AJAXRefresh", GridParameter))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Sub SaveSearchFilter(ByVal ajaxParameter As Object)
        '=====================================================================
        ' Procedure Name        : SaveSearchFilter
        ' Description           : For saving search filter
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")
        Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
        Dim strSQL As String = ""
        Dim strSearchFilterName As String = ""
        Dim strSearchFilterValue As String = ""
        Dim m_lngEmployeeID As Long = CType(HttpContext.Current.Session("intUserID"), Long)
        Dim m_strUserName As String = HttpContext.Current.Session("strUserName").ToString
        Dim m_strLoginType As String = HttpContext.Current.Session("LoginType").ToString
        Dim m_lngLoginID As Long = CType(HttpContext.Current.Session("intLoginID"), Long)
        If Trim(ajaxParameter("SearchFilterName")) <> "" Then
            strSearchFilterName = Trim(ajaxParameter("SearchFilterName")) + "_SearchFilter_DB"
        End If
        strSearchFilterValue = Trim(ajaxParameter("SearchFilterValue"))
        If Trim(ajaxParameter("SearchFilterName") & "") <> "" Then
            strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",'" & CommonFunctions.General.BuildQueryString(strSearchFilterName) & "','" & CommonFunctions.General.BuildQueryString(strSearchFilterValue) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','DB'"
        Else
            strSQL = "usp_CRM_SetDefaultSearchFilter	" & m_lngEmployeeID & ",null,null,'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "','DB'"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
    End Sub
    <System.Web.Services.WebMethod>
    Public Shared Function GetFlagDetails(ByVal RequestID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        RequestID = Utilities.Security.SecurityBuilder.CheckUserInput(RequestID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetFlagDetails
        ' Description           : To Get Flag details when clicked
        ' Created Date           : 10th-OCT-2017
        '=====================================================================
        Try
            Dim drProjectCount As IDataReader
            Dim blnComplete As Boolean
            Dim DueDate As String
            Dim FlagTo As String = ""
            Dim strContextType As String = ""
            Dim m_intUniqueID As Integer = 0
            drProjectCount = CommonFunctions.Data.GetDataReader("usp_sel_TrackingDtls_Edit " & RequestID & ",'HelpDeskRequest', " + CType(HttpContext.Current.Session("intUserID"), String), True)
            Dim ContextValue As String = CommonFunctions.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_MyeDashboard_ContextName " & RequestID.ToString & ",'HelpDeskRequest'", True), "")
            If drProjectCount.Read Then
                m_intUniqueID = CType(drProjectCount("UniqueID"), Integer)
                blnComplete = CType(drProjectCount("IsComplete"), Boolean)
                DueDate = CType(drProjectCount("DueDate"), String)
                FlagTo = CType(drProjectCount("FlagTo"), String)
            Else
                m_intUniqueID = 0
                blnComplete = False
                DueDate = ""
                FlagTo = ""
            End If
            Return m_intUniqueID.ToString & "#$#" & blnComplete.ToString & "#$#" & DueDate.ToString & "#$#" & FlagTo & "#$#" & ContextValue.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ClearRequestFlag(FlagUniqueID As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        FlagUniqueID = Utilities.Security.SecurityBuilder.CheckUserInput(FlagUniqueID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ClearRequestFlag
        ' Description           : To clear  request flagged details
        ' Created Date           : 12th-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            objCRMRequestListNew.ClearTrackingDtls(FlagUniqueID)
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveRequestFlag(ByVal FlagParameters As Object)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : SaveRequestFlag
        ' Description           : To save request flag details
        ' Created Date           : 12th-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            objCRMRequestListNew.GenerateTrackingDtls(FlagParameters)
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetFilterControl(ByVal ControlName As String, ByVal count As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        ControlName = Utilities.Security.SecurityBuilder.CheckUserInput(ControlName, 2, True, False, False)
        count = Utilities.Security.SecurityBuilder.CheckUserInput(count, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : SaveRequestFlag
        ' Description           : To get advance filter control dynamically
        ' Created Date           : 12th-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim strFilterControlHTML As New StringBuilder("")
            strFilterControlHTML.Append(objCRMRequestListNew.GetAdvanceFilterControl(ControlName, count))
            Return strFilterControlHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveFilter(ByVal FilterQuery As String, ByVal FilterName As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        FilterQuery = Utilities.Security.SecurityBuilder.CheckUserInput(FilterQuery, 2, True, False, False)
        FilterName = Utilities.Security.SecurityBuilder.CheckUserInput(FilterName, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : SaveFilter
        ' Description           : To  save advance filter
        ' Created Date           : 12th-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim strFilterID As String
            strFilterID = objCRMRequestListNew.SaveAdvanceFilter(FilterQuery, FilterName)
            Return strFilterID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetAttachmentGrid(ByVal QueryID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        QueryID = Utilities.Security.SecurityBuilder.CheckUserInput(QueryID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetAttachmentGrid
        ' Description           : To  get list of attachments againsts requests
        ' Created Date           : 13th-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objCRMRequestListNew.WriteAttachmentGrid(QueryID))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenerateZipFile(ByVal QueryID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        QueryID = Utilities.Security.SecurityBuilder.CheckUserInput(QueryID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GenerateZipFile
        ' Description           : Generate Zip file
        ' Created Date           : 13th-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim strArchiveFileName As String = ""
            strArchiveFileName = objCRMRequestListNew.GenerateZipFileStructure(QueryID)
            Return strArchiveFileName
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ApproveRejectRequest(ByVal dataParamter As Object) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ApproveRejectRequest
        ' Description           : To Approve or Reject Multiple Requests
        ' Created Date           : 23rd-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            objCRMRequestListNew.performApproveRejectAction(dataParamter)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function AssignToSelf(ByVal strQueryIDList As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strQueryIDList = Utilities.Security.SecurityBuilder.CheckUserInput(strQueryIDList, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : AssignToSelf
        ' Description           : To Assign Request to self.
        ' Created Date           : 24th-Oct-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim arrRequestList() As String
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strRequestCanNotAssign As String = ""
            Dim arrRequestCanNotAssign() As String
            Dim AList As ArrayList
            strSQL = "Usp_NG2_Validate_Requests 'AssignToSelf'," & HttpContext.Current.Session("intUserID") & ",'" & strQueryIDList & "','" & HttpContext.Current.Session("LoginType") & "'"
            strRequestCanNotAssign = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If (strRequestCanNotAssign <> "") Then
                arrRequestCanNotAssign = strRequestCanNotAssign.Split(",")
            Else
                strRequestCanNotAssign = ""
                arrRequestCanNotAssign = strRequestCanNotAssign.Split(",")
            End If
            If Not arrRequestCanNotAssign Is Nothing Then
                AList = New ArrayList(arrRequestCanNotAssign)
            Else
                arrRequestCanNotAssign = {""}
                AList = New ArrayList(arrRequestCanNotAssign)
            End If
            arrRequestList = strQueryIDList.Split(",")
            For Each queryID As String In arrRequestList
                Try
                    If AList.Contains(queryID) = False Then
                        objCRMRequestListNew.AssignRequestToSelf(queryID)
                    End If
                Catch ex As Exception
                    strResult = ex.Message
                End Try
            Next
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function AssignToEmployee(ByVal strQueryIDList As String, ByVal EmployeeID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strQueryIDList = Utilities.Security.SecurityBuilder.CheckUserInput(strQueryIDList, 2, True, False, False)
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : AssignToEmployee
        ' Description           : To Assign Request to specific Employee.
        ' Created Date           : 9th-Nov-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim arrRequestList() As String
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strRequestCanNotAssign As String = ""
            Dim arrRequestCanNotAssign() As String = {}
            strSQL = "Usp_NG2_Validate_Requests 'AssignToEmployee'," & EmployeeID & ",'" & strQueryIDList & "','" & HttpContext.Current.Session("LoginType") & "'"
            strRequestCanNotAssign = CommonFunctions.Data.GetDataScalar(strSQL, True)
            If (strRequestCanNotAssign <> "") Then
                arrRequestCanNotAssign = strRequestCanNotAssign.Split(",")
            End If
            'Dim AList As ArrayList = New ArrayList(arrRequestCanNotAssign)
            If (arrRequestCanNotAssign.Length <= 0) Then
                arrRequestList = strQueryIDList.Split(",")
                For Each queryID As String In arrRequestList
                    Try
                        'If AList.Contains(queryID) = False Then
                        objCRMRequestListNew.AssignRequestToEmployee(queryID, EmployeeID)
                        'End If
                    Catch ex As Exception
                        strResult = ex.Message
                    End Try
                Next
            Else
                strResult = strRequestCanNotAssign
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ValidateSelectedRequestsIDs(ByVal strQueryIDList As String, ByVal Flag As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strQueryIDList = Utilities.Security.SecurityBuilder.CheckUserInput(strQueryIDList, 2, True, False, False)
        Flag = Utilities.Security.SecurityBuilder.CheckUserInput(Flag, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ValidateSelectedRequestsIDs
        ' Description           : To check selected rquests before Assign Request to self.
        ' Created Date           : 9th-Nov-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim arrRequestList() As String
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strRequestCanNotAssign As String = ""
            strSQL = "Usp_NG2_Validate_Requests '" & Flag & "'," & HttpContext.Current.Session("intUserID") & ",'" & strQueryIDList & "','" & HttpContext.Current.Session("LoginType") & "'"
            strRequestCanNotAssign = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strRequestCanNotAssign
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ValidateRequestsAndGetDataForApproval(ByVal strQueryIDList As String, ByVal Flag As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strQueryIDList = Utilities.Security.SecurityBuilder.CheckUserInput(strQueryIDList, 2, True, False, False)
        Flag = Utilities.Security.SecurityBuilder.CheckUserInput(Flag, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ValidateRequestsAndGetDataForApproval
        ' Description           : To check selected rquests before approval
        ' Created Date          : 24th-Nov-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim arrRequestList() As String
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strRequestCanNotAssign As String = ""
            Dim dtTable As DataTable
            Dim strGridHTML As New StringBuilder("")
            strRequestCanNotAssign = ValidateSelectedRequestsIDs(strQueryIDList, Flag)
            Dim result = Join(strQueryIDList.Split(New Char() {","c}).Except(strRequestCanNotAssign.Split(New Char() {","c})).ToArray(), ",")
            If Not result Is Nothing Then
                strSQL = "Usp_NG2_Sel_ReqDetails_FromCommaRequests '" & result.ToString & "','" & HttpContext.Current.Session("LoginType") & "'"
                dtTable = CommonFunctions.Data.GetDataTable(strSQL, True)
                strResult = GetSerialized(dtTable)
            Else
                strResult = ""
            End If
            Return strRequestCanNotAssign & "#$$#" & strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ValidateRequestsAndGetPickupData(ByVal strQueryIDList As String, ByVal Flag As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strQueryIDList = Utilities.Security.SecurityBuilder.CheckUserInput(strQueryIDList, 2, True, False, False)
        Flag = Utilities.Security.SecurityBuilder.CheckUserInput(Flag, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ValidateRequestsAndGetPickupData
        ' Description           : To check selected rquests before Assign Request to self.
        ' Created Date          : 24th-Nov-2017
        '=====================================================================
        Try
            Dim objCRMRequestListNew As New CRM_UnCategorizedRequestList
            Dim arrRequestList() As String
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strRequestCanNotAssign As String = ""
            Dim dtTable As DataTable
            Dim strGridHTML As New StringBuilder("")
            strRequestCanNotAssign = ValidateSelectedRequestsIDs(strQueryIDList, Flag)
            Dim result = Join(strQueryIDList.Split(New Char() {","c}).Except(strRequestCanNotAssign.Split(New Char() {","c})).ToArray(), ",")
            If Not result Is Nothing Then
                strSQL = "Usp_NG2_Sel_ReqDetails_FromCommaRequests '" & result.ToString & "','" & HttpContext.Current.Session("LoginType") & "'"
                dtTable = CommonFunctions.Data.GetDataTable(strSQL, True)
                strResult = GetSerialized(dtTable)
            Else
                strResult = ""
            End If
            Return strRequestCanNotAssign & "#$$#" & strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    ''Added By Vidya Jadhav ON 27 Oct 2017 For Requestor And Statistic Details
    <System.Web.Services.WebMethod> _
    Public Shared Function PlotRequestorDetails(ByVal QueryID As String, ByVal Requestor As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        QueryID = Utilities.Security.SecurityBuilder.CheckUserInput(QueryID, 2, True, False, False)
        Requestor = Utilities.Security.SecurityBuilder.CheckUserInput(Requestor, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim strHTML As New StringBuilder()
            '' strHTML.Append("<form class='modal-content animate' action='/action_page.php'>")
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strScript As String()
            Dim dtAttachment As New DataTable
            strSQL = "Exec usp_Sel_RequestorDetails " & QueryID & ",'" & Requestor & "'"
            dtAttachment = CommonFunctions.Data.GetDataTable(strSQL, True)
            Dim SystemFileName As String = ""
            Dim SubmittedDate As String = ""
            Dim DiscussionThread As String = ""
            Dim SubmittedBy As String = ""
            'Dim Flag As Integer = 0
            Dim Counter As Integer = 0
            Dim Phone As String = ""
            Dim DateAttachedTime As String = ""
            Dim Location As String = ""
            Dim RequestorName As String = ""
            Dim EmailID As String = ""
            Dim CurrentPhone As String = ""
            Dim CommunicationID As String = ""
            Dim ContactPerson As String = ""
            Dim Position As String = ""
            Dim Flag As Integer = 0
            '' strHTML.Append("<div style='font-weight:bold;'> Requestor </div> ")
            If Requestor = "E" Then
                ' strHTML.Append("<div class='table-responsive'>  ")
                '  strHTML.Append(" <table class='clsGridTable table table-bordred table-striped table-condensed' style='border-collapse:collapse'>")
                strHTML.Append("<div class='table-info' id='divrequestorTable'>  ")
                strHTML.Append(" <table class='table table-hover'>")
                ''Added By Vidya Jadhav ON 30 Nov 2017 For Theme Issue 
                'strHTML.Append("<thead>")
                strHTML.Append("<thead class='imgcontainer'>")
                ''End Of Added By Vidya Jadhav ON 30 Nov 2017 For Theme Issue 
                strHTML.Append(" <tr>")
                strHTML.Append("<th>Requestor Name</th>")
                strHTML.Append("<th>Email ID</th>")
                strHTML.Append("<th>Location</th>")
                strHTML.Append("<th>Current Phone</th>")
                strHTML.Append("<th>Phone</th>")
                strHTML.Append(" </tr>")
                strHTML.Append("</thead>")
                strHTML.Append("<tbody>")
                For i As Integer = 0 To dtAttachment.Rows.Count - 1
                    Flag = 1
                    strHTML.Append("<tr>")
                    RequestorName = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("RequestorName").ToString, "")
                    EmailID = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("EmailID").ToString, "")
                    CurrentPhone = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("CurrentPhone").ToString, "")
                    CommunicationID = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("CommunicationID").ToString, "")
                    Location = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Location").ToString, "")
                    Phone = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Phone").ToString, "")
                    strHTML.Append("<td>" & RequestorName & "</td>")
                    strHTML.Append("<td>" & EmailID & "</td>")
                    strHTML.Append("<td>" & Location & "</td>")
                    strHTML.Append(" <td>" & CurrentPhone & "</td>")
                    strHTML.Append("<td>" & Phone & "</td>")
                    strHTML.Append("</tr>")
                    Counter += 1
                Next
                If Flag = 0 Then
                    strHTML.Append(" <tr>")
                    strHTML.Append("<td>No Records Found</td>")
                    strHTML.Append(" </tr>")
                End If
                strHTML.Append("</tbody>")
                strHTML.Append("</table>")
                strHTML.Append("</div>")
                'strHTML.Append(" </form>")
            Else
                strHTML.Append("<div class='table-info'  id='divrequestorTable'>  ")
                strHTML.Append(" <table class='table table-hover'>")
                strHTML.Append("<thead class='imgcontainer'>")
                strHTML.Append(" <tr>")
                strHTML.Append("<th>Requestor Name</th>")
                strHTML.Append("<th>Contact Person</th>")
                strHTML.Append("<th>Position</th>")
                strHTML.Append("<th>Email ID</th>")
                strHTML.Append("<th >Location</th>")
                strHTML.Append("<th>Phone</th>")
                strHTML.Append(" </tr>")
                strHTML.Append("</thead>")
                strHTML.Append("<tbody>")
                For i As Integer = 0 To dtAttachment.Rows.Count - 1
                    Flag = 1
                    strHTML.Append("<tr>")
                    RequestorName = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("RequestorName").ToString, "")
                    EmailID = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("EmailID").ToString, "")
                    'CurrentPhone = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("CurrentPhone").ToString, "")
                    'CommunicationID = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("CommunicationID").ToString, "")
                    Location = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Location").ToString, "")
                    Phone = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Phone").ToString, "")
                    ContactPerson = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("ContactPerson").ToString(), "")
                    Position = CommonFunctions.Data.CheckIsDBNull(dtAttachment.Rows(i)("Position").ToString(), "")
                    strHTML.Append("<td>" & RequestorName & "</td>")
                    strHTML.Append("<td>" & ContactPerson & "</td>")
                    strHTML.Append(" <td>" & Position & "</td>")
                    strHTML.Append("<td>" & EmailID & "</td>")
                    strHTML.Append("<td>" & Location & "</td>")
                    strHTML.Append("<td>" & Phone & "</td>")
                    strHTML.Append("</tr>")
                    Counter += 1
                Next
                If Flag = 0 Then
                    strHTML.Append(" <tr>")
                    strHTML.Append("<td>No Records Found</td>")
                    strHTML.Append(" </tr>")
                End If
                strHTML.Append("</tbody>")
                strHTML.Append("</table>")
                strHTML.Append("</div>")
            End If
            '' strHTML.Append("<div style='font-weight:bold;'> Statistics </div> ")
            Dim strQuery As String
            Dim strEmployeename As String
            Dim strActivity As String
            Dim strTimeSpent As String
            Dim strCreatedDate As String
            Dim strQueryID As String
            Dim strClass As String = "clsTREven"
            Dim dblTotalSpend As Double = 0.0
            Dim iterator As Integer
            Dim sbHTML As New StringBuilder("")
            Dim strSubject As String
            Dim TotalCols As Integer
            Dim dsRecords As DataSet
            'Dim dsRecordsInnerLoop As DataSet
            ' Dim drRecords As IDataReader
            strQuery = "usp_Sel_CrossTab_RequestorRequests " + QueryID + ",'" + Requestor + "'"
            dsRecords = CommonFunctions.Data.GetDataSet(strQuery, "RequestCount", , , True)
            For Each drRecords As DataRow In dsRecords.Tables(0).Rows
                Requestor = drRecords("Requestor").ToString()
            Next
            TotalCols = dsRecords.Tables(1).Rows.Count
            strHTML.Append("<div style='font-weight:bold;margin-top:10px;margin-left:18px'>")
            strHTML.Append("Summary Of Request Posted By :  " + Requestor)
            strHTML.Append("</div>")
            strHTML.Append("<div id='divStatistic' class='table-info'>  ")
            strHTML.Append(" <table class='table table-hover'>")
            strHTML.Append("<TR class='imgcontainer'>")
            strHTML.Append("<th>Request Type</th>" + vbCrLf)
            Dim ToolTip As String
            For Each drRecords As DataRow In dsRecords.Tables(1).Rows
                strHTML.Append("<th align=left >" + drRecords("Status").ToString() + "</th>" + vbCrLf)
            Next
            strHTML.Append("</TR>" + vbCrLf)
            For Each drRecords As DataRow In dsRecords.Tables(2).Rows
                strHTML.Append("<TR > ")
                strHTML.Append("<TD >" + drRecords("RequestType").ToString() + "</TD>" + vbCrLf)
                For Each dsRecordsInnerLoop As DataRow In dsRecords.Tables(1).Rows
                    ToolTip = "Request Type : " + drRecords("RequestType").ToString() + vbCrLf
                    ToolTip = ToolTip + "Status : " + dsRecordsInnerLoop("Status").ToString()
                    strHTML.Append("<TD align=left title='" + ToolTip + "'>" + drRecords(dsRecordsInnerLoop("Status").ToString()).ToString() + "</TD>" + vbCrLf)
                Next
                strHTML.Append("</TR>" + vbCrLf)
            Next
            strHTML.Append("</table>")
            strHTML.Append("</div>")
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    ''End of Added By Vidya Jadhav ON 27 Oct 2017 For Requestor And Statistic Details
    <System.Web.Services.WebMethod> _
    Public Shared Function SetDefaultFilter(dataParameter As Object) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : SetDefaultFilter
        ' Description           : To set the default filter
        ' Created Date           : 2nd-Nov-2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
            Dim drCount As IDataReader
            Dim strResult As String = ""
            strSQL = "Usp_NG2_Ins_tbl_NG2_CRM_RequestDefaultFilter " & HttpContext.Current.Session("intUserID") & ",'" & dataParameter("FilterID") & "','" & dataParameter("FilterFlag") & "','" & HttpContext.Current.Session("LoginType") & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetRequestCounts() As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetRequestCounts
        ' Description           : To  get count of requests
        ' Created Date           : 2nd-Nov-2017
        '=====================================================================
        Try
            Dim objCRM_RequestListsNew As New CRM_UnCategorizedRequestList
            Dim strSQL As String = ""
            Dim drCount As IDataReader
            Dim strResult As String = ""
            strSQL = "Usp_NG2_Sel_UserRequestsCount " & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "','" & HttpContext.Current.Session("LoginType") & "'"
            drCount = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drCount.Read Then
                strResult = CommonFunctions.Data.CheckIsDBNull(drCount("AllCount"), "0") & "$$"
                strResult &= CommonFunctions.Data.CheckIsDBNull(drCount("SubmittedCount"), "0") & "$$"
                strResult &= CommonFunctions.Data.CheckIsDBNull(drCount("MyRequestCount"), "0") & "$$"
                strResult &= CommonFunctions.Data.CheckIsDBNull(drCount("FlaggedCount"), "0") & "$$"
                strResult &= CommonFunctions.Data.CheckIsDBNull(drCount("RequestForApprovalCount"), "0") & "$$"
                strResult &= CommonFunctions.Data.CheckIsDBNull(drCount("RequestAcceptedRejectedCount"), "0")
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmployeeImagePath(ByVal intEmployeeID As Integer) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim strImageName As String = ""
            Dim strEmployeeImage As String
            Dim strFilePath As String = ""
            strImageName = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_RM_EmployeeMaintenance_Attachment " & intEmployeeID, True), ""))
            Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
            strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1)
            strEmployeeImage = strEmployeeImage.Replace("\", "/")
            If Not strImageName Is Nothing Then
                strFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), strImageName)
            End If
            If File.Exists(strFilePath) = False Or CommonFunctions.General.CheckIsNothing(strImageName) = "" Then
                strEmployeeImage = strEmployeeImage + "/Images/Photo/no-photo.png"
            Else
                strEmployeeImage = strEmployeeImage + "/Images/Photo/" + strImageName
            End If
            Return strEmployeeImage
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Private Function DrawExcelUploadDiv() As String
        '***********************************************************************************
        'Created By : Bharat T.
        'Created Date : 26th-Jun-2017
        'Purpose : Excel Upload Div on Product Backlog Page.
        '***********************************************************************************
        Dim strHTML As New StringBuilder("")
        Dim strSQLQuery As String
        Dim drAttach As IDataReader
        Dim strOriginalFileName As String = ""
        Dim strSystemFileName As String = ""
        'strHTML.Append("<div class='import'>")
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='col-md-12'>")
        'strHTML.Append("<div class='bros-btn'>")
        'strHTML.Append("<div class='btn-group drp'>")
        'strHTML.Append(" <button type='button' class='btn src'>Browse</button>")
        'strHTML.Append(" <button type='button' class='btn dropdown-toggle dropdown-toggle-split' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>")
        'strHTML.Append("<span class='sr-only'>Toggle Dropdown</span>")
        'strHTML.Append("</button>")
        'strHTML.Append("<button type='button' class='btn updtae-btn' id='btnSave'  onclick=SaveExcelConfiguration()>Save</button>")
        ''onblur='()'
        'strHTML.Append("<div class='dropdown-menu'>")
        'strHTML.Append("<a class='dropdown-item' href='#'>Action</a>")
        'strHTML.Append(" </div>")
        'strHTML.Append("</div>	")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        ' strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-12'>")
        strHTML.Append("	<div class='preview-table'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-8'>	")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-7'>	")
        strHTML.Append("<h4 class='pre-title' style='font-size:12px'>Preview from <span style='font-weight:bold'>Column A - Column J</span> of uploaded excel</h4>	")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-md-5'>	")
        strHTML.Append(" <table class='tableHeader' style='vertical-align: top;'>")
        strHTML.Append("<tr>")
        strHTML.Append("<td style='vertical-align:top;padding-right: 4px;padding-top: 1px;'>")
        strHTML.Append("<div style='height:14px;width:14px;background-color:Green;border-radius: 3px;' ></div></td><td style='font-size:12px;padding-right:14px;'>Valid Row")
        strHTML.Append("</td>  ")
        strHTML.Append(" <td style='vertical-align:top;padding-right: 4px;padding-top: 1px;'>")
        strHTML.Append(" <div style='height:14px;width:14px;background-color:Red;border-radius: 3px;' ></div></td><td style='font-size:12px;padding-right:14px;'>Invalid Row")
        strHTML.Append(" </td>  ")
        strHTML.Append(" </tr>")
        strHTML.Append("</table>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''   strHTML.Append("	<h4 class='pre-title'>Preview (A - J)</h4>	")
        strHTML.Append("<div class='table-info' id='tblFileDetails'>	")
        '  strHTML.Append("<div  id='tblValidateFile'>	")
        'strHTML.Append("<table class='table table-hover'>")
        'strHTML.Append("<thead>")
        'strHTML.Append("  <tr>")
        'strHTML.Append("<th>Column1</th>")
        'strHTML.Append("<th>Column1</th>")
        'strHTML.Append("<th>Column1</th>")
        'strHTML.Append("<th>Column1</th>")
        'strHTML.Append("<th>Column1</th>")
        'strHTML.Append("</tr>")
        'strHTML.Append("</thead>")
        'strHTML.Append("<tbody>")
        'strHTML.Append(" <tr>")
        'strHTML.Append("<td>Field1</td>")
        'strHTML.Append("<td>Field2</td>")
        'strHTML.Append("<td>Field3</td>")
        'strHTML.Append("<td>Field4</td>")
        'strHTML.Append("<td>Field5</td>")
        'strHTML.Append(" </tr>")
        'strHTML.Append("</tbody>")
        'strHTML.Append("</table>")
        ' strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='col-md-4' >")
        strHTML.Append("<h4 class='pre-title' style='FONT-SIZE: 13PX;MARGIN-LEFT: -29PX;'>Excel Column Mapping</h4>	")
        strHTML.Append("<div class='col-table'  id='RequestColumsMapp'>")
        strHTML.Append("<div id='RequestColumsMappScroll'>")
        Dim arrColCaptions() As String = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"}
        ''Usp_NG2_Sel_tbl_NG2_CRM_RequestImport_Fields
        Dim strFieldQuery As String = "Usp_NG2_Sel_tbl_NG2_CRM_RequestFields "
        Dim drReader As DataTable
        Dim strFieldValue As String = ""
        Dim k As Integer = 1
        Dim dtTable As DataTable
        Dim strExcelFieldName As String
        Dim dr() As DataRow
        Dim strDetailsQuery As String = "Usp_NG2_Sel_tbl_NG2_CRM_RequestImport_Fields " & HttpContext.Current.Session("intUserID") & ""
        drReader = CommonFunctions.Data.GetDataTable(strDetailsQuery, True)
        dtTable = CommonFunctions.Data.GetDataTable(strFieldQuery, True)
        Dim flag As Integer = 0
        ' While drReader.Read
        For i As Integer = 0 To dtTable.Rows.Count - 1
            flag = 0
            ' strHTML.Append("<tr>")
            'For k = 1 To 12 Step 1
            'If (k = 1 Or k = 3 Or k = 5 Or k = 7 Or k = 9 Or k = 11) Then
            '    strHTML.Append("<tr>")
            'End If
            dr = drReader.Select("RequestFieldName= '" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") & "'")
            If dr.Length <> 0 Then
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(dr(0)("RequestFieldName"), "")
                strExcelFieldName = CommonFunctions.Data.CheckIsDBNull(dr(0)("ExcelFieldName"), "")
            Else
                strFieldValue = ""
                strExcelFieldName = ""
            End If
            If HttpContext.Current.Session("LoginType") = "C" Then
                If CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") = "OrganizationType" Then
                    flag = 1
                End If
                If CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") = "ExpDateOfResolution" Then
                    flag = 1
                End If
            End If
            If flag = 0 Then
                strHTML.Append("<div class='row'>")
                '   strHTML.Append("<div class='col-xs-4'>")
                strHTML.Append("<div class='col-xs-6'>")
                If CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") = "TicketID" Then
                    strHTML.Append("<label class='clslabelColumns' id='lblField_" & i & "' >Reference ID</label>")
                ElseIf CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") <> "Severity" And CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") <> "TicketID" And CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") <> "Description" Then
                    strHTML.Append("<label class='clslabelColumns' id='lblField_" & i & "' > " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldCaption").ToString, "") & "<span class='clsMandatoryCol'>*</span> </label>")
                Else
                    strHTML.Append("<label class='clslabelColumns' id='lblField_" & i & "' > " & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldCaption").ToString, "") & "</label>")
                End If
                If CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") <> "Severity" Then
                End If
                strHTML.Append("<input type=hidden name='hdnColumns' id=hdnColumns_" & i & " value=" & CommonFunctions.Data.CheckIsDBNull(dtTable.Rows(i)("FieldName").ToString, "") & ">")
                strHTML.Append("</div>")
                'strHTML.Append("<div class='col-xs-8'>")
                strHTML.Append("<div class='col-xs-6'>")
                Dim strColSQL As String = "Usp_NG2_Sel_tbl_NG2_CRM_RequestColumns"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestField_" & i, strColSQL, 110, strExcelFieldName, " class='form-control' ", False, True))
                'If strFieldValue = "Priority" Then
                '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUSField_" & k, "Usp_App_Sel_tbl_PM_PBScrumFields", 180, strFieldValue, "onchange='USField_OnChange(" & k & ")' class='form-control clsBorderRed' ", True, True))
                '    strHTML.Append("<span id='spnUSField_" & k & "' class='clsSpanColor' >Priority should be in 'Must Have','Should Have','Could Have','Wont Have' only in excel </span>")
                'Else
                '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboUSField_" & k, "Usp_App_Sel_tbl_PM_PBScrumFields", 180, strFieldValue, "onchange='USField_OnChange(" & k & ")' class='form-control'", True, True))
                '    strHTML.Append("<span id='spnUSField_" & k & "' class='clsSpanColor' ></span>")
                'End If
                strHTML.Append("</div>")
                ' If (k = 2 Or k = 4 Or k = 6 Or k = 8 Or k = 10 Or k = 12) Then
                strHTML.Append("</div>")
                'End If
                ''End While
                flag = 0
            End If
        Next
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='row'>")
        'strHTML.Append("<div class='col-xs-12'>")
        'strHTML.Append("<div class='bros-btn importbtn3'>")
        'strHTML.Append("<button  type='button' class='btn btn-default' style='background-color:#364660;color:white;font-weight:normal;' onclick='Import_Onclick()'>Import</button>")
        'strHTML.Append("<button  type='button' class='btn btn-default' style='background-color:#364660;color:white;font-weight:normal;' onclick='ValidateExcel_Onclick()'>Validate</button>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-xs-12'>")
        strHTML.Append("<div class='bros-btn importbtn3'>")
        strHTML.Append("<button  type='button' class='btn btn-default save' data-toggle='tooltip' data-placement='top' title='Import Excel Records' style='font-weight:normal;margin-left:5px;' onclick='Import_Onclick()'>Import</button>")
        strHTML.Append("<button  type='button' class='btn btn-default save'  data-toggle='tooltip' data-placement='top' title='Valiadte Excel Records' style='font-weight:normal;margin-left:5px;' onclick='ValidateExcel_Onclick()'>Validate</button>")
        strHTML.Append("<button  type='button'  class='btn btn-default save' title='Clear Column Mapping'  data-toggle='tooltip' data-placement='top' style='font-weight:normal;margin-left:5px;' onclick='ClearConfiguration_Onclick()'>Clear</button>")
        strHTML.Append("</div>")
        '  strHTML.Append("</div>	")
        '  strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveExcelConfiguration(ByVal arrPBFields As Object, ByVal arrExcelFields As Object) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim blnFlag As Boolean = False
            Dim intColumnCount As Integer = 0
            If HttpContext.Current.Session("LoginType") = "C" Then
                intColumnCount = 7
            Else
                intColumnCount = 9
            End If
            For k As Integer = 0 To intColumnCount Step 1
                Dim strPBFieldName As String = arrPBFields(k)
                Dim strExcelFieldName As String = arrExcelFields(k)
                If strPBFieldName = "Select Column" Then
                    strPBFieldName = ""
                End If
                Dim strSQLQuery As String = "Usp_NG2_Ins_Upd_tbl_NG2_CRM_RequestImport_Fields '" & strPBFieldName & "','" & strExcelFieldName & "'," & HttpContext.Current.Session("intUserID").ToString & ",'" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
                blnFlag = True
            Next
            If blnFlag = True Then
                Return "1"
            Else
                Return "0"
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetImportDetails() As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetImportDetails
        ' Description           : To  get list of attachments againsts requests
        ' Created Date           : 13th-Oct-2017
        '=====================================================================
        Try
            Dim objCRM_RequestListsNew As New CRM_UnCategorizedRequestList
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objCRM_RequestListsNew.DrawExcelUploadDiv())
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Private Function ReadExcelData(ByVal strAttachmentID As String, ByVal UploadedFilePath As String, ByVal OriginalFileName As String)
    '    '==================================================================================
    '    ' Function Name     :   ReadExcelData
    '    ' Purpose           :   Getting dataset for the excel file data
    '    ' Author            :   BharatT
    '    ' Created On        :   27th-Jun-2017
    '    '==================================================================================
    '    Dim strConnectionString As String = ""
    '    Dim strSQL As String
    '    Dim intCounter As Integer
    '    Dim objConn As New ADODB.Connection
    '    Dim objExcel As New ADOX.Catalog
    '    Dim strExcelData As New StringBuilder("")
    '    Response.Clear()
    '    Try
    '        'Establishing the connection with the Source Excel file.
    '        Dim checkExtension As String = System.IO.Path.GetExtension(UploadedFilePath)
    '        '' for [OS compatibility]
    '        If Environment.Is64BitOperatingSystem = True Then
    '            strConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 12.0;Xml;HDR=No;IMEX=1"""
    '        Else
    '            If checkExtension.ToString = ".xls" Then
    '                strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 8.0;Xml;HDR=No;IMEX=1"""
    '            ElseIf checkExtension.ToString = ".xlsx" Then
    '                strConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 12.0;Xml;HDR=No;IMEX=1"""
    '            End If
    '        End If
    '        m_objOLEConnection = New OleDbConnection
    '        m_objOLEConnection.ConnectionString = strConnectionString
    '        m_objOLEConnection.Open()
    '        m_objOLECommand = New OleDbCommand
    '        m_objOLECommand.Connection = m_objOLEConnection
    '        m_objOLEAdapter = New OleDbDataAdapter(m_objOLECommand)
    '        m_objDataSet = New DataSet
    '        'Getting the name of the Excel WorkSeheet through ADOX.Catalog
    '        objConn.ConnectionString = strConnectionString
    '        objConn.Open()
    '        objExcel.ActiveConnection = objConn
    '        Dim myTableName = m_objOLEConnection.GetSchema("Tables").Rows(0)("TABLE_NAME")
    '        Dim intFieldCount As Integer
    '        Dim intDataTableColumn As Integer
    '        'Getting all the column names from the source excel file.
    '        'strSQL = "Select * from [" & myTableName & "]"
    '        strSQL = "Select * from [" & myTableName & "]"
    '        m_objOLECommand.CommandText = strSQL
    '        m_objOLEDataReader = m_objOLECommand.ExecuteReader(CommandBehavior.SingleResult)
    '        intFieldCount = m_objOLEDataReader.FieldCount
    '        'Filling the SourceColumns global array.
    '        ReDim m_arrSourceColumns(m_objOLEDataReader.FieldCount - 1)
    '        For intCounter = 0 To m_objOLEDataReader.FieldCount - 1
    '            m_arrSourceColumns(intCounter) = m_objOLEDataReader.GetName(intCounter)
    '        Next
    '        m_objOLEDataReader.Close()
    '        m_objOLEDataReader = Nothing
    '        'Filling the global dataset with all the source data.
    '        m_objOLEAdapter.Fill(m_objDataSet)
    '        For k As Int16 = intFieldCount + 1 To 12
    '            m_objDataSet.Tables(0).Columns.Add("F" & k)
    '        Next
    '        Dim strQuery As String = ""
    '        Dim drExceField As IDataReader
    '        Dim FieldDictionary As New System.Collections.Specialized.StringDictionary
    '        Dim FieldCaptionDictionary As New System.Collections.Specialized.StringDictionary
    '        '  Dim arrColCaptions() As String = {"TicketID", "Subject", "Description", "Department", "RequestType", "SubRequestType", "Priority", "Severity", "Oraganization Type", "Exp. Date Of Resolution"}
    '        Dim arrColCaptions() As String = {"Column A", "Column B", "Column C", "Column D", "Column E", "Column F", "Column G", "Column H", "Column I", "Column J"}
    '        Dim strFieldName As String
    '        Dim errMsg As String = ""
    '        Dim strQueryData As New StringBuilder("")
    '        Dim strExcelValidateData As New StringBuilder("")
    '        Dim strTableHeaderHTML As New StringBuilder("")
    '        Dim strTempQuery As String
    '        Dim strTDData As String = ""
    '        strQuery = "Usp_NG2_Sel_tbl_NG2_CRM_RequestImport_Fields "
    '        drExceField = CommonFunctions.Data.GetDataReader(strQuery, True)
    '        While drExceField.Read
    '            If CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")) <> "" Then
    '                FieldDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")))
    '                FieldCaptionDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("FieldCaption")))
    '            End If
    '        End While
    '        ''  strExcelData.Append("<div id='excelDataDivInner' >")
    '        strExcelData.Append("<input type=hidden id='hdnAttachmentID' value='" & strAttachmentID & "' >")
    '        '' strExcelData.Append("<table class='table' border='1' style='border:1px solid #ddd; border-color:#ddd;'>")
    '        strExcelData.Append("<table class='table table-hover'>")
    '        '  strExcelData.Append("<thead>")
    '        '  strExcelData.Append("  <tr>")
    '        'strExcelData.Append("<th>Column1</th>")
    '        'strExcelData.Append("<th>Column1</th>")
    '        'strExcelData.Append("<th>Column1</th>")
    '        'strExcelData.Append("<th>Column1</th>")
    '        'strExcelData.Append("<th>Column1</th>")
    '        'strExcelData.Append("</tr>")
    '        'strExcelData.Append("</thead>")
    '        'strExcelData.Append("<tbody>")
    '        'strExcelData.Append(" <tr>")
    '        'strExcelData.Append("<td>Field1</td>")
    '        'strExcelData.Append("<td>Field2</td>")
    '        'strExcelData.Append("<td>Field3</td>")
    '        'strExcelData.Append("<td>Field4</td>")
    '        'strExcelData.Append("<td>Field5</td>")
    '        'strExcelData.Append(" </tr>")
    '        'strExcelData.Append("</tbody>")
    '        'strExcelData.Append("</table>")
    '        strTableHeaderHTML.Append("<thead>")
    '        ' If strTableHeaderHTML IsNot Nothing Then
    '        ' strTableHeaderHTML.Append("<TH style='width:2%;text-align:center;'>Is Valid</TH>")
    '        ' End If
    '        strTableHeaderHTML.Append("  <tr>")
    '        For Each drPBUS As DataRow In m_objDataSet.Tables(0).Rows
    '            errMsg = ""
    '            strQueryData.Clear()
    '            strExcelValidateData.Clear()
    '            'strQueryData.Append("Usp_App_Ins_tbl_PM_PBUserStories_Temp " & strAttachmentID)               
    '            '    For j As Integer = 0 To 11
    '            For j As Integer = 0 To 9
    '                strFieldName = FieldDictionary.Item(arrColCaptions(j))
    '                strQueryData.Append(",'" & CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j))).Replace("'", "''") & "'")
    '                strTDData = CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j)))
    '                If strTableHeaderHTML IsNot Nothing Then
    '                    ' If strFieldName <> "" Then
    '                    strTableHeaderHTML.Append("<TH align=center >" & FieldCaptionDictionary(strFieldName) & "</TH>")
    '                    'Else
    '                    '  strTableHeaderHTML.Append("<TH align=center ></TH>")
    '                    'End If
    '                End If
    '                Select Case strFieldName
    '                    Case "TicketID"
    '                        If strTDData = "" Then
    '                            errMsg &= "<li> Ticket ID is mandatory. </li>" & vbCrLf
    '                        End If
    '                    Case "Subject"
    '                        If strTDData = "" Then
    '                            errMsg &= "<li> Subject is mandatory.</li>" & vbCrLf
    '                        End If
    '                        'Case "Description"
    '                        '    If strTDData.Length > 200 Then
    '                        '        errMsg &= "<li> Acceptance Criteria should not exceed 200 characters.</li>" & vbCrLf
    '                        '    End If
    '                    Case "Priority"
    '                        If (strTDData = "") Then
    '                            errMsg &= "<li> Priority should not left blank.</li>" & vbCrLf
    '                        End If
    '                    Case "Severity"
    '                        If (strTDData = "") Then
    '                            errMsg &= "<li> Severity should not left blank.</li>" & vbCrLf
    '                        End If
    '                        'Case "OrganizationType"
    '                        '    If strTDData.Length > 50 Then
    '                        '        errMsg &= "<li> Complexity should not exceed 50 characters.</li>" & vbCrLf
    '                        '    End If
    '                    Case "Department"
    '                        Dim strSQLToValidate As String = ""
    '                        Dim strResult As String = ""
    '                        Dim dr As IDataReader
    '                        If strTDData = "" Then
    '                            errMsg &= "<li> Department should not be left blank.</li>" & vbCrLf
    '                        End If
    '                        strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'Department'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','Department'"
    '                        '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
    '                        dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
    '                        If dr.Read Then
    '                            strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
    '                        End If
    '                        CommonFunctions.Data.DisposeDataReader(dr)
    '                        If strResult = "0" Then
    '                            errMsg &= "<li> Department is not valid.</li>" & vbCrLf
    '                        End If
    '                    Case "RequestType"
    '                        Dim strSQLToValidate As String = ""
    '                        Dim strResult As String = ""
    '                        errMsg &= "<li> Request Type data is not matched with existing data.</li>" & vbCrLf
    '                    Case "SubRequestType"
    '                        Dim strSQLToValidate As String = ""
    '                        Dim strResult As String = ""
    '                        errMsg &= "<li> Sub Request Type field data is not matched with existing data.</li>" & vbCrLf
    '                    Case "ExpDateOfResolution"
    '                        If (strTDData = "") Then
    '                            errMsg &= "<li> Exp. Date Of Resolution should not left blank.</li>" & vbCrLf
    '                        End If
    '                End Select
    '                ' strExcelValidateData.Append("<td title='" & strFieldName & "' >")
    '                strExcelValidateData.Append("<td >")
    '                strExcelValidateData.Append(strTDData)
    '                strExcelValidateData.Append("</td>")
    '            Next
    '            If strTableHeaderHTML IsNot Nothing Then
    '                strTableHeaderHTML.Append("<TH>Errors</TH>")
    '                strTableHeaderHTML.Append("</tr>")
    '                strTableHeaderHTML.Append("</thead>")
    '                strTableHeaderHTML.Append("<tbody>")
    '                strExcelData.Append(strTableHeaderHTML.ToString)
    '                strTableHeaderHTML = Nothing
    '            End If
    '            strTempQuery = "Usp_NG2_Ins_tbl_NG2_CRM_ImportRequest_Temp " & strAttachmentID
    '            'If errMsg = "" Then
    '            '    strTempQuery &= ",1"
    '            '    strExcelData.Append("<tr class='clsValidRow'>") '
    '            '    strExcelData.Append("<td  class='clsvalidRowIndication' >")
    '            '    strExcelData.Append("<input type=checkbox id='chkUS' id='chkUS' checked disabled />")
    '            '    strExcelData.Append("</td>")
    '            'Else
    '            '    strTempQuery &= ",0"
    '            '    strExcelData.Append("<tr class='clsInValidRow' >")
    '            '    strExcelData.Append("<td  class='clsInvalidRowIndication'>")
    '            '    strExcelData.Append("<input type=checkbox id='chkUS' id='chkUS' disabled />")
    '            '    strExcelData.Append("</td>")
    '            'End If
    '            strExcelData.Append(strExcelValidateData.ToString)
    '            strTempQuery &= strQueryData.ToString
    '            Try
    '                'Insert Excel Row into the table
    '                CommonFunctions.Data.InsertOrUpdateData(strTempQuery, True)
    '            Catch ex As Exception
    '                Response.Write(ex.Message)
    '            End Try
    '            strTempQuery = ""
    '            strExcelData.Append("<td title='Error Description' style='white-space:nowrap;' >")
    '            strExcelData.Append("<ul class='clsErrorDesc' >" & errMsg & "</ul>")
    '            strExcelData.Append("</td>")
    '            strExcelData.Append("</tr>")
    '        Next
    '        strExcelData.Append("</tbody>")
    '        strExcelData.Append("</table>")
    '        '' strExcelData.Append("</div>")
    '        '  strExcelData.Append("</Div></Div></Div></Div></Div></Div></Div>") 'End accordian to container
    '        Response.Write(strExcelData.ToString)
    '        Response.End()
    '        'Dim sqlcmd As New SqlCommand("Usp_App_Ins_tbl_PM_PBUserStories_Temp")
    '        'sqlcmd.Parameters.AddWithValue("@tblPBUserStories", m_objDataSet.Tables(0))
    '        'sqlcmd.Parameters.AddWithValue("@intAttachmentID", strAttachmentID)
    '        'sqlcmd.CommandType = CommandType.StoredProcedure
    '        'CommonFunction.Data.GetSQLCommandExecute(sqlcmd, True)
    '        If m_objOLEDataReader.IsClosed = False Then
    '            m_objOLEDataReader.Close()
    '            m_objOLEDataReader = Nothing
    '        End If
    '        'If objRequestInfo.m_intEndRow = 0 Then objRequestInfo.m_intEndRow = m_objDataSet.Tables(0).Rows.Count
    '        'objRequestInfo.m_intTotalRecords = m_objDataSet.Tables(0).Rows.Count
    '        If objConn.State = ConnectionState.Open Then
    '            objConn.Close()
    '            objConn = Nothing
    '        End If
    '    Catch ex As Exception
    '        If objConn.State = ConnectionState.Open Then
    '            objConn.Close()
    '            objConn = Nothing
    '        End If
    '        If m_objOLEDataReader.IsClosed = False Then
    '            m_objOLEDataReader.Close()
    '            m_objOLEDataReader = Nothing
    '        End If
    '        Return ex.Message
    '    End Try
    'End Function
    Private Function ValidateExcelData(ByVal strAttachmentID As String, ByVal ValidateClicked As String)
        '==================================================================================
        ' Function Name     :   ReadExcelData
        ' Purpose           :   Getting dataset for the excel file data
        ' Author            :   Vidya Jadhav
        ' Created On        :   30 Oct 2017
        '==================================================================================
        Dim strConnectionString As String = ""
        Dim strSQL As String
        Dim intCounter As Integer
        Dim objConn As New ADODB.Connection
        Dim objExcel As New ADOX.Catalog
        Dim strExcelData As New StringBuilder("")
        Dim intCount As Integer = 0
        Try
            Dim strQuery As String = ""
            Dim drExceField As IDataReader
            Dim FieldDictionary As New System.Collections.Specialized.StringDictionary
            Dim FieldCaptionDictionary As New System.Collections.Specialized.StringDictionary
            Dim arrColCaptions1() As String = {"Column A", "Column B", "Column C", "Column D", "Column E", "Column F", "Column G", "Column H", "Column I", "Column J"}
            Dim arrColCaptions() As String = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"}
            Dim strFieldName As String
            Dim errMsg As String = ""
            Dim strQueryData As New StringBuilder("")
            Dim strExcelValidateData As New StringBuilder("")
            Dim strTableHeaderHTML As New StringBuilder("")
            Dim strTempQuery As String
            Dim strTDData As String = ""
            Dim strdataSql As String = ""
            Dim strDataReader As DataTable
            Dim strRequestIds As Integer
            Dim strSubRequestType As String = ""
            Dim strDepartment As String = ""
            Dim strRequestType As String = ""
            Dim ValidDepartment As String = ""
            Dim strHeaderDataReader As DataTable
            Dim ValidHeader As String = ""
            Dim CounterRow As Integer = 0
            strQuery = "Usp_NG2_Sel_tbl_NG2_CRM_RequestImport_Fields " & HttpContext.Current.Session("intUserID") & ""
            drExceField = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drExceField.Read
                If CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")) <> "" Then
                    FieldDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")))
                    FieldCaptionDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("FieldCaption")))
                End If
            End While
            strExcelData.Append("<div  id='tblValidateFile'>")
            strExcelData.Append("<input type=hidden id='hdnAttachmentID' value='" & strAttachmentID & "' >")
            strExcelData.Append("<table class='table table-hover'  style='border:1px solid #ddd; border-color:#ddd;'>")
            ''strExcelData.Append("<table class='table table-hover'>")
            strTableHeaderHTML.Append("<thead>")
            strTableHeaderHTML.Append("  <tr>")
            If strTableHeaderHTML IsNot Nothing Then
                ''   strTableHeaderHTML.Append("<TH style='width:2%;text-align:center;' class='FixedTD'>Is Valid</TH>")
                strTableHeaderHTML.Append("<TH style='width:2%;text-align:center;' class='FixedTD'><input type=checkbox name='chkRequestAll' id='chkRequestAll' onclick='SelectAllValidRequest()' /></TH>")
            End If
            '       For Each drPBUS As DataRow In m_objDataSet.Tables(0).Rows
            strDataReader = CommonFunction.Data.GetDataTable("Usp_NG2_SEL_tbl_NG2_CRM_ImportRequest_Temp " & strAttachmentID & "", True)
            CounterRow = 0
            For Each drPBUS As DataRow In strDataReader.Rows
                errMsg = ""
                Dim FlagValidRequest As Integer = 0
                Dim FlagValidSubRequest As Integer = 0
                strQueryData.Clear()
                strExcelValidateData.Clear()
                Dim Str
                'strQueryData.Append("Usp_App_Ins_tbl_PM_PBUserStories_Temp " & strAttachmentID)               
                '    For j As Integer = 0 To 11
                For j As Integer = 0 To 9
                    strFieldName = FieldDictionary.Item(arrColCaptions1(j))
                    strQueryData.Append(",'" & CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j + 1))).Replace("'", "''") & "'")
                    strRequestIds = CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(0)))
                    strTDData = CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j + 1))).Replace("'", "''")
                    If strTableHeaderHTML IsNot Nothing Then
                        ' If strFieldName <> "" Then
                        strTableHeaderHTML.Append("<TH align=center class='FixedTD'>" & arrColCaptions(j) & "</TH>")
                        'Else
                        '  strTableHeaderHTML.Append("<TH align=center ></TH>")
                        'End If
                    End If
                    'If j = 0 Then
                    '    strHeaderDataReader = CommonFunction.Data.GetDataTable("usp_NG2_Sel_ValidHeader_tbl_NG2_CRM_ImportRequests_Temp  " & strRequestIds & ", " & strAttachmentID & "", True)
                    '    For i As Integer = 0 To strHeaderDataReader.Rows.Count - 1
                    '        ValidHeader = CommonFunctions.Data.CheckIsDBNull(strHeaderDataReader.Rows(i)("ValidHeader").ToString, "")
                    '    Next
                    'End If
                    'If ValidHeader = "1" And j = 0 Then
                    '    errMsg &= "<li>This can be expected header</li>" & vbCrLf
                    'Else
                    Select Case strFieldName
                        Case "TicketID"
                            If strTDData = "" Then
                                ' errMsg &= "<li> Ticket ID is mandatory. </li>" & vbCrLf
                            End If
                        Case "Subject"
                            If strTDData = "" Then
                                errMsg &= "<li> Subject is mandatory.</li>" & vbCrLf
                            End If
                            'Case "Description"
                            '    If strTDData.Length > 200 Then
                            '        errMsg &= "<li> Acceptance Criteria should not exceed 200 characters.</li>" & vbCrLf
                            '    End If
                        Case "Priority"
                            Dim strSQLToValidate As String = ""
                            Dim strResult As String = ""
                            Dim dr As IDataReader
                            Dim Flag As Integer = 0
                            If (strTDData = "") Then
                                errMsg &= "<li> Priority should not left blank.</li>" & vbCrLf
                                Flag = 1
                            End If
                            If Flag = 0 Then
                                ''  strDepartment = ""
                                strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'Priority'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','Priority','" & strDepartment & "',NULL"
                                '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                If dr.Read Then
                                    strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                End If
                                CommonFunctions.Data.DisposeDataReader(dr)
                                If strResult = "0" Then
                                    errMsg &= "<li> Priority is not valid.</li>" & vbCrLf
                                End If
                            End If
                        Case "Severity"
                            Dim strSQLToValidate As String = ""
                            Dim strResult As String = ""
                            Dim dr As IDataReader
                            Dim Flag As Integer = 0
                            'If (strTDData = "") Then
                            '    errMsg &= "<li> Severity should not left blank.</li>" & vbCrLf
                            '    Flag = 1
                            'End If
                            If (strTDData <> "") Then
                                If Flag = 0 Then
                                    ''strDepartment = ""
                                    strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'Severity'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','Severity','" & strDepartment & "',NULL"
                                    '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    If dr.Read Then
                                        strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(dr)
                                    If strResult = "0" Then
                                        errMsg &= "<li> Severity is not valid.</li>" & vbCrLf
                                    End If
                                End If
                            End If
                        Case "Department"
                            Dim strSQLToValidate As String = ""
                            Dim strResult As String = ""
                            Dim dr As IDataReader
                            Dim Flag As Integer = 0
                            If strTDData = "" Then
                                errMsg &= "<li> Department should not be left blank.</li>" & vbCrLf
                                Flag = 1
                            End If
                            If Flag = 0 Then
                                strDepartment = strTDData
                                strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'Department'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','Department','" & strDepartment & "',NULL"
                                '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                If dr.Read Then
                                    strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                End If
                                CommonFunctions.Data.DisposeDataReader(dr)
                                If strResult = "1" Then
                                    ValidDepartment = "1"
                                End If
                                If strResult = "0" Then
                                    errMsg &= "<li> Department is not valid.</li>" & vbCrLf
                                End If
                            End If
                        Case "RequestType"
                            Dim strSQLToValidate As String = ""
                            Dim strResult As String = ""
                            Dim Flag As Integer = 0
                            Dim dr As IDataReader
                            If strTDData = "" Then
                                errMsg &= "<li> Request Type should not be left blank.</li>" & vbCrLf
                                Flag = 1
                            End If
                            If Flag = 0 Then
                                strRequestType = strTDData
                                'strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'RequestType'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','RequestType','" & strDepartment & "',NULL"
                                ' '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                'dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                'If dr.Read Then
                                '    strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                'End If
                                'CommonFunctions.Data.DisposeDataReader(dr)
                                'If strResult = "0" Then
                                '    errMsg &= "<li> Request Type data is not matched with existing data.</li>" & vbCrLf
                                'End If
                            End If
                        Case "SubRequestType"
                            Dim strSQLToValidate As String = ""
                            Dim strResult As String = ""
                            Dim Flag As Integer = 0
                            Dim dr As IDataReader
                            If strTDData = "" Then
                                errMsg &= "<li>Sub Request Type should not be left blank.</li>" & vbCrLf
                                Flag = 1
                            End If
                            If Flag = 0 Then
                                strSubRequestType = strTDData
                                'strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'SubRequestType'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','SubRequestType','" & strDepartment & "','" & strRequestType & "'"
                                ' '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                'dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                'If dr.Read Then
                                '    strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                'End If
                                'CommonFunctions.Data.DisposeDataReader(dr)
                                'If strResult = "0" Then
                                '    errMsg &= "<li>Sub Request Type data is not matched with existing data.</li>" & vbCrLf
                                'End If
                            End If
                        Case "ExpDateOfResolution"
                            Dim Flag As Integer = 0
                            Dim strSQLToValidate As String = ""
                            Dim dr As IDataReader
                            Dim strResult As String = ""
                            Dim strDateData As String = ""
                            If HttpContext.Current.Session("LoginType") = "E" Then
                                If (strTDData = "") Then
                                    errMsg &= "<li> Exp. Date Of Resolution should not left blank.</li>" & vbCrLf
                                Else
                                    Try
                                        strDateData = DateTime.Parse(strTDData).ToString()
                                        Flag = 1
                                    Catch
                                        errMsg &= "<li> Please check the date format in excel!</li>" & vbCrLf
                                        Flag = 0
                                    End Try
                                    If Flag = 1 Then
                                        strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'ExpDateOfResolution'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','ExpDateOfResolution','" & strDepartment & "',NULL"
                                        '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                        dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                        If dr.Read Then
                                            strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                        End If
                                        CommonFunctions.Data.DisposeDataReader(dr)
                                        If strResult = "0" Then
                                            errMsg &= "<li> Please enter date greater than or equal to the current date!</li>" & vbCrLf
                                        End If
                                    End If
                                End If
                            End If
                        Case "OrganizationType"
                            If HttpContext.Current.Session("LoginType") = "E" Then
                                Dim strSQLToValidate As String = ""
                                Dim strResult As String = ""
                                Dim dr As IDataReader
                                Dim Flag As Integer = 0
                                If (strTDData = "") Then
                                    errMsg &= "<li> Organization Unit should not left blank.</li>" & vbCrLf
                                End If
                                If Flag = 0 Then
                                    strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'OrganizationType'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','OrganizationType','" & strDepartment & "',NULL"
                                    '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    If dr.Read Then
                                        strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(dr)
                                    If strResult = "0" Then
                                        errMsg &= "<li> Organization Unit is not valid.</li>" & vbCrLf
                                    End If
                                End If
                            End If
                    End Select
                    ''       End If
                    Dim strSQLToValidates As String = ""
                    Dim drValidates As IDataReader
                    Dim strResults As String = ""
                    Dim RequestType As String = ""
                    Dim SubRequestType As String = ""
                    ''  If ValidHeader <> "1" Then
                    If ValidDepartment = "1" And (strRequestType <> "" And strSubRequestType <> "") Then
                        strSQLToValidates = "Usp_NG2_Sel_ValiadteDependentRequestFromExcel  " & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strDepartment & "','" & strRequestType & "','" & strSubRequestType & "'"
                        '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                        drValidates = CommonFunctions.Data.GetDataReader(strSQLToValidates, True)
                        If drValidates.Read Then
                            RequestType = CType(CommonFunctions.Data.CheckIsDBNull(drValidates("RequestType"), "0"), String)
                            SubRequestType = CType(CommonFunctions.Data.CheckIsDBNull(drValidates("SubRequestType"), "0"), String)
                        End If
                        CommonFunctions.Data.DisposeDataReader(drValidates)
                        If RequestType = "0" Then
                            ' If FlagValidRequest = 0 Then
                            errMsg &= "<li>  Request Type data is not matched with existing data.</li>" & vbCrLf
                            FlagValidRequest = 1
                            'End If
                        End If
                        If SubRequestType = "0" Then
                            '    If FlagValidSubRequest = 0 Then
                            errMsg &= "<li> Sub Request Type data is not matched with existing data.</li>" & vbCrLf
                            FlagValidSubRequest = 1
                            'End If
                        End If
                    End If
                    If CounterRow = 0 And errMsg <> "" Then
                        errMsg = ""
                        errMsg &= "<li>This may be expected header.</li>" & vbCrLf
                    End If
                    ''  End If
                    ' strExcelValidateData.Append("<td title='" & strFieldName & "' >")
                    strExcelValidateData.Append("<td >")
                    strExcelValidateData.Append(strTDData)
                    strExcelValidateData.Append("</td>")
                Next
                If strTableHeaderHTML IsNot Nothing Then
                    strTableHeaderHTML.Append("<TH class='FixedTD'>Errors</TH>")
                    strTableHeaderHTML.Append("</tr>")
                    strTableHeaderHTML.Append("</thead>")
                    strTableHeaderHTML.Append("<tbody>")
                    strExcelData.Append(strTableHeaderHTML.ToString)
                    strTableHeaderHTML = Nothing
                End If
                Dim RequestUniqueID As Integer
                strTempQuery = "Usp_NG2_Ins_tbl_NG2_CRM_ImportRequest_Temp " & strAttachmentID
                strTempQuery &= "," & strRequestIds & ""
                If errMsg = "" Then
                    strTempQuery &= ",1"
                Else
                    strTempQuery &= ",0"
                End If
                strTempQuery &= "," & HttpContext.Current.Session("intUserID")
                strTempQuery &= ",'" & HttpContext.Current.Session("strUserName").ToString & "'"
                strTempQuery &= ",'" & HttpContext.Current.Session("LoginType").ToString & "'"
                strTempQuery &= ",NULL"
                strTempQuery &= strQueryData.ToString
                Try
                    'Insert Excel Row into the table
                    ''CommonFunctions.Data.InsertOrUpdateData(strTempQuery, True)
                    Dim drRequestIDs As IDataReader
                    Dim ApprovalStatusForEmail As String
                    drRequestIDs = CommonFunction.Data.GetDataReader(strTempQuery, True)
                    If drRequestIDs.Read() Then
                        RequestUniqueID = drRequestIDs("UniqueID").ToString()
                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequestIDs)
                Catch ex As Exception
                End Try
                If errMsg = "" Then
                    strExcelData.Append("<input type=hidden name='hdnvalidRow' id='hdnvalidRow' value='1' >")
                    strExcelData.Append("<tr class='clsValidRow'>") '
                    strExcelData.Append("<td  class='clsvalidRowIndication' >")
                    strExcelData.Append("<input type=checkbox name='chkRequest' id='chkRequest_" & intCount & "' disabled checked value=" & RequestUniqueID & "  />")
                    strExcelData.Append("</td>")
                Else
                    strExcelData.Append("<input type=hidden name='hdnInvalidRow' id='hdnInvalidRow' value='0' >")
                    strExcelData.Append("<tr class='clsInValidRow' >")
                    strExcelData.Append("<td  class='clsInvalidRowIndication'>")
                    strExcelData.Append("<input type=checkbox name='chkRequest' id='chkRequest_" & intCount & "' disabled value=" & RequestUniqueID & " />")
                    strExcelData.Append("</td>")
                End If
                strExcelData.Append(strExcelValidateData.ToString)
                strTempQuery = ""
                strExcelData.Append("<td title='Error Description' style='white-space:nowrap;' >")
                strExcelData.Append("<ul class='clsErrorDesc' >" & errMsg & "</ul>")
                strExcelData.Append("</td>")
                strExcelData.Append("</tr>")
                intCount = intCount + 1
                CounterRow = CounterRow + 1
            Next
            strExcelData.Append("</tbody>")
            strExcelData.Append("</table>")
            strExcelData.Append("</div>")
            '  strExcelData.Append("</Div></Div></Div></Div></Div></Div></Div>") 'End accordian to container
        Catch ex As Exception
            Return ex.Message
        End Try
        Return strExcelData.ToString
    End Function
    Private Function ValidateExcelDataToSelect(ByVal strAttachmentID As String, ByVal ValidateClicked As String)
        '==================================================================================
        ' Function Name     :   ReadExcelD
        ' Purpose           :   Getting dataset for the excel file data
        ' Author            :   Vidya Jadhav
        ' Created On        :   30 Oct 2017
        '==================================================================================
        Dim strConnectionString As String = ""
        Dim strSQL As String
        Dim intCounter As Integer
        Dim objConn As New ADODB.Connection
        Dim objExcel As New ADOX.Catalog
        Dim strExcelData As New StringBuilder("")
        Dim intCount As Integer = 0
        ''Response.Clear()
        Dim strExceptionMsg As String = ""
        Try
            Dim strQuery As String = ""
            Dim drExceField As IDataReader
            Dim FieldDictionary As New System.Collections.Specialized.StringDictionary
            Dim FieldCaptionDictionary As New System.Collections.Specialized.StringDictionary
            Dim arrColCaptions1() As String = {"Column A", "Column B", "Column C", "Column D", "Column E", "Column F", "Column G", "Column H", "Column I", "Column J"}
            Dim arrColCaptions() As String = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"}
            Dim strFieldName As String
            Dim errMsg As String = ""
            Dim strQueryData As New StringBuilder("")
            Dim strExcelValidateData As New StringBuilder("")
            Dim strTableHeaderHTML As New StringBuilder("")
            Dim strTempQuery As String
            Dim strTDData As String = ""
            Dim strdataSql As String = ""
            Dim strDataReader As DataTable
            Dim strRequestIds As Integer
            '  Dim strSubRequestType As String = ""
            Dim strDepartment As String = ""
            '   Dim strRequestType As String = ""
            Dim ValidDepartment As String = ""
            Dim strHeaderDataReader As DataTable
            Dim ValidHeader As String = ""
            Dim ValidDone As String = "0"
            Dim CounterRow As Integer = 0
            strQuery = "Usp_NG2_Sel_tbl_NG2_CRM_RequestImport_Fields " & HttpContext.Current.Session("intUserID") & ""
            drExceField = CommonFunctions.Data.GetDataReader(strQuery, True)
            While drExceField.Read
                If CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")) <> "" Then
                    FieldDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")))
                    FieldCaptionDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("FieldCaption")))
                End If
            End While
            strExcelData.Append("<div  id='tblValidateFile'>")
            strExcelData.Append("<input type=hidden id='hdnAttachmentID' value='" & strAttachmentID & "' >")
            strExcelData.Append("<table class='table table-hover'  style='border:1px solid #ddd; border-color:#ddd;'>")
            ''strExcelData.Append("<table class='table table-hover'>")
            strTableHeaderHTML.Append("<thead>")
            strTableHeaderHTML.Append("  <tr>")
            If strTableHeaderHTML IsNot Nothing Then
                ''strTableHeaderHTML.Append("<TH style='width:2%;text-align:center;' class='FixedTD'>Is Valid</TH>")
                strTableHeaderHTML.Append("<TH style='width:2%;text-align:center;' class='FixedTD'><input type=checkbox name='chkRequestAll' id='chkRequestAll' onclick='SelectAllValidRequest()'/></TH>")
            End If
            '       For Each drPBUS As DataRow In m_objDataSet.Tables(0).Rows
            strDataReader = CommonFunction.Data.GetDataTable("Usp_NG2_SEL_tbl_NG2_CRM_ImportRequest_Temp " & strAttachmentID & "", True)
            CounterRow = 0
            For Each drPBUS As DataRow In strDataReader.Rows
                errMsg = ""
                Dim strSubRequestType As String = ""
                Dim strRequestType As String = ""
                Dim FlagValidRequest As Integer = 0
                Dim FlagValidSubRequest As Integer = 0
                strQueryData.Clear()
                strExcelValidateData.Clear()
                Dim Str
                'strQueryData.Append("Usp_App_Ins_tbl_PM_PBUserStories_Temp " & strAttachmentID)               
                '    For j As Integer = 0 To 11
                For j As Integer = 0 To 9
                    strFieldName = FieldDictionary.Item(arrColCaptions1(j))
                    strQueryData.Append(",'" & CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j + 1))).Replace("'", "''") & "'")
                    strRequestIds = CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(0)))
                    strTDData = CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j + 1))).Replace("'", "''")
                    Try
                        If strTableHeaderHTML IsNot Nothing Then
                            ' If strFieldName <> "" Then
                            strTableHeaderHTML.Append("<TH align=center class='FixedTD'>" & arrColCaptions(j) & "</TH>")
                            'Else
                            '  strTableHeaderHTML.Append("<TH align=center ></TH>")
                            'End If
                        End If
                        'If j = 0 Then
                        '    strHeaderDataReader = CommonFunction.Data.GetDataTable("usp_NG2_Sel_ValidHeader_tbl_NG2_CRM_ImportRequests_Temp  " & strRequestIds & ", " & strAttachmentID & "", True)
                        '    For i As Integer = 0 To strHeaderDataReader.Rows.Count - 1
                        '        ValidHeader = CommonFunctions.Data.CheckIsDBNull(strHeaderDataReader.Rows(i)("ValidHeader").ToString, "")
                        '        ValidDone = "1"
                        '    Next
                        'End If
                        'If ValidHeader = "1" And j = 0 Then
                        '    errMsg &= "<li>This can be expected header</li>" & vbCrLf
                        'ElseIf ValidDone = "0" Then
                        Select Case strFieldName
                            Case "TicketID"
                                If strTDData = "" Then
                                    '  errMsg &= "<li> Ticket ID is mandatory. </li>" & vbCrLf
                                End If
                            Case "Subject"
                                If strTDData = "" Then
                                    errMsg &= "<li> Subject is mandatory.</li>" & vbCrLf
                                End If
                                'Case "Description"
                                '    If strTDData.Length > 200 Then
                                '        errMsg &= "<li> Acceptance Criteria should not exceed 200 characters.</li>" & vbCrLf
                                '    End If
                            Case "Priority"
                                Dim strSQLToValidate As String = ""
                                Dim strResult As String = ""
                                Dim dr As IDataReader
                                Dim Flag As Integer = 0
                                If (strTDData = "") Then
                                    errMsg &= "<li> Priority should not left blank.</li>" & vbCrLf
                                    Flag = 1
                                End If
                                If Flag = 0 Then
                                    ''     strDepartment = ""
                                    strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'Priority'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','Priority','" & strDepartment & "',NULL"
                                    '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    If dr.Read Then
                                        strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(dr)
                                    If strResult = "0" Then
                                        errMsg &= "<li> Priority is not valid.</li>" & vbCrLf
                                    End If
                                End If
                            Case "Severity"
                                Dim strSQLToValidate As String = ""
                                Dim strResult As String = ""
                                Dim dr As IDataReader
                                Dim Flag As Integer = 0
                                'If (strTDData = "") Then
                                '    errMsg &= "<li> Severity should not left blank.</li>" & vbCrLf
                                '    Flag = 1
                                'End If
                                If (strTDData <> "") Then
                                    If Flag = 0 Then
                                        ''  strDepartment = ""
                                        strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'Severity'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','Severity','" & strDepartment & "',NULL"
                                        '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                        dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                        If dr.Read Then
                                            strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                        End If
                                        CommonFunctions.Data.DisposeDataReader(dr)
                                        If strResult = "0" Then
                                            errMsg &= "<li> Severity is not valid.</li>" & vbCrLf
                                        End If
                                    End If
                                End If
                            Case "Department"
                                Dim strSQLToValidate As String = ""
                                Dim strResult As String = ""
                                Dim dr As IDataReader
                                Dim Flag As Integer = 0
                                If strTDData = "" Then
                                    errMsg &= "<li> Department should not be left blank.</li>" & vbCrLf
                                    Flag = 1
                                End If
                                If Flag = 0 Then
                                    strDepartment = strTDData
                                    strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'Department'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','Department','" & strDepartment & "',NULL"
                                    '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    If dr.Read Then
                                        strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                    End If
                                    CommonFunctions.Data.DisposeDataReader(dr)
                                    If strResult = "1" Then
                                        ValidDepartment = 1
                                    End If
                                    If strResult = "0" Then
                                        errMsg &= "<li> Department is not valid.</li>" & vbCrLf
                                    End If
                                End If
                            Case "RequestType"
                                Dim strSQLToValidate As String = ""
                                Dim strResult As String = ""
                                Dim Flag As Integer = 0
                                Dim dr As IDataReader
                                If strTDData = "" Then
                                    errMsg &= "<li> Request Type should not be left blank.</li>" & vbCrLf
                                    Flag = 1
                                End If
                                If Flag = 0 Then
                                    strRequestType = strTDData
                                    'strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'RequestType'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','RequestType','" & strDepartment & "',NULL"
                                    ' '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    'dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    'If dr.Read Then
                                    '    strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                    'End If
                                    'CommonFunctions.Data.DisposeDataReader(dr)
                                    'If strResult = "0" Then
                                    '    errMsg &= "<li> Request Type data is not matched with existing data.</li>" & vbCrLf
                                    'End If
                                End If
                            Case "SubRequestType"
                                Dim strSQLToValidate As String = ""
                                Dim strResult As String = ""
                                Dim Flag As Integer = 0
                                Dim dr As IDataReader
                                If strTDData = "" Then
                                    errMsg &= "<li>Sub Request Type should not be left blank.</li>" & vbCrLf
                                    Flag = 1
                                End If
                                If Flag = 0 Then
                                    strSubRequestType = strTDData
                                    'strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'SubRequestType'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','SubRequestType','" & strDepartment & "','" & strRequestType & "'"
                                    ' '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    'dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                    'If dr.Read Then
                                    '    strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                    'End If
                                    'CommonFunctions.Data.DisposeDataReader(dr)
                                    'If strResult = "0" Then
                                    '    errMsg &= "<li>Sub Request Type data is not matched with existing data.</li>" & vbCrLf
                                    'End If
                                End If
                            Case "ExpDateOfResolution"
                                Dim Flag As Integer = 0
                                Dim strSQLToValidate As String = ""
                                Dim dr As IDataReader
                                Dim strResult As String = ""
                                Dim strDateData As String = ""
                                If HttpContext.Current.Session("LoginType") = "E" Then
                                    If (strTDData = "") Then
                                        errMsg &= "<li> Exp. Date Of Resolution should not left blank.</li>" & vbCrLf
                                    Else
                                        Try
                                            strDateData = DateTime.Parse(strTDData).ToString()
                                            Flag = 1
                                        Catch
                                            errMsg &= "<li> Please enter date in MM/dd/yyyy format.</li>" & vbCrLf
                                            Flag = 0
                                        End Try
                                        If Flag = 1 Then
                                            strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'ExpDateOfResolution'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','ExpDateOfResolution','" & strDepartment & "',NULL"
                                            '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                            dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                            If dr.Read Then
                                                strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                            End If
                                            CommonFunctions.Data.DisposeDataReader(dr)
                                            If strResult = "0" Then
                                                errMsg &= "<li> Please enter date greater than or equal to the current date!</li>" & vbCrLf
                                            End If
                                        End If
                                    End If
                                End If
                            Case "OrganizationType"
                                If HttpContext.Current.Session("LoginType") = "E" Then
                                    Dim strSQLToValidate As String = ""
                                    Dim strResult As String = ""
                                    Dim dr As IDataReader
                                    Dim Flag As Integer = 0
                                    If (strTDData = "") Then
                                        errMsg &= "<li> Organization Unit should not left blank.</li>" & vbCrLf
                                    End If
                                    If Flag = 0 Then
                                        strSQLToValidate = "Usp_NG2_Sel_ValiadteRequestFromExcel  'OrganizationType'," & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strTDData & "','OrganizationType','" & strDepartment & "',NULL"
                                        '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                        dr = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                                        If dr.Read Then
                                            strResult = CType(CommonFunctions.Data.CheckIsDBNull(dr("Result"), "0"), Long)
                                        End If
                                        CommonFunctions.Data.DisposeDataReader(dr)
                                        If strResult = "0" Then
                                            errMsg &= "<li> Organization Unit is not valid.</li>" & vbCrLf
                                        End If
                                    End If
                                End If
                        End Select
                        ''  End If
                        Dim strSQLToValidates As String = ""
                        Dim drValidates As IDataReader
                        Dim strResults As String = ""
                        Dim RequestType As String = ""
                        Dim SubRequestType As String = ""
                        ' If ValidHeader <> "1" Then
                        If ValidDepartment = "1" And (strRequestType <> "" And strSubRequestType <> "") Then
                            strSQLToValidates = "Usp_NG2_Sel_ValiadteDependentRequestFromExcel  " & Session("intUserID") & ",'" & Session("strUserName").ToString & "','" & Session("LoginType").ToString & "','" & strDepartment & "','" & strRequestType & "','" & strSubRequestType & "'"
                            '' strResult = CommonFunctions.Data.GetDataReader(strSQLToValidate, True)
                            drValidates = CommonFunctions.Data.GetDataReader(strSQLToValidates, True)
                            If drValidates.Read Then
                                RequestType = CType(CommonFunctions.Data.CheckIsDBNull(drValidates("RequestType"), "0"), String)
                                SubRequestType = CType(CommonFunctions.Data.CheckIsDBNull(drValidates("SubRequestType"), "0"), String)
                            End If
                            CommonFunctions.Data.DisposeDataReader(drValidates)
                            If RequestType = "0" Then
                                If FlagValidRequest = 0 Then
                                    errMsg &= "<li>  Request Type data is not matched with existing data.</li>" & vbCrLf
                                    FlagValidRequest = 1
                                End If
                            End If
                            If SubRequestType = "0" Then
                                If FlagValidSubRequest = 0 Then
                                    errMsg &= "<li> Sub Request Type data is not matched with existing data.</li>" & vbCrLf
                                    FlagValidSubRequest = 1
                                End If
                            End If
                        End If
                        '  End If
                        ' strExcelValidateData.Append("<td title='" & strFieldName & "' >")
                        strExcelValidateData.Append("<td >")
                        strExcelValidateData.Append(strTDData)
                        strExcelValidateData.Append("</td>")
                    Catch ex As Exception
                        strExceptionMsg = ex.Message
                    End Try
                Next
                If strTableHeaderHTML IsNot Nothing Then
                    strTableHeaderHTML.Append("<TH class='FixedTD'>Errors</TH>")
                    strTableHeaderHTML.Append("</tr>")
                    strTableHeaderHTML.Append("</thead>")
                    strTableHeaderHTML.Append("<tbody>")
                    strExcelData.Append(strTableHeaderHTML.ToString)
                    strTableHeaderHTML = Nothing
                End If
                Dim RequestUniqueID As Integer
                strTempQuery = "Usp_NG2_Ins_tbl_NG2_CRM_ImportRequest_Temp " & strAttachmentID
                strTempQuery &= "," & strRequestIds & ""
                If errMsg = "" Then
                    strTempQuery &= ",1"
                Else
                    strTempQuery &= ",0"
                End If
                strTempQuery &= "," & HttpContext.Current.Session("intUserID")
                strTempQuery &= ",'" & HttpContext.Current.Session("strUserName").ToString & "'"
                strTempQuery &= ",'" & HttpContext.Current.Session("LoginType").ToString & "'"
                strTempQuery &= ",NULL"
                strTempQuery &= strQueryData.ToString
                Try
                    'Insert Excel Row into the table
                    ''CommonFunctions.Data.InsertOrUpdateData(strTempQuery, True)
                    Dim drRequestIDs As IDataReader
                    Dim ApprovalStatusForEmail As String
                    drRequestIDs = CommonFunction.Data.GetDataReader(strTempQuery, True)
                    If drRequestIDs.Read() Then
                        RequestUniqueID = drRequestIDs("UniqueID").ToString()
                    End If
                    CommonFunctions.Data.DisposeDataReader(drRequestIDs)
                Catch ex As Exception
                    ''  Response.Write(ex.Message)
                End Try
                If errMsg = "" Then
                    strExcelData.Append("<input type=hidden name='hdnvalidRow' id='hdnvalidRow' value='1' >")
                    strExcelData.Append("<tr class='clsValidRow'>") '
                    strExcelData.Append("<td  class='clsvalidRowIndication' >")
                    strExcelData.Append("<input type=checkbox name='chkRequest' id='chkRequest_" & intCount & "' onclick='CheckRequests(this)' checked value=" & RequestUniqueID & "  />")
                    strExcelData.Append("</td>")
                Else
                    strExcelData.Append("<input type=hidden name='hdnInvalidRow' id='hdnInvalidRow' value='0' >")
                    strExcelData.Append("<tr class='clsInValidRow' >")
                    strExcelData.Append("<td  class='clsInvalidRowIndication'>")
                    strExcelData.Append("<input type=checkbox name='chkRequest' id='chkRequest_" & intCount & "'  disabled value=" & RequestUniqueID & " />")
                    strExcelData.Append("</td>")
                End If
                strExcelData.Append(strExcelValidateData.ToString)
                strTempQuery = ""
                strExcelData.Append("<td title='Error Description' style='white-space:nowrap;' >")
                ''strExcelData.Append("<ul class='clsErrorDesc' >" & errMsg & "</ul>")
                strExcelData.Append("<ul class='clsErrorDesc' >")
                If CounterRow = 0 And errMsg <> "" Then
                    strExcelData.Append("<li>This may be expected header.</li>")
                End If
                strExcelData.Append("" & errMsg & "")
                strExcelData.Append("</ul>")
                strExcelData.Append("</td>")
                strExcelData.Append("</tr>")
                intCount = intCount + 1
                CounterRow = CounterRow + 1
            Next
            strExcelData.Append("</tbody>")
            strExcelData.Append("</table>")
            Dim drValidRequestIDs As IDataReader
            Dim ValidRequests As String
            Dim InValidRequests As String
            drValidRequestIDs = CommonFunction.Data.GetDataReader("usp_SEL_Count_ValidInvalidRow_tbl_NG2_CRM_ImportRequests_Temp " & strAttachmentID, True)
            If drValidRequestIDs.Read() Then
                ValidRequests = CommonFunction.Data.CheckIsDBNull(drValidRequestIDs("ValidRow").ToString(), "0")
                InValidRequests = CommonFunction.Data.CheckIsDBNull(drValidRequestIDs("InvalidRow").ToString(), "0")
            End If
            strExcelData.Append("<input type=hidden name='hdnvalidRowCount' id='hdnvalidRowCount' value=" & ValidRequests & " >")
            strExcelData.Append("<input type=hidden name='hdnInvalidRowCount' id='hdnInvalidRowCount' value=" & InValidRequests & " >")
            CommonFunctions.Data.DisposeDataReader(drValidRequestIDs)
            strExcelData.Append("</div>")
            '  strExcelData.Append("</Div></Div></Div></Div></Div></Div></Div>") 'End accordian to container
        Catch ex As Exception
            strExceptionMsg = ex.Message
            Return strExceptionMsg
        End Try
        Return strExcelData.ToString
    End Function
    Private Function ReadExcelData(ByVal strAttachmentID As String, ByVal UploadedFilePath As String, ByVal OriginalFileName As String)
        '==================================================================================
        ' Function Name     :   ReadExcelData
        ' Purpose           :   Getting dataset for the excel file data
        ' Author            :   Vidya Jadhav
        ' Created On        :   30 Oct 2017
        '==================================================================================
        Dim strConnectionString As String = ""
        Dim strSQL As String
        Dim intCounter As Integer
        Dim objConn As New ADODB.Connection
        Dim objExcel As New ADOX.Catalog
        Dim strExcelData As New StringBuilder("")
        Response.Clear()
        Try
            'Establishing the connection with the Source Excel file.
            Dim checkExtension As String = System.IO.Path.GetExtension(UploadedFilePath)
            '' for [OS compatibility]
            If Environment.Is64BitOperatingSystem = True Then
                strConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 12.0;Xml;HDR=No;IMEX=1"""
            Else
                If checkExtension.ToString = ".xls" Then
                    strConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 8.0;Xml;HDR=No;IMEX=1"""
                ElseIf checkExtension.ToString = ".xlsx" Then
                    strConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & UploadedFilePath & ";Extended Properties=""Excel 12.0;Xml;HDR=No;IMEX=1"""
                End If
            End If
            m_objOLEConnection = New OleDbConnection
            m_objOLEConnection.ConnectionString = strConnectionString
            m_objOLEConnection.Open()
            m_objOLECommand = New OleDbCommand
            m_objOLECommand.Connection = m_objOLEConnection
            m_objOLEAdapter = New OleDbDataAdapter(m_objOLECommand)
            m_objDataSet = New DataSet
            'Getting the name of the Excel WorkSeheet through ADOX.Catalog
            objConn.ConnectionString = strConnectionString
            objConn.Open()
            objExcel.ActiveConnection = objConn
            Dim myTableName = m_objOLEConnection.GetSchema("Tables").Rows(0)("TABLE_NAME")
            Dim intFieldCount As Integer
            Dim intDataTableColumn As Integer
            'Getting all the column names from the source excel file.
            'strSQL = "Select * from [" & myTableName & "]"
            strSQL = "Select top 100 * from [" & myTableName & "]"
            m_objOLECommand.CommandText = strSQL
            m_objOLEDataReader = m_objOLECommand.ExecuteReader(CommandBehavior.SingleResult)
            intFieldCount = m_objOLEDataReader.FieldCount
            'Filling the SourceColumns global array.
            ReDim m_arrSourceColumns(m_objOLEDataReader.FieldCount - 1)
            For intCounter = 0 To m_objOLEDataReader.FieldCount - 1
                m_arrSourceColumns(intCounter) = m_objOLEDataReader.GetName(intCounter)
            Next
            m_objOLEDataReader.Close()
            m_objOLEDataReader = Nothing
            'Filling the global dataset with all the source data.
            m_objOLEAdapter.Fill(m_objDataSet)
            For k As Int16 = intFieldCount + 1 To 12
                m_objDataSet.Tables(0).Columns.Add("F" & k)
            Next
            Dim strQuery As String = ""
            Dim drExceField As IDataReader
            Dim FieldDictionary As New System.Collections.Specialized.StringDictionary
            Dim FieldCaptionDictionary As New System.Collections.Specialized.StringDictionary
            '  Dim arrColCaptions() As String = {"TicketID", "Subject", "Description", "Department", "RequestType", "SubRequestType", "Priority", "Severity", "Oraganization Type", "Exp. Date Of Resolution"}
            Dim arrColCaptions() As String = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"}
            Dim strFieldName As String
            Dim errMsg As String = ""
            Dim strQueryData As New StringBuilder("")
            Dim strExcelValidateData As New StringBuilder("")
            Dim strTableHeaderHTML As New StringBuilder("")
            Dim strTempQuery As String
            Dim strTDData As String = ""
            'strQuery = "Usp_NG2_Sel_tbl_NG2_CRM_RequestImport_Fields "
            'drExceField = CommonFunctions.Data.GetDataReader(strQuery, True)
            'While drExceField.Read
            '    If CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")) <> "" Then
            '        FieldDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("ExcelFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")))
            '        FieldCaptionDictionary.Add(CommonFunctions.Data.CheckIsDBNull(drExceField("RequestFieldName")), CommonFunctions.Data.CheckIsDBNull(drExceField("FieldCaption")))
            '    End If
            'End While
            strExcelData.Append("<div  id='tblValidateFile'>")
            strExcelData.Append("<input type=hidden id='hdnAttachmentID' value='" & strAttachmentID & "' >")
            strExcelData.Append("<table class='table table-hover' border='1' style='border:1px solid #ddd; border-color:#ddd;'>")
            ' strExcelData.Append("<table class='table table-hover'>")
            strTableHeaderHTML.Append("<thead>")
            strTableHeaderHTML.Append("  <tr>")
            'If strTableHeaderHTML IsNot Nothing Then
            '    strTableHeaderHTML.Append("<TH style='width:2%;text-align:center;'>Is Valid</TH>")
            'End If
            For Each drPBUS As DataRow In m_objDataSet.Tables(0).Rows
                errMsg = ""
                strQueryData.Clear()
                strExcelValidateData.Clear()
                'strQueryData.Append("Usp_App_Ins_tbl_PM_PBUserStories_Temp " & strAttachmentID)               
                '    For j As Integer = 0 To 11
                For j As Integer = 0 To 9
                    'strFieldName = FieldDictionary.Item(arrColCaptions(j))
                    strQueryData.Append(",'" & CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j))).Replace("'", "''") & "'")
                    strTDData = CStr(CommonFunctions.Data.CheckIsDBNull(drPBUS.Item(j)))
                    If strTableHeaderHTML IsNot Nothing Then
                        ' If strFieldName <> "" Then
                        strTableHeaderHTML.Append("<TH align=center class='FixedTD'>" & arrColCaptions(j) & "</TH>")
                        'Else
                        '  strTableHeaderHTML.Append("<TH align=center ></TH>")
                        'End If
                    End If
                    ' strExcelValidateData.Append("<td title='" & strFieldName & "' >")
                    strExcelValidateData.Append("<td >")
                    strExcelValidateData.Append(strTDData)
                    strExcelValidateData.Append("</td>")
                Next
                If strTableHeaderHTML IsNot Nothing Then
                    '    strTableHeaderHTML.Append("<TH>Errors</TH>")
                    strTableHeaderHTML.Append("</tr>")
                    strTableHeaderHTML.Append("</thead>")
                    strTableHeaderHTML.Append("<tbody>")
                    strExcelData.Append(strTableHeaderHTML.ToString)
                    strTableHeaderHTML = Nothing
                End If
                strTempQuery = "Usp_NG2_Ins_tbl_NG2_CRM_ImportRequest_Temp " & strAttachmentID & ",0,0"
                'If errMsg = "" Then
                '    strTempQuery &= ",1"
                '    strExcelData.Append("<tr class='clsValidRow'>") '
                '    strExcelData.Append("<td  class='clsvalidRowIndication' >")
                '    strExcelData.Append("<input type=checkbox id='chkUS' id='chkUS' checked disabled />")
                '    strExcelData.Append("</td>")
                'Else
                '    strTempQuery &= ",0"
                '    strExcelData.Append("<tr class='clsInValidRow' >")
                '    strExcelData.Append("<td  class='clsInvalidRowIndication'>")
                '    strExcelData.Append("<input type=checkbox id='chkUS' id='chkUS' disabled />")
                '    strExcelData.Append("</td>")
                'End If
                strExcelData.Append(strExcelValidateData.ToString)
                strTempQuery &= "," & HttpContext.Current.Session("intUserID")
                strTempQuery &= ",'" & HttpContext.Current.Session("strUserName").ToString & "'"
                strTempQuery &= ",'" & HttpContext.Current.Session("LoginType").ToString & "'"
                strTempQuery &= ",'" & OriginalFileName & "'"
                strTempQuery &= strQueryData.ToString
                Try
                    'Insert Excel Row into the table
                    CommonFunctions.Data.InsertOrUpdateData(strTempQuery, True)
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
                strTempQuery = ""
                'strExcelData.Append("<td title='Error Description' style='white-space:nowrap;' >")
                'strExcelData.Append("<ul class='clsErrorDesc' >" & errMsg & "</ul>")
                'strExcelData.Append("</td>")
                strExcelData.Append("</tr>")
            Next
            strExcelData.Append("</tbody>")
            strExcelData.Append("</table>")
            Dim drValidRequestIDs As IDataReader
            Dim ValidRequests As String
            Dim InValidRequests As String
            drValidRequestIDs = CommonFunction.Data.GetDataReader("usp_SEL_Count_ValidInvalidRow_tbl_NG2_CRM_ImportRequests_Temp " & strAttachmentID, True)
            If drValidRequestIDs.Read() Then
                ValidRequests = CommonFunction.Data.CheckIsDBNull(drValidRequestIDs("ValidRow").ToString(), "0")
                InValidRequests = CommonFunction.Data.CheckIsDBNull(drValidRequestIDs("InvalidRow").ToString(), "0")
            End If
            strExcelData.Append("<input type=hidden name='hdnvalidRowCount' id='hdnvalidRowCount' value=" & ValidRequests & " >")
            strExcelData.Append("<input type=hidden name='hdnInvalidRowCount' id='hdnInvalidRowCount' value=" & InValidRequests & " >")
            CommonFunctions.Data.DisposeDataReader(drValidRequestIDs)
            strExcelData.Append("</div>")
            '  strExcelData.Append("</Div></Div></Div></Div></Div></Div></Div>") 'End accordian to container
            Response.Write(strExcelData.ToString)
            Response.End()
            'Dim sqlcmd As New SqlCommand("Usp_App_Ins_tbl_PM_PBUserStories_Temp")
            'sqlcmd.Parameters.AddWithValue("@tblPBUserStories", m_objDataSet.Tables(0))
            'sqlcmd.Parameters.AddWithValue("@intAttachmentID", strAttachmentID)
            'sqlcmd.CommandType = CommandType.StoredProcedure
            'CommonFunction.Data.GetSQLCommandExecute(sqlcmd, True)
            If m_objOLEDataReader.IsClosed = False Then
                m_objOLEDataReader.Close()
                m_objOLEDataReader = Nothing
            End If
            'If objRequestInfo.m_intEndRow = 0 Then objRequestInfo.m_intEndRow = m_objDataSet.Tables(0).Rows.Count
            'objRequestInfo.m_intTotalRecords = m_objDataSet.Tables(0).Rows.Count
            If objConn.State = ConnectionState.Open Then
                objConn.Close()
                objConn = Nothing
            End If
        Catch ex As Exception
            If objConn.State = ConnectionState.Open Then
                objConn.Close()
                objConn = Nothing
            End If
            If m_objOLEDataReader.IsClosed = False Then
                m_objOLEDataReader.Close()
                m_objOLEDataReader = Nothing
            End If
            Return ex.Message
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function UploadData(ByVal AttachmentID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        AttachmentID = Utilities.Security.SecurityBuilder.CheckUserInput(AttachmentID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim strSQLQuery As String = "Usp_NG2_Ins_tbl_CRM_Query_Master_ExcelUpload " & AttachmentID & ",'" & HttpContext.Current.Session("strUserName") & "'," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("LoginType") & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateAndSave(ByVal SelectedRequestIDs As String, ByVal AttachmentID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        SelectedRequestIDs = Utilities.Security.SecurityBuilder.CheckUserInput(SelectedRequestIDs, 2, True, False, False)
        AttachmentID = Utilities.Security.SecurityBuilder.CheckUserInput(AttachmentID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim arrUpdate() As String
        Dim index As Integer = 0
        Dim strSQL As String = ""
        arrUpdate = SelectedRequestIDs.Split(",")
        Try
            ''  For index = 0 To arrUpdate.Length - 1
            strSQL = "exec usp_NG2_Upd_tbl_NG2_CRM_ImportRequests_Temp  '" & SelectedRequestIDs & "'," & HttpContext.Current.Session("intUserID") & "," & AttachmentID & ""
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            ''Next
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ValidateExcelToSelect(ByVal AttachmentID As String, ByVal ValidateClicked As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        AttachmentID = Utilities.Security.SecurityBuilder.CheckUserInput(AttachmentID, 2, True, False, False)
        ValidateClicked = Utilities.Security.SecurityBuilder.CheckUserInput(ValidateClicked, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ValidateExcelToSelect
        ' Description           : To  get list of attachments againsts requests
        ' Created Date           : 13th-Oct-2017
        '=====================================================================
        Try
            Dim objCRM_RequestListsNew As New CRM_UnCategorizedRequestList
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objCRM_RequestListsNew.ValidateExcelDataToSelect(AttachmentID, ValidateClicked))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ValidateExcelToImport(ByVal AttachmentID As String, ByVal ValidateClicked As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        AttachmentID = Utilities.Security.SecurityBuilder.CheckUserInput(AttachmentID, 2, True, False, False)
        ValidateClicked = Utilities.Security.SecurityBuilder.CheckUserInput(ValidateClicked, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : ValidateExcelToImport
        ' Description           : To  get list of attachments againsts requests
        ' Created Date           : 13th-Oct-2017
        '=====================================================================
        Try
            Dim objCRM_RequestListsNew As New CRM_UnCategorizedRequestList
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objCRM_RequestListsNew.ValidateExcelData(AttachmentID, ValidateClicked))
            Return strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ClearConfiguration() As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim strSQLQuery As String = "usp_NG2_Del_tbl_NG2_CRM_RequestImport_Fields " & HttpContext.Current.Session("intUserID") & ""
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, True)
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetFilterQuery(ByVal FilterID As String, ByVal PageMode As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        FilterID = Utilities.Security.SecurityBuilder.CheckUserInput(FilterID, 2, True, False, False)
        PageMode = Utilities.Security.SecurityBuilder.CheckUserInput(PageMode, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim strResult As String = ""
            Dim drReader As IDataReader
            Dim strGridCount As String = ""
            Dim strSQLQuery As String = "usp_sel_tbl_CRM_Filters " & FilterID & ""
            drReader = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_Filters " & FilterID & "," & HttpContext.Current.Session("intUserID"), True)
            If drReader.Read Then
                If Trim(drReader("FilterText").ToString & "") <> "" Then
                    strResult = CommonFunctions.General.BuildQueryString(Trim(drReader("FilterText").ToString & ""))
                End If
            End If
            'This Query is just for to test whether the above where query is valid or not 
            'means to check whether it have status column or not
            If PageMode = "RFA" Or PageMode = "RAR" Then
                Try
                    strGridCount = CommonFunctions.Data.GetDataScalar("EXEC usp_NG_CRM_Sel_AllRequests_Count 61,1,Null,Null,Null,'SUBMITTEDDATE','DESC','" & strResult & "',0,Null,1,'E','" & PageMode & "','admin'", True)
                Catch ex As Exception
                    strResult = ""
                End Try
            End If
            'strResult = CommonFunctions.Data.GetDataScalar(strSQLQuery, True)
            Return strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveFeedback(ByVal globalFeedbackID As String, ByVal RequestID As String, ByVal FeedbackComment As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        globalFeedbackID = Utilities.Security.SecurityBuilder.CheckUserInput(globalFeedbackID, 2, True, False, False)
        RequestID = Utilities.Security.SecurityBuilder.CheckUserInput(RequestID, 2, True, False, False)
        FeedbackComment = Utilities.Security.SecurityBuilder.CheckUserInput(FeedbackComment, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure  Name		:	SaveFeedback
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Assign Issue
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   15 Nov 2017
        '=====================================================================
        Try
            Dim strHTML As New StringBuilder("")
            Dim m_strFeedBack As String = ""
            Dim objCRMRequestDetails As New CRM_RequestDetailsNew
            Dim strSQL As String = ""
            Dim UniqueID As Integer = 0
            If globalFeedbackID = "" Then
                globalFeedbackID = "NULL"
            End If
            Try
                strSQL = "exec usp_NG2_INS_Feedback  " & globalFeedbackID & "," & RequestID & " ,'" & FeedbackComment & "'"
                m_strFeedBack = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
                UniqueID = 1
            Catch ex As Exception
            End Try
            Return UniqueID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        Dim jsonString As String = ""
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                If col.DataType = GetType(DateTime) Then
                    col.DateTimeMode = DataSetDateTime.Unspecified
                End If
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        jsonString = serializer.Serialize(rows)
        Return jsonString
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function RemoveFilter(ByVal strFilterID As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strFilterID = Utilities.Security.SecurityBuilder.CheckUserInput(strFilterID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try
            Dim strSql As String = "usp_NG2_UPD_tbl_CRM_ClearFilters " & HttpContext.Current.Session("intUserID")
            CommonFunctions.Data.InsertOrUpdateData(strSql, True)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDueDate(ByVal DueDate As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        DueDate = Utilities.Security.SecurityBuilder.CheckUserInput(DueDate, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '==================================================================================
        ' Procedure Name	:	CheckDueDate
        ' Purpose			:	To check is date validation
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Aniruddh Gujar
        ' Created			:	21-Dec-2017
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            strSQL = "usp_Ng2_Validate_DueDate '" & DueDate & "'"
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
#End Region
End Class