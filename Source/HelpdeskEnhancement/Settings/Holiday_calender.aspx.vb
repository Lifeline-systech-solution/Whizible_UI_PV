Public Class Holiday_calender
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
        Try
            m_objSubTabAccess = New WebPage.Templates.AccessRights
            Dim objGlobal As New WebPage.Templates.WhizGlobal(strUserName, SubtagID, m_intRoleID, intUserID, strLoginType, False, TagID)
            m_objSubTabAccess.GetAccess(objGlobal)
        Catch ex As Exception
            Return "Bad Request found"
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
        '/*Changed By Yasmin on 25th july 2018*/
        GetAccessRights()
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='divScroll'>")
        strHTML.Append("<div class='type-top-bar top-bar' id='EmployeeFilter'>")
        'strHTML.Append("<ul class='left'>")
        'strHTML.Append("<li class='search-bar'><div class='left search-bar'><i id='idSearchHistory' class='fa fa-search' aria-hidden='true' style='margin-top: 13px'></i><input type='text' id='txtSearchHistory' placeholder='Search in table' title='Type here to search'>")
        strHTML.Append("    <ul class='left'>")
        strHTML.Append(" <li class='left search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='txtSearchHistory'   placeholder='Search in table' >")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        'strHTML.Append("</div></li>")
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
        ' strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccess.Add = True Then
            strHTML.Append("<li class='clearall'><button type='button' class='btn btn-default' style='color:black!important;background-color:white!important' onclick='AddHoliday()' title='Add Holiday'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccess.Delete = True Then
            strHTML.Append("<li class='clearall'><button type='button' class='btn btn-default' style='color:black!important;background-color:white!important' title='Delete Holiday' onclick='DeleteHoliday()'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='divRequestTypes'>")
        'strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))        
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, "", "", ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divSubTypeBottom edit_target'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'><h3><span><i class='fa fa-plus' style='float: none; padding-left: 10px;'></i><span style='margin-left: 5px;'> Add New Holiday Calender</span></span></h3><h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' class='' id='Addaccordion'><i id='plus' class='fa fa-plus toggle-plus' title='Expand'></i><i id='minus' class='fa fa-minus toggle-plus' title='Hide'></i></a></h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2' aria-expanded='true' style=''>")
        strHTML.Append("<div class='panel-body' >")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;font-size: 12px'> Holiday Name* </label>")
        strHTML.Append("<div class='col-sm-4'>")
        '<select class="form-control" id="CboEmplyeeType" name="CboEmplyeeType" style="width:217px "><option value="Select User"></option><option title="Contract" value="Contract">Contract</option><option title="Hourly" value="Hourly">Hourly</option><option title="Salary" value="Salary">Salary</option></select>
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboUserName", "usp_Sel_tbl_PM_Employee  NULL,1", 129, , " onchange='UserName_OnChange(this)' class='form-control' ", False, True, "form-control"))
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHolidayName", "txtHolidayName", "form-control", 219, 50, , , , , , , , " class='form-control' placeholder='Enter Holiday Name'  ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        'strHTML.Append("<label class='control-label col-sm-2' for='Employee Type' style='text-align: right;font-size: 11px'> Login Name* </label>")
        'strHTML.Append("<div class='col-sm-4'>")
        ''strHTML.Append("<input type="text" style="width:217px;" class="form-control" id="Text1" name="" placeholder="Enter Login Name">")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtLoginName", "txtLoginName", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Chakshuta
        strHTML.Append("<div class='form-group'><label class='control-label col-sm-2' for='request type' style='text-align: right;font-size: 12px'>Holiday Date*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'Commented and addded by Usha Pandit on 20.12.2017 for using Whizible controls
        'strHTML.Append("<input type='text' name='dtHolidayDate' value=''  class='form-control' style=' text-align:Left' id='dtHolidayDate' placeholder=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dtHolidayDate", "dtHolidayDate", "form-control", 219, , , , , , , , , " class='form-control' placeholder ='Enter Holiday Date'  ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        'end of addition by Usha Pandit on 20.12.2017 for using Whizible controls
        strHTML.Append("<i class='fa fa-calendar' style='margin-left:-93px;' id='idCalender' onclick=""$('#dtHolidayDate').datepicker();$('#dtHolidayDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        'strHTML.Append("<div class='form-group' style='    border-bottom: 1px solid #ebedf2;'>")
        'strHTML.Append("<label class='control-label col-sm-2' for=' ' style='text-align: right;font-size: 11px;padding-top: 2px;'>Holiday Date  </label>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='Textbox' name='txtOrderNumber' id='Textbox1' class='form-control' style=' text-align:Left' value=''> </div>")
        'strHTML.Append("<i class='fa fa-calendar' style='margin-left:-93px;'></i>")
        'strHTML.Append("</div>")
        'strHTML.Append("<label class='control-label col-sm-2' for='request type' style='text-align: right;font-size: 11px'>Confirm Password*</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        ''<input type="Textbox" name="Sub_WorkHrs" id="Sub_WorkHrs" class="form-control" style="text-align:Left" value="" placeholder="Confirm Password Name"> 
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtConfirmPassword", "txtConfirmPassword", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=True, EnableHTMLEncode:=True))
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group' style='    border-bottom: none; margin-top: 5px; '>")
        strHTML.Append("<div class='right'>")
        If m_objAccess.Add = True Or m_objAccess.Edit = True Then
            strHTML.Append("<button type='button'  id='Save' class='btn btn-default save' onclick='SaveHoliday()' style='background-color: #343660; color: #ffffff'>Save</button>")
            strHTML.Append("<button type='button'  id='SaveandAdd' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddHoliday()' style='border-left: 1px solid; margin-left: 5px; background-color: #343660; color: #ffffff'>Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
            strHTML.Append("<button type='button'  id='History' class='btn btn-default save clsbuttonLinks' onclick='ShowHistory_OnClick()' style=' display:none; margin-left: 5px; background-color: #343660; color: #ffffff'>Show History</button>")
        End If
        Dim strSQLLoginID As String = "select Count(1) As recordcount from 	tbl_PM_Login WITH(NOLOCK) INNER JOIN tbl_PM_Customer WITH(NOLOCK) On tbl_PM_Login.CustomerID = tbl_PM_Customer.Customer INNER JOIN tbl_PM_Client WITH(NOLOCK) On tbl_PM_Login.ClientID = tbl_PM_Client.ClientID	Where tbl_PM_Login.RoleID = 23 And tbl_PM_Login.IsCreatedByCustomer = 1 AND tbl_PM_Login.CustomerID=" & HttpContext.Current.Session("intUserID") & ""
        Dim Count As String = CommonFunctions.Data.GetDataScalar(strSQLLoginID, True)
        strHTML.Append("<button type='button' id='Cancel' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Holiday()' style='margin-right: 19px;    margin-left: 5px; background-color: #343660; color: #ffffff' >Cancel</button>")
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
        strSQLQuery = "usp_NG_Sel_tbl_PM_Holiday "
        arrstrActualList = {"HolidayName", "HolidayDate", "Edit", "Delete"}
        arrstrUserFriendlyList = {"Holiday Calender", "Holiday Date", "Edit", "Delete"}
        arrstrLinkArray = {"", "", "", ""}
        arrCheckBoxArray = {"", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=center", "align=center"}
        objGrid = m_objTypeGrid
        '/*Changed By Yasmin on 25th july 2018*/
        If Flag = 0 Then
            With objGrid
                .ActualColumnArray = arrstrActualList
                .UserFriendlyColumnArray = arrstrUserFriendlyList
                ' .CheckBoxIDArray = arrCheckBoxArray
                .NoOfDataColumns = intNoOfDataColumn
                .RowLinkArray = arrstrLinkArray
                .TDStyleArray = arrWidthArray
                .DIVStyle = "overflow:auto"
                .ColNameToolTipOnEachRow = False
                .EmptyValueReplacement = (" ")
                .DIVID = strDivID
                .SQL = strSQLQuery
                .ColNameToolTipOnEachRow = False
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
    Private Sub m_objTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTypeGrid.DataRowTD_BeforePrint
        Dim CheckEnable As String
        If Args.DataField.ToUpper = "EDIT" Then
            Cancel = True
            'Args.StringToBeInserted = "<td style='text-align:center;width:1%;position:absolute!important'  title=" & Args.DataField & "><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Employee_OnClick(" & Args.DataReader("LoginID") & ")""  title='Edit' id='Editdata_" & Args.DataReader("LoginID") & "'></i></td>"
            Args.StringToBeInserted = "<td align='center' title='Edit Holiday'><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Holiday_OnClick(" & Args.DataReader("HolidayID") & ")""   id='Editdata_" & Args.DataReader("HolidayID") & "'></i></td>"
        End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Dim strSQLCheckEnable As String = "Usp_Check_Holiday_Used " & Args.DataReader("HolidayID") & ""
            CheckEnable = CommonFunctions.Data.GetDataScalar(strSQLCheckEnable, True)
            If CheckEnable = "" Then
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkHolidayDelete name=chkHolidayDelete  onclick='select_checkbox(this)' value=" & Args.DataReader("HolidayID") & " >" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Delete Holiday'><input type=checkbox id=chkHolidayDelete name=chkHolidayDelete  onclick='select_checkbox(this)' value=" & Args.DataReader("HolidayID") & " >" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            Else
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = 'Select'><input type=checkbox id=chkHolidayDelete name=chkHolidayDelete disabled value=" & Args.DataReader("HolidayID") & " >" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Holiday is in use. Can not be deleted '><input type=checkbox id=chkHolidayDelete name=chkHolidayDelete disabled value=" & Args.DataReader("HolidayID") & " >" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            End If
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
    Private Sub m_objTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objTypeGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            '  Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
            Args.StringToBeInserted = "<th style='text-align:center !important;'>Edit</th>"
        End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            '  Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
            'Commented and Added by Usha Pandit on 18.12.2017 for plotting Select all checkbox 
            'Args.StringToBeInserted = "<th style='text-align:center !important;'>Edit</th>"
            Args.StringToBeInserted = "<th><input type=checkbox name='chkHolidaySelect' id='chkHolidaySelect' title='Select All' onclick='SelectHolidayAll_Checkbox(this)'/></th>"
            'End of addition by Usha Pandit
            'Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteMultiple_Priority()' type=checkbox id=chkAllDeletePriority name=chkAllDeletePriority /></th>"
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
            Dim objSetting As New Holiday_calender()
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
            Dim objSetting As New Holiday_calender()
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
        ' Author                : Chakshuta H
        ' Created Date           : 8th-Dec-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New Holiday_calender()
            'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))
            strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", "", "", ""))
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
            Dim objSetting As New Holiday_calender()
            strGridHTML.Append(objSetting.WriteSubRequestTabGrid("PlotSubRequestType", "PlotSubRequestType", RequestTypeID))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveHoliday(ByVal HolidayName As String, ByVal HolidayDate As String, ByVal HolidayID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim strHolidayID As String = ""
            Dim Str As String
            Str = "usp_NG_Ins_tbl_PM_HolidayEdit '" + HolidayName + "','" + HolidayDate + "'," + HolidayID
            'CommonFunction.Data.InsertOrUpdateData(Str, True)
            strHolidayID = CommonFunctions.Data.GetDataScalar(Str, True)
            '------------------------------------------------------------------------------------      
            Return strHolidayID.ToString
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
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateHolidayDate(ByVal HolidayDate As String, ByVal HolidayID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Request Type
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   8 Nov 2017
        '=====================================================================
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            HolidayID = Utilities.Security.SecurityBuilder.CheckUserInput(HolidayID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strResult = "0"
            Dim strSQL As String
            If (HolidayDate = "") Then
                HolidayDate = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_Holiday '" & HolidayDate & "'," + HolidayID
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetHolidayDetails(ByVal HolidayID As String) As String
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
            Dim HolidayName As String
            Dim HolidayDate As String
            drProjectCount = CommonFunctions.Data.GetDataReader("usp_NG_Sel_tbl_PM_HolidayEdit " & HolidayID & "", True)
            If drProjectCount.Read Then
                HolidayName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("HolidayName").ToString, "")
                HolidayDate = CommonFunctions.Data.CheckIsDBNull(drProjectCount("HolidayDate").ToString, "")
            End If
            Return HolidayName & "#$#" & HolidayDate & ""
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
    Public Shared Function DeleteHoliday(ByVal HolidayID As String)
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
        Dim strSQL As String = ""
        Dim arrDelete() As String
        Dim index As Integer = 0
        arrDelete = HolidayID.Split(",")
        Try
            For index = 0 To arrDelete.Length - 1
                strSQL = "exec usp_del_tbl_PM_Holiday  " & arrDelete(index) & ",''"
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Next
        Catch ex As Exception
            Return "Bad Request found"
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
            Dim objSetting As New Holiday_calender
            Dim strHTML As New StringBuilder("")
            Dim str As String = objSetting.ShowMailHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
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
        '/*Changed By Yasmin on 25th july 2018*/
        Dim strHTML As New StringBuilder("")
        If (storedprocedure = Nothing) Then
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 26 & "','" & UniqueID & "'")
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
            .ColNameToolTipOnEachRow = False
            .DIVID = "ShowHistoryGrid"
            .DIVStyle = "overflow: auto !important"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = False
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
            Dim objSetting As New Holiday_calender
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 26, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"
            Dim str As String = objSetting.ShowMailHistoryGrid(MessageID, strSQL)
            Return str
        Catch ex As Exception
            Return "Bad Request found"
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