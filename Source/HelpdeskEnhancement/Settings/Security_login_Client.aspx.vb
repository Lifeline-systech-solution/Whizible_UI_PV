Public Class Security_login_Client
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
        ' Author                : Chakshuta H
        ' Created               : 8th Dec 2017
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
        ' Author                :	Chakshuta H
        ' Created               :	8-Dec-2017
        ' Revisions             :
        '=====================================================================
        m_objSubTabAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(strUserName, SubtagID, m_intRoleID, intUserID, strLoginType, False, TagID)
        m_objSubTabAccess.GetAccess(objGlobal)
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
        ' Author                : Chakshuta H
        ' Created               : 8th Dec 2017
        ' Revisions             : None
        '=====================================================================
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
        ' Author                : Chakshuta H
        ' Created               : 8th Dec 2017
        ' Revisions             : None
        '=====================================================================
        GetAccessRights()
        '/*Changed By Yasmin on 25th july 2018*/
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='divScroll'>")
        strHTML.Append("<div class='type-top-bar top-bar' id='EmployeeFilter'>")
        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'><div class='left search-bar'><i id='idSearchHistory' class='fa fa-search' aria-hidden='true' style='margin-top: 13px'></i><input type='text' id='txtSearchHistory' placeholder='Search in table'>")
        strHTML.Append("</div></li>")
        'strHTML.Append("<li style='font-weight:normal !important;'>")
        ''strHTML.Append("<select onchange="DepartMentFilter_OnChange(this)" class="form-control" id="cboDepartment" name="cboDepartment" style="width:129px; font-weight:normal !important;" ><option title="Department" value="0">Department</option><option title="Product Helpdesk" value="2">Product Helpdesk</option><option title="Management" value="3">Management</option><option title="Services" value="8">Services</option><option title="Human Resource" value="51">Human Resource</option><option title="test1" value="64">test1</option><option title="test2" value="65">test2</option><option title="test3" value="66">test3</option><option title="test4" value="67">test4</option></select>
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_NG2_Sel_tbl_PM_DepartmentMaster", 129, , " onchange='DepartMentFilter_OnChange(this)' class='form-control' ", False, True))
        'strHTML.Append("</li> ")
        'strHTML.Append("<li style='font-weight:normal !important;'>")
        ''strHTML.Append("<select onchange="DepartMentFilter_OnChange(this)" class="form-control" id="CboRole" name="CboRole" style="width:129px "><option title="Role" value="0">Role</option><option title="DELIVERY MANAGER" value="1">DELIVERY MANAGER</option><option title="APPLICATION ADMINISTRATOR" value="7">APPLICATION ADMINISTRATOR</option><option title="HELPDESK EXECUTIVE" value="24">HELPDESK EXECUTIVE</option><option title="PRESIDENT" value="68">PRESIDENT</option><option title="MANAGING DIRECTOR" value="69">MANAGING DIRECTOR</option><option title="SOFTWARE ENGINEER / TEAM MEMBER" value="70">SOFTWARE ENGINEER / TEAM MEMBER</option><option title="IMPLEMENTATION ENGG / BUSINESS ANALYST" value="71">IMPLEMENTATION ENGG / BUSINESS ANALYST</option><option title="TEAM LEADER" value="72">TEAM LEADER</option><option title="HELPDESK LEAD / MANAGER" value="73">HELPDESK LEAD / MANAGER</option><option title="PROJECT MANAGER / SCRUM MASTER" value="74">PROJECT MANAGER / SCRUM MASTER</option><option title="HR MANAGER / EXECUTIVE" value="75">HR MANAGER / EXECUTIVE</option><option title="ADMIN MANAGER" value="76">ADMIN MANAGER</option><option title="BUSINESS DEVELOPMENT MANAGER" value="77">BUSINESS DEVELOPMENT MANAGER</option><option title="SALES EXECUTIVE" value="78">SALES EXECUTIVE</option><option title="FINANCE MANAGER" value="82">FINANCE MANAGER</option><option title="TEST ENGINEER" value="83">TEST ENGINEER</option><option title="TEST LEAD" value="85">TEST LEAD</option><option title="IT SUPPORT EXECUTIVE" value="88">IT SUPPORT EXECUTIVE</option><option title="SUPPORT (My Assets)" value="90">SUPPORT (My Assets)</option><option title="PROJECT CO-ORDINATOR" value="91">PROJECT CO-ORDINATOR</option></select>
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRole", "usp_NG2_Sel_tbl_PM_Role ", 129, , " onchange='DepartMentFilter_OnChange(this)' class='form-control' ", False, True))
        'strHTML.Append("</li>")
        'strHTML.Append("<li style='font-weight:normal !important;'>")
        ''<select onchange="DepartMentFilter_OnChange(this)" class="form-control" id="CboStatus" name="CboStatus" style="width:129px "><option title="Status" value="-1">Status</option><option title="Active" value="0">Active</option><option title="Inactive" value="1">Inactive</option></select>
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", "usp_NG2_Sel_v_tbl_PM_LoginStatus ", 129, , "onchange='DepartMentFilter_OnChange(this)' class='form-control' ", False, True, "form-control"))
        'strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccess.Add = True Then
            If HttpContext.Current.Session("LoginType") = "C" Then
                strHTML.Append("<li class='clearall'><button type='button' class='btn btn-default' title='Add' onclick='AddEmployee()'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
            Else
                strHTML.Append("<li class='clearall'><button type='button' class='btn btn-default' style='display:none;' title='Add' onclick='AddEmployee()'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
            End If
        End If
        If m_objAccess.Delete = True Then
            If HttpContext.Current.Session("LoginType") = "C" Then
                strHTML.Append("<li class='clearall'><button type='button' class='btn btn-default' title='Delete' onclick='DeleteEmployee()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
            Else
                strHTML.Append("<li class='clearall'><button type='button' class='btn btn-default' title='Delete' style='display:none;' onclick='DeleteEmployee()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
            End If
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='divRequestTypes'>")
        'strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))        
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, "", "", ""))
        strHTML.Append("</div>")
        If HttpContext.Current.Session("LoginType") = "C" Then
            strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom edit_target'>")
            strHTML.Append("<div class='pannel-section'>")
            strHTML.Append("<div class='col-md-12 col-sm-12'>")
            strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
            strHTML.Append("<div class='panel'>")
            strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'> Add New Client Login</span></span></h3><h4 class='panel-title'>")
            strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class=''><i id='plus' class='fa fa-plus toggle-plus'></i><i id='minus' class='fa fa-minus toggle-plus'></i></a></h4>")
            strHTML.Append("</div>")
            strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in show' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
            'cOMMENTED & aDDED BY DIPALI V ON 6TH MAY 2020 FOR ISSUE ID-24136
            'strHTML.Append("<div class='panel-body' style='height: 150px;'>")
            strHTML.Append("<div class='panel-body' style='height: 220px;'>")
            'eND OF cOMMENTED & aDDED BY DIPALI V ON 6TH MAY 2020 FOR ISSUE ID-24136
            strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
            strHTML.Append("<div id='divlogin'>") 'Added By Dipali V On 8th April 2023 For UI Issues
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;font-size: 12px'> User Name* </label>")
            strHTML.Append("<div class='col-sm-4' style='margin-top: 5px;'>")
            '<select class="form-control" id="CboEmplyeeType" name="CboEmplyeeType" style="width:217px "><option value="Select User"></option><option title="Contract" value="Contract">Contract</option><option title="Hourly" value="Hourly">Hourly</option><option title="Salary" value="Salary">Salary</option></select>
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboUserName", "usp_Sel_tbl_PM_Employee  NULL,1", 129, , " onchange='UserName_OnChange(this)' class='form-control' ", False, True, "form-control"))
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboUserName", "usp_Sel_ClientsByCustomerEdit " & HttpContext.Current.Session("intUserID") & ",'Add'", 200, , "onchange='UserName_OnChange(this)' class='form-control'  ", True, True))
            strHTML.Append("</div>")
            strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;font-size: 12px'> Login Name* </label>")
            strHTML.Append("<div class='col-sm-4'>")
            'strHTML.Append("<input type="text" style="width:217px;" class="form-control" id="Text1" name="" placeholder="Enter Login Name">")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtLoginName", "txtLoginName", "form-control", 219, , , , , , , , , " class='form-control'  placeholder='Enter Login Name' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='form-group'><label class='control-label col-sm-2' for='request type' style='text-align: right;font-size: 12px'>Password*</label>")
            strHTML.Append("<div class='col-sm-4'>")
            '<input type="Textbox" name="SubrequesttypeCode" id="SubrequesttypeCode" class="form-control" style="text-align:Left" value="" placeholder="Enter Password Name">
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPassword", "txtPassword", "form-control", 219, , , , , , , , , " class='form-control'  placeholder='Enter Password' ", returnHTML:=True, IsPassword:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("<label class='control-label col-sm-2' for='request type' style='text-align: right;font-size: 12px'>Confirm Password*</label>")
            strHTML.Append("<div class='col-sm-4'>")
            '<input type="Textbox" name="Sub_WorkHrs" id="Sub_WorkHrs" class="form-control" style="text-align:Left" value="" placeholder="Confirm Password Name"> 
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtConfirmPassword", "txtConfirmPassword", "form-control", 219, , , , , , , , , " class='form-control'  placeholder='Enter Confirm Password' ", returnHTML:=True, IsPassword:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("</div>")
            strHTML.Append("</div>") 'Added By Dipali V On 8th April 2023 For UI Issues
            strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
            strHTML.Append("<div class='right' style='margin-top: 1%;'>")
            If m_objAccess.Add = True Or m_objAccess.Edit = True Then
                If HttpContext.Current.Session("LoginType") = "C" Then
                    strHTML.Append("<button type='button' id='Save' class='btn btn-default save' onclick='SaveLogin()' style='background-color: #343660; color: #ffffff'>Save</button>")
                    strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks'  onclick='SaveAndAddLogin()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                Else
                    strHTML.Append("<button type='button' id='Save' class='btn btn-default save'  onclick='SaveLogin()' style='display:none; background-color: #343660; color: #ffffff'>Save</button>")
                    strHTML.Append("<button type='button' id='SaveandAdd' class='btn btn-default save clsbuttonLinks'  onclick='SaveAndAddLogin()' style='display:none; border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                End If
                'strHTML.Append("<button type='button' id='Deactivate' class='btn btn-default save clsbuttonLinks' onclick='Deactivate_Login()' style=' display:none;   margin-left: 5px; background-color: #343660; color: #ffffff'>Deactivate Login</button>")
            End If
            Dim strSQLLoginID As String = "select Count(1) As recordcount from 	tbl_PM_Login WITH(NOLOCK) INNER JOIN tbl_PM_Customer WITH(NOLOCK) On tbl_PM_Login.CustomerID = tbl_PM_Customer.Customer INNER JOIN tbl_PM_Client WITH(NOLOCK) On tbl_PM_Login.ClientID = tbl_PM_Client.ClientID	Where tbl_PM_Login.RoleID = 23 And tbl_PM_Login.IsCreatedByCustomer = 1 AND tbl_PM_Login.CustomerID=" & HttpContext.Current.Session("intUserID") & ""
            Dim Count As String = CommonFunctions.Data.GetDataScalar(strSQLLoginID, True)
            strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks'  onclick='Cancel_Login()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff'>Cancel</button>")
            strHTML.Append("<input type=hidden name='hidRecordCount' id='hidRecordCount' value=" + Count + ">")
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
            strHTML.Append("</div>")
        End If
        Return strHTML.ToString
    End Function
    'Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal RequestTypeID As String) As String
    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal strDepartmentFlag As String, ByVal StrRoleFlag As String, ByVal StrStatusFlag As String) As String
        '=====================================================================
        ' Procedure Name        : WriteRequestTabGrid()	
        ' Purpose               : To Plot the Request Tab Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Chakshuta H
        ' Created               : 8th Dec 2017
        ' Revisions             : None
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")
        'strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, RequestTypeID))
        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, strDepartmentFlag, StrRoleFlag, StrStatusFlag))
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
        ' Author                : Chakshuta H
        ' Created               : 8th Dec 2017
        ' Revisions             : None
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")
        'strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, RequestTypeID))
        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function
    'Protected Sub GetGlobalObject()
    '    '=====================================================================
    '    ' Procedure Name        :	GetGlobalObject
    '    ' Purpose               :	Get the global object and assign it to variable
    '    ' Description           :	Same as above
    '    ' Parameters Passed     :	None.
    '    ' Parameters Affected   :	None.
    '    ' Returns               :	None
    '    ' Assumptions           :	None.
    '    ' Dependencies          :	None.
    '    ' Author                :	Vidya Jadhav
    '    ' Created               :	1 Nov  2016
    '    '=====================================================================
    '    MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
    '    m_objGlobal = MyBase.GlobalObject()
    '    'If RequestTypeTagID <> "" Then
    '    '    m_objGlobal.TagID = RequestTypeTagID
    '    'End If
    '    m_objGlobal.TagID = TagID
    '    m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
    '    m_objAccessRights.GetAccess()
    'End Sub
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
        ' Author                :	Chakshuta H
        ' Created               :	08-DEC-2017
        ' Revisions             :
        '=====================================================================
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal
    End Sub
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
        Dim Flag As Integer = 0
        Dim Count As String = ""
        If strDepartmentFlag = "" Then
            strDepartmentFlag = "null"
        End If
        If StrRoleFlag = "" Then
            StrRoleFlag = "null"
        End If
        If StrStatusFlag = "" Then
            StrStatusFlag = "null"
        End If
        intNoOfDataColumn = 2
        strDivID = "divEmpLogin"
        strSQLQuery = "usp_NG_Sel_e_tbl_PM_Login " & HttpContext.Current.Session("intUserID") & ""
       
        arrstrActualList = {"ClientName", "LoginName", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Client", "Login Name", "Edit", "Delete"}
        arrstrLinkArray = {"", "", "", ""}
        arrCheckBoxArray = {"", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left"}
        objGrid = m_objTypeGrid
        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
        strGridHTML.Append("<input type=hidden id=FilterClient value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue
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
                '.PageSize = m_intNoOfRecordInGrid
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                strGridHTML.Append(.DrawGrid())
            End With
            'intRecordCount = m_objGridAttachment.NoOfRows
            objGrid = Nothing
        End If
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
    '/*Changed By Yasmin on 18th july 2018*/
    Private Sub m_objTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTypeGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            'Args.StringToBeInserted = "<td style='text-align:center;width:1%;position:absolute!important'  title=" & Args.DataField & "><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Employee_OnClick(" & Args.DataReader("LoginID") & ")""  title='Edit' id='Editdata_" & Args.DataReader("LoginID") & "'></i></td>"
            Args.StringToBeInserted = "<td style='text-align:center;width:1%;position:absolute!important'  title=" & Args.DataField & "><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Employee_OnClick(" & Args.DataReader("LoginID") & ")""  title='Edit' id='Editdata_" & Args.DataReader("LoginID") & "'></i></td>"
        End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            
            Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkClientDelete name=chkClientDelete  value=" & Args.DataReader("LoginID") & " >" + "</TD>"
        End If
    End Sub
    'Private Sub m_objSubRequestTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSubRequestTypeGrid.DataRowTD_BeforePrint
    '    If Args.ColumnName.ToUpper = "SELECT" Then
    '        Cancel = True
    '        m_strIsTypeMapped = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Sel_tbl_CRM_RequestType_SubRequestType " & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID, True), "0")
    '        m_strCanUnMap = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Unmap_tbl_CRM_SubRequestType " & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID, True), "0")
    '        If m_strIsTypeMapped = "1" And m_strCanUnMap = "1" Then
    '            Args.StringToBeInserted = "<td align='center' Title = 'Map Sub Type'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType checked=true disabled onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
    '        ElseIf m_strIsTypeMapped = "1" And m_strCanUnMap = "0" Then
    '            If m_objSubTabAccess.Add = True And m_objSubTabAccess.Edit = True Then
    '                Args.StringToBeInserted = "<td align='center' Title = 'Map Sub Type'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType checked=true onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
    '            Else
    '                Args.StringToBeInserted = "<td align='center' Title = 'You do not have add or edit access'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType  disabled onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
    '            End If
    '        Else
    '            If m_objSubTabAccess.Delete = True Then
    '                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")"" value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
    '            Else
    '                Args.StringToBeInserted = "<td align='center' Title = 'You do not have delete access'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType disabled value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
    '            End If
    '        End If
    '    End If
    'End Sub
    '/*Changed By Yasmin on 25th july 2018*/
    Private Sub m_objTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objTypeGrid.ColumnHeaderTD_BeforePrint
       If Args.DataField.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th><input type=checkbox name='chkLoginSelect' title='Select All' onclick='SelectLoginAll_Checkbox(this)'/></th>"
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
        ' Author                : Chakshuta H
        ' Created Date           : 8th-Dec-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New Security_login_Client()
            If GridParameter("cityName") = "Type" Then
                strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", "", "", ""))
            End If
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ComboOnAdd(ByVal Mode As Object) As String
        '=====================================================================
        ' Procedure Name        : ComboOnAdd
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Chakshuta H
        ' Created Date           : 8th-Dec-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New Security_login_Client()
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()
            Dim strComboSQL As String = ""
            If Mode = "Add" Then
                strComboSQL = "usp_Sel_ClientsByCustomerEdit " & HttpContext.Current.Session("intUserID") & ",'Add'"
            Else
                strComboSQL = "usp_Sel_ClientsByCustomerEdit " & HttpContext.Current.Session("intUserID") & ",'Edit'"
            End If
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
    Public Shared Function RefreshPlotGrid(ByVal GridParameter As Object, ByVal Department As String, ByVal Role As String, ByVal Status As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Chakshuta H
        ' Created Date           : 8th-Dec-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New Security_login_Client()
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))
            strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", Department, Role, Status))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
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
        ' Author                : Chakshuta H
        ' Created Date           :8 Dec -2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New Security_login_Client()
            strGridHTML.Append(objSetting.WriteSubRequestTabGrid("PlotSubRequestType", "PlotSubRequestType", RequestTypeID))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveLogin(ByVal lngEmployeeID As String, ByVal strLoginName As String, ByVal strPassword As String, ByVal LoginID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
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
            Dim strSQL1 As String, Str As String
            Dim strbuildpassword As String
            Dim strlogin As String = ""
            Dim strSqlquery As String = ""
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
            Dim strencryptedkey As String = ""
            Dim strencryptedlength As String = ""
            Dim struniqueid As String = ""
            Dim IsValid As Boolean = False
            Dim strpwd1 As String()
            'Dim strSQLLoginID As String = "Select LoginID from tbl_PM_Login Where EmployeeID =  " & lngEmployeeID & ""
            Dim strSQLLoginID As String = "Select LoginID from tbl_PM_Login Where ClientID = " & lngEmployeeID & ""
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
            Dim objEncrypt As New Authentication.PWEncryption(Replace(CommonFunction.General.UnBuildQueryString(strLoginName), "''", "'"), Replace(CommonFunction.General.UnBuildQueryString(strPassword), "''", "'"))
            strEncryPass = objEncrypt.Encrypt()
            strLoginName = strLoginName
            strbuildpassword = strEncryPass
            objEncrypt = Nothing
            If LoginID Is Nothing Then
                'INSERT mode
                'Dim lngUserId As Long = CType(CommonFunction.General.CheckIsNothing(ControlsHashTable("CustomerID"), "0"), Long)
                strSQL1 = "Exec usp_Ins_tbl_PM_Login 'C','" + HttpContext.Current.Session("intUserId").ToString() + "',null," + CommonFunction.Constants.ROLE_CUSTOMER.ToString + ",1,'" + strLoginName + "','" + CommonFunction.General.BuildQueryString(strEncryPass) + "'"
                Dim drInsert As IDataReader = CommonFunction.Data.GetDataReader(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drInsert.Read Then
                    If drInsert("Exceeded").ToString = "1" And drInsert("Success").ToString = "1" And HttpContext.Current.Session("LoginType").ToString.ToUpper <> "C" Then
                        Dim blnDisableUserLicencing As Boolean = False
                        blnDisableUserLicencing = CommonFunctions.General.GetFrameworkSettings("WAF_DISABLE_USERLICENCING", "Y")
                        If blnDisableUserLicencing = False Then
                            'SaveCustomerLoginInformation = "alert(""" + Microsoft.VisualBasic.Strings.Replace(CommonFunctions.General.CheckIsNothing(m_objTemplate.GetResourceString("EMP_LOGIN_LIC_EXCEED")), "<LIC_NO>", drInsert("Users").ToString) + """)" + vbCrLf
                        End If
                    End If
                End If
                'dispose
                'Send Email
                'SaveEmployeeLoginInformation += SendEmailForNewLogin(lngUserId, strLoginName, strPassword, "E")            
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 443", True)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                'strencryptedkey = strbuildpassword.Substring(1, strCount)
                strpwd1 = strbuildpassword.Split("|")
                strbuildpassword = ""
                For i As Integer = 0 To strpwd1.Length - 2
                    strbuildpassword &= strpwd1(i).Substring(0, 1)
                Next
                strbuildpassword = StrReverse(strbuildpassword)
                strbuildpassword = strEncryPass
                If blnSendMail Then
                    If blnShowPopup Then
                        MsgFlag += "443" + ","
                    Else
                        ' silent mail
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailID, strToMailID, strSubject, strMessage, strLoginName, strbuildpassword)
                        strMessage = strMessage.Replace("reset", "created")
                        strSubject = strSubject.Replace("reset", "created")
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drInsert)
            Else
                'UPDATE mode
                'Dim lngLoginId As Long = CType(LoginID, Long)            
                strSQL1 = "Exec usp_Upd_tbl_PM_Login_Password " + LoginID.ToString + ",'" + CommonFunction.General.BuildQueryString(strEncryPass) + "',N'" + CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Session("strUserName"), String)) + "'" 'Modified By Ninad on 15 May 2008, Issue ID-  20310
                CommonFunction.Data.InsertOrUpdateData(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'Send Email
                'SaveEmployeeLoginInformation += SendEmailForNewLogin(lngUserId, strLoginName, strPassword, "E")            
                blnSendMail = False : blnShowPopup = False
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 443", True)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
                'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
                ''Added By Vaijat K ON 24/02/2017 For password encryption
                'strencryptedkey = strbuildpassword.Substring(1, strCount)
                strpwd1 = strbuildpassword.Split("|")
                strbuildpassword = ""
                For i As Integer = 0 To strpwd1.Length - 2
                    strbuildpassword &= strpwd1(i).Substring(0, 1)
                Next
                strbuildpassword = StrReverse(strbuildpassword)
                strbuildpassword = strEncryPass
                If blnSendMail Then
                    If blnShowPopup Then
                        MsgFlag += "443" + ","
                    Else
                        ' silent mail
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailID, strToMailID, strSubject, strMessage, strLoginName, strbuildpassword)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If
            End If
            ''''''''''''''''''''''''''''''''''''''''''''  
            Str = "UPDATE tbl_PM_Login set ClientId=" + lngEmployeeID + " WHERE LoginName='" + strLoginName + "' AND CustomerId=" + HttpContext.Current.Session("intUserId").ToString()
            CommonFunction.Data.InsertOrUpdateData(Str, True)
            '------------------------------------------------------------------------------------      
            'Return LoginID.ToString & "||" & MsgFlag
            Return strLoginName.ToString & "||" & MsgFlag & "||" & strPassword.ToString
            'Return LoginID.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function DeactivateLogin(ByVal UserName As String) As String
        '=====================================================================
        ' Procedure Name        : DeactivateLogin
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
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
            'Dim strSQL1 As String = "Select LoginID from tbl_PM_Login Where EmployeeID =  " & UserName & ""
            Dim strSQL1 As String = "Usp_NG2_Sel_GetLoginID " & UserName & ""
            UserID = CommonFunctions.Data.GetDataScalar(strSQL1, True)
            Dim strSQL As String = "exec usp_Upd_tbl_PM_Login_SetResetLogin  " & UserID & ""
            Flag = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return 1
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetLoginDetails(ByVal LoginID As String) As String
        '=====================================================================
        ' Procedure Name        : GetEmployeeDetails
        ' Description           : To Get Flag details when clicked
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            'LoginID = Utilities.Security.SecurityBuilder.CheckUserInput(LoginID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim drProjectCount As IDataReader
            Dim blnComplete As Boolean
            Dim DueDate As String
            Dim FlagTo As String = ""
            Dim EmployeeName As String
            Dim LoginName As String
            Dim UserName As String
            drProjectCount = CommonFunctions.Data.GetDataReader("usp_NG_Sel_e_tbl_PM_LoginEdit " & LoginID & "", True)
            If drProjectCount.Read Then
                LoginName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("LoginName").ToString, "")
                UserName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("ClientID").ToString, "")
            End If
            Return LoginName & "#$#" & UserName & ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetUserName(ByVal ClientID As String) As String
        '=====================================================================
        ' Procedure Name        : GetUserName
        ' Description           : To Get Flag details when clicked
        ' Created Date           : 6th Nov 2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            'ClientID = Utilities.Security.SecurityBuilder.CheckUserInput(ClientID, 2, True, False, False)
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
            Dim FlagTo As String = ""
            Dim LoginName As String
            drLoginName = CommonFunctions.Data.GetDataReader("usp_Sel_ClientCodeById " & ClientID & "", True)
            If drLoginName.Read Then
                LoginName = CommonFunctions.Data.CheckIsDBNull(drLoginName("ClientCode").ToString, "")
            End If
            Return LoginName & ""
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ValidateUserName(ByVal objLoginName As Object) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Chakshuta H
        ' Created Date           : 8th-Dec-2017
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
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            strUserName = Utilities.Security.SecurityBuilder.CheckUserInput(strUserName, 2, True, False, False)
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
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
                'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
                m_blnEnablePassPharsesDays = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassPhrases"), "0"), Boolean)
                m_intPassPharsesDays = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassPharsesDays"), "0"))
                m_blnEnablePreviousPassCheck = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePreviousPassCheck"), "0"), Boolean)
                m_intPreviousPassCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PreviousPassCount"), "0"))
                m_blnEnablePassLockoutDuration = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassLockoutDuration"), "0"), Boolean)
                m_intPassLockoutDuration = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockoutDuration"), "0"))
                m_blnEnableLockUserID = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableLockUserID"), "0"), Boolean)
                m_intPassLockingCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockingCount"), "0"))
                m_intPassCaptchaCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassCaptchaCount"), "0"))
                'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
                'Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
                m_blnIsAutoPasswordCreation = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("IsAutoPasswordCreation"), "0"), Boolean)
                'End of Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
            End If
            strAuthenticationType = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString
            'If m_LoginHashTable.ContainsKey(strUserName) Then
            '    m_LoginHashTable.Remove(strUserName)
            'End If
            'm_LoginHashTable.Add(strUserName, strUniuqeID)
            Return strResult.ToString & "#$#" & m_blnAllowSameLoginPwd & "#$#" & blnFirstTimeLogin & "#$#" & m_blnEnablePassLength & "#$#" & m_intMinPassLen & "#$#" & m_intMaxPassLen & "#$#" & m_blnEnableAlphaNumSpeChar & "#$#" & m_intNumberOfAlpha & "#$#" & m_intNumberOfNumerals & "#$#" & m_intNumberOfSpecialChars & "#$#" & m_blnEnablePassPharsesDays.ToString & "#$#" & m_intPassPharsesDays & "#$#" & m_blnEnablePreviousPassCheck & "#$#" & m_intPreviousPassCount & "#$#" & m_blnEnablePassLockoutDuration & "#$#" & m_intPassLockoutDuration & "#$#" & m_blnEnableLockUserID & "#$#" & m_intPassLockingCount & "#$#" & m_intPassCaptchaCount & "#$#" & m_blnIsAutoPasswordCreation & "#$#" & strAuthenticationType & ""
            'Return strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function CHECKISLOCKED(ByVal objLoginName As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
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
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
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
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
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
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteClient(ByVal LoginID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Attchments
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Chakshuta H
        ' Created				:   8 Dec 2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
            Dim arrDelete() As String
            Dim index As Integer = 0
            Dim strSQLLoginID As String = "select Count(1) As recordcount from 	tbl_PM_Login WITH(NOLOCK) INNER JOIN tbl_PM_Customer WITH(NOLOCK) On tbl_PM_Login.CustomerID = tbl_PM_Customer.Customer INNER JOIN tbl_PM_Client WITH(NOLOCK) On tbl_PM_Login.ClientID = tbl_PM_Client.ClientID	Where tbl_PM_Login.RoleID = 23 And tbl_PM_Login.IsCreatedByCustomer = 1 AND tbl_PM_Login.CustomerID=" & HttpContext.Current.Session("intUserID") & ""
            Dim Count As String = CommonFunctions.Data.GetDataScalar(strSQLLoginID, True)
            arrDelete = LoginID.Split(",")
            Try
                For index = 0 To arrDelete.Length - 1
                    strSQL = "exec usp_Del_tbl_PM_CustomerCreatedLogins  " & arrDelete(index) & ",''"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                Next
            Catch ex As Exception
            End Try
            Return Count.ToString
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
            If Not drCompanyInfo Is Nothing Then
                drCompanyInfo.Dispose()
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
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
            Dim strSQL As String = "Usp_NG2_INS_tbl_CRM_Severity  '" & RequestSeverityCode & "','" & RequestSeverity & "'," & EditSeverityID & ",'" & HttpContext.Current.Session("strUserName") & "'"
            PriorityID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return PriorityID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
#End Region
End Class