Public Class CRM_User_RoleAccess
    Inherits WebPages.Template.WhizTemplate
    'For Access
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
    Protected Shared strUserName As String = ""
    Protected Shared intUserID As Integer = 0
    Protected Shared m_strUserID As String
    Dim m_strUserName As String
    'End of  Access

    Protected m_lngQueryID As String = ""
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Protected m_intNoOfRecordInGrid As Int16 = 50

    Private WithEvents m_objUserMasterGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objCustomerMasterGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objRoleMasterGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objAccessMasterGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objRoleStatusGrid As New WebPages.Template.GenericGrid

    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected m_objGlobal As WebPages.Template.IGlobal
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private Shared m_objSubTabAccess As WebPage.Templates.AccessRights
    Private Shared m_objReleaseAccess As WebPage.Templates.AccessRights
    Protected m_objAccessRights As WebPages.Security.cAccessRights



    Protected StrRoleDescription As String
    Protected StrEmployeeCode As String
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected Shared TagID As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_strUserID = Session("intUserID")
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("intUserID"), Integer)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
        m_strUserName = CommonFunctions.General.CheckIsNothing(CType((HttpContext.Current.Session("strUserName")), String), "")
        'Dim StrSQL1 As String = "usp_NG2_Sel_All_RoleExistOrNot"
        'Dim StrEmplyeeCode As String = "usp_NG2_Sel_All_EmployeeCodeExistOrNot"
        'Dim drRole As IDataReader
        'Dim drEmployee As IDataReader

        'drRole = CommonFunctions.Data.GetDataReader(StrSQL1, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If drRole.Read Then
        '    StrRoleDescription = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drRole(0), ""), String))
        'End If
        'CommonFunction.Data.DisposeDataReader(drRole)

        'drEmployee = CommonFunctions.Data.GetDataReader(StrEmplyeeCode, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If drEmployee.Read Then
        '    StrEmployeeCode = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drEmployee(0), ""), String))
        'End If
        'CommonFunction.Data.DisposeDataReader(drEmployee)

    End Sub
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
        ' Author                :	Dipali Vekhande
        ' Created               :	10th Nov 2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

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
        ' Author                : Dipali Vekhande
        ' Created               : 6th Nov 2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder


        'strHTML.Append(WriteTabsControls("Type", "Load", ""))
        'If Flag.ToUpper = "LOAD" Then
        '    CommonFunctions.General.WriteHTML(strHTML.ToString)
        'Else
        '    Return strHTML.ToString
        'End If

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

        '---------------------------- Vertical Tabs-----------------------------'
        '-------------------------------------Request inner Horizontal Tabs---------------------------------------------------------->
        strHTML.Append("<div id='RoleMaster' class='tabcontent3 h-type h-form clsSettingstabs'>")
        strHTML.Append(RoleAccessTabDetails(strWhichGrid, strGridFlag))
        strHTML.Append("</div>")

        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function
    ''Department, Role, Status
     
    Public Function RoleAccessTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
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
        GetGlobalObject(23)

        Dim strHTML As New StringBuilder("")

        '   strHTML.Append("<div id='UserMaster' class='tabcontent3 h-type h-form'>")
        strHTML.Append("<div id='divRoleScroll'>")
        strHTML.Append("<div class='type-top-bar top-bar' id='RoleButton'>")

        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRole' placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")

        'strHTML.Append("<ul class='left'>")
        'strHTML.Append("<li class='left search-bar'>")
        'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        'strHTML.Append("<input type='text' id='SearchRole' placeholder='Search in table'>")
        'strHTML.Append("</li>")
        'strHTML.Append("</ul>")


        strHTML.Append(" <ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append(" <li class='clearall'><button type='button' class='btn btn-default' style='color:black!important;background-color:white!important' onclick='AddRole()' title='Add Role'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")        End If        If m_objAccessRights.Delete = True Then            strHTML.Append(" <li class='clearall'><button type='button' class='btn btn-default' style='color:black!important;background-color:white!important' title='Delete Role' onclick='DeleteRole()'>Delete<i class='fa fa-trash-o' aria-hidden=true'></i></button></li>")
        End If
        strHTML.Append(" </ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='tblEmployee'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, "", "", "", ""))
        strHTML.Append("</div>")
        strHTML.Append(" <div class='bottom-bar' >")
        strHTML.Append(" <div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")

        strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='heading1'>")
        strHTML.Append("<h3><span>Add New Role</span></h3>")

        strHTML.Append("<h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' id='Addaccordion' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2'>")
        strHTML.Append("<i class='fa fa-plus' title='Expand'></i>")
        strHTML.Append("<i class='fa fa-minus' title='Hide'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='heading1'>")
        strHTML.Append(" <div class='panel-body' id='RolePanel'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Role Description*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:173px;' class='form-control' id='RoleDescription'  name='RoleDescription' placeholder='Role Description'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("RoleDescription", "RoleDescription", "form-control", 200, , , , , , , , , " class='form-control'  placeholder='Enter Role Description' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Level'>Level*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Cbolevel", "usp_Sel_RoleLevels", 200, , "class='form-control' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-2' for='Standard Billing Rate'>Standard Billing Rate*</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        '' strHTML.Append("<input type='text' style='width:173px;' class='form-control' id='textBillingRate'  name='textBillingRate' placeholder='Standard Billing Rate'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("textBillingRate", "textBillingRate", "form-control", 200, , , , , , , , , " class='form-control'  placeholder='Enter Standard Billing Rate' ", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append("</div>")
        'strHTML.Append(" <label class='control-label col-sm-2' for='cost'>Cost($)*</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        ''strHTML.Append("<input type='textbox' style='width:11px;' id='TextCost' name='TextCost' placeholder='Cost'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("TextCost", "TextCost", "form-control", 200, , , , , , , , , " class='form-control'  placeholder='Enter Cost' ", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append(" </div>	")
        'strHTML.Append("</div>")
        strHTML.Append("<div class='form-group' id='DefaultModuleDiv'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='Default Module'>Default Module*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboModule", "usp_NG2_Sel_Role_Default_Modules", 200, , "class='form-control' ", True, True))
        strHTML.Append("</div>")

        strHTML.Append("  <label class='control-label col-sm-2' for='Department/Unit'>Department/Unit*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRoleDepartMent", "usp_Sel_PM_DepartmentList", 200, , "class='form-control' ", True, True))
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append("  <label class='control-label col-sm-2' for='Authorized to generate invoice'>Authorized to generate invoice</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append(" <input type='checkbox' style='width:11px;' id='GenerateInvoice'>")
        'strHTML.Append(" </div>")
        'strHTML.Append("<label class='control-label col-sm-2' for='Deployable'>Authorized for sales activity</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append(" <input type='checkbox' style='width:11px;' id='SalesActivity'>")
        'strHTML.Append(" </div></div>")

        'strHTML.Append("<div class='form-group'>	")
        'strHTML.Append(" <label class='control-label col-sm-2' for='Default assignment to project'>Default assignment to project</label>")
        'strHTML.Append(" <div class='col-sm-4'>")
        'strHTML.Append(" <input type='checkbox' style='width:11px;' id='CheckAssignment'>")
        'strHTML.Append("</div>")
        'strHTML.Append("<label class='control-label col-sm-2' for='Expiry Date'></label>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("  </div></div>")
        '/*'/*Added by Kashish for ui change*/
        strHTML.Append("<div class='' style='float:right'>")
        strHTML.Append("<div class='col-md-12 push-right'>	")
        ' strHTML.Append("<button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;margin-right:3px;'>Attachment</button>")
        GetGlobalObject(23)
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save'   onclick='SaveRole(""Save"")'>Save</button>")
            'strHTML.Append(" <button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;border-left:1px solid;' onclick='AddSaveRole(""AddSave"")' title='Save and Add'>Save and Add<i class='fa fa-plus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
            strHTML.Append(" <button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;border-left:1px solid;' onclick='AddSaveRole(""AddSave"")' >Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
        End If
        strHTML.Append(" <button type='button' class='btn btn-default save' style='border-left:1px solid;' onclick='CancelRole()'  >Cancel</button>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''Added By Aniruddh Gujar on 18-Dec-2017 Purpose::To add Role Status SubTag
        strHTML.Append("<div class='panel-heading' role='tab' id='Statusheading1' style='display:none;'>")
        strHTML.Append("<h3><span>Map Status to Role</span></h3>")

        strHTML.Append("<h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' id='AddSubtagaccordion' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2'>")
        strHTML.Append("<i class='fa fa-plus' title='Expand'></i>")
        strHTML.Append("<i class='fa fa-minus' title='Hide'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='tblRoleStatus'>")
       
        strHTML.Append(" </div>")
        ''End of Added By Aniruddh Gujar on 18-Dec-2017 Purpose::To add Role Status SubTag
        strHTML.Append("</form>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal strDepartmentFlag As String, ByVal StrRoleFlag As String, ByVal StrStatusFlag As String) As String
        Dim strGridHTML As New StringBuilder("")
        Dim AddAccess As String = ""
        Dim EditAccess As String = ""
        Dim DeleteAccess As String = ""
        Dim ViewAccess As String = ""



        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

        AddAccess = m_objAccess.Add
        EditAccess = m_objAccess.Edit
        DeleteAccess = m_objAccess.Delete
        ViewAccess = m_objAccess.View



        If strDepartmentFlag = "" Then
            strDepartmentFlag = "null"
        End If

        If StrRoleFlag = "" Then
            StrRoleFlag = "null"
        End If

        If StrStatusFlag = "" Then
            StrStatusFlag = "null"
        End If

        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, strDepartmentFlag, StrRoleFlag, StrStatusFlag))

        strGridHTML.Append("<input type=hidden id=hdnAddAccess name=hdnAddAccess value='" & AddAccess & "' />")
        strGridHTML.Append("<input type=hidden id=hdnEditAccess name=hdnEditAccess value='" & EditAccess & "' />")
        strGridHTML.Append("<input type=hidden id=hdnDeleteAccess name=hdnDeleteAccess value='" & DeleteAccess & "' />")
        strGridHTML.Append("<input type=hidden id=hdnViewAccess name=hdnViewAccess value='" & ViewAccess & "' />")

         
            Return strGridHTML.ToString

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function PlotRoleStatus(ByVal RoleID As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubRequestType
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Aniruddh Gujar
        ' Created Date           :18 Dec 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_User_RoleAccess()

            strGridHTML.Append(objSetting.WriteRoleStatusTabGrid("PlotRoleStatus", RoleID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Protected Function WriteRoleStatusTabGrid(ByVal strWhichGrid As String, ByVal RoleID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteSubRequestTabGrid()	
        ' Purpose               : To Plot the Request Tab Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Aniruddh Gujar
        ' Created               : 18 Dec 2017
        ' Revisions             : None
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")

        strGridHTML.Append(WriteRoleStatusMasterGrid(strWhichGrid, RoleID))
        Return strGridHTML.ToString

    End Function
    Private Function WriteRoleStatusMasterGrid(ByVal strWhichGrid As String, ByVal RoleID As String) As String

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

        intNoOfDataColumn = 2

        GetSubTabAccessRights(3377, TagID)
        If m_objSubTabAccess.View Then
            Flag = 0
        Else
            Flag = 1
        End If

        If RoleID = 0 Then
            strSQLQuery = "usp_NG2_sel_n_tbl_CRM_RoleStatus "
        Else
            strSQLQuery = "usp_NG2_sel_n_tbl_CRM_RoleStatus " & RoleID
        End If

        arrstrActualList = {"Status", ""}
        arrstrUserFriendlyList = {"Status", "Select"}
        arrstrLinkArray = {"", ""}
        arrCheckBoxArray = {"", ""}
        arrWidthArray = {"align=left", "align=left"}

        strDivID = "divRoleStatus"

        If Flag = 0 Then
            With m_objRoleStatusGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
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
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
        End If
        m_objRoleStatusGrid = Nothing

        Return strGridHTML.ToString
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function MapRoleStatus(ByVal RoleID As String, ByVal RoleStatusID As String, ByVal Checked As String) As String
        '=====================================================================
        ' Procedure Name        : MapRoleStatus
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
        '====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim Flag As String = ""
            Dim strSQL As String = "exec Usp_NG2_Map_tbl_CRM_RoleStatus  " & RoleID & ", " & RoleStatusID & "," & Checked & "," & HttpContext.Current.Session("intUserID")
            Flag = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return Flag.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
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

        m_objSubTabAccess = New WebPage.Templates.AccessRights
            Dim objGlobal As New WebPage.Templates.WhizGlobal(strUserName, SubtagID, m_intRoleID, intUserID, strLoginType, False, TagID)
            m_objSubTabAccess.GetAccess(objGlobal)

    End Function
    Private Function WriteHelpdeskMasterGrid(ByVal strWhichGrid As String, ByVal strDepartmentFlag As String, ByVal StrRoleFlag As String, ByVal StrStatusFlag As String) As String
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""

        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String

        If strDepartmentFlag = "" Then
            strDepartmentFlag = "null"
        End If

        If StrRoleFlag = "" Then
            StrRoleFlag = "null"
        End If

        If StrStatusFlag = "" Then
            StrStatusFlag = "null"
        End If


        intNoOfDataColumn = 1
        strDivID = "divRole"
        strSQLQuery = "usp_NG2_Sel_v_tbl_PM_Role"

        arrstrActualList = {"RoleDescription", "Edit", "Select"}
        arrstrUserFriendlyList = {"Role Description", "Edit", ""}
        arrstrLinkArray = {"", "", "", ""}
        arrCheckBoxArray = {"", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}

        objGrid = m_objRoleMasterGrid

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = ""
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            '.ClientSideSortFunctionName = "Sort_OnClickwe_For_CRM"
            '.SortBy = strSortBy
            '.SortOrder = strSortOrder
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With

        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing

        Return strGridHTML.ToString
    End Function

    Private Sub m_objRoleStatusGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objRoleStatusGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            If Args.DataReader("StatusFlag").toUpper = "TRUE" Then
                Args.StringToBeInserted = "<td align='center' title = 'Map Role Status' data-placement='bottom'><input type=checkbox id=chkMapRoleStatus checked=true name=chkMapRoleStatus onclick=""MapRoleStatus(this," & Args.DataReader("StatusID") & "," & Args.DataReader("RoleID") & ")""  value=" & Args.DataReader("StatusID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' title = 'Map Role Status' data-placement='bottom'><input type=checkbox id=chkMapRoleStatus name=chkMapRoleStatus onclick=""MapRoleStatus(this," & Args.DataReader("StatusID") & "," & Args.DataReader("RoleID") & ")""  value=" & Args.DataReader("StatusID") & ">" + "</TD>"
            End If

        End If
    End Sub
    Private Sub m_objUserMasterGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objUserMasterGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkUserMaster' id='chkUserMaster' title='Select All' data-placement='top' onclick='SelectAll_Checkbox(this)'/></th>"
        End If
    End Sub

    Private Sub m_objRoleMasterGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objRoleMasterGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkRoleSelect' id='chkRoleSelect' title='Select All' data-placement='top' onclick='SelectRoleAll_Checkbox(this)'/></th>"
        End If
    End Sub

    Private Shared Sub m_objUserMasterGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objUserMasterGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure  Name		:	m_objGrid_DataRowTD_BeforePrint
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	to dispaly UserMaster Grid
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	 6th Nov 2017
        ' Revisions				:	
        '=====================================================================
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td style='text-align:center;width:1%;position:absolute!important' title='Edit Role'  ><i class='fa fa-pencil-square-o'  style='font-size:16px!important;cursor:pointer;' onclick=""Employee_OnClick(" & Args.DataReader("EmployeeID") & ")""  id='Editdata_" & Args.DataReader("EmployeeID") & "'  ></i></td>"
        End If

        If Args.DataField.ToUpper = "EMPLOYEENAME" Then
            Cancel = True
            Args.StringToBeInserted = "<TD nowrap; ><A href=""JavaScript:Employee_OnClick(" & CType(Args.DataReader("EmployeeID"), String) & ")"">" & Args.DataReader("EmployeeName").ToString & "" & "</A></br></TD>"
        End If

        Dim m_strCanDelete As String
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            ' Args.StringToBeInserted = "<TD  title=" & Args.DataField & "><input type=checkbox name='chkUserMasterSelect' Id='chkUserMaster_" & Args.DataReader("EmployeeID") & " title='Select Record' onclick='ListCheckBox_OnClick(this," & Args.DataReader("EmployeeID") & ")' value=" & Args.DataReader("EmployeeID") & " ></TD>"
            Cancel = True
            ' Args.StringToBeInserted = "<TD nowrap; title=" & Args.DataField & "><input type=checkbox name='chkchkRoleMasterSelect' Id='chkRoleMaster_" & Args.DataReader("RoleID") & " title='Select Record' onclick='RoleListCheckBox_OnClick(this," & Args.DataReader("RoleID") & ")' value=" & Args.DataReader("RoleID") & " ></TD>"
            Cancel = True
            '  m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_tbl_PM_EmployeeEdit " & Args.DataReader("EmployeeID"), True), "0")

            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            If m_strCanDelete = "0" Then
                Args.StringToBeInserted = "<td align='' Title = 'Delete '><input type=checkbox id='chkUserMasterSelect'" & Args.DataReader("EmployeeID") & " name=chkUserMasterSelect   value=" & Args.DataReader("EmployeeID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='' Title = '" & m_strCanDelete & "' ><input type=checkbox id='chkUserMasterSelect'" & Args.DataReader("EmployeeID") & " name=chkUserMasterSelect disabled  value=" & Args.DataReader("EmployeeID") & " >" + "</TD>"
            End If
        End If
    End Sub
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
        ' Created               :	2 Dec 2016
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
    Private Shared Sub m_objRoleMasterGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objRoleMasterGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure  Name		:	m_objGrid_DataRowTD_BeforePrint
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	to dispaly UserMaster Grid
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:	6th Nov 2017
        ' Revisions				:	
        '=====================================================================
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td style='text-align:center;width:1%;'  title='Edit Role'><i class='fa fa-pencil-square-o'  style='font-size:16px!important;cursor:pointer;' onclick=""Role_OnClick(" & Args.DataReader("RoleID") & ")""   id='Editdata_" & Args.DataReader("RoleID") & "'></i></td>"
        End If

        If Args.DataField.ToUpper = "ROLEDESCRIPTION" Then
            Cancel = True
            Args.StringToBeInserted = "<TD nowrap;>" & Args.DataReader("RoleDescription").ToString & "" & "</TD>"
        End If

        Dim m_strCanDelete As String
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            ' Args.StringToBeInserted = "<TD nowrap; title=" & Args.DataField & "><input type=checkbox name='chkchkRoleMasterSelect' Id='chkRoleMaster_" & Args.DataReader("RoleID") & " title='Select Record' onclick='RoleListCheckBox_OnClick(this," & Args.DataReader("RoleID") & ")' value=" & Args.DataReader("RoleID") & " ></TD>"
            Cancel = True
            m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_tbl_PM_RoleEdit " & Args.DataReader("RoleID"), True), "0")

            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            If m_strCanDelete = "0" Then
                Args.StringToBeInserted = "<td align='' Title = 'Delete Role' ><input type=checkbox id='chkchkRoleMasterSelect'" & Args.DataReader("RoleID") & " name=chkchkRoleMasterSelect  onclick='select_checkbox(this)' value=" & Args.DataReader("RoleID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='' Title = '" & m_strCanDelete & "'  ><input type=checkbox id='chkchkRoleMasterSelect'" & Args.DataReader("RoleID") & " name=chkchkRoleMasterSelect disabled  value=" & Args.DataReader("RoleID") & " >" + "</TD>"
            End If
        End If


        'If Args.ColumnName.ToUpper = "DELETE" Then
        '    Cancel = True
        '    m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_tbl_PM_RoleEdit " & Args.DataReader("RoleID"), True), "0")

        '    '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        '    If m_strCanDelete = "1" Then
        '        Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete disabled  value=" & Args.DataReader("RoleID") & ">" + "</TD>"
        '    Else
        '        Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete  value=" & Args.DataReader("RoleID") & " >" + "</TD>"
        '    End If
        'End If
    End Sub
    Protected Function WritePaging(PageNumber As Integer, ByVal strFlag As String, Optional ByVal GridParameter As Object = Nothing) As String
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To plot pagination of the grid
        ' Created Date           : 6th Nov 2017
        '=====================================================================

        Dim strPagingHTML As New StringBuilder("")
        Dim strSQL As String = "usp_NG2_Sel_v_tbl_PM_Employee"

        m_intPageNumber = PageNumber
        'If Not GridParameter Is Nothing Then
        '    strSQL = WriteHelpdeskMasterGrid("UserMaster")
        'Else
        '    strSQL = WriteHelpdeskMasterGrid(GridParameter)
        'End If

        strSQL = strSQL.Replace("usp_NG2_Sel_v_tbl_PM_Employee", "usp_NG2_Sel_v_tbl_PM_EmployeeCount")

        'm_dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "default", , , MyBase.UseSQL)

        m_intTotalNoOfRows = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), 0)

        If Math.Ceiling(m_intTotalNoOfRows / m_intNoOfRecordInGrid) < m_intPageNumber Then
            m_intPageNumber = 1
        End If


        strPagingHTML.Append("<ul class='pagination'>")
        strPagingHTML.Append("<li>")

        strPagingHTML.Append("<a href='#' onclick=FirstPage(1);>")
        strPagingHTML.Append("<span>&laquo;</span>")
        strPagingHTML.Append("</a>")

        strPagingHTML.Append("<a href='#'  onclick=PreviousePage(" & m_intPageNumber - 1 & ");>	")
        strPagingHTML.Append("<span >&#8249;</span>")
        'strPagingHTML.Append("<span class='sr-only'>Previous</span>")
        strPagingHTML.Append("</a>")
        strPagingHTML.Append("</li>")

        If m_intPageNumber <> 0 And m_intPageNumber <> -1 Then
            strPagingHTML.Append("<li><a style='background: #c0c0c0;color:#000;font-weight:600;' href='#'>" & ((m_intNoOfRecordInGrid * m_intPageNumber) - m_intNoOfRecordInGrid + 1).ToString & " - " & (IIf(m_intNoOfRecordInGrid * m_intPageNumber > m_intTotalNoOfRows, m_intTotalNoOfRows, m_intNoOfRecordInGrid * m_intPageNumber)).ToString & " of " & (Math.Ceiling(m_intTotalNoOfRows)).ToString & "</a></li>	")
        End If

        strPagingHTML.Append("<li>")
        strPagingHTML.Append("<a href='#' onclick=NextPage(" & m_intPageNumber + 1 & ");>")
        strPagingHTML.Append("<span>&#8250;</span>")
        strPagingHTML.Append("</a>")
        strPagingHTML.Append("<a href='#' onclick=LastPage(" & (Math.Ceiling(m_intTotalNoOfRows / m_intNoOfRecordInGrid)) & ");>")
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

    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object, ByVal Department As String, ByVal Role As String, ByVal Status As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid0
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_User_RoleAccess As New CRM_User_RoleAccess()
            If Department = "" Then
                Department = "null"
            End If
            If Role = "" Then
                Role = "null"
            End If
            If Status = "" Then
                Status = "null"
            End If
            strGridHTML.Append(objCRM_User_RoleAccess.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", Department, Role, Status))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshPlotControls(ByVal GridParameter As Object, ByVal Department As String, ByVal Role As String, ByVal Status As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshPlotControls
        ' Description           : For Refreshing The grid0
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_User_RoleAccess As New CRM_User_RoleAccess()
            If Department = "" Then
                Department = "null"
            End If
            If Role = "" Then
                Role = "null"
            End If
            If Status = "" Then
                Status = "null"
            End If
            '  If GridParameter("cityName") = "UserMaster" Then
            strGridHTML.Append(objCRM_User_RoleAccess.RoleAccessTabDetails(GridParameter("cityName"), "AJAXRefresh"))
            ' ElseIf GridParameter("cityName") = "RoleMaster" Then
            ' strGridHTML.Append(objCRM_User_RoleAccess.UserMasterTabDetails(GridParameter("cityName"), "AJAXRefresh", Department, Role, Status))
            ' End If


            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod> _
    Public Shared Function GetEmployeeDetails(ByVal EmployeeID As String) As String
        '=====================================================================
        ' Procedure Name        : GetEmployeeDetails
        ' Description           : To Get Flag details when clicked
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            Dim drProjectCount As IDataReader
            Dim blnComplete As Boolean
            Dim DueDate As String
            Dim FlagTo As String = ""
            Dim EmployeeName As String
            Dim EmployeeCode As String
            Dim UserName As String
            Dim IsLDAPAuthentication As String
            Dim BirthDate As String
            Dim EmailID As String
            Dim Address As String
            Dim City As String
            Dim PinCode As String
            Dim EmployeeType As String
            Dim CurrentAddress As String
            Dim CurrentCity As String
            Dim CurrentPinCode As String
            Dim CurrentState As String
            Dim ReportingTo As String
            Dim RoleName As String
            Dim PassportNumber As String
            Dim PP_PlaceOfIssue As String
            Dim PP_FullName As String
            Dim PP_ExpiryDate As String
            Dim PP_DateOfIssue As String
            Dim DepartmentID As String
            Dim NoofPagesLeft As String
            Dim Deployable As String
            Dim RatePerHour As String
            Dim LocationID As String
            Dim BusinessGroupID As String
            Dim Location As String
            Dim State As String
            Dim CostPerHour As String = ""
            Dim m_intUniqueID As Integer = 0
            Dim PP_RelativeName As String
            Dim JoiningDate As String
            drProjectCount = CommonFunctions.Data.GetDataReader("usp_NG2_Sel_v_tbl_PM_EmployeeEdit " & EmployeeID & "", True)
            If drProjectCount.Read Then
                EmployeeName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("EmployeeName").ToString, "")
                EmployeeCode = CommonFunctions.Data.CheckIsDBNull(drProjectCount("EmployeeCode").ToString, "")
                UserName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("UserName").ToString, "")
                IsLDAPAuthentication = CommonFunctions.Data.CheckIsDBNull(drProjectCount("IsLDAPAuthentication").ToString, "")
                BirthDate = CommonFunctions.Data.CheckIsDBNull(drProjectCount("BirthDate").ToString, "")
                EmailID = CommonFunctions.Data.CheckIsDBNull(drProjectCount("EmailID").ToString, "")

                Address = CommonFunctions.Data.CheckIsDBNull(drProjectCount("Address").ToString, "")
                City = CommonFunctions.Data.CheckIsDBNull(drProjectCount("City").ToString, "")
                PinCode = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PinCode").ToString, "")
                State = CommonFunctions.Data.CheckIsDBNull(drProjectCount("State").ToString, "")
                CurrentAddress = CommonFunctions.Data.CheckIsDBNull(drProjectCount("CurrentAddress").ToString, "")
                CurrentCity = CommonFunctions.Data.CheckIsDBNull(drProjectCount("CurrentCity").ToString, "")

                CurrentState = CommonFunctions.Data.CheckIsDBNull(drProjectCount("CurrentState").ToString, "")
                CurrentPinCode = CommonFunctions.Data.CheckIsDBNull(drProjectCount("CurrentPinCode").ToString, "")

                RoleName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PostID").ToString, "")
                EmployeeType = CommonFunctions.Data.CheckIsDBNull(drProjectCount("EmployeeType").ToString, "")
                ReportingTo = CommonFunctions.Data.CheckIsDBNull(drProjectCount("ReportingTo").ToString, "")
                PassportNumber = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PassportNumber").ToString, "")
                PP_PlaceOfIssue = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PP_PlaceOfIssue").ToString, "")
                PP_FullName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PP_FullName").ToString, "")
                PP_ExpiryDate = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PP_ExpiryDate").ToString, "")
                PP_DateOfIssue = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PP_DateOfIssue").ToString, "")
                NoofPagesLeft = CommonFunctions.Data.CheckIsDBNull(drProjectCount("NoofPagesLeft").ToString, "")
                DepartmentID = CommonFunctions.Data.CheckIsDBNull(drProjectCount("DepartmentID").ToString, "")


                RatePerHour = CommonFunctions.Data.CheckIsDBNull(drProjectCount("RatePerHour").ToString, "")
                CostPerHour = CommonFunctions.Data.CheckIsDBNull(drProjectCount("CostPerHour").ToString, "")
                Deployable = CommonFunctions.Data.CheckIsDBNull(drProjectCount("Deployable").ToString, "")
                BusinessGroupID = CommonFunctions.Data.CheckIsDBNull(drProjectCount("BusinessGroupID").ToString, "")
                LocationID = CommonFunctions.Data.CheckIsDBNull(drProjectCount("LocationID").ToString, "")
                Location = CommonFunctions.Data.CheckIsDBNull(drProjectCount("Location").ToString, "")
                PP_RelativeName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PP_RelativeName").ToString, "")
                JoiningDate = CommonFunctions.Data.CheckIsDBNull(drProjectCount("JoiningDate").ToString, "")



            End If

            Return EmployeeName & "#$#" & EmployeeCode & "#$#" & UserName & "#$#" & IsLDAPAuthentication & "#$#" & BirthDate & "#$#" & Address & "#$#" & City & "#$#" & PinCode & "#$#" & State.ToString & "#$#" & CurrentAddress & "#$#" & CurrentCity & "#$#" & CurrentPinCode & "#$#" & CurrentState & "#$#" & RoleName & "#$#" & EmployeeType & "#$#" & ReportingTo & "#$#" & PassportNumber & "#$#" & PP_PlaceOfIssue & "#$#" & PP_FullName & "#$#" & PP_DateOfIssue & "#$#" & NoofPagesLeft & "#$#" & DepartmentID & "#$#" & EmailID & "#$#" & PP_ExpiryDate & "#$#" & RatePerHour & "#$#" & CostPerHour & "#$#" & Deployable & "#$#" & BusinessGroupID & "#$#" & Location & "#$#" & LocationID & "#$#" & PP_RelativeName & "#$#" & JoiningDate & ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function



    <System.Web.Services.WebMethod> _
    Public Shared Function GetRoleDetails(ByVal RoleID As String) As String
        '=====================================================================
        ' Procedure Name        : GetRoleDetails
        ' Description           : To Get RoleDetails
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            Dim drRoleCount As IDataReader
            Dim blnComplete As Boolean
            Dim DueDate As String
            Dim FlagTo As String = ""
            Dim RoleDescription As String
            Dim DefaultModule As String
            Dim Level As String
            Dim IsAuthorisedToGenerateInvoice As String
            Dim AuthorisedForSalesActivity As String
            Dim AssignToProjectByDefault As String
            Dim Rate As String
            Dim RoleCost As String
            Dim EmployeeType As String
            Dim DepartmentID As String

            Dim strContextType As String = ""
            Dim m_intUniqueID As Integer = 0


            drRoleCount = CommonFunctions.Data.GetDataReader("usp_NG2_Sel_v_tbl_PM_RoleEdit " & RoleID & "", True)
            If drRoleCount.Read Then
                RoleDescription = CommonFunctions.Data.CheckIsDBNull(drRoleCount("RoleDescription").ToString, "")
                DefaultModule = CommonFunctions.Data.CheckIsDBNull(drRoleCount("DefaultModule").ToString, "")
                Level = CommonFunctions.Data.CheckIsDBNull(drRoleCount("Level").ToString, "")
                IsAuthorisedToGenerateInvoice = CommonFunctions.Data.CheckIsDBNull(drRoleCount("IsAuthorisedToGenerateInvoice").ToString, "")
                AuthorisedForSalesActivity = CommonFunctions.Data.CheckIsDBNull(drRoleCount("AuthorisedForSalesActivity").ToString, "")
                AssignToProjectByDefault = CommonFunctions.Data.CheckIsDBNull(drRoleCount("AssignToProjectByDefault").ToString, "")
                Rate = CommonFunctions.Data.CheckIsDBNull(drRoleCount("Rate").ToString, "")
                RoleCost = CommonFunctions.Data.CheckIsDBNull(drRoleCount("RoleCost").ToString, "")
                DepartmentID = CommonFunctions.Data.CheckIsDBNull(drRoleCount("DepartmentID").ToString, "")

                'IsLDAPAuthentication = CommonFunctions.Data.CheckIsDBNull(drRoleCount("IsLDAPAuthentication").ToString, "")
                'BirthDate = CommonFunctions.Data.CheckIsDBNull(drRoleCount("BirthDate").ToString, "")
                'EmailID = CommonFunctions.Data.CheckIsDBNull(drRoleCount("EmailID").ToString, "")


            End If

            Return RoleDescription & "#$#" & DefaultModule & "#$#" & Level & "#$#" & IsAuthorisedToGenerateInvoice & "#$#" & AuthorisedForSalesActivity & "#$#" & AssignToProjectByDefault & "#$#" & Rate & "#$#" & RoleCost & "#$#" & DepartmentID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod> _
    Public Shared Function SaveRoleDescription(ByVal RoleDescription As String, ByVal ModuleValue As String, ByVal level As String, ByVal textBillingRate As String, ByVal TextCost As String, ByVal CboRoleDepartMent As String, ByVal GenerateInvoicevalue As String, ByVal SalesActivityvalue As String, ByVal CheckAssignmentvalue As String, ByVal RoleID As String) As String
        '=====================================================================
        ' Procedure Name        : GetRoleDetails
        ' Description           : To Get RoleDetails
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            Dim m_intUniqueID As Integer = 0
            Dim strSQL As String
            Dim m_RoleId As String

            strSQL = "exec usp_NG2_INS_v_tbl_PM_RoleNew  '" & RoleDescription & "'," & textBillingRate & "," & TextCost & ",'" & ModuleValue & "'," & level & "," & CboRoleDepartMent & "," & GenerateInvoicevalue & "," & SalesActivityvalue & "," & CheckAssignmentvalue & "," & RoleID & ""

            m_RoleId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return m_RoleId
        Catch ex As Exception

            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveEmployeeDetails(ByVal EmployeeName As String, ByVal EmployeeCode As String, ByVal UserName As String, ByVal LdapValue As String, ByVal Bdate As String, ByVal JoiningDate As String, ByVal EmailID As String, ByVal CurrentAddess As String, ByVal CurrentAddess1 As String, ByVal CurrentCity As String, ByVal CurrentCity1 As String, ByVal CurrentState As String, ByVal CurrentState1 As String, ByVal CurrentPincode As String, ByVal CurrentPincode1 As String, ByVal CboRoleEdit As String, ByVal CboDepartmentUnitEdit As String, ByVal CboEmplyeeType As String, ByVal CboReportingTo As String, ByVal txtRatehrs As String, ByVal txtCosthrs As String, ByVal CboDeployable As String, ByVal BusinessGroupID As String, ByVal CboOrganizationUnit As String, ByVal PssportNo As String, ByVal DateIssue As String, ByVal PlcIssue As String, ByVal ExDate As String, ByVal FullName As String, ByVal SonWife As String, ByVal NoLeftPage As String, ByVal EmployeeID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveEmployeeDetails
        ' Description           : To  Save EmployeeDetails
        ' Created Date           : 9th Nov 2017
        '=====================================================================
        Try
            Dim m_intUniqueID As Integer = 0
            Dim strSQL As String
            Dim m_EmployeeId As String

            If CboEmplyeeType = "" Then
                CboEmplyeeType = "Null"
            End If

            If UserName = "" Then
                UserName = "Null"
            End If

            If EmployeeCode = "" Then
                EmployeeCode = "Null"
            End If

            If CboDeployable = "" Then
                CboDeployable = "Null"
            End If

            If PlcIssue = "" Then
                PlcIssue = ""
            End If



            If FullName = "" Then
                FullName = ""
            End If
            If SonWife = "" Then
                SonWife = ""
            End If

            If PssportNo = "" Then
                PssportNo = ""
            End If

            If NoLeftPage = "" Then
                NoLeftPage = "Null"
            End If


            If NoLeftPage = "" Then
                NoLeftPage = "Null"
            End If

            If CurrentAddess = "" Then
                CurrentAddess = ""
            End If

            If CurrentCity = "" Then
                CurrentCity = ""
            End If


            If CurrentCity1 = "" Then
                CurrentCity1 = ""
            End If


            If CurrentPincode = "" Then
                CurrentPincode = ""
            End If


            If CurrentPincode1 = "" Then
                CurrentPincode1 = ""
            End If


            If CurrentAddess1 = "" Then
                CurrentAddess1 = ""
            End If


            If CurrentState = "" Then
                CurrentState = "Null"
            End If

            If CurrentState1 = "" Then
                CurrentState1 = ""
            End If

            If CboReportingTo = "" Then
                CboReportingTo = "Null"
            End If

            If CboOrganizationUnit = "" Then
                CboOrganizationUnit = ""
            End If


            strSQL = "exec usp_NG2_Ins_v_tbl_PM_Employee  '" & EmployeeName & "','" & EmployeeCode & "','" & UserName & "'," & LdapValue & ",'" & Bdate & "','" & EmailID & "','" & CurrentAddess & "','" & CurrentAddess1 & "','" & CurrentCity & "','" & CurrentCity1 & "','" & CurrentState & "','" & CurrentState1 & "','" & CurrentPincode & "','" & CurrentPincode1 & "'," & CboRoleEdit & "," & CboDepartmentUnitEdit & ",'" & CboEmplyeeType & "'," & CboReportingTo & ",'" & JoiningDate & "'," & txtRatehrs & "," & txtCosthrs & ",'" & CboDeployable & "'," & BusinessGroupID & "," & CboOrganizationUnit & ",'" & PssportNo & "','" & DateIssue & "','" & PlcIssue & "','" & ExDate & "','" & FullName & "','" & SonWife & "'," & NoLeftPage & "," & EmployeeID & ""
            'strSQL +=  & CurrentCity1 & " '""

            m_EmployeeId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))

            Return m_EmployeeId
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteRole(ByVal RoleIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteRole
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Attchments
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   8 Nov 2017
        '=====================================================================

        Try
            Dim strSQL As String = ""
            Dim arrDelete() As String
            Dim index As Integer = 0
            Dim Flag As Integer = 0
            Dim Restult As String
            arrDelete = RoleIDs.Split(",")


            For index = 0 To arrDelete.Length - 1

                strSQL = "exec usp_NG2_Del_Role_RoleMaster  " & arrDelete(index) & ""

                'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
                Flag = 1
            Next



            If (Restult <> "") Then
                Return Restult
            Else
                Return "0"
            End If

            Return Restult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetOU(ByVal TypeID As String)
        Try
            Dim strSQL As String
            Dim strBussinessGroupID As String
            Dim strProjectID As String
            Dim strLocationID As String
            strBussinessGroupID = TypeID
            Dim dtBG As DataTable
            Dim strHTML As New StringBuilder()
            Dim strResult As String = ""
            Dim strScript As String()
            'Dim strProjectID As String
            If strProjectID = "" Then
                strProjectID = "NULL"
            End If
            strSQL = "usp_Sel_GetBusinessGroupsForLocation " & strBussinessGroupID & "," & strProjectID & ",0,1"
            Dim strResult_ProjectDetails As New System.Text.StringBuilder
            Dim drStaffingDetails As SqlClient.SqlDataReader = CommonFunctions.Data.GetSQLDataReader(strSQL)
            'If (drStaffingDetails.HasRows) Then
            '    While (drStaffingDetails.Read())
            '        strResult_ProjectDetails.Append(drStaffingDetails("OUPoolID").ToString())
            '        'strResult_ProjectDetails.Append(",")
            '        strResult_ProjectDetails.Append(drStaffingDetails("Location").ToString())
            '        'strResult_ProjectDetails.Append("$")
            '    End While
            'End If
            'CommonFunctions.Data.DisposeDataReader(CType(drStaffingDetails, SqlClient.SqlDataReader))
            dtBG = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtBG)

            strScript = strResult.Split("|")
            'strValidation = strScript(1)
            strHTML.Append(strScript(0) + vbCrLf)

            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteEmployee(ByVal strEmployeeIDs As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteRole
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Employee
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   10 Nov 2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
            Dim arrDelete() As String
            Dim index As Integer = 0
            Dim Flag As Integer = 0
            Dim Restult As String
            arrDelete = strEmployeeIDs.Split(",")



            For index = 0 To arrDelete.Length - 1

                strSQL = "exec usp_NG2_Del_Employee_EmployeeMaster  " & arrDelete(index) & ""

                'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
                Flag = 1
            Next



            If (Restult <> "") Then
                Return Restult
            Else
                Return "0"
            End If

            Return Restult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function




    <System.Web.Services.WebMethod()>
    Public Shared Function CheckRoleDescription(ByVal RoleDescription As String, ByVal RoleID As String)
        '==================================================================================
        ' Procedure Name	:	CheckRoleDescription
        ' Purpose			:	To check is duplicate Role Description
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Dipali V
        ' Created			:	13-Dec-2017
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String

            strSQL = "usp_NG2_Sel_All_RoleExistOrNot '" & RoleDescription & "'," & RoleID & ""
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
End Class