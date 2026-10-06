Public Class CRM_RequestStatus
    '' Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objTypeGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSubTypeGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objStatusGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objPriorityGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSeverityGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objDepartmentGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSubRequestTypeGrid As New WebPages.Template.GenericGrid

    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Private m_dsGrid As DataSet
    Protected m_intNoOfRecordInGrid As Int16 = 5
    Protected Shared m_strRequestTypeID As Integer = 0
    Protected Shared m_strSubRequestTypeID As Integer = 0
    Protected Shared m_strStatusID As Integer = 0
    Protected Shared m_strPriorityID As Integer = 0
    Protected Shared m_strSeverityID As Integer = 0

    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected Shared RequestTypeTagID As Integer = 918
    Protected Shared SubRequestTypeTagID As Integer = 919
    Protected m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
    'Protected m_intRoleID As String
    'Protected strLoginType As String
    'Protected strUserName As String
    'Protected intUserID As String
    Protected Status_View As String
    Protected Priority_View As String
    Protected Severity_View As String
    Protected SubType_View As String
    Protected Type_View As String
    Protected m_strIsTypeMapped As String
    Protected str_RequestTypeID As String
    Protected m_strCanDelete As String
    Protected m_strCanUnMap As String
    Protected m_strChkConfigureStatusFlow As String
    Protected m_strCanSubTypeDelete As String
    Protected m_strCanStatusDelete As String
    Protected m_strCanPriorityDelete As String
    Protected m_strCanSevrityDelete As String

    Protected m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Protected m_strUserName As String = ""
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Protected m_blnUseSQL As String = ""

    Protected m_blnSLAAccess As Boolean = False
    Private m_objSubTagGlobal As WebPages.Template.IGlobal
    Protected m_objSubTagAccess As WebPage.Templates.AccessRights
    Private m_objSubTagCLSQL As CommonEngines.CommonList.cSubTagCLSQL
    Private Shared m_objSubTabAccess As WebPage.Templates.AccessRights
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
    Protected Shared strUserName As String = ""
    Protected Shared intUserID As Integer = 0
    Protected Shared TagID As String = ""

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Protected WithEvents m_objGrid As New WebPages.Template.GenericGrid
#End Region

    Private Property Type_Edit As Boolean

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_strRequestTypeID = 0
        m_strSubRequestTypeID = 0
        m_strPriorityID = 0
        m_strStatusID = 0
        m_strSeverityID = 0
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intLOGINID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        intUserID = CType(Session("intUserID"), Integer)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)

    End Sub
    Public Function PageInit(ByVal Flag As String)
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================

        'CommonFunctions.General.WriteHTML("<script>StartLoader('#fastTrackID');</script>")
        'DrawPage()
        Dim strHTML As New StringBuilder

        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngLoginID = CType(Session("intLOGINID"), Long)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)

        'Code For SLA Access
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()

        '' objGlobal.TagID = 3821

        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        objAccessRights.GetAccess()

        m_blnSLAAccess = objAccessRights.View
        'End of Code For SLA Access
        'strHTML.Append(WriteTabsControls("Type", "Load", ""))
        'If Flag.ToUpper = "LOAD" Then
        '    CommonFunctions.General.WriteHTML(strHTML.ToString)
        'Else
        '    Return strHTML.ToString
        'End If

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSubTabAccessRights(ByVal SubtagID As Integer, ByVal TagID As String)
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Sub Tag 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SwapnilA
        ' Created               :	3-JAN-2017
        ' Revisions             :
        '=====================================================================
        Try
            m_objSubTabAccess = New WebPage.Templates.AccessRights
            Dim objGlobal As New WebPage.Templates.WhizGlobal(strUserName, SubtagID, m_intRoleID, intUserID, strLoginType, False, TagID)
            m_objSubTabAccess.GetAccess(objGlobal)
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    Protected Function WriteTabsControls(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : WriteTabsControls()	
        ' Purpose               : To Plot the Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        '-------------------------------------Request inner Horizontal Tabs---------------------------------------------------------->

        strHTML.Append("<div id='Status' class='tabcontent1 h-type h-form clsSettingstabs'>")
        strHTML.Append(RequestStatusTabDetails(strWhichGrid, strGridFlag))
        strHTML.Append("</div>")

        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function

#Region "Request Tab Section Related Code"
    Public Function RequestStatusTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
        '=====================================================================
        ' Procedure Name        : RequestStatusTabDetails()	
        ' Purpose               : To Plot the Request Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        GetGlobalObject(RequestTypeTagID)

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='divScrollStatus'>")
        strHTML.Append("<div class='type-top-bar top-bar'  id='divStatusTab'>")
        strHTML.Append("<ul class='left'>")

        'strHTML.Append("<li class='left search-bar'>")
        'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        'strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        'strHTML.Append("</li>")
        '/*Changed By Yasmin on 25th july 2018*/
        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch' aria-hidden='true'>")
        strHTML.Append("</i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")

        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("  <button type='button' onclick='AddRequestStatus()' title='Add Request Status' class='btn btn-default' style='color:black!important;background-color:white!important' >Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("    <button onclick='DeleteRequestStatus()' title='Delete Request Status' type='button' class='btn btn-default' title='Delete' style='color:black!important;background-color:white!important' >Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='tblStatus'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divStatusBottom'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion3' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne3'>")
        strHTML.Append("   <h3><span>Add New Status<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        strHTML.Append("  <h4 class='panel-title'>")
        strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion3' href='#collapseOne3' aria-expanded='true' aria-controls='collapseOne3' id='Addaccordion'>")
        strHTML.Append(" <i class='fa fa-plus' title='Expand'></i>")
        strHTML.Append("<i class='fa fa-minus' title='Hide'></i>")
        strHTML.Append(" </a>")
        strHTML.Append(" </h4>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div id='collapseOne3' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne3'>")
        strHTML.Append(" <div class='panel-body'  >")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Status Code*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStatusCode", "txtStatusCode", "form-control", 219, 30, , , , , , , , " class='form-control' placeholder='Enter Request Status Code'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Order Number*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", "form-control", 54, 3, , , , , , , , " class='form-control' placeholder='Enter Order Number'  ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Status*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestStatus", "txtRequestStatus", "form-control", 219, 100, , , , , , , , " class='form-control' placeholder='Enter Request Status'  ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>System Status*</label>")
        strHTML.Append("<div class='col-sm-4' style=' margin-top: 5px;'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSystemStatus", "Usp_NG2_Sel_tbl_IB_Status_For_Status", 200, , "class='form-control' placeholder='Enter System Status' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        '/*Added by Kashish for ui change*/
        '/* Change by Yasmin For UI Changes On 11th July 2018*/
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='chromef'>")
        '/*Added By Yasmin on 27th july 2018*/
        ''margin-right: 19px;
        strHTML.Append("<button type='button' class='btn btn-default save right' onclick='Cancel_Status()'  style='margin-left:2px;'>Cancel</button>")
        strHTML.Append("<button type='button' id='History' class='btn btn-default save clsbuttonLinks right' onclick='HistoryDetails()'  style=' margin-left: 2px;    margin-right: 3px; background-color: #343660; color: #ffffff'>Show History</button>")

        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks  right' onclick='SaveAndAddStatus()'   style='background-color: #343660; color: #fff; border-left: 1px solid; margin-left: 5px; margin-right: 3px'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
            strHTML.Append("<button type='button' class='btn btn-default save right' onclick='SaveStatus()'  style='background-color: #343660; color: #fff;'>Save</button>")

        End If


        strHTML.Append(" </div>")
        '/*Added by Kashish for ui change*/

        strHTML.Append("</div>")
        strHTML.Append("  </form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
   
    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteRequestTabGrid()	
        ' Purpose               : To Plot the Request Tab Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        If strWhichGrid = "Type" Then
            GetGlobalObject(RequestTypeTagID)
            'Type_Add = m_objAccessRights.Add
            'Type_Delete = m_objAccessRights.Delete
            'Type_Edit = m_objAccessRights.Edit
            'Type_View = m_objAccessRights.View
        ElseIf strWhichGrid = "Subtype" Then
            GetGlobalObject(RequestTypeTagID)
        End If
        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, RequestTypeID))
        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function
    
    Protected Sub GetGlobalObject(ByVal TagID As String)
        '=====================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get the global object and assign it to variable
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Vidya Jadhav
        ' Created               :	1 Nov  2016
        '=====================================================================

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        'If RequestTypeTagID <> "" Then
        '    m_objGlobal.TagID = RequestTypeTagID
        'End If
        m_objGlobal.TagID = TagID
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub
    Private Function WriteHelpdeskMasterGrid(ByVal strWhichGrid As String, ByVal RequestTypeID As String) As String

        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        Dim Flag As Integer = 0
        str_RequestTypeID = RequestTypeID
        intNoOfDataColumn = 5
        strDivID = "divStatus"
        strSQLQuery = "Usp_NG2_Sel_v_tbl_CRM_Status"

        arrstrActualList = {"StatusCode", "Status", "StatusOfStatus", "OrderNumber", "Select", ""}
        arrstrUserFriendlyList = {"Request Status Code", "Request Status", "System Status", "Order Number", "Select", "Delete"}
        arrstrLinkArray = {"", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

        objGrid = m_objStatusGrid

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            '.ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
            .SQL = strSQLQuery
            '.ColNameToolTipOnEachRow = True
            .UseSQL = True
            '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
            '.SortBy = strSortBy
            '.SortOrder = strSortOrder
            ' .CurrentPage = m_intPageNumber
            ' .PageSize = m_intNoOfRecordInGrid
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With

        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing

        Return strGridHTML.ToString
    End Function
    
  
    
    Private Sub m_objStatusGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objStatusGrid.ColumnHeaderTD_BeforePrint

        Select Case UCase(Trim(Args.DataField & ""))
            Case "STATUSCODE"
                Cancel = True
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.StringToBeInserted = "<th align='center'>Request Status Code<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "STATUS"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='center'>Request Status<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "STATUSOFSTATUS"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='left'>System Status<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "ORDERNUMBER"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='left'>Order Number<i class='fa fa-sort' aria-hidden='true'></i></th>"

        End Select

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center'><input onclick='DeleteMultiple_Status()' type=checkbox id=chkAllDeleteStatus name=chkAllDeleteStatus  title='Select All'/></th>"
        End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center'>Edit</th>"
        End If


    End Sub
    Private Sub m_objStatusGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objStatusGrid.DataRowTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td style='text-align:left'><input type=checkbox name='chkStatusSelect' title='select' /></td>"
        'End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            If m_strStatusID = Args.DataReader("StatusID") Then
                ''Args.StringToBeInserted = "<td align='center' Title = 'Select Checkbox'><a  id=chkRequestTypeSelect name=chkRequestTypeSelect  checked=true onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Request Status'><button type='button' class='edit-bt'  checked=true id=chkStatusSelect name=chkStatusSelect onclick='EditRequestStatus(this," & Args.DataReader("StatusID") & ")' value=" & Args.DataReader("StatusID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Request Status'><button type='button' class='edit-bt'  id=chkStatusSelect name=chkStatusSelect onclick='EditRequestStatus(this," & Args.DataReader("StatusID") & ")' value=" & Args.DataReader("StatusID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanStatusDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Chk_Del_tbl_CRM_Status " & Args.DataReader("StatusID"), True), "0")

            If m_strCanStatusDelete = "0" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Delete Request Status'><input type=checkbox id=chkStatusDelete name=chkStatusDelete   value=" & Args.DataReader("StatusID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = '" & m_strCanStatusDelete & "'><input type=checkbox id=chkStatusDelete disabled name=chkStatusDelete  value=" & Args.DataReader("StatusID") & ">" + "</TD>"
            End If
        End If
    End Sub

#End Region
#Region "Jquery AJAX Methods"
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")
        Dim objSetting As New CRM_RequestStatus()
        strGridHTML.Append(objSetting.RequestStatusTabDetails(GridParameter("cityName"), "AJAXRefresh"))
        Return strGridHTML.ToString
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshPlotGrid(ByVal GridParameter As Object) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")
        Dim objSetting As New CRM_RequestStatus()

        strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))



        Return strGridHTML.ToString
    End Function
    
    <System.Web.Services.WebMethod()>
    Public Shared Function GetRequestStatusDetails(ByVal RequestStatusID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetRequestStatusDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of Request Status Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:  7-Nov-2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim strUniqueID As String = ""
            Dim RequestTypeCode As String = ""
            Dim RequestType As String = ""
            Dim strReasonForOccurence As String = ""

            Dim StatusCode As String = ""
            Dim Status As String = ""
            Dim SystemStatusID As String = ""
            Dim OrderNumber As String = ""
            Dim IsSystemDefined As String = ""


            Dim strSQL As String = ""
            strSQL = "Usp_NG2_Sel_tbl_CRM_Status " & RequestStatusID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                strUniqueID = CommonFunctions.Data.CheckIsDBNull(drTabData("StatusID"), "")
                StatusCode = CommonFunctions.Data.CheckIsDBNull(drTabData("StatusCode"), "")
                Status = CommonFunctions.Data.CheckIsDBNull(drTabData("Status"), "")
                SystemStatusID = CommonFunctions.Data.CheckIsDBNull(drTabData("SystemStatusID"), "")
                OrderNumber = CommonFunctions.Data.CheckIsDBNull(drTabData("OrderNumber"), "")
                IsSystemDefined = CommonFunctions.Data.CheckIsDBNull(drTabData("IsSystemDefined"), "")

            End If
            strResult = strUniqueID & "##" & StatusCode & "##" & Status & "##" & SystemStatusID & "##" & OrderNumber & "##" & IsSystemDefined
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function


   
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteRequestStatus(ByVal RequestStausID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteRequestStatus
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Status
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   8 Nov 2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0
        arrDelete = RequestStausID.Split(",")

            For index = 0 To arrDelete.Length - 1
                    strSQL = "exec usp_NG2_Del_tbl_CRM_Status  " & arrDelete(index) & ""
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                Next
            Catch ex As Exception
                Return "Bad Request Found"
            End Try

    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SaveStatus(ByVal StatusCode As String, ByVal OrderNumber As String, ByVal RequestStatus As String, ByVal SystemStaus As String, ByVal StatusID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim Status_ID As String = ""

            Dim strSQL As String = "Usp_NG2_INS_tbl_CRM_Status  '" & StatusCode & "', '" & RequestStatus & "','" & SystemStaus & "','" & OrderNumber & "','" & HttpContext.Current.Session("strUserName") & "'," & StatusID & ""
            Status_ID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return Status_ID
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateStatusMapped(ByVal RequestStatus As String, ByVal EditStatusID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateStatusMapped
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Status
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   9 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If (RequestStatus = "") Then
                RequestStatus = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_RequestStatus '" & RequestStatus & "'," & EditStatusID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateOrderNumber(ByVal OrderNumber As String, ByVal EditStatusID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateOrderNumber
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Order Number
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   9 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If (OrderNumber = "") Then
                OrderNumber = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_OrderNumber '" & OrderNumber & "'," & EditStatusID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateStatusCode(ByVal StatusCode As String, ByVal EditStatusID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateStatusCode
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Status Code
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   9 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If (StatusCode = "") Then
                StatusCode = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_StatusCode '" & StatusCode & "'," & EditStatusID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function ShowMailHistoryDetails(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryDetails                              '
        ' Purpose				:   Call ShowMailHistoryGrid function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Try
            Dim objSetting As New CRM_RequestStatus
            Dim strHTML As New StringBuilder("")
            Dim str As String = objSetting.ShowMailHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Dim strHTML As New StringBuilder("")

        If (storedprocedure = Nothing) Then
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 915 & "','" & UniqueID & "'")
        Else
            txtSQLQuery.Append(storedprocedure)
        End If

        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Modified Date")
        arrColumnHeadingList.Add("Field Modified")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Value")

        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("FieldName")
        arrActualColumnNames.Add("ModifiedBy")
        arrActualColumnNames.Add("Value")
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 4
            .PrimaryKey = "LogID"
            .TDStyleArray = arrWidthArray
            '.ColNameToolTipOnEachRow = False
            .DIVID = "ShowHistoryGrid"
            .DIVStyle = ""
            .SQL = strSQLQuery
            '.ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            strHTML.Append(.DrawGrid())
        End With

        Return strHTML.ToString()

    End Function
    Public Function GetArray(ByVal arrList As ArrayList) As String()
        '================================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : tejal D
        ' Created               : 
        ' Revisions             :
        '===============================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilteredHistory(ByVal newModifiedField As String, ByVal MessageID As Integer, ByVal newModifiedBy As String)
        '================================================================================
        ' Procedure Name        : FilteredHistory()	
        ' Purpose               : Get Email setting details for selected filter
        ' Description           : Get Email setting details for selected filter
        ' Parameters Passed     : newModifiedField
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 01-Dec-2017
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim objSetting As New CRM_RequestStatus
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 915, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = objSetting.ShowMailHistoryGrid(MessageID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
#End Region
End Class