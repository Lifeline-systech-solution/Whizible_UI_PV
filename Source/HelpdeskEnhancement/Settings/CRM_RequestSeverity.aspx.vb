Public Class CRM_RequestSeverity
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

       

        strHTML.Append("<div id='Severity' class='tabcontent1 h-type h-form clsSettingstabs' >")
        strHTML.Append(RequestSeverityTabDetails(strWhichGrid, strGridFlag))
        strHTML.Append("</div>")

      
        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function

#Region "Request Tab Section Related Code"
    Public Function RequestSeverityTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
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
        '/*Changed By Yasmin on 25th july 2018*/
        GetGlobalObject(917)

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='divScrollSeverity'>")
        strHTML.Append("<div class='type-top-bar top-bar'  id='divSeverityTab'>")
        strHTML.Append("<ul class='left'>")

        'strHTML.Append("<li class='left search-bar'>")
        'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        'strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        'strHTML.Append("</li>")

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
            strHTML.Append("  <button type='button' onclick='Add_RequestSeverity()' title='Add Request Severity' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("    <button onclick='DeleteRequestSeverity()' type='button' title='Delete  Request Severity' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='divtblSeverity'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divSeverityBottom'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion5' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne5'>")
        strHTML.Append("   <h3><span>Add New Severity<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        strHTML.Append("  <h4 class='panel-title'>")
        strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion5' href='#collapseOne5' aria-expanded='true' aria-controls='collapseOne5' id='Addaccordion'>")
        strHTML.Append(" <i class='fa fa-plus' title='Expand'></i>")
        strHTML.Append("<i class='fa fa-minus' title='Hide'></i>")
        strHTML.Append(" </a>")
        strHTML.Append(" </h4>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div id='collapseOne5' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne5'>")
        strHTML.Append(" <div class='panel-body'  >")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")

        'Commented and Added by Usha Pandit on 11 JAN 2018 for Severity Code Alignment
        'strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Severity Code*</label>")
        strHTML.Append(" <label class='control-label col-sm-3' for='request type'>Request Severity Code*</label>")
        'End of Added by Usha Pandit on 11 JAN 2018 for Severity Code Alignment

        strHTML.Append("<div class='col-sm-4'>")

        'Commented and Added by Usha Pandit on 05 JAN 2018 for setting max length
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestSeverityCode", "txtRequestSeverityCode", "form-control", 54, , , , , , , , , " class='form-control'  placeholder='Enter Request Severity Code' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestSeverityCode", "txtRequestSeverityCode", "form-control", 54, 30, , , , , , , , " class='form-control'  placeholder='Enter Request Severity Code' ", returnHTML:=True, EnableHTMLEncode:=True))
        'End of Added by Usha Pandit on 05 JAN 2018 for setting max length

        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")

        'Commented and Added by Usha Pandit on 11 JAN 2018 for Severity Code Alignment
        'strHTML.Append("<label class='control-label col-sm-2' for='request type'>Request Severity*</label>")
        strHTML.Append("<label class='control-label col-sm-3' for='request type'>Request Severity*</label>")
        'End of Added by Usha Pandit on 11 JAN 2018 for Severity Code Alignment

        strHTML.Append("<div class='col-sm-4'>")

        'Commented and Added by Usha Pandit on 05 JAN 2018 for setting max length
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestSeverity", "txtRequestSeverity", "form-control", 219, , , , , , , , , " class='form-control'  placeholder='Enter Request Severity' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestSeverity", "txtRequestSeverity", "form-control", 219, 100, , , , , , , , " class='form-control'  placeholder='Enter Request Severity' ", returnHTML:=True, EnableHTMLEncode:=True))
        'End of Added by Usha Pandit on 05 JAN 2018 for setting max length
        '/*Changed By Yasmin on 25th july 2018*/
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='right' id='bottombuttons'>")
        '/*Added By Yasmin on 27th july 2018*/
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save' onclick='SaveRequestSeverity()'  >Save</button>")
            strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddRequestSeverity()'  style='border-left: 1px solid;    margin-left: 5px;margin-right: 0px;'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strHTML.Append(" <button type='button' id='idShowHistory' style='display:none;' onclick='ShowHistory()'  class='btn btn-default save' style='margin-left: 2px; margin-right: 3px;'>Show History</button>")
        '/*Added By Kashish for ui change*/
        strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Severity()' >Cancel</button>")
        'End of Added by Kashish  for ui change*/
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
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
    Protected Function WriteSubRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteSubRequestTabGrid()	
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
       
            intNoOfDataColumn = 3
            strDivID = "divSeverity"
            strSQLQuery = "Usp_NG2_Sel_v_tbl_CRM_Severity"

            arrstrActualList = {"SeverityCode", "Severity", "Select", ""}
            arrstrUserFriendlyList = {"Severity Code", "Severity", "Select", "Delete"}
            arrstrLinkArray = {"", "", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objSeverityGrid
        '/*Changed By Yasmin on 25th july 2018*/
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
    Private Sub m_objSeverityGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objSeverityGrid.ColumnHeaderTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        'End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th align='center'><input onclick='DeleteMultiple_Severity()' type=checkbox id=chkAllDeleteSeverity name=chkAllDeleteSeverity title='Select All'/></th>"
        End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th  align='center'>Edit</th>"
        End If
    End Sub
    Private Sub m_objSeverityGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSeverityGrid.DataRowTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td><input type=checkbox name='chkSeveritySelect' title='select' /></td>"
        'End If

        '/*Changed By Yasmin on 25th july 2018*/
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            If m_strSeverityID = Args.DataReader("SeverityID") Then
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Request Severity' data-toggle='tooltip' data-placement='bottom'><button type='button' class='edit-bt'  checked=true id=chkSeveritySelect name=chkSeveritySelect onclick='EditRequestSeverity(this," & Args.DataReader("SeverityID") & ")' value=" & Args.DataReader("SeverityID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Request Severity' data-toggle='tooltip' data-placement='bottom'><button type='button' class='edit-bt'  id=chkSeveritySelect name=chkSeveritySelect onclick='EditRequestSeverity(this," & Args.DataReader("SeverityID") & ")' value=" & Args.DataReader("SeverityID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanSevrityDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_Tbl_CRM_Severity " & Args.DataReader("SeverityID"), True), "0")

            If m_strCanSevrityDelete = "0" Then
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkSeverityDelete name=chkSeverityDelete  onclick='select_checkbox(this)' value=" & Args.DataReader("SeverityID") & " >" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Delete Request Severity' data-toggle='tooltip' data-placement='bottom'><input type=checkbox id=chkSeverityDelete name=chkSeverityDelete  onclick='select_checkbox(this)' value=" & Args.DataReader("SeverityID") & " >" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            Else
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = '" & m_strCanSevrityDelete & "'><input type=checkbox id=chkSeverityDelete name=chkSeverityDelete disabled value=" & Args.DataReader("SeverityID") & ">" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Severity is in use. Can not be deleted ' data-toggle='tooltip' data-placement='bottom'><input type=checkbox id=chkSeverityDelete name=chkSeverityDelete disabled value=" & Args.DataReader("SeverityID") & ">" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
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
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestSeverity()

            strGridHTML.Append(objSetting.RequestSeverityTabDetails(GridParameter("cityName"), "AJAXRefresh"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
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
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestSeverity()

            strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))



            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetRequestSeverityDetails(ByVal RequestSeverityID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetRequestSeverityDetails
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
            Dim SeverityCode As String = ""
            Dim Severity As String = ""

            Dim strSQL As String = ""
            strSQL = "Usp_NG2_Sel_Tbl_CRM_Severity_Details " & RequestSeverityID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                strUniqueID = CommonFunctions.Data.CheckIsDBNull(drTabData("SeverityID"), "")
                SeverityCode = CommonFunctions.Data.CheckIsDBNull(drTabData("SeverityCode"), "")
                Severity = CommonFunctions.Data.CheckIsDBNull(drTabData("Severity"), "")

            End If
            strResult = strUniqueID & "##" & SeverityCode & "##" & Severity
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteRequestSeverity(ByVal RequestSeverityID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteRequestPriority
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Request Priority
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   10 Nov 2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0
            arrDelete = RequestSeverityID.Split(",")
            For index = 0 To arrDelete.Length - 1
                    strSQL = "exec usp_NG2_Del_Tbl_CRM_Severity  " & arrDelete(index) & ""
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                Next

            Catch ex As Exception
                Return "Bad Request Found"
            End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveRequestSeverity(ByVal RequestSeverityCode As String, ByVal RequestSeverity As String, ByVal EditSeverityID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestSeverity
        ' Description           : For Saving Request Severity
        ' Created Date           : 11-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim PriorityID As String = ""

            Dim strSQL As String = "Usp_NG2_INS_tbl_CRM_Severity  '" & RequestSeverityCode & "','" & RequestSeverity & "','" & HttpContext.Current.Session("strUserName") & "'," & EditSeverityID & ""
            PriorityID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return PriorityID
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateOrderNumber(ByVal OrderNumber As String) As String
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
            strSQL = "Usp_NG2_CheckDuplicate_OrderNumber '" & OrderNumber & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateSeverityControls(ByVal SeverityCode As String, ByVal Severity As String, ByVal StrFlag As String, ByVal EditSeverityID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateSeverityControls
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Severity Controls
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   9 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If (SeverityCode = "") Then
                SeverityCode = "NULL"
            End If
            If (Severity = "") Then
                Severity = "NULL"
            End If

            strSQL = "usp_NG2_Chk_tbl_CRM_Severity_Validations '" & SeverityCode & "','" & Severity & "','" & StrFlag & "'," & EditSeverityID & ""
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
            Dim objSetting As New CRM_RequestSeverity
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
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 3741 & "','" & UniqueID & "'")
        Else
            txtSQLQuery.Append(storedprocedure)
        End If
        '/*Changed By Yasmin on 25th july 2018*/
        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Modified Date")
        arrColumnHeadingList.Add("Field Modified")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Value")
        '/*Changed By Yasmin on 25th july 2018*/
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
            Dim objSetting As New CRM_RequestSeverity
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 3741, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = objSetting.ShowMailHistoryGrid(MessageID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
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
#End Region
End Class