Public Class Security_login_customer
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objEmpGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected Shared TagID As String = ""
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
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
        ' Author                :	Yogesh Jalamkar
        ' Created               :	08-DEC-2017
        ' Revisions             :
        '=====================================================================
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal
    End Sub
    Protected Function WritePage(Optional ByVal strflag = "")
        '=====================================================================
        ' Procedure Name        : WriteTabsControls()	
        ' Purpose               : To Plot the Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               :08-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        '-------------------------------------Request inner Horizontal Tabs---------------------------------------------------------->
        GetAccessRights()
        'strHTML.Append("<div id='Type' class='tabcontent1 h-type clsSettingstabs'>")
        'strHTML.Append("<div id='divScroll'>")
        strHTML.Append(DrawFilter())
        strHTML.Append(DrawDetails())
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        If strflag = "1" Then
            Return strHTML.ToString()
        Else
            CommonFunction.General.WriteHTML(strHTML.ToString)
        End If
    End Function
    Protected Function DrawFilter() As String
        '=====================================================================
        ' Procedure Name        :DrawFilter()
        ' Purpose               : To Plot the Request Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                :YOgesh Jalamkar
        ' Created               :08-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar' id='CustomerFilter'>")
        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='txtSearchHistory' placeholder='Search in table' placeholder='Search in table'>")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccess.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' class='btn btn-default addcustomer' title='Add Customer Login' onclick='AddCustomer()'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If
        If m_objAccess.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' class='btn btn-default deletecustomer' title='Delete Customer Login' onclick='DeleteCustomer()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function DrawDetails() As String
        '=====================================================================
        ' Procedure Name        :DrawDetails()
        ' Purpose               : To Plot customer page details
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               : 08-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        ''Grid Plotting Start
        strHTML.Append("<div class='table-responsive' id='divCustomerGrid'>")
        strHTML.Append(DrawCustomerGrid())
        strHTML.Append("</div>")
        ''Grid Plotting End
        ''Collapse Button Start
        strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom edit_target'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'> Add Customer Login</span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class=''><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;font-size: 11px'>Customer Name* </label>")
        strHTML.Append("<div class='col-sm-4' style='margin-top: 5px;'>")
        '<select class="form-control" id="CboEmplyeeType" name="CboEmplyeeType" style="width:217px "><option value="Select User"></option><option title="Contract" value="Contract">Contract</option><option title="Hourly" value="Hourly">Hourly</option><option title="Salary" value="Salary">Salary</option></select>
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboUserName", "usp_Sel_tbl_PM_Employee  NULL,1", 129, , " onchange='UserName_OnChange(this)' class='form-control' ", False, True, "form-control"))
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboUserName", "usp_Sel_tbl_PM_Customer NULL,1", 200, , "onchange='UserName_OnChange(this)' class='form-control' placeholder='Enter Customer Name' ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;font-size: 11px'> Login Name* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type="text" style="width:217px;" class="form-control" id="Text1" name="" placeholder="Enter Login Name">")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtLoginName", "txtLoginName", "form-control", 219, 30, , , , , , , , " class='form-control' placeholder='Enter Login Name'  ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'><label class='control-label col-sm-2' for='request type' style='text-align: right;font-size: 11px'>Password*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        '<input type="Textbox" name="SubrequesttypeCode" id="SubrequesttypeCode" class="form-control" style="text-align:Left" value="" placeholder="Enter Password Name">
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPassword", "txtPassword", "form-control", 219, 30, , , , , , , , " class='form-control' placeholder='Enter Password'  ", returnHTML:=True, IsPassword:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type' style='text-align: right;font-size: 11px'>Confirm Password*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        '<input type="Textbox" name="Sub_WorkHrs" id="Sub_WorkHrs" class="form-control" style="text-align:Left" value="" placeholder="Confirm Password Name"> 
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtConfirmPassword", "txtConfirmPassword", "form-control", 219, 100, , , , , , , , " class='form-control'  placeholder='Enter Confirm Password'  ", returnHTML:=True, IsPassword:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        '/*Changed By Yasmin on 25th july 2018*/
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")
        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveLogin()' style='background-color: #343660; color: #ffffff'>Save</button>")
            strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks'  onclick='SaveAndAddLogin()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
            strHTML.Append("<button type='button' id='Deactivate' class='btn btn-default save clsbuttonLinks'  onclick='Deactivate_Login()' style=' display:none;   margin-left: 5px; background-color: #343660; color: #ffffff'>Deactivate Login</button>")
        End If
        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks'  onclick='Cancel_Login()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff'>Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''Collapse Button End      
        Return strHTML.ToString
    End Function
    Protected Function DrawCustomerGrid() As String
        '=====================================================================
        ' Procedure Name        :DrawCustomerGrid()
        ' Purpose               : To Plot employee grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               : 08-DEC-2017
        ' Revisions             : None
        '=====================================================================
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
        '/*Commented By Yasmin on 25th july 2018*/
        intNoOfDataColumn = 3
        strDivID = "divCustomerLogin"
        'strSQLQuery = "Usp_NG2_Sel_v_tbl_PM_Login"
        strSQLQuery = "usp_NG_Sel_tbl_PM_Login "
        arrstrActualList = {"LoginName", "UserName", "IsActiveLogin", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Login Name", "Customer Name", "Is Active", "Edit", "Delete"}
        arrstrLinkArray = {"", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}
        objGrid = m_objEmpGrid
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
            'intRecordCount = m_objGridAttachment.NoOfRows
            objGrid = Nothing
        End If
        Return strGridHTML.ToString
    End Function
    Private Sub m_objEmpGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objEmpGrid.DataRowTR_BeforePrint
        'Cancel = True
        'Args.clsTR.Remove()
        'Args.StringToBeInserted = "<tr role='row' class='" & strClass & "'></tr>"
        'If strClass = "clsTROdd" Then
        '    strClass = "clsTREvenRow"
        'End If
    End Sub
    Private Sub m_objEmpGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objEmpGrid.DataRowTD_BeforePrint
        Dim IsActiveLogin As String
        Dim strSQlIsActiveLogin As String = "Select isnull(IsActiveLogin,0) From tbl_PM_Login Where LoginID = " & Args.DataReader("LoginID") & ""
        IsActiveLogin = CommonFunctions.Data.GetDataScalar(strSQlIsActiveLogin, True)
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center'  title='Edit Customer Login'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Customer_OnClick(" & Args.DataReader("LoginID") & ",'" & IsActiveLogin & "')""   id='Editdata_" & Args.DataReader("LoginID") & "'></i></td>"
        End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            'Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete  value=" & Args.DataReader("LoginID") & " >" + "</TD>"
            Args.StringToBeInserted = "<td align='center' Title = 'Delete Customer Login'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete  value=" & Args.DataReader("LoginID") & " >" + "</TD>"
            'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
        End If
    End Sub
    Private Sub m_objEmpGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objEmpGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th><input type=checkbox name='chkLoginSelect' id='chkLoginSelect' title='Select All' onclick='SelectLoginAll_Checkbox(this)'/></th>"
        End If
    End Sub
    <System.Web.Services.WebMethod> _
    Public Shared Function GetUserName(ByVal LoginID As String) As String
        '=====================================================================
        ' Procedure Name        : GetEmployeeDetails
        ' Description           : To Get Flag details when clicked
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            '' LoginID = Utilities.Security.SecurityBuilder.CheckUserInput(LoginID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim drLoginName As IDataReader
            Dim LoginName As String
            drLoginName = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Customer " & LoginID & ",0,'C'", True)
            If drLoginName.Read Then
                LoginName = CommonFunctions.Data.CheckIsDBNull(drLoginName("CustomerID").ToString, "")
            End If
            Return LoginName & ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ValidateUserName(ByVal objLoginName As Object) As String
        '=====================================================================
        ' Procedure Name        : ValidateUserName
        ' Purpose               : To validate user name
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Yogesh Jalamkar 
        ' Created Date           :08-DEC-2017
        '=====================================================================
        Try
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
            Dim strUserName As String
            Dim strUniuqeID As String
            Dim strSQL As String
            Dim strResult As String
            Dim strEncryptedUniuqeID As String
            Dim drCompanyInfo As IDataReader
            Dim m_blnEnablePassLength As Boolean = False
            Dim m_intMinPassLen As Integer = 0
            Dim m_intMaxPassLen As Integer = 0
            Dim m_blnEnableAlphaNumSpeChar As Boolean = False
            Dim m_intNumberOfAlpha As Integer = 0
            Dim m_intNumberOfNumerals As Integer = 0
            Dim m_intNumberOfSpecialChars As Integer = 0
            Dim m_blnEnablePassPharsesDays As Boolean = False
            Dim m_intPassPharsesDays As Integer = 0
            Dim m_blnEnablePreviousPassCheck As Boolean = False
            Dim m_intPreviousPassCount As Integer = 0
            Dim m_blnEnablePassLockoutDuration As Boolean = False
            Dim m_intPassLockoutDuration As Integer = 0
            Dim m_blnEnableLockUserID As Boolean = False
            Dim m_intPassLockingCount As Integer = 0
            Dim m_intPassCaptchaCount As Integer = 0
            Dim m_blnIsAutoPasswordCreation As Boolean = False
            Dim blnFirstTimeLogin As Boolean
            Dim m_blnAllowSameLoginPwd As Boolean = False
            Dim strAuthenticationType As String
            strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UserName"), "").ToString()
            strUniuqeID = Guid.NewGuid().ToString
            strEncryptedUniuqeID = Token.GetUserNameToken(strUniuqeID)
            strResult = strEncryptedUniuqeID
            drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCompanyInfo.Read Then
                m_blnAllowSameLoginPwd = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("AllowSameLoginPwd"), "0"), Boolean)
                blnFirstTimeLogin = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableFirstTimeLogin"), "0"), Boolean)
                m_blnEnablePassLength = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePWDLength"), "0"), Boolean)
                m_intMinPassLen = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MiniPwdLength"), "0"))
                m_intMaxPassLen = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MaxPwdLength"), "0"))
                m_blnEnableAlphaNumSpeChar = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableAlphaNumSpecialChar"), "0"), Boolean)
                m_intNumberOfAlpha = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfAlpha"), "0"))
                m_intNumberOfNumerals = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfNumerals"), "0"))
                m_intNumberOfSpecialChars = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfSpecial"), "0"))
                m_blnEnablePassPharsesDays = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassPhrases"), "0"), Boolean)
                m_intPassPharsesDays = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassPharsesDays"), "0"))
                m_blnEnablePreviousPassCheck = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePreviousPassCheck"), "0"), Boolean)
                m_intPreviousPassCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PreviousPassCount"), "0"))
                m_blnEnablePassLockoutDuration = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassLockoutDuration"), "0"), Boolean)
                m_intPassLockoutDuration = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockoutDuration"), "0"))
                m_blnEnableLockUserID = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableLockUserID"), "0"), Boolean)
                m_intPassLockingCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockingCount"), "0"))
                m_intPassCaptchaCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassCaptchaCount"), "0"))
                m_blnIsAutoPasswordCreation = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("IsAutoPasswordCreation"), "0"), Boolean)
            End If
            strAuthenticationType = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString
            Return strResult.ToString & "#$#" & m_blnAllowSameLoginPwd & "#$#" & blnFirstTimeLogin & "#$#" & m_blnEnablePassLength & "#$#" & m_intMinPassLen & "#$#" & m_intMaxPassLen & "#$#" & m_blnEnableAlphaNumSpeChar & "#$#" & m_intNumberOfAlpha & "#$#" & m_intNumberOfNumerals & "#$#" & m_intNumberOfSpecialChars & "#$#" & m_blnEnablePassPharsesDays.ToString & "#$#" & m_intPassPharsesDays & "#$#" & m_blnEnablePreviousPassCheck & "#$#" & m_intPreviousPassCount & "#$#" & m_blnEnablePassLockoutDuration & "#$#" & m_intPassLockoutDuration & "#$#" & m_blnEnableLockUserID & "#$#" & m_intPassLockingCount & "#$#" & m_intPassCaptchaCount & "#$#" & m_blnIsAutoPasswordCreation & "#$#" & strAuthenticationType & ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CHECKISLOCKED(ByVal objLoginName As String) As String
        '=====================================================================
        ' Procedure Name        : CHECKISLOCKED
        ' Description           : 
        ' Created Date           : 08-DEC-2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            objLoginName = Utilities.Security.SecurityBuilder.CheckUserInput(objLoginName, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strResult As String = ""
            Dim strSQL As String = ""
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
            CommonFunctions.Data.GetDataScalar("Usp_Chk_User_IsLocked '" & objLoginName & "'", True), ""), "")
            Return strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CHECKOLDNEWPWD(ByVal LoginName As String, ByVal NewPassword As String, ByVal AuthNo As String) As String
        '=====================================================================
        ' Procedure Name        : CHECKOLDNEWPWD
        ' Description           : 
        ' Created Date           : 08-DEC-2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            LoginName = Utilities.Security.SecurityBuilder.CheckUserInput(LoginName, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim strLoginName As String
            Dim strNewPwd As String
            strLoginName = LoginName
            strNewPwd = NewPassword
            Dim strencryptedkey As String = ""
            Dim strencryptedlength As String = ""
            Dim struniqueid As String = ""
            Dim IsValid As Boolean = False
            strencryptedlength = AuthNo
            struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
            strencryptedkey = strNewPwd.Substring(1, strencryptedlength)
            Dim strpwd1 As String() = strNewPwd.Split("|")
            strNewPwd = ""
            For i As Integer = 0 To strpwd1.Length - 2
                strNewPwd &= strpwd1(i).Substring(0, 1)
            Next
            strNewPwd = StrReverse(strNewPwd)
            Dim objEncryptNewPassword As New Authentication.PWEncryption(strLoginName, strNewPwd)
            strNewPwd = objEncryptNewPassword.Encrypt()
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
            CommonFunctions.Data.GetDataScalar("Usp_Chk_Old_New_Password '" & strLoginName & "','" & strNewPwd & "'", True)))
            Return strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CHECKLASTENTEREDPWDS(ByVal LoginName As String, ByVal NewPassword As String, ByVal AuthNo As String) As String
        '=====================================================================
        ' Procedure Name        : CHECKLASTENTEREDPWDS
        ' Description           : 
        ' Created Date           : 08-DEC-2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            LoginName = Utilities.Security.SecurityBuilder.CheckUserInput(LoginName, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strLoginName As String
            Dim strResult As String
            Dim strNewPwd As String
            Dim strencryptedkey As String = ""
            Dim strencryptedlength As String = ""
            Dim struniqueid As String = ""
            Dim IsValid As Boolean = False
            strLoginName = LoginName
            strNewPwd = NewPassword
            strencryptedlength = AuthNo
            struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
            strencryptedkey = strNewPwd.Substring(1, strencryptedlength)
            Dim strpwd1 As String() = strNewPwd.Split("|")
            strNewPwd = ""
            For i As Integer = 0 To strpwd1.Length - 2
                strNewPwd &= strpwd1(i).Substring(0, 1)
            Next
            strNewPwd = StrReverse(strNewPwd)
            Dim objEncryptNewPassword As New Authentication.PWEncryption(strLoginName, strNewPwd)
            strNewPwd = objEncryptNewPassword.Encrypt()
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
            CommonFunctions.Data.GetDataScalar("Usp_Check_LastEnteredPwds '" & strLoginName & "','" & strNewPwd & "'", True)))
            Return strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveLogin(ByVal CustomerID As String, ByVal strLoginName As String, ByVal strPassword As String, ByVal LoginID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveLogin
        ' Description           : To save login details
        ' Created Date           : 08-DEC-2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            strLoginName = Utilities.Security.SecurityBuilder.CheckUserInput(strLoginName, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            If CommonFunction.RateLimiter.CheckRateLimit(request) Then
                response.StatusCode = 429
                response.Write("Bad Request found")
                Return "Bad Request found"
            End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strGridHTML As New StringBuilder("")
            Dim strEncryPass As String = ""
            Dim blnShowPopup As Boolean
            Dim blnSendMail As Boolean
            Dim strFromEmailID As String
            Dim strToMailID As String
            Dim strCCToMailID As String
            Dim strSubject, strMessage As String
            Dim dr As IDataReader
            Dim MsgFlag As String = ""
            Dim strUserType As String = ""
            Dim lngUserId As String = ""
            Dim strSQL1 As String
            Dim strSQLLoginID As String = "Select LoginID from tbl_PM_Login Where CustomerID =  " & CustomerID & ""
            LoginID = CommonFunctions.Data.GetDataScalar(strSQLLoginID, True)
            '' Dim strSQL As String = "exec Usp_NG2_Ins_Upd_tbl_CRM_RequestType  '" & RequestTypeCode & "', '" & RequestType & "','" & SubRequestType & "'," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'," & RequestTypeID & ""
            'Dim strSQL As String = "exec Usp_NG2_Ins_Upd_tbl_CRM_RequestType  '" & RequestTypeCode & "', '" & RequestType & "'," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'," & RequestTypeID & ""
            Dim strSQL As String
            Dim objDr As IDataReader
            If strLoginName = "" Then
                strSQL = ""
                strSQL = "usp_Sel_tbl_PM_Login "
                strSQL += LoginID.ToString
                objDr = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While objDr.Read
                    strLoginName = CommonFunction.Data.CheckIsDBNull(objDr("loginName"), "").ToString
                End While
                CommonFunction.Data.DisposeDataReader(objDr)
            End If
            '''''''''''''''''''''''''''''''''''''''''''''''''
            Dim objEncrypt As New Authentication.PWEncryption(CommonFunction.General.UnBuildQueryString(strLoginName), CommonFunction.General.UnBuildQueryString(strPassword))
            strEncryPass = objEncrypt.Encrypt()
            If LoginID Is Nothing Then
                'INSERT mode
                strSQL1 = "Exec usp_Ins_tbl_PM_Login 'C','" + CustomerID.ToString + "',null,23,0,'" + strLoginName + "','" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                Dim drInsert As IDataReader = CommonFunction.Data.GetDataReader(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drInsert.Read Then
                    If drInsert("Exceeded").ToString = "1" And drInsert("Success").ToString = "1" Then
                        Dim blnDisableUserLicencing As Boolean = False
                        blnDisableUserLicencing = CommonFunctions.General.GetFrameworkSettings("WAF_DISABLE_USERLICENCING", "Y")
                        If blnDisableUserLicencing = False Then
                            ' SaveEmployeeLoginInformation = "alert(""" + Microsoft.VisualBasic.Strings.Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf
                        End If
                    End If
                End If
                'dispose
                CommonFunction.Data.DisposeDataReader(drInsert)
                'Send Email
                'SaveEmployeeLoginInformation += SendEmailForNewLogin(lngUserId, strLoginName, strPassword, "E")            
                strUserType = HttpContext.Current.Session("LoginType").ToString
                lngUserId = HttpContext.Current.Session("intUserID").ToString
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 12 ", True)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                If blnSendMail Then
                    If blnShowPopup Then
                        MsgFlag += "12" + ","
                    Else
                        ' silent mail
                        Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, lngUserId, strUserType, strLoginName, strPassword)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If
            Else
                'UPDATE mode
                'Dim lngLoginId As Long = CType(LoginID, Long)
                strSQL1 = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "',N'" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "'" 'Modified By Ninad on 15 May 2008, Issue ID-  20310
                CommonFunction.Data.InsertOrUpdateData(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
            ''''''''''''''''''''''''''''''''''''''''''''
            'Dim objEncrypt As New Authentication.PWEncryption(CommonFunction.General.UnBuildQueryString(strLoginName), CommonFunction.General.UnBuildQueryString(strPassword))
            'strEncryPass = objEncrypt.Encrypt()
            'Dim strSQL1 As String = "Exec usp_Ins_tbl_PM_Login 'E',null,'" + lngEmployeeID.ToString + "',null,0,'" + strLoginName + "','" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
            'LoginID = CommonFunctions.Data.GetDataScalar(strSQL1, True)
            'Return LoginID.ToString & "||" & MsgFlag
            Return strLoginName.ToString & "||" & MsgFlag & "||" & strPassword.ToString
            'Return LoginID.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshPlotGrid() As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Yogesh Jalamkar
        ' Created Date           :08-DEc-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCustomer As New Security_login_customer()
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))
            strGridHTML.Append(objCustomer.WritePage("1"))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'Added by Usha Pandit on 10 JAN 2018 for refreshing Customer Grid 
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid() As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Customer Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Usha Pandit
        ' Created Date           :10-JAN-2018
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCustomer As New Security_login_customer()
            strGridHTML.Append(objCustomer.DrawCustomerGrid())
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    'End of Added by Usha Pandit on 10 JAN 2018 for refreshing Customer Grid 
    <System.Web.Services.WebMethod> _
    Public Shared Function ComboOnAdd(ByVal Mode As Object) As String
        '=====================================================================
        ' Procedure Name        : ComboOnAdd
        ' Purpose               : 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created Date           :08-DEc-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New Security_login_employee()
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()
            Dim strComboSQL As String = ""
            strComboSQL = "EXEC usp_NG2_Sel_tbl_PM_Customer"
            dtDefectType = CommonFunctions.Data.GetDataTable(strComboSQL, True)
            strResult = GetSerialized(dtDefectType)
            strScript = strResult.Split("|")
            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult
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
    <System.Web.Services.WebMethod> _
    Public Shared Function GetLoginDetails(ByVal LoginID As String) As String
        '=====================================================================
        ' Procedure Name        : GetLoginDetails
        ' Description           : To Get Flag details when clicked
        ' Created Date           :08-DEC-2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            ''LoginID = Utilities.Security.SecurityBuilder.CheckUserInput(LoginID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim drLogin As IDataReader
            Dim FlagTo As String = ""
            Dim LoginName As String
            Dim UserName As String
            drLogin = CommonFunctions.Data.GetDataReader("usp_NG_Sel_tbl_PM_Login " & LoginID & "", True)
            If drLogin.Read Then
                LoginName = CommonFunctions.Data.CheckIsDBNull(drLogin("LoginName").ToString, "")
                UserName = CommonFunctions.Data.CheckIsDBNull(drLogin("CustomerID").ToString, "")
            End If
            Return LoginName & "#$#" & UserName & ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function DeactivateLogin(ByVal UserName As String) As String
        '=====================================================================
        ' Procedure Name        : DeactivateLogin
        ' Description           : For Refreshing The grid0
        ' Created Date           :08-DEC-2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            UserName = Utilities.Security.SecurityBuilder.CheckUserInput(UserName, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            If CommonFunction.RateLimiter.CheckRateLimit(request) Then
                response.StatusCode = 429
                response.Write("Bad Request found")
                Return "Bad Request found"
            End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strGridHTML As New StringBuilder("")
            Dim Flag As String = ""
            Dim UserID As String = ""
            Dim strSQL1 As String = "Select LoginID from tbl_PM_Login Where CustomerID =  " & UserName & ""
            UserID = CommonFunctions.Data.GetDataScalar(strSQL1, True)
            Dim strSQL As String = "exec usp_NX2_Upd_tbl_PM_Login_SetResetLogin  " & UserID & ""
            Flag = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return Flag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCustomer(ByVal LoginID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteCustomer
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete customer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0
        arrDelete = LoginID.Split(",")
        Try
            For index = 0 To arrDelete.Length - 1
                strSQL = "exec usp_NG2_Del_Employee_tbl_PM_Login  " & arrDelete(index) & ""
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Next
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GETCOMPANYINFORMATIONDETAILS(ByVal LoginID As String)
        '=====================================================================
        ' Procedure  Name		:	To get company information for auto password creation
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	auto password creation
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:   8 Dec 2017
        '=====================================================================
        Dim m_blnIsAutoPasswordCreation As String = "False"
        Dim drCompanyInfo As IDataReader
        Dim strResult As String
        Dim strNewPassword As String = ""
        'Get data reader Object    
        Try
            drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drCompanyInfo.Read Then
                m_blnIsAutoPasswordCreation = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("IsAutoPasswordCreation"), ""), String)
            End If
            If drCompanyInfo.IsClosed = False Then
                drCompanyInfo.Close()
            End If
            If (m_blnIsAutoPasswordCreation = "True") Then
                Dim objNewPassowrd As New CreateNewPassword()
                strNewPassword = objNewPassowrd.CreatePassword()
                strResult = m_blnIsAutoPasswordCreation + "$$" + strNewPassword
            Else
                strResult = m_blnIsAutoPasswordCreation
            End If
        Catch ex As Exception
        Finally
            If Not drCompanyInfo Is Nothing Then
                drCompanyInfo.Dispose()
            End If
        End Try
        Return strResult
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckIsDuplicate(ByVal LoginName As String) As String
        '=====================================================================
        ' Procedure Name        : CheckIsDuplicate
        ' Description           : TO check duplicate login Name
        ' Created Date           : 08-DEC-2017
        '=====================================================================
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        LoginName = Utilities.Security.SecurityBuilder.CheckUserInput(LoginName, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim strSQl As String = "usp_Sel_tbl_PM_Login_For_LoginName '" & LoginName & "'"
        Dim drLogin As IDataReader
        Dim strFlag = ""
        Try
            drLogin = CommonFunction.Data.GetDataReader(strSQl, True)
            If (drLogin.Read) Then
                strFlag = "1"
            End If
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
            End Try
    End Function
End Class