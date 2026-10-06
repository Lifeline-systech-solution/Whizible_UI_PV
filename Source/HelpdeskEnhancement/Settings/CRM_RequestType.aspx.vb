Public Class CRM_RequestType
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
    Private Shared m_objAccess As WebPage.Templates.AccessRights
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
        Try
            Dim strHTML As New StringBuilder("")

            '-------------------------------------Request inner Horizontal Tabs---------------------------------------------------------->


            strHTML.Append("<div id='Type' class='tabcontent1 h-type clsSettingstabs'>")
            strHTML.Append(RequestTabDetails(strWhichGrid, strGridFlag))
            strHTML.Append("</div>")

            If (strGridFlag.ToUpper = "LOAD") Then
                CommonFunctions.General.WriteHTML(strHTML.ToString)
            Else
                Return strHTML.ToString
            End If
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

#Region "Request Tab Section Related Code"
    Public Function RequestTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
        '=====================================================================
        ' Procedure Name        : RequestTabDetails()	
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
        GetAccessRights()

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='divScroll'>")
        strHTML.Append("<div class='type-top-bar top-bar' id='divTypeTab'>")
        strHTML.Append("<ul class='left'>")
        '/*Changed By Yasmin on 25th july 2018*/
        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccess.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("  <button type='button' onclick='AddRequestType()' style='color:black!important;background-color:white!important' class='btn btn-default' title='Add Request Type'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccess.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("    <button onclick='DeleteRequestType()' type='button' style='color:black!important;background-color:white!important' class='btn btn-default' title='Delete Request Type'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='divRequestTypes'>")
        strHTML.Append(WriteRequestTabGrid("Type", "", ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne'>")
        strHTML.Append("  <h4 class='panel-title'>")
        strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne' aria-expanded='true' aria-controls='collapseOne' id='Addaccordion'>")
        strHTML.Append(" <i class='fa fa-plus' title='Expand'></i>")
        strHTML.Append("<i class='fa fa-minus' title='Hide'></i>")
        strHTML.Append(" </a>")
        strHTML.Append(" </h4>")
        strHTML.Append("   <h3><span>Add Request Type<i class='fa fa-plus'  style='float: none; padding-left: 10px;'></i></span></h3>")

        strHTML.Append(" </div>")
        strHTML.Append(" <div id='collapseOne' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strHTML.Append(" <div class='panel-body' id='idPanelBody'>")
        strHTML.Append("   <form class='form-horizontal' id='frmType' action='/action_page.php'>")
        strHTML.Append("   <div class='form-group'>")
        strHTML.Append("    <label class='control-label col-sm-2' for='request type code'>Request Type Code*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("requesttypecode", "requesttypecode", "form-control", , , , , , , , , , "  class='form-control' placeholder='Enter Request Type Code' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Type*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("requesttype", "requesttype", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Request Type' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='form-group' style='border: none:'>")
        strHTML.Append(" <div class='right'>")
        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append(" <button type='button' onclick='SaveRequestType_Onclick(""Save"")' class='btn btn-default save' style='background-color: #343660; color: #fff;'  >Save</button>")
            strHTML.Append("<button type='button' onclick='SaveAndAddRequestType_Onclick(""SaveAdd"")' class='btn btn-default save clsbuttonLinks' style='background-color: #343660; color: #fff; border-left: 1px solid;'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        '/*Added By Yasmin on 27th july 2018*/
        ''style='margin-right: 19px;'
        strHTML.Append(" <button type='button' onclick='Cancel_RequestType()' class='btn btn-default save'  style='margin-left:1px!important;' >Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='table-responsive' id='tblSubRequestType'>")

        strHTML.Append(" </div>")
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
        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, RequestTypeID))
        'If (strGridFlag = "Ajax") Then
        '    CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        'Else
        Return strGridHTML.ToString
        ' End If
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
    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Vidya Jadhav
        ' Created               :	08-DEC-2016
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

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
        If strWhichGrid.ToUpper = "TYPE" Then
            intNoOfDataColumn = 3
            'strDivID = "divRequestType"
            strSQLQuery = "Usp_Sel_NG2_RequestType"
            arrstrActualList = {"RequestTypeCode", "RequestType", "SubRequestType", "", ""}
            arrstrUserFriendlyList = {"Request Type Code", "Request Type", "Sub Request Type", "Select", "Delete"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objTypeGrid
        ElseIf strWhichGrid.ToUpper = "PLOTSUBREQUESTTYPE" Then
            GetSubTabAccessRights(115, TagID)
            If m_objSubTabAccess.View Then
                intNoOfDataColumn = 2
                strDivID = "divSubRequestType"
                strSQLQuery = "Usp_Sel_NG2_SubRequestTypeCombo "

                arrstrActualList = {"SubRequestType", ""}
                arrstrUserFriendlyList = {"Map Sub Request Type To Request Type", "Select"}
                arrstrLinkArray = {"", ""}
                arrCheckBoxArray = {"", ""}
                arrWidthArray = {"align=left", "align=left"}
                objGrid = m_objSubRequestTypeGrid
            Else
                Flag = 1
            End If
        End If

        If Flag = 0 Then
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
        End If
        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing


        Return strGridHTML.ToString
    End Function
    Protected strClass As String = "clsTROdd"
    Private Sub m_objTypeGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objTypeGrid.DataRowTR_BeforePrint

        'Cancel = True
        'Args.clsTR.Remove()
        'Args.StringToBeInserted = "<tr role='row' class='" & strClass & "'></tr>"

        'If strClass = "clsTROdd" Then
        '    strClass = "clsTREvenRow"
        'End If
    End Sub

    Private Sub m_objTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTypeGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            If m_strRequestTypeID = Args.DataReader("RequestTypeID") Then
                ''Args.StringToBeInserted = "<td align='center' Title = 'Select Checkbox'><a  id=chkRequestTypeSelect name=chkRequestTypeSelect  checked=true onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Request Type'><button type='button' class='edit-bt' data-toggle='tooltip' checked=true id=chkRequestTypeSelect name=chkRequestTypeSelect onclick='Edit_RequestType(" & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Request Type'><button type='button' class='edit-bt' data-toggle='tooltip' id=chkRequestTypeSelect name=chkRequestTypeSelect onclick='Edit_RequestType(" & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If

        If Args.DataField.ToUpper = "SUBREQUESTTYPE" Then
            Cancel = True
            Dim DiscussionThreadless As String = ""
            Dim SubRequestType() As String

            If CommonFunction.Data.CheckIsDBNull(Args.DataReader("SubRequestType"), "") <> "" Then
                SubRequestType = Args.DataReader("SubRequestType").Split(",")
                If SubRequestType.Length > 2 Then
                    Args.StringToBeInserted = "<td align='left' >" & SubRequestType(0) & "," & SubRequestType(1) & "... </TD>"
                Else
                    Args.StringToBeInserted = "<td align='left' >" & SubRequestType(0) & " </TD>"
                End If


            Else
                Args.StringToBeInserted = "<td align='left' > </TD>"
            End If

        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_RequestType " & Args.DataReader("RequestTypeID"), True), "0")

            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            If m_strCanDelete = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Request type is in use, can not be deleted'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete disabled  value=" & Args.DataReader("RequestTypeID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Delete Request Type'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete  value=" & Args.DataReader("RequestTypeID") & " >" + "</TD>"
            End If
        End If


    End Sub
    Private Sub m_objSubRequestTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSubRequestTypeGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            m_strIsTypeMapped = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Sel_tbl_CRM_RequestType_SubRequestType " & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID, True), "0")

            m_strCanUnMap = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Unmap_tbl_CRM_SubRequestType " & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID, True), "0")

            'Change By Yasmin S On 12/11/18
            If m_strIsTypeMapped = "1" And m_strCanUnMap = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Mapped Sub Request Type'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType checked=true disabled onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
            ElseIf m_strIsTypeMapped = "1" And m_strCanUnMap = "0" Then
                If m_objSubTabAccess.Add = True And m_objSubTabAccess.Edit = True Then
                    Args.StringToBeInserted = "<td align='center' Title = 'Map Sub Request Type'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType checked=true onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
                Else
                    Args.StringToBeInserted = "<td align='center' Title = 'You do not have add or edit access'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType  disabled onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
                End If
            Else
                If m_objSubTabAccess.Delete = True Then
                    Args.StringToBeInserted = "<td align='center' Title = 'Map Sub Request Type'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")"" value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
                Else
                    Args.StringToBeInserted = "<td align='center' Title = 'You do not have delete access'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType disabled value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
                End If

            End If
        End If
    End Sub
    Private Sub m_objTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objTypeGrid.ColumnHeaderTD_BeforePrint
        ' Added By Usha Pandit on 15.12.2017 to remove sort
        'Select Case UCase(Trim(Args.DataField & ""))
        '    Case "REQUESTTYPECODE"
        '        Cancel = True
        '        Args.ApplyHTMLEncode = False
        '        Args.ApplySorting = False
        '        Args.TDStyle = " "

        '        Args.StringToBeInserted = "<th align='center'> Request Code<i class='fa fa-sort' aria-hidden='true'></i></th>"
        '    Case "REQUESTTYPE"
        '        Cancel = True

        '        Args.ApplySorting = False
        '        Args.ApplyHTMLEncode = False
        '        Args.StringToBeInserted = "<th align='center'>Request Type<i class='fa fa-sort' aria-hidden='true'></i></th>"

        '    Case "SUBREQUESTTYPE"
        '        Cancel = True

        '        Args.ApplySorting = False
        '        Args.ApplyHTMLEncode = False
        '        Args.StringToBeInserted = "<th align='center'>Sub Request Type<i class='fa fa-sort' aria-hidden='true'></i></th>"

        'End Select
        ' End of addition Usha Pandit on 15.12.2017
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<th style='width:170px'><input onclick='DeleteMultiple_RequestType()' type=checkbox id=chkAllDeleteType name=chkAllDeleteType title='Select All' /></th>"

        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            '  Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
            Args.StringToBeInserted = "<th>Edit</i></th>"
        End If

    End Sub
#End Region
#Region "Jquery AJAX Methods"
    <System.Web.Services.WebMethod>
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
            Dim objSetting As New CRM_RequestType()
            If GridParameter("cityName") = "Type" Then
                strGridHTML.Append(objSetting.RequestTabDetails(GridParameter("cityName"), "AJAXRefresh"))
            End If

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod>
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
            Dim objSetting As New CRM_RequestType()

            strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))



            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function PlotSubRequestType(ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubRequestType
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           :8 Nov -2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestType()

            strGridHTML.Append(objSetting.WriteSubRequestTabGrid("PlotSubRequestType", "PlotSubRequestType", RequestTypeID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod>
    Public Shared Function SaveRequestType(ByVal RequestType As String, ByVal RequestTypeCode As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim RquestTypeID As String = ""
            '' Dim strSQL As String = "exec Usp_NG2_Ins_Upd_tbl_CRM_RequestType  '" & RequestTypeCode & "', '" & RequestType & "','" & SubRequestType & "'," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'," & RequestTypeID & ""
            Dim strSQL As String = "exec Usp_NG2_Ins_Upd_tbl_CRM_RequestType  '" & RequestTypeCode & "', '" & RequestType & "'," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'," & RequestTypeID & ""
            RquestTypeID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return RquestTypeID.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod>
    Public Shared Function MapSubRequestType(ByVal RequestTypeID As String, ByVal SubRequestTypeID As String, ByVal Checked As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim Flag As String = ""
            '' Dim strSQL As String = "exec Usp_NG2_Ins_Upd_tbl_CRM_RequestType  '" & RequestTypeCode & "', '" & RequestType & "','" & SubRequestType & "'," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'," & RequestTypeID & ""
            Dim strSQL As String = "exec Usp_NG2_Map_tbl_CRM_RequestType_SubRequestType  " & RequestTypeID & ", " & SubRequestTypeID & "," & Checked & ""
            Flag = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return Flag.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetRequestTypeDetails(ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetRequestTypeDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of Risk Occurence record
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:  7rd-Nov-2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim strUniqueID As String = ""
            Dim RequestTypeCode As String = ""
            Dim RequestType As String = ""
            Dim strReasonForOccurence As String = ""



            Dim strSQL As String = ""
            strSQL = "Usp_NG2_Sel_tbl_CRM_RequestType " & RequestTypeID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                strUniqueID = CommonFunctions.Data.CheckIsDBNull(drTabData("RequestTypeID"), "")
                RequestTypeCode = CommonFunctions.Data.CheckIsDBNull(drTabData("RequestTypeCode"), "")
                RequestType = CommonFunctions.Data.CheckIsDBNull(drTabData("RequestType"), "")
            End If
            strResult = strUniqueID & "##" & RequestTypeCode & "##" & RequestType


            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''SubRequestTypeCode,SubRequestType,DefaultWork,IsAttachmentMandatory,TaskType,GuidelinesForRequestor,GuidelinesForAssignee,SLARedLimit,SLAYellowLimit


    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteRequestType(ByVal RequestTypeID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Attchments
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
            arrDelete = RequestTypeID.Split(",")

            For index = 0 To arrDelete.Length - 1

                strSQL = "exec usp_NG2_Del_tbl_CRM_RequestType  " & arrDelete(index) & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            Next

        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteSubRequestType(ByVal SubRequestTypeID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteSubRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Sub Type
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
            arrDelete = SubRequestTypeID.Split(",")

            For index = 0 To arrDelete.Length - 1

                strSQL = "exec usp_NG2_Del_tbl_CRM_SubRequestType  " & arrDelete(index) & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            Next

        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function

    'Commented and Added by Usha Pandit on 15.12.2017 for duplicate RequestTypeCode check
    '<System.Web.Services.WebMethod()>
    'Public Shared Function IsDuplicateRequestType(ByVal RequestType As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	IsDuplicateRequestType
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	Check for duplicate Request Type
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Vidya Jadhav
    '    ' Created				:   8 Nov 2017
    '    '=====================================================================
    '    Dim strResult = "0"
    '    Dim strSQL As String
    '    If (RequestType = "") Then
    '        RequestType = "NULL"
    '    End If
    '    strSQL = "Usp_NG2_CheckDuplicate_RequestType '" & RequestType & "'"
    '    strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
    '    Return strResult
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateRequestType(ByVal RequestType As String, ByVal RequestTypeCode As String, ByVal Flag As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Request Type and Request Type Code
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   15 Dec 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If (RequestType = "") Then
                RequestType = "NULL"
            End If
            If (RequestTypeCode = "") Then
                RequestTypeCode = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_RequestType '" & RequestType & "','" & RequestTypeCode & "','" & Flag & "'," & RequestTypeID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ' End of addition Usha Pandit
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateSubRequestType(ByVal SubRequestType As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateSubRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Sub Request Type
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   8 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If (SubRequestType = "") Then
                SubRequestType = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_SubRequestType '" & SubRequestType & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
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
#End Region
End Class