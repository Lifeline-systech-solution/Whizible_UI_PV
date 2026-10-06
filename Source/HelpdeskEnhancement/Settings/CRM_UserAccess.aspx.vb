Imports System.IO
Imports System.IO.Compression
Imports System.Xml
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Linq



Public Class CRM_UserAccess
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

    Protected EmployeeName As String
    Protected EmployeeCode As String
    Protected UserName As String
    Protected LdapValue As String
    Protected Bdate As String
    Protected JoiningDate As String
    Protected EmailID As String
    Protected CurrentAddess As String
    Protected CurrentAddess1 As String
    Protected CurrentCity As String
    Protected CurrentCity1 As String
    Protected CurrentState As String
    Protected CurrentState1 As String
    Protected CurrentPincode As String
    Protected CurrentPincode1 As String
    Protected CboRoleEdit As String
    Protected CboDepartmentUnitEdit As String
    Protected CboEmplyeeType As String
    Protected CboReportingTo As String
    Protected txtRatehrs As String
    Protected txtCosthrs As String
    Protected CboDeployable As String
    Protected BusinessGroupID As String
    Protected CboOrganizationUnit As String
    Protected PssportNo As String
    Protected DateIssue As String
    Protected PlcIssue As String
    Protected ExDate As String
    Protected FullName As String
    Protected SonWife As String
    Protected NoLeftPage As String
    Protected EmployeeID As String
    Protected EmployeePhoto As String
    Protected TentativeLeavingDate As String
    Protected LeavingDate As String
    Protected idStatusValue As String
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
        If Request.Params("Mode") = "SaveEmployeeInfo" Then
            ' the system file name
            Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""

            If Request.Files.Count > 0 Then
                'strOriginalFileName = Request.Files(0).FileName
                ' strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                ' strFileName &= strFileExtension


                strOriginalFileName = System.IO.Path.GetFileName(Request.Files(0).FileName)
                'strFileName = objFile.UploadedFileName
                strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension


                Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), strFileName)
                Request.Files(0).SaveAs(fileSavePath)
                'strSQLQuery = "usp_NG2_Ins_tbl_NG2_CRM_RequestAttachments '" & strOriginalFileName & "','" & strFileName & "'," & Session("intUserID") & ""
                ' strAttachmentID = CommonFunctions.Data.GetDataScalar(strSQLQuery, True)

            End If
            EmployeePhoto = Request.Params("EmployeePhoto")
            EmployeeName = Request.Params("EmployeeName")
            EmployeeCode = Request.Params("EmployeeCode")
            UserName = Request.Params("UserName")
            LdapValue = Request.Params("LdapValue")
            Bdate = Request.Params("Bdate")
            JoiningDate = Request.Params("JoiningDate")
            EmailID = Request.Params("EmailID")
            CurrentAddess = Request.Params("CurrentAddess")
            CurrentAddess1 = Request.Params("CurrentAddess1")
            CurrentCity = Request.Params("CurrentCity")
            CurrentCity1 = Request.Params("CurrentCity1")
            CurrentState = Request.Params("CurrentState")
            CurrentState1 = Request.Params("CurrentState1")
            CurrentPincode = Request.Params("CurrentPincode")
            CurrentPincode1 = Request.Params("CurrentPincode1")
            CboRoleEdit = Request.Params("CboRoleEdit")
            CboDepartmentUnitEdit = Request.Params("CboDepartmentUnitEdit")
            CboEmplyeeType = Request.Params("CboEmplyeeType")
            CboReportingTo = Request.Params("CboReportingTo")
            'txtRatehrs = Request.Params("txtRatehrs")
            'txtCosthrs = Request.Params("txtCosthrs")
            CboDeployable = Request.Params("CboDeployable")
            'BusinessGroupID = Request.Params("BusinessGroupID")
            'CboOrganizationUnit = Request.Params("CboOrganizationUnit")
            PssportNo = Request.Params("PssportNo")
            DateIssue = Request.Params("DateIssue")
            PlcIssue = Request.Params("PlcIssue")
            ExDate = Request.Params("ExDate")
            FullName = Request.Params("FullName")
            SonWife = Request.Params("SonWife")
            NoLeftPage = Request.Params("NoLeftPage")
            TentativeLeavingDate = Request.Params("TentativeLeavingDate")
            LeavingDate = Request.Params("LeavingDate")
            idStatusValue = Request.Params("idStatusValue")
            EmployeeID = Request.Params("EmployeeID")
            ''   SaveEmployeeDetails(EmployeeName, EmployeeCode, UserName, LdapValue, Bdate, JoiningDate, EmailID, CurrentAddess, CurrentAddess1, CurrentCity, CurrentCity1, CurrentState, CurrentState1, CurrentPincode, CurrentPincode1, CboRoleEdit, CboDepartmentUnitEdit, CboEmplyeeType, CboReportingTo, txtRatehrs, txtCosthrs, CboDeployable, BusinessGroupID, CboOrganizationUnit, PssportNo, DateIssue, PlcIssue, ExDate, FullName, SonWife, NoLeftPage, EmployeeID, strOriginalFileName, strFileName)
            ''   SaveEmployeeDetails(EmployeeName, EmployeeCode, UserName, LdapValue, Bdate, JoiningDate, EmailID, CurrentAddess, CurrentAddess1, CurrentCity, CurrentCity1, CurrentState, CurrentState1, CurrentPincode, CurrentPincode1, CboRoleEdit, CboDepartmentUnitEdit, CboEmplyeeType, CboReportingTo, txtRatehrs, txtCosthrs, CboDeployable, PssportNo, DateIssue, PlcIssue, ExDate, FullName, SonWife, NoLeftPage, EmployeeID, strOriginalFileName, strFileName)
            SaveEmployeeDetails(EmployeeName, EmployeeCode, UserName, LdapValue, Bdate, JoiningDate, EmailID, CurrentAddess, CurrentAddess1, CurrentCity, CurrentCity1, CurrentState, CurrentState1, CurrentPincode, CurrentPincode1, CboRoleEdit, CboDepartmentUnitEdit, CboEmplyeeType, CboReportingTo, CboDeployable, PssportNo, DateIssue, PlcIssue, ExDate, FullName, SonWife, NoLeftPage, EmployeeID, strOriginalFileName, strFileName, TentativeLeavingDate, LeavingDate, idStatusValue)
        End If
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


        strHTML.Append(WriteTabsControls("Type", "Load", ""))
        If Flag.ToUpper = "LOAD" Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If

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

        strHTML.Append("<div id='UserMaster' class='tabcontent3 h-type h-form clsSettingstabs'>")
        strHTML.Append(UserMasterTabDetails(strWhichGrid, strGridFlag, "", "", ""))
        strHTML.Append("</div>")


        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function
    ''Department, Role, Status
    Public Function UserMasterTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal Department As String, ByVal Role As String, ByVal Status As String)
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
        strHTML.Append("<div id='divEmployeeScroll'>")
        strHTML.Append("<div class='type-top-bar top-bar' id='EmployeeFilter'>")
        strHTML.Append("<ul class='left'>")
        strHTML.Append("<li class='search-bar'>")
        strHTML.Append("<div class='left search-bar'>")
        strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'")
        strHTML.Append("</div>")
        strHTML.Append("</li>")
        strHTML.Append("<li>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_NG2_Sel_tbl_PM_DepartmentMaster", 129, , " onchange='DepartMentFilter_OnChange(this)' class='form-control' ", False, True))
        strHTML.Append("</li>	")
        strHTML.Append("<li>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRole", "usp_NG2_Sel_tbl_PM_Role ", 129, , " onchange='DepartMentFilter_OnChange(this)' class='form-control' ", False, True))
        strHTML.Append("</li>")
        strHTML.Append("<li>")

        strHTML.Append("</li>")
        strHTML.Append("<li>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboStatus", "usp_NG2_Sel_v_tbl_PM_EmployeeStatus ", 129, , "onchange='DepartMentFilter_OnChange(this)' class='form-control' ", False, True, "form-control"))
        strHTML.Append("</li>")
        'strHTML.Append("<li class='left search-bar'>")


        ' strHTML.Append("<ul class='left'>")

        strHTML.Append("</ul>")

        'strHTML.Append("</li>")

        'strHTML.Append("<li class='left search-bar'>")
        'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        'strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        'strHTML.Append("</li>")
        'strHTML.Append("</ul>")

        '/*Changed By Yasmin on 25th july 2018*/
        strHTML.Append(" <ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append(" <li class='clearall'><button type='button' class='btn btn-default'  title='Add Employee' onclick='AddEmployee()'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")        End If        If m_objAccessRights.Delete = True Then            strHTML.Append(" <li class='clearall'><button type='button' class='btn btn-default' title='Delete Employee' onclick='DeleteEmployee()'>Delete<i class='fa fa-trash-o'  aria-hidden=true'></i></button></li>")
        End If
        strHTML.Append(" </ul>")

        strHTML.Append(" </div>")

        strHTML.Append("<div class='table-responsive' id='tblEmployee'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, "", "", "", ""))
        strHTML.Append("</div>")
        strHTML.Append(" <div class='bottom-bar'>")
        strHTML.Append(" <div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")

        strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne'>")
        strHTML.Append("	<h3><span>Add New User</span></h3>")

        strHTML.Append("<h4 class='panel-title'>")
        strHTML.Append("<a role='button' id='Addaccordion' data-toggle='collapse' data-parent='#accordion' href='#collapseOne8' aria-expanded='true' aria-controls='collapseOne'>")
        strHTML.Append("<i class='fa fa-plus' title='Expand'  onclick='AddEmployeeSign(this)' ></i>")
        strHTML.Append("<i class='fa fa-minus' title='Hide' onclick='AddEmployeeSign(this)'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne8' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strHTML.Append(" <div class='panel-body' id='EmployeePanel'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php' enctype='multipart/form-data' method='post'>")
        strHTML.Append("<div class='form-group' id='UploadImage'>")
        'strHTML.Append("<div class='col-xs-1' >")
        'strHTML.Append("<div class='avatar'><img class='img-circle'   src=''>Upload Image</div>")
        'strHTML.Append("<div class='bros-btn'>")
        'strHTML.Append("<input type='file' id='file' name='img[]' class='file'/>")
        'strHTML.Append("<button type='button' id='btnSelectFile' data-toggle='tooltip'  filecount='0' onclick='SelectFile();' class='btn btn-default save'></button>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")

        strHTML.Append("<div class='col-xs-1' id='idUploadImage' >")
        '  strHTML.Append("<div class='avatar'><div class='bros-btn'><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='' /></a></div></div></div>")
        strHTML.Append("<div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' title='Upload Image' src='' /></a></div></div></div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' id='EditImage' style='display:none'>")
        strHTML.Append("<div class='edit'>")
        strHTML.Append("<input name='img[]'class='file' id='file' type='file'><a   id='btnSelectFile'  onclick='SelectFile()' filecount='0'><i class='fa fa-pencil' title='Edit Photo' style='font-size: 16px'></i></a>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Employee Name*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='EmployeeName'  name='EmployeeName' placeholder='Employee Name'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("EmployeeName", "EmployeeName", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter Employee Name' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Employee Code*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        ' strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='EmployeeCode' placeholder='Employee Code'  name='EmployeeCode' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("EmployeeCode", "EmployeeCode", "form-control", 217, 50, , , , , , , , " class='form-control'  placeholder='Enter Employee Code' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>User Name*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='UserName'  name='UserName' placeholder='User Name'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("UserName", "UserName", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter User Name' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Enable LDAP Authenication</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<input type='checkbox' style='width:11px;' id='LDAPCHECk'>")
        strHTML.Append(" </div>	")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Birth Date*</label>")
        strHTML.Append(" <div class='col-sm-2'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='Bdate'   name='Bdate' placeholder='Birth Date'>")
        '' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Bdate", "Bdate", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Enter Birth Date' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("<input type='text' value=''  class='form-control inp clsDateControl' id='Bdate' placeholder=''>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<i class='fa fa-calendar fcal' id='idCalenderBdate' style='font-size: 14px; margin-right: 10px;' onclick=""$('#Bdate').datepicker();$('#Bdate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Joining Date*</label>")
        strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='JoiningDate'   name='JoiningDate' placeholder='Joining Date'>")
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("JoiningDate", "JoiningDate", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Enter Joining Date' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("<input type='text' value='' class='form-control inp clsDateControl' id='JoiningDate' placeholder=''>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<i class='fa fa-calendar fcal' id='idCalenderJoiningDate' style='font-size: 14px; margin-right: 10px;' onclick=""$('#JoiningDate').datepicker();$('#JoiningDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Email ID*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='EmailID'  name='EmailID' placeholder='Email ID'  onblur='ValidateEmailID1()'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("EmailID", "EmailID", "form-control", 217, 50, , , , , , , , " class='form-control'  placeholder='Enter Email ID'  onblur='ValidateEmailID1()'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Deployable'>Deployable*</label>")
        strHTML.Append("<div id='divdelopable' class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDeployable", "usp_Sel_Employee_Deployable ", 200, , "class='form-control' ", True, True))
        strHTML.Append(" </div></div>")
        '''''''''''''''''Cost Per Hours && Rate Per Hours''''''''''''''''''''''''''''''''''''''''''''''''''''
        'strHTML.Append("<div class='form-group'>	")
        'strHTML.Append(" <label class='control-label col-sm-2' for='Cost Per Hours'>Cost Per Hours*</label>")
        'strHTML.Append(" <div class='col-sm-4'>")
        '' strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='txtCosthrs'  name='txtCosthrs' placeholder='Cost Per Hours'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCosthrs", "txtCosthrs", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Enter Cost Per Hours'", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append("</div>")
        'strHTML.Append("<label class='control-label col-sm-2' for='Expiry Date'>Rate Per Hours*</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        '' strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='txtRatehrs'  name='txtRatehrs' placeholder='Rate Per Hours'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRatehrs", "txtRatehrs", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Enter Rate Per Hours'", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append("  </div></div>")

        ''''''''''''''''''''''''''''''''''''''''''''''''
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='request type' style='text-decoration:underline'>Permanant Address</label>")
        strHTML.Append("  <div class='col-sm-4'>")
        strHTML.Append(" </div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type' style='text-decoration:underline'>Current address</label>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Same as permanant address</label>")
        strHTML.Append(" <div class='col-sm-1'>")
        strHTML.Append("<input type='checkbox' style='width:11px;' id='checkSameasall' onclick='SameAsAll(this)' >")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='Address'>Address</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='Address'  name='Address' placeholder='Address' onkeypress='AddData()'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Address", "Address", "form-control", 217, 255, , , , , , , , " class='form-control'  placeholder='Enter Address' onkeypress='AddData()'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Address'>Address</label>")
        strHTML.Append("<div class='col-sm-4'>")
        ' strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='Address2'  name='Address2' placeholder='Address'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Address2", "Address2", "form-control", 217, 255, , , , , , , , " class='form-control'  placeholder='Enter Address'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='City'>City</label>")
        strHTML.Append("  <div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='City'  name='City' placeholder='City' onkeypress='AddData()'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("City", "City", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter City' onkeypress='AddData()'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='City'>City</label>")
        strHTML.Append("<div class='col-sm-4'>")
        ' strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='City2'  name='City2' placeholder='City'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("City2", "City2", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter City'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='State'>State</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        ' strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='State'  name='State' placeholder='State' onkeypress='AddData()'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("State", "State", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter State' onkeypress='AddData()'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='State'>State</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='State2'  name='State2' placeholder='State'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("State2", "State2", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter State' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='Pin Code'>Pin Code</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='PinCode'  name='PinCode' placeholder=' Pin Code' onkeypress='AddData()'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PinCode", "PinCode", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter PinCode' onkeypress='AddData()'", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Pin Code'>Pin Code</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        ' strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='PinCode2'  name='PinCode2'  placeholder=' Pin Code'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PinCode2", "PinCode2", "form-control", 217, 30, , , , , , , , " class='form-control'  placeholder='Enter PinCode' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' id='new'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Role'>Role*</label>")
        strHTML.Append(" <div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRoleEdit", "usp_Sel_tbl_PM_Role ", 200, , "class='form-control' ", True, True))

        strHTML.Append(" </div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='Department /Unit'>Department /Unit*</label>")
        strHTML.Append(" <div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartmentUnitEdit", "usp_Sel_PM_DepartmentList ", 200, , "class='form-control' ", True, True))

        strHTML.Append("	  </div>	")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' id='new1'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='Employee Type'>Employee Type*</label>")
        strHTML.Append(" <div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEmplyeeType", "usp_Sel_tbl_RTS_ProjectSpecificControlData 'EmployeeType'", 200, , "class='form-control' ", True, True))

        strHTML.Append("  </div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='Reporting To'>Reporting To*</label>")
        strHTML.Append("  <div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboReportingTo", "usp_NG2_Sel_tbl_PM_EmployeeReportingTo", 200, , "class='form-control' ", True, True))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")





        'strHTML.Append("<div class='form-group'>")
        'strHTML.Append(" <label class='control-label col-sm-2' for='LocationID'>Business Group*</label>")
        'strHTML.Append(" <div class='col-sm-4'>")

        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("BusinessGroupID", "usp_Sel_tbl_CNF_BusinessGroup 0 , " & HttpContext.Current.Session("intUserID") & "," & HttpContext.Current.Session("intUserID") & ",'RM'", 217, , " onchange=BusinessGroup_Change(this) class='form-control' ", True, True))

        'strHTML.Append("  </div>")
        'strHTML.Append(" <label class='control-label col-sm-2' for='Organization Unit'>Organization Unit*</label>")
        'strHTML.Append(" <div class='col-sm-4'>")

        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboOrganizationUnit", "Select 'Organization Unit'", 217, , " onchange=LocationCopy_OnChange(this) class='form-control' ", False, True))
        'strHTML.Append("</div>")
        'strHTML.Append("</div>	")


        strHTML.Append("<div class='form-group' style='display:none' id='idFromLeavingDate'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='Tentative Leaving Date'>Tentative Leaving Date</label>")
        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<input type='text' value=''  class='form-control inp clsDateControl' id='TentativeLeavingDate' placeholder=''>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<i class='fa fa-calendar fcal' id='idTentativeLeavingDate' style='font-size: 14px; margin-right: 10px;' onclick=""$('#TentativeLeavingDate').datepicker();$('#TentativeLeavingDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Leaving Date  </label>")
        strHTML.Append("<div class='col-sm-2'>")
        'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='JoiningDate'   name='JoiningDate' placeholder='Joining Date'>")
        ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("JoiningDate", "JoiningDate", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Enter Joining Date' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("<input type='text' value='' class='form-control inp clsDateControl' id='LeavingDate' placeholder=''>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<i class='fa fa-calendar fcal' id='idCalenderLeavingDate' style='font-size: 14px; margin-right: 10px;' onclick=""$('#LeavingDate').datepicker();$('#LeavingDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group' id='FormStatus' style='display:none'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Status (Inactive)</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<input type='checkbox' style='width:11px;' id='idStatus'>")
        strHTML.Append(" </div>	")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='Passport Details' style='text-decoration:underline'>Passport Details</label>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Passport Number'>Passport Number</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='PssportNo'  name='PssportNo'  placeholder='Passport Number'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PssportNo", "PssportNo", "form-control", 217, 33, , , , , , , , " class='form-control'  placeholder='Enter Passport Number' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("<label class='control-label col-sm-2' for='Place Of Issue'>Place Of Issue</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='PlcIssue'  name='PlcIssue' placeholder='Place Of Issue'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PlcIssue", "PlcIssue", "form-control", 217, 50, , , , , , , , " class='form-control'  placeholder='Enter Place Of Issue' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='Full name (as in Passport)'>Full name (as in Passport)</label>")
        strHTML.Append("<div class='col-sm-4'>")
        ' strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='FullName'  name='FullName' placeholder='Full name (as in Passport)'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("FullName", "FullName", "form-control", 217, 100, , , , , , , , " class='form-control'  placeholder='Enter Full name (as in Passport)' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='Son of/Wife of/Daughter of'>Son of/Wife of/Daughter of</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        'strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='SonWife'  name='SonWife' placeholder='Son of/Wife of/Daughter of'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SonWife", "SonWife", "form-control", 217, 36, , , , , , , , " class='form-control'  placeholder='Enter Son of/Wife of/Daughter of' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='Date of Issue'>Date of Issue</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        ''strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='DateIssue'  name='DateIssue' placeholder='Date of Issue'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DateIssue", "DateIssue", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Date of Issue' ", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append(" </div>")


        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<input type='text' value=''  class='form-control inp clsDateControl' id='DateIssue' placeholder=''>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<i class='fa fa-calendar fcal' id='idCalenderDateIssue' style='font-size: 14px; margin-right: 10px;' onclick=""$('#DateIssue').datepicker();$('#DateIssue').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='No. of Pages left'>No. of Pages left</label>")
        strHTML.Append("<div class='col-sm-4'>")
        ' strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='NoLeftPage'  name='NoLeftPage' placeholder='No. of Pages left'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("NoLeftPage", "NoLeftPage", "form-control", 217, 8, , , , , , , , " class='form-control'  placeholder='Enter No. of Pages left' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='Expiry Date'>Expiry Date</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        ''strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='ExDate'  name='ExDate' placeholder='Expiry Date'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ExDate", "ExDate", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Expiry Date' ", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append("</div>")

        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<input type='text' value=''  class='form-control inp clsDateControl' id='ExDate' placeholder=''>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='col-sm-2'>")
        strHTML.Append("<i class='fa fa-calendar fcal' id='idCalenderExDate' style='font-size: 14px; margin-right: 10px;' onclick=""$('#ExDate').datepicker();$('#ExDate').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        '/*Changed By Yasmin on 27th july 2018*/
        strHTML.Append("<div class=''>	")
        strHTML.Append("<div class='right'>	")
        ''strHTML.Append("<button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;'>Attachment</button>")
        GetGlobalObject(23)
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            'strHTML.Append("<button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;' onclick='SaveEmployee()'>Save</button>")
        End If

        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveEmployee(""Save"")'>Save</button>")
            strHTML.Append(" <button type='button' class='btn btn-default save' style='background-color:#343660;color:#fff;border-left:1px solid;' onclick='SaveEmployee(""AddSave"")' >Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")

        End If
        strHTML.Append(" <button type='button' class='btn btn-default save' style='border-left:1px solid;' onclick='CancelEmployee()' >Cancel</button>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
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

        Return strGridHTML.ToString

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



        intNoOfDataColumn = 4
        strDivID = "divEmployee"
        strSQLQuery = "usp_NG2_Sel_v_tbl_PM_Employee " & strDepartmentFlag & " ," & StrRoleFlag & "," & StrStatusFlag & ""

        arrstrActualList = {"EmployeeName", "UserName", "RoleName", "Department", "Edit", "Select"}
        arrstrUserFriendlyList = {"Employee Name", "User Name", "Role", "Department", "Edit", ""}
        arrstrLinkArray = {"", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

        objGrid = m_objUserMasterGrid


        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            ' .CheckBoxIDArray = arrCheckBoxArray
            .NoOfDataColumns = intNoOfDataColumn
            .RowLinkArray = arrstrLinkArray
            .TDStyleArray = arrWidthArray
            .DIVStyle = ""
            '.ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = (" ")
            .DIVID = strDivID
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

        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing

        Return strGridHTML.ToString
    End Function


    Private Sub m_objUserMasterGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objUserMasterGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkUserMaster' id='chkUserMaster' title='Select All' onclick='SelectAll_Checkbox(this)'/></th>"
        End If




    End Sub

    Private Sub m_objRoleMasterGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objRoleMasterGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkRoleSelect' title='Select All' onclick='SelectRoleAll_Checkbox(this)'/></th>"
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
            Args.StringToBeInserted = "<td salign=''  Title='Edit Employee' ><i class='fa fa-pencil-square-o'  style='font-size:16px!important;cursor:pointer;'  onclick=""Employee_OnClick(" & Args.DataReader("EmployeeID") & ")""   id='Editdata_" & Args.DataReader("EmployeeID") & "'></i></td>"
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
            m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_tbl_PM_EmployeeEdit " & Args.DataReader("EmployeeID"), True), "0")

            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            If m_strCanDelete = "0" Then
                Args.StringToBeInserted = "<td align='' Title = 'Delete Employee'><input type=checkbox id='chkUserMasterSelect'" & Args.DataReader("EmployeeID") & " name=chkUserMasterSelect   value=" & Args.DataReader("EmployeeID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='' Title = """ & m_strCanDelete & """ ><input type=checkbox id='chkUserMasterSelect'" & Args.DataReader("EmployeeID") & " name=chkUserMasterSelect disabled  value=" & Args.DataReader("EmployeeID") & " >" + "</TD>"
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
            Args.StringToBeInserted = "<td style='text-align:center;width:1%;'  title=" & Args.DataField & "><i class='fa fa-pencil-square-o' data-placement='bottom' data-toggle='tooltip' style='font-size:16px!important;cursor:pointer;' onclick=""Role_OnClick(" & Args.DataReader("RoleID") & ")""  title='Edit' id='Editdata_" & Args.DataReader("RoleID") & "'></i></td>"
        End If

        If Args.DataField.ToUpper = "ROLEDESCRIPTION" Then
            Cancel = True
            Args.StringToBeInserted = "<TD nowrap; title=" & Args.DataField & "><A href=""JavaScript:Role_OnClick(" & CType(Args.DataReader("RoleID"), String) & ")"">" & Args.DataReader("RoleDescription").ToString & "" & "</A></br></TD>"
        End If

        Dim m_strCanDelete As String
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            ' Args.StringToBeInserted = "<TD nowrap; title=" & Args.DataField & "><input type=checkbox name='chkchkRoleMasterSelect' Id='chkRoleMaster_" & Args.DataReader("RoleID") & " title='Select Record' onclick='RoleListCheckBox_OnClick(this," & Args.DataReader("RoleID") & ")' value=" & Args.DataReader("RoleID") & " ></TD>"
            Cancel = True
            m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Del_tbl_PM_RoleEdit " & Args.DataReader("RoleID"), True), "0")

            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            If m_strCanDelete = "0" Then
                Args.StringToBeInserted = "<td align='' Title = 'Delete Employee'><input type=checkbox id='chkchkRoleMasterSelect'" & Args.DataReader("RoleID") & " name=chkchkRoleMasterSelect   value=" & Args.DataReader("RoleID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='' Title = '" & m_strCanDelete & "' ><input type=checkbox id='chkchkRoleMasterSelect'" & Args.DataReader("RoleID") & " name=chkchkRoleMasterSelect disabled  value=" & Args.DataReader("RoleID") & " >" + "</TD>"
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
            Dim objCRM_User_RoleAccess As New CRM_UserAccess()
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
            Dim objCRM_User_RoleAccess As New CRM_UserAccess()
            If Department = "" Then
                Department = "null"
            End If
            If Role = "" Then
                Role = "null"
            End If
            If Status = "" Then
                Status = "null"
            End If

            strGridHTML.Append(objCRM_User_RoleAccess.UserMasterTabDetails(GridParameter("cityName"), "AJAXRefresh", Department, Role, Status))

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
            Dim SystemFilename As String = ""
            Dim strImageName As String = ""
            Dim strEmployeeImage As String
            Dim strFilePath As String = ""
            Dim TentativeDateOfRelieving As String = ""
            Dim LeavingDate As String = ""
            Dim Status As String = ""
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


                'RatePerHour = CommonFunctions.Data.CheckIsDBNull(drProjectCount("RatePerHour").ToString, "")
                'CostPerHour = CommonFunctions.Data.CheckIsDBNull(drProjectCount("CostPerHour").ToString, "")
                Deployable = CommonFunctions.Data.CheckIsDBNull(drProjectCount("Deployable").ToString, "")
                BusinessGroupID = CommonFunctions.Data.CheckIsDBNull(drProjectCount("BusinessGroupID").ToString, "")
                LocationID = CommonFunctions.Data.CheckIsDBNull(drProjectCount("LocationID").ToString, "")
                Location = CommonFunctions.Data.CheckIsDBNull(drProjectCount("Location").ToString, "")
                PP_RelativeName = CommonFunctions.Data.CheckIsDBNull(drProjectCount("PP_RelativeName").ToString, "")
                JoiningDate = CommonFunctions.Data.CheckIsDBNull(drProjectCount("JoiningDate").ToString, "")
                SystemFilename = CommonFunctions.Data.CheckIsDBNull(drProjectCount("SystemFilename").ToString, "")
                TentativeDateOfRelieving = CommonFunctions.Data.CheckIsDBNull(drProjectCount("TentativeDateOfRelieving").ToString, "")
                LeavingDate = CommonFunctions.Data.CheckIsDBNull(drProjectCount("LeavingDate").ToString, "")
                Status = CommonFunctions.Data.CheckIsDBNull(drProjectCount("Status").ToString, "")



                Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
                strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1)
                strEmployeeImage = strEmployeeImage.Replace("\", "/")

                If Not SystemFilename Is Nothing Then
                    strFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), SystemFilename)
                End If

                If File.Exists(strFilePath) = False Or CommonFunctions.General.CheckIsNothing(SystemFilename) = "" Then
                    strEmployeeImage = strEmployeeImage + "/Images/Photo/no-photo.png"
                Else
                    strEmployeeImage = strEmployeeImage + "/Images/Photo/" + SystemFilename
                End If



            End If

            Return EmployeeName & "#$#" & EmployeeCode & "#$#" & UserName & "#$#" & IsLDAPAuthentication & "#$#" & BirthDate & "#$#" & Address & "#$#" & City & "#$#" & PinCode & "#$#" & State.ToString & "#$#" & CurrentAddress & "#$#" & CurrentCity & "#$#" & CurrentPinCode & "#$#" & CurrentState & "#$#" & RoleName & "#$#" & EmployeeType & "#$#" & ReportingTo & "#$#" & PassportNumber & "#$#" & PP_PlaceOfIssue & "#$#" & PP_FullName & "#$#" & PP_DateOfIssue & "#$#" & NoofPagesLeft & "#$#" & DepartmentID & "#$#" & EmailID & "#$#" & PP_ExpiryDate & "#$#" & RatePerHour & "#$#" & CostPerHour & "#$#" & Deployable & "#$#" & BusinessGroupID & "#$#" & Location & "#$#" & LocationID & "#$#" & PP_RelativeName & "#$#" & JoiningDate & "#$#" & strEmployeeImage & "#$#" & TentativeDateOfRelieving & "#$#" & LeavingDate & "#$#" & Status
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

        Dim m_intUniqueID As Integer = 0
        Dim strSQL As String
        Dim m_RoleId As String
        Try

            strSQL = "exec usp_NG2_INS_v_tbl_PM_RoleNew  '" & RoleDescription & "'," & textBillingRate & "," & TextCost & ",'" & ModuleValue & "'," & level & "," & CboRoleDepartMent & "," & GenerateInvoicevalue & "," & SalesActivityvalue & "," & CheckAssignmentvalue & "," & RoleID & ""

            m_RoleId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return m_RoleId
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function
    '<System.Web.Services.WebMethod> _
    'Public Shared Function SaveEmployeeDetails(ByVal EmployeeName As String, ByVal EmployeeCode As String, ByVal UserName As String, ByVal LdapValue As String, ByVal Bdate As String, ByVal JoiningDate As String, ByVal EmailID As String, ByVal CurrentAddess As String, ByVal CurrentAddess1 As String, ByVal CurrentCity As String, ByVal CurrentCity1 As String, ByVal CurrentState As String, ByVal CurrentState1 As String, ByVal CurrentPincode As String, ByVal CurrentPincode1 As String, ByVal CboRoleEdit As String, ByVal CboDepartmentUnitEdit As String, ByVal CboEmplyeeType As String, ByVal CboReportingTo As String, ByVal txtRatehrs As String, ByVal txtCosthrs As String, ByVal CboDeployable As String, ByVal BusinessGroupID As String, ByVal CboOrganizationUnit As String, ByVal PssportNo As String, ByVal DateIssue As String, ByVal PlcIssue As String, ByVal ExDate As String, ByVal FullName As String, ByVal SonWife As String, ByVal NoLeftPage As String, ByVal EmployeeID As String) As String
    ' Public Function SaveEmployeeDetails(ByVal EmployeeName As String, ByVal EmployeeCode As String, ByVal UserName As String, ByVal LdapValue As String, ByVal Bdate As String, ByVal JoiningDate As String, ByVal EmailID As String, ByVal CurrentAddess As String, ByVal CurrentAddess1 As String, ByVal CurrentCity As String, ByVal CurrentCity1 As String, ByVal CurrentState As String, ByVal CurrentState1 As String, ByVal CurrentPincode As String, ByVal CurrentPincode1 As String, ByVal CboRoleEdit As String, ByVal CboDepartmentUnitEdit As String, ByVal CboEmplyeeType As String, ByVal CboReportingTo As String, ByVal txtRatehrs As String, ByVal txtCosthrs As String, ByVal CboDeployable As String, ByVal BusinessGroupID As String, ByVal CboOrganizationUnit As String, ByVal PssportNo As String, ByVal DateIssue As String, ByVal PlcIssue As String, ByVal ExDate As String, ByVal FullName As String, ByVal SonWife As String, ByVal NoLeftPage As String, ByVal EmployeeID As String, ByVal strOriginalFileName As String, ByVal strFileName As String) As String
    ''Public Function SaveEmployeeDetails(ByVal EmployeeName As String, ByVal EmployeeCode As String, ByVal UserName As String, ByVal LdapValue As String, ByVal Bdate As String, ByVal JoiningDate As String, ByVal EmailID As String, ByVal CurrentAddess As String, ByVal CurrentAddess1 As String, ByVal CurrentCity As String, ByVal CurrentCity1 As String, ByVal CurrentState As String, ByVal CurrentState1 As String, ByVal CurrentPincode As String, ByVal CurrentPincode1 As String, ByVal CboRoleEdit As String, ByVal CboDepartmentUnitEdit As String, ByVal CboEmplyeeType As String, ByVal CboReportingTo As String, ByVal txtRatehrs As String, ByVal txtCosthrs As String, ByVal CboDeployable As String, ByVal PssportNo As String, ByVal DateIssue As String, ByVal PlcIssue As String, ByVal ExDate As String, ByVal FullName As String, ByVal SonWife As String, ByVal NoLeftPage As String, ByVal EmployeeID As String, ByVal strOriginalFileName As String, ByVal strFileName As String) As String
    Public Function SaveEmployeeDetails(ByVal EmployeeName As String, ByVal EmployeeCode As String, ByVal UserName As String, ByVal LdapValue As String, ByVal Bdate As String, ByVal JoiningDate As String, ByVal EmailID As String, ByVal CurrentAddess As String, ByVal CurrentAddess1 As String, ByVal CurrentCity As String, ByVal CurrentCity1 As String, ByVal CurrentState As String, ByVal CurrentState1 As String, ByVal CurrentPincode As String, ByVal CurrentPincode1 As String, ByVal CboRoleEdit As String, ByVal CboDepartmentUnitEdit As String, ByVal CboEmplyeeType As String, ByVal CboReportingTo As String, ByVal CboDeployable As String, ByVal PssportNo As String, ByVal DateIssue As String, ByVal PlcIssue As String, ByVal ExDate As String, ByVal FullName As String, ByVal SonWife As String, ByVal NoLeftPage As String, ByVal EmployeeID As String, ByVal strOriginalFileName As String, ByVal strFileName As String, ByVal TentativeLeavingDate As String, ByVal LeavingDate As String, ByVal idStatusValue As String) As String
        '=====================================================================
        ' Procedure Name        : SaveEmployeeDetails
        ' Description           : To  Save EmployeeDetails
        ' Created Date           : 9th Nov 2017
        '=====================================================================
        Try
            Dim m_intUniqueID As Integer = 0
            Dim strSQL As String
            Dim m_EmployeeId As String
            Dim strListHTML As New StringBuilder("")
            Dim strUsername As String = HttpContext.Current.Session("strUserName")
            Dim strLoginType As String = HttpContext.Current.Session("LoginType")
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
                CurrentState = ""
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

            If TentativeLeavingDate = "" Then
                TentativeLeavingDate = ""
            End If
            If LeavingDate = "" Then
                LeavingDate = ""
            End If

            If idStatusValue = "" Then
                idStatusValue = "NULL"
            End If


            ''  strSQL = "exec usp_NG2_Ins_v_tbl_PM_Employee  '" & EmployeeName & "','" & EmployeeCode & "','" & UserName & "'," & LdapValue & ",'" & Bdate & "','" & EmailID & "','" & CurrentAddess & "','" & CurrentAddess1 & "','" & CurrentCity & "','" & CurrentCity1 & "','" & CurrentState & "','" & CurrentState1 & "','" & CurrentPincode & "','" & CurrentPincode1 & "'," & CboRoleEdit & "," & CboDepartmentUnitEdit & ",'" & CboEmplyeeType & "'," & CboReportingTo & ",'" & JoiningDate & "'," & txtRatehrs & "," & txtCosthrs & ",'" & CboDeployable & "'," & BusinessGroupID & "," & CboOrganizationUnit & ",'" & PssportNo & "','" & DateIssue & "','" & PlcIssue & "','" & ExDate & "','" & FullName & "','" & SonWife & "'," & NoLeftPage & "," & EmployeeID & ",'" & strOriginalFileName & "','" & strFileName & "','" & strLoginType & "','" & strUsername & "'"
            '' strSQL = "exec usp_NG2_Ins_v_tbl_PM_Employee  '" & EmployeeName & "','" & EmployeeCode & "','" & UserName & "'," & LdapValue & ",'" & Bdate & "','" & EmailID & "','" & CurrentAddess & "','" & CurrentAddess1 & "','" & CurrentCity & "','" & CurrentCity1 & "','" & CurrentState & "','" & CurrentState1 & "','" & CurrentPincode & "','" & CurrentPincode1 & "'," & CboRoleEdit & "," & CboDepartmentUnitEdit & ",'" & CboEmplyeeType & "'," & CboReportingTo & ",'" & JoiningDate & "'," & txtRatehrs & "," & txtCosthrs & ",'" & CboDeployable & "','" & PssportNo & "','" & DateIssue & "','" & PlcIssue & "','" & ExDate & "','" & FullName & "','" & SonWife & "'," & NoLeftPage & "," & EmployeeID & ",'" & strOriginalFileName & "','" & strFileName & "','" & strLoginType & "','" & strUsername & "'"
            strSQL = "exec usp_NG2_Ins_v_tbl_PM_Employee  '" & EmployeeName & "','" & EmployeeCode & "','" & UserName & "'," & LdapValue & ",'" & Bdate & "','" & EmailID & "','" & CurrentAddess & "','" & CurrentAddess1 & "','" & CurrentCity & "','" & CurrentCity1 & "','" & CurrentState & "','" & CurrentState1 & "','" & CurrentPincode & "','" & CurrentPincode1 & "'," & CboRoleEdit & "," & CboDepartmentUnitEdit & ",'" & CboEmplyeeType & "'," & CboReportingTo & ",'" & JoiningDate & "','" & CboDeployable & "','" & PssportNo & "','" & DateIssue & "','" & PlcIssue & "','" & ExDate & "','" & FullName & "','" & SonWife & "'," & NoLeftPage & "," & EmployeeID & ",'" & strOriginalFileName & "','" & strFileName & "','" & strLoginType & "','" & strUsername & "'," & idStatusValue & ",'" & TentativeLeavingDate & "','" & LeavingDate & "'"
            'strSQL +=  & CurrentCity1 & " '""

            m_EmployeeId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))

            Dim dtTable As DataTable
            Dim dtTable1 As DataTable

            Dim strEmployeeImage As String = ""
            Dim intEmployeeID As Integer = 0

            strEmployeeImage = GetEmployeeImagePath(m_EmployeeId)
            strListHTML.Append("<div class='col-xs-1' >")
            '  strListHTML.Append("<div class='avatar'><div class='bros-btn'><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='' /></a></div></div></div>")
            strListHTML.Append("<div><div><img id='imgUser' alt='Upload Image' title='Upload Image' src='" & strEmployeeImage & "' /></div></div></div>")
            strListHTML.Append("<input type=hidden name='hdnEmployeeIDValue' id='hdnEmployeeIDValue' value='" & m_EmployeeId & "' /></div>")

            ''CommonFunctions.General.WriteHTML(strListHTML.ToString)
            Response.Write(strListHTML.ToString)
            Response.End()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

        '  Response.Write(strListHTML.ToString)

    End Function


    Public Function GetEmployeeImagePath(ByVal intEmployeeID As Integer) As String
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

            Try

                For index = 0 To arrDelete.Length - 1

                    strSQL = "exec usp_NG2_Del_Role_RoleMaster  " & arrDelete(index) & ""

                    'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
                    Flag = 1
                Next

            Catch ex As Exception

            End Try

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
            Dim Flag As String = "0"
            Dim Restult As String
            arrDelete = strEmployeeIDs.Split(",")



            For index = 0 To arrDelete.Length - 1

                strSQL = "exec usp_NG2_Del_Employee_EmployeeMaster  " & arrDelete(index) & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

                Flag = "1"
            Next
            Return Flag
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function CheckDateValidation(ByVal BirthDate As String, ByVal Joiningdate As String)
        '==================================================================================
        ' Procedure Name	:	CheckDateValidation
        ' Purpose			:	To check is date validation
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Dipali v
        ' Created			:	29-Sept-2017
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
            strSQL = "usp_Ng2_Validate_DateswithProjectDates '" & BirthDate & "','" & Joiningdate & "'"
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function CheckLeavingDateValidation(ByVal TentativeLeavingDate As String, ByVal LeavingDate As String)
        '==================================================================================
        ' Procedure Name	:	CheckLeavingDateValidation
        ' Purpose			:	To check is Leaving date validation
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Vidya Jadhav
        ' Created			:	18 Dec 2917
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            'If LeavingDate = "" Then
            '    LeavingDate = "NULL"
            'End If
            Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0")
            strSQL = "usp_NG2_Validate_LeavingDates '" & TentativeLeavingDate & "','" & LeavingDate & "'"
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateUserName(ByVal UserName As String, ByVal EmailID As String, ByVal StrFlag As String, ByVal globalEmployeeID As String) As String
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
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            UserName = Utilities.Security.SecurityBuilder.CheckUserInput(UserName, 2, True, False, False)
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
            strSQL = "Usp_NG2_CheckDuplicate_UserName "
            If (UserName = "") Then
                strSQL += "NULL"
            Else
                strSQL += "'" & UserName & "'"
            End If

            If (EmailID = "") Then
                strSQL += ",NULL"
            Else
                strSQL += ",'" & EmailID & "'"
            End If
            strSQL += ",'" & StrFlag & "'," & globalEmployeeID & ""

            'strSQL = "Usp_NG2_CheckDuplicate_UserName '" & UserName & "','" & EmailID & "','" & StrFlag & "'," & globalEmployeeID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateEmailID(ByVal UserName As String, ByVal EmailID As String, ByVal StrFlag As String, ByVal globalEmployeeID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateEmailID
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
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            UserName = Utilities.Security.SecurityBuilder.CheckUserInput(UserName, 2, True, False, False)
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
            If (UserName = "") Then
                UserName = "NULL"
            End If
            If (EmailID = "") Then
                EmailID = "NULL"
            End If

            strSQL = "Usp_NG2_CheckDuplicate_EmailID '" & UserName & "','" & EmailID & "','" & StrFlag & "'," & globalEmployeeID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
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

End Class
