
Imports System.IO
Imports System.IO.Compression
Imports System.Xml
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Linq
Public Class CRM_CustomerMaster
    Inherits WebPages.Template.WhizTemplate

#Region "Member Declaration"
    Private WithEvents m_objTypeGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objCustomerContactGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objCustomerClientContactGrid As New WebPages.Template.GenericGrid
    'Private WithEvents m_objPriorityGrid As New WebPages.Template.GenericGrid
    'Private WithEvents m_objSeverityGrid As New WebPages.Template.GenericGrid
    'Private WithEvents m_objDepartmentGrid As New WebPages.Template.GenericGrid
    'Private WithEvents m_objSubRequestTypeGrid As New WebPages.Template.GenericGrid

    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Private m_dsGrid As DataSet
    Protected m_intNoOfRecordInGrid As Int16 = 5
    Protected Shared m_Customer As Integer = 0
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
    Protected StrCustomerID As String
    Protected StrEmployeeCode As String
    Protected StrCustomercilent As String

    Protected m_blnSLAAccess As Boolean = False
    Private m_objSubTagGlobal As WebPages.Template.IGlobal
    Protected m_objSubTagAccess As WebPage.Templates.AccessRights
    Private m_objSubTagCLSQL As CommonEngines.CommonList.cSubTagCLSQL
    Private Shared m_objSubTabAccess As WebPage.Templates.AccessRights
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""
    Protected Shared strUserName As String = ""
    Protected Shared intUserID As Integer = 0
    Protected Shared TagID As String = 54
    Protected EmployeePhoto As String



    Protected AbbreviatedName As String
    Protected CustomerName As String
    Protected Region As String
    Protected ContractDate As String
    Protected DateAssigned As String
    Protected JoiningDate As String
    Protected EmailID As String
    Protected Address As String
    Protected Addess As String
    Protected City As String
    Protected CustomerID As String
    Protected PinCode As String
    Protected SeeHelpdeskSLAvalue As String
    Protected State As String
    Private Shared m_objAccess As WebPage.Templates.AccessRights
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intLOGINID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        intUserID = CType(Session("intUserID"), Integer)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)



        'Dim StrSQL1 As String = "usp_NG2_Sel_All_CustomerIDExistOrNot"
        'Dim StrCilentName As String = "usp_NG2_Sel_All_CheckExistCustomerCilent"
        'Dim drRole As IDataReader
        'Dim drEmployee As IDataReader

        'drRole = CommonFunctions.Data.GetDataReader(StrSQL1, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If drRole.Read Then
        '    StrCustomerID = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drRole(0), ""), String))
        'End If
        'CommonFunction.Data.DisposeDataReader(drRole)


        'drEmployee = CommonFunctions.Data.GetDataReader(StrCilentName, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If drEmployee.Read Then
        '    StrCustomercilent = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drEmployee(0), ""), String))
        'End If
        'CommonFunction.Data.DisposeDataReader(drEmployee)







        If Request.Params("Mode") = "SaveCustomerInfo" Then
            ' the system file name
            Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""

            If Request.Files.Count > 0 Then
                strOriginalFileName = System.IO.Path.GetFileName(Request.Files(0).FileName)
                'strFileName = objFile.UploadedFileName
                strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension


                Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), strFileName)
                Request.Files(0).SaveAs(fileSavePath)


            End If
            EmployeePhoto = Request.Params("EmployeePhoto")
            CustomerName = Request.Params("CustomerName")
            AbbreviatedName = Request.Params("AbbreviatedName")
            Region = Request.Params("Region")
            DateAssigned = Request.Params("DateAssigned")
            ContractDate = Request.Params("ContractDate")
            EmailID = Request.Params("EmailID")
            Address = Request.Params("Address")
            City = Request.Params("City")
            State = Request.Params("State")
            PinCode = Request.Params("PinCode")
            CustomerID = Request.Params("hdnCustomerID")
            SeeHelpdeskSLAvalue = Request.Params("SeeHelpdeskSLAvalue")

            ''   SaveEmployeeDetails(EmployeeName, EmployeeCode, UserName, LdapValue, Bdate, JoiningDate, EmailID, CurrentAddess, CurrentAddess1, CurrentCity, CurrentCity1, CurrentState, CurrentState1, CurrentPincode, CurrentPincode1, CboRoleEdit, CboDepartmentUnitEdit, CboEmplyeeType, CboReportingTo, txtRatehrs, txtCosthrs, CboDeployable, BusinessGroupID, CboOrganizationUnit, PssportNo, DateIssue, PlcIssue, ExDate, FullName, SonWife, NoLeftPage, EmployeeID, strOriginalFileName, strFileName)
            SaveCustomerDetails(CustomerName, AbbreviatedName, Region, DateAssigned, ContractDate, EmailID, Address, City, State, PinCode, CustomerID, strOriginalFileName, strFileName, SeeHelpdeskSLAvalue)
        End If
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
        ' Created               : 6th Dec 2017
        ' Revisions             : None
        '=====================================================================


        Dim strHTML As New StringBuilder

        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngLoginID = CType(Session("intLOGINID"), Long)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)

       

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
        ' Author                : Dipali Vekhande
        ' Created               : 6th Dec 2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div id='Type' class='tabcontent1 h-type clsSettingstabs'>")
        strHTML.Append(RequestTabDetails(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")

        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
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
        ' Author                :	Dipali Vekhande
        ' Created               :	6th-DEC-2017
        ' Revisions             :
        '=====================================================================
        'If TagID = 0 Then
        '    TagID = 54
        'End If
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
    Public Function RequestTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal CustomerID As String)
        '=====================================================================
        ' Procedure Name        : RequestTabDetails()	
        ' Purpose               : To Plot the Customer Master With Subtag
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali Vekhande
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        GetAccessRights()
        'TagID = 54
        Dim strHTML As New StringBuilder("")
        If strWhichGrid <> "PlotSubtab" And strWhichGrid <> "ClientContact" Then
            strHTML.Append("<div id='divTypeStatus'>")
            strHTML.Append("<div class='type-top-bar top-bar' id='divTypeTab'>")
            'strHTML.Append("<ul class='left'>")

            'strHTML.Append("<li class='left search-bar'>")
            'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
            'strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
            'strHTML.Append("</li>")
            'strHTML.Append("</ul>")
            '/*Changed By Yasmin on 25th july 2018*/

            strHTML.Append("<ul class='left'>")
            strHTML.Append("<li class='search-bar'>")
            strHTML.Append("<div class='left search-bar'>")
            strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
            strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table' >")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
            strHTML.Append("</ul>")

            strHTML.Append("<ul class='right'>")
            If m_objAccess.Add = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append("  <button type='button' onclick='AddCustomer()' class='btn btn-default' style='color:black!important;background-color:white!important' title='Add Customer'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
            End If
            'If m_objAccess.Delete = True Then
            '    strHTML.Append("<li class='clearall'>")
            '    strHTML.Append("    <button onclick='DeleteRequestType()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
            'End If
            strHTML.Append("</ul>")
            strHTML.Append(" </div>")

            strHTML.Append("<div class='table-responsive' id='divRequestTypes'>")
            strHTML.Append(WriteRequestTabGrid("TYPE", strGridFlag, ""))
            strHTML.Append("</div>")

            strHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")

            strHTML.Append("<div class='pannel-section'>")
            strHTML.Append("<div class='col-md-12 col-sm-12' >")
            strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
            strHTML.Append(" <div class='panel'>")
            strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne'>")
            strHTML.Append("  <h4 class='panel-title'>")
            strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne' aria-expanded='true' aria-controls='collapseOne' id='Addaccordion'>")
            strHTML.Append(" <i class='fa fa-plus' title='Expand' style='color:white!important' id='plus'></i>")
            strHTML.Append("<i class='fa fa-minus' title='Hide' style='color:white!important' id='minus'></i>")
            strHTML.Append(" </a>")
            strHTML.Append(" </h4>")
            strHTML.Append("   <h3><span style='color:white'>Add New Customer<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")

            strHTML.Append(" </div>")
            strHTML.Append(" <div id='collapseOne' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
            strHTML.Append(" <div class='panel-body' id='idPanelBody'>")
            strHTML.Append("<form class='form-horizontal' action='/action_page.php' enctype='multipart/form-data' method='post'>")
            'strHTML.Append("<div class='form-group'>")
            'strHTML.Append("<label class='control-label col-sm-2' for='request type code'>Upload Customer Image *</label>")
            'strHTML.Append(" <div class='col-sm-4'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("CustomerImage", "CustomerImage", "form-control", , , , , , , , , , "  class='form-control' placeholder='Add Customer Image' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")


            strHTML.Append("<div class='form-group' id='UploadImage'>")
            'strHTML.Append("<div class='col-xs-1' >")
            'strHTML.Append("<div class='avatar'><img class='img-circle'   src=''>Upload Image</div>")
            'strHTML.Append("<div class='bros-btn'>")
            'strHTML.Append("<input type='file' id='file' name='img[]' class='file'/>")
            'strHTML.Append("<button type='button' id='btnSelectFile' data-toggle='tooltip'  filecount='0' onclick='SelectFile();' class='btn btn-default save'></button>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            strHTML.Append("<div class='col-xs-1'  id='idUploadImage'  >")
            '  strHTML.Append("<div class='avatar'><div class='bros-btn'><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='' /></a></div></div></div>")
            'Commented by yasmin for image broken on 2rd july 2018
            strHTML.Append("<div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' title='Upload Image' src='../../../Images/Photo/no-photo.png' style='margin-left: -16px; margin-top: -1px;'> </a></div></div></div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group' id='EditImage' style='display:none'>")
            strHTML.Append("<div class='edit'>")
            strHTML.Append("<input name='img[]'class='file' id='file' type='file'><a  title='Edit Photo' id='btnSelectFile' style='text-align: center; font-weight: normal; font-size: 11px !important;' onclick='SelectFile()' filecount='0'><i class='fa fa-pencil' style='font-size: 16px'></i></a>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <label class='control-label col-sm-3' for='request type'>Customer Name*</label>")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("CustomerName", "CustomerName", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Customer Name' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(" </div>")

            strHTML.Append(" <label class='control-label col-sm-3' for='request type'>Abbreviated Name*</label>")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("AbbreviatedName", "AbbreviatedName", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Abbreviated Name' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(" </div>")
            strHTML.Append("</div>")


            'strHTML.Append("<div class='form-group'>")
            ''strHTML.Append("<label class='control-label col-sm-2' for='Date Assigned'>Date Assigned</label>")
            'strHTML.Append("<label class='control-label col-sm-2' for='Date Assigned'>Date Signed</label>")
            'strHTML.Append("<div class='col-sm-4'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DateAssigned", "DateAssigned", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Date Signed' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append(" </div>")
            'strHTML.Append("<label class='control-label col-sm-2' for='Contract Validity Date'>Contract Validity Date</label>")
            'strHTML.Append("<div class='col-sm-4'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContractDate", "ContractDate", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Contract Validity Date' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append(" </div>")
            'strHTML.Append("</div>")



            strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <label class='control-label col-sm-3' for='Date Assigned'>Date signed</label>")
            strHTML.Append(" <div class='col-sm-3'>")
            strHTML.Append("<input type='text' value=''  class='form-control inp clsDateControl' id='DateAssigned' placeholder='Enter Date Signed' autocomplete='off'>")
            strHTML.Append("<i class='fa fa-calendar fcal' id='idTentativeLeavingDate'  onclick=""$('#DateAssigned').datepicker();$('#DateAssigned').datepicker('show');""></i>")
            strHTML.Append("</div>")
            'strHTML.Append(" <div class='col-sm-2'>")

            'strHTML.Append("</div>")
            strHTML.Append("  <label class='control-label col-sm-3' for='request type'>Contract Validity Date</label>")
            strHTML.Append("<div class='col-sm-3'>")
            'strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='JoiningDate'   name='JoiningDate' placeholder='Joining Date'>")
            ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("JoiningDate", "JoiningDate", "form-control", 217, , , , , , , , , " class='form-control'  placeholder='Enter Joining Date' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("<input type='text' value='' class='form-control inp clsDateControl' id='ContractDate' placeholder='Contract Validity Date' autocomplete='off'>")
            strHTML.Append("<i class='fa fa-calendar fcal' id='ContractDate1'  onclick=""$('#ContractDate').datepicker();$('#ContractDate').datepicker('show');""></i>")
            strHTML.Append("</div>")
            'strHTML.Append(" <div class='col-sm-2'>")

            'strHTML.Append("</div>")
            strHTML.Append("</div>")



            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-3' for='Email ID'>Email ID *</label>")
            strHTML.Append("<div class='col-sm-3'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("EmailID", "EmailID", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Email ID' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(" </div>")
            strHTML.Append("<label class='control-label col-sm-3' for='Contract Validity Date'>Region</label>")

            'Added by Usha Pandit on 16.12.2017   style = 'padding-top: 5px;'
            strHTML.Append("<div class='col-sm-3' style = 'padding-top: 5px;'>")
            'End of Addition

            Dim sql As String = "usp_NG2_Sel_tbl_CNF_RegionMaster"
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Region", sql, 200, , "style='height:26px' class='form-control clscombo' ", True, True))
            strHTML.Append(" </div>")
            strHTML.Append("</div>")

            'strHTML.Append("<div class='form-group'>")
            'strHTML.Append("<label class='control-label col-sm-2' for='Email ID'>Email ID *</label>")
            'strHTML.Append("<div class='col-sm-4'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("EmailID", "EmailID", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Email ID' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append(" </div>")
            'strHTML.Append("<div class='col-sm-3'>")
            'strHTML.Append("<label class='control-label col-sm-2' for='Email ID'>Region</label>")
            'Dim sql As String = "select RegionID,RegionName from tbl_CNF_RegionMaster order by RegionName"
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Region", sql, , , " class='form-control' ", True, True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")



            'strHTML.Append("<div class='form-group'>")
            'strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Permanant Address</label>")
            'strHTML.Append("  <div class='col-sm-4'>")
            'strHTML.Append(" </div>")
            'strHTML.Append("<label class='control-label col-sm-2' for='request type'>Current Address</label>")
            'strHTML.Append("<label class='control-label col-sm-3' for='request type'>Same AS Permanant Address</label>")
            'strHTML.Append(" <div class='col-sm-1'>")
            'strHTML.Append("<input type='checkbox' style='width:11px;' id='checkSameasall' onclick='SameAsAll(this)' >")
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")



            strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <label class='control-label col-sm-3' for='Address'>Address</label>")
            strHTML.Append("<div class='col-sm-3'>")
            '  strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='Address'  name='Address' placeholder='Address' onkeypress='AddData()'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Address", "Address", "form-control", , 100, , , , , , , , " class='form-control'  placeholder='Enter Address' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("<label class='control-label col-sm-3' for='Address'>City</label>")
            strHTML.Append("<div class='col-sm-3'>")
            '  strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='Address2'  name='Address2' placeholder='Address'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("City", "City", "form-control", , 30, , , , , , , , " class='form-control'  placeholder='Enter City' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("  <label class='control-label col-sm-3' for='City'>State</label>")
            strHTML.Append("  <div class='col-sm-3'>")
            ' strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='City'  name='City' placeholder='City' onkeypress='AddData()'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("State", "State", "form-control", , 30, , , , , , , , " class='form-control'  placeholder='Enter State' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(" </div>")
            strHTML.Append(" <label class='control-label col-sm-3' for='Pin Code'>Pin Code</label>")
            strHTML.Append("<div class='col-sm-3'>")
            ' strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='City2'  name='City2' placeholder='City'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PinCode", "PinCode", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Pin Code' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")

            strHTML.Append("<div class='form-group'>")
            strHTML.Append("  <label class='control-label col-sm-3' for='City' style='line-height: 1.2;'>Allow To See Helpdesk SLA </label>")
            strHTML.Append("  <div class='col-sm-3'>")
            strHTML.Append(" <input type='checkbox' style='width:12px;' id='SeeHelpdeskSLA'>")
            strHTML.Append(" </div>")
            strHTML.Append("</div>")

            'strHTML.Append("<div class='form-group'>")
            'strHTML.Append("<label class='control-label col-sm-3' for='request type'>Region</label>")
            'strHTML.Append("<div class='col-sm-3'>")
            'Dim sql As String = "select RegionID,RegionName from tbl_CNF_RegionMaster order by RegionName"
            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Region", sql, 129, , " class='form-control' ", False, True))
            'strHTML.Append("</div>")
            'strHTML.Append(" <label class='control-label col-sm-2' for='State'>State</label>")
            'strHTML.Append("<div class='col-sm-4'>")
            '' strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='State2'  name='State2' placeholder='State'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("State2", "State2", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter State' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append("</div>")
            'strHTML.Append("</div>")

            'strHTML.Append("<div class='form-group'>")
            'strHTML.Append("  <label class='control-label col-sm-2' for='Pin Code'>Pin Code</label>")
            'strHTML.Append(" <div class='col-sm-4'>")
            '' strHTML.Append("<input type='text' style='width:217px;' class='form-control' id='PinCode'  name='PinCode' placeholder=' Pin Code' onkeypress='AddData()'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PinCode", "PinCode", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Pin Code' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append("</div>")
            'strHTML.Append("<label class='control-label col-sm-2' for='Pin Code'>Pin Code</label>")
            'strHTML.Append(" <div class='col-sm-4'>")
            ''strHTML.Append("	<input type='text' style='width:217px;' class='form-control' id='PinCode2'  name='PinCode2'  placeholder=' Pin Code'>")
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PinCode2", "PinCode2", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Pin Code' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append(" </div>")
            'strHTML.Append("</div>")SaveCustomerInfo

            '/*Changed By Yasmin on 27th july 2018*/

            strHTML.Append(" <div class='form-group' style='border: none:'>")
            strHTML.Append(" <div class='right'>")
            If m_objAccess.Add = True Or m_objAccess.Edit = True Then
                strHTML.Append(" <button type='button' style='margin-right: 4px!important;' onclick='SaveCustomerdetails( ""new"")' class='btn btn-default save' >Save</button>")
                'strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveAddCustomerdetails(""SaveAddnew"")' title='Save and Add'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveAddCustomerdetails(""SaveAddnew"")' >Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: inline-block; padding-left: 5px;color:#fff;'></i></button>")
            End If
            strHTML.Append(" <button type='button' onclick='Cancel()' class='btn btn-default save' style='margin-right: 19px;'>Cancel</button>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")




            strHTML.Append("  </form>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("<div id='divSubRequestType'>")
        Else
            'If strWhichGrid <> "ClientContact" Then

            'strHTML.Append("<div id='divSubRequestType'>")
            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("<div class='clsHideHorizontalDiv' id='DivHorizontal'>")
            End If
            strHTML.Append("<div class='h-tabs'>")

            strHTML.Append("<div class='tab'>")
            GetSubTabAccessRights(90, 54)
            If m_objSubTabAccess.View = True Then
                strHTML.Append("<button id='btnConfigureHRM' class='tablinks4 active clsSubtags' onclick='openCity4(event, ""ConfigureHRM"")' id='defaultOpen4'>Customer Contacts</button>")
            End If
            GetSubTabAccessRights(3373, 54)
            If m_objSubTabAccess.View = True Then
                strHTML.Append("<button id='btnProjectMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""ProjectMapping"")'>Client Contacts</button>")
            End If
            'GetSubTabAccessRights(2121, TagID)
            'If m_objSubTabAccess.View = True Then
            '    strHTML.Append("<button id='btnGroupEmail' class='tablinks4 clsSubtags' onclick='openCity4(event, ""GroupEmail"")'>Group Email</button>")
            'End If
            'GetSubTabAccessRights(3376, TagID)
            'If m_objSubTabAccess.View = True Then
            '    strHTML.Append("<button id='btnCustomerMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""CustomerMapping"")'>Customer Mapping</button>")
            'End If
            ''GetCurrentTagAccessRights(3746)
            ''If m_objCurrentTagAccess.View = True Then
            'strHTML.Append("<button id='btnRequestTypeMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""RequestTypeMapping"")'>Request Type Mapping</button>")
            ''End If
            'GetCurrentTagAccessRights(3820)
            'If m_objCurrentTagAccess.View = True Then
            '    strHTML.Append("<button id='btnWorkingHours' class='tablinks4 clsSubtags' onclick='openCity4(event, ""WorkingHours"")'>Working Hours</button>")
            'End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")


            If strWhichGrid <> "ClientContact" Then
                strHTML.Append("<div id='ConfigureHRM' class='tabcontent4' style='display: block;'>")
                strHTML.Append("<div class='type-top-bar top-bar'>")

                GetSubTabAccessRights(90, 54)
                If m_objSubTabAccess.Add = True Then
                    strHTML.Append("<ul class='right'>")
                    strHTML.Append("<li class='clearall'><button type='button' onclick='AddcustomerContact()' style='background-color:white!important;color:black!important' class='btn btn-default' title='Add Customer Contact'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
                    strHTML.Append("</ul>")
                End If

                strHTML.Append("</div>")
                strHTML.Append("<div class='table-responsive'  id='tblConfigureHRM' >")
                strHTML.Append(WriteMasterGrid("PlotSubtab", CustomerID))
                strHTML.Append(" </div>")


                'strHTML.Append("<div class='h-tabs'>")
                'strHTML.Append("<div class='tab'>")
                'strHTML.Append("<button class='tablinks5 active' onclick='openCity5(event, 'Contact')' id='defaultOpen5'>Customer Contacts</button>")
                'strHTML.Append("<button class='tablinks5' onclick='openCity5(event, 'UserGroup')'>Client Contacts</button>")
                'strHTML.Append("</div>")
                'strHTML.Append("<div id='Contact' class='tabcontent5' style='display: block;'>")

                'strHTML.Append("<div class='type-top-bar top-bar'>")
                'strHTML.Append("<ul class='right'>")
                'strHTML.Append("<li class='clearall'><button type='button' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
                'strHTML.Append("</ul>")
                'strHTML.Append("</div>")

                'strHTML.Append("<div class='table-responsive'>")
                'strHTML.Append(WriteHelpdeskMasterGrid("PlotSubtab", CustomerID))
                'strHTML.Append(" </div>")


                strHTML.Append("<div class='pannel-section' id='customerControl'>")
                strHTML.Append("<div class='col-md-12 col-sm-12'>")

                strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
                strHTML.Append("<div class='panel'>")
                strHTML.Append("<div class='panel-heading' role='tab' id='panelHRMAdd'  style='width: 100%;'>")
                strHTML.Append("<h3 style='font-size: 13px;'><span style='color:white'>Add New Customer Contacts </span></h3>")
                strHTML.Append("<h4 class='panel-title'>")
                'strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion'href='#collapseOne11' aria-expanded='true' aria-controls='collapseOne' id='addContact'>")
                strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion'href='#collapseOne11' aria-expanded='true' aria-controls='collapseOne11' id='addContact'>")
                strHTML.Append("<i class='fa fa-plus' title='Expand' style='color:white!important;cursor:pointer;'></i>")
                strHTML.Append("<i class='fa fa-minus' title='Hide' style='color:white!important;cursor:pointer;'></i>")
                strHTML.Append("</a>")
                strHTML.Append("</h4>")
                strHTML.Append("</div>")

                strHTML.Append("<div id='collapseOne11' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
                strHTML.Append("<div class='panel-body' id='panelHRM'>")
                strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Contact Person*</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactPerson", "ContactPerson", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Contact Person' ", returnHTML:=True, EnableHTMLEncode:=True))
                '<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                strHTML.Append("</div>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Type of Contact *</label>")
                strHTML.Append("<div class='col-sm-3'>")
                '			<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                ' strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("TypeofContact", "TypeofContact", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Pin Code' ", returnHTML:=True, EnableHTMLEncode:=True))
                Dim sql As String = "usp_Sel_tbl_RTS_ProjectSpecificControlData  'ContactPerson'"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("TypeofContact", sql, , , " class='form-control clscombo' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Email ID*</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactEmailID", "ContactEmailID", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Email ID' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append("</div>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Mobile</label>")
                strHTML.Append("<div class='col-sm-3'>")

                'Commented and added by Usha Pandit on on 03 JAN 2018
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Mobile", "Mobile", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Mobile' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Mobile", "Mobile", "form-control", , 10, , , , , , , , " class='form-control'  placeholder='Enter Mobile' onkeypress='return validateContact(event)' ", returnHTML:=True, EnableHTMLEncode:=True))
                'End of addition by Usha Pandit on on 03 JAN 2018

                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Phone</label>")
                strHTML.Append("<div class='col-sm-3'>")

                'Commented and added by Usha Pandit on on 03 JAN 2018
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Phone", "Phone", "form-control", , 50, , , , , , , , " class='form-control' placeholder='Enter Phone' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Phone", "Phone", "form-control", , 50, , , , , , , , " class='form-control' placeholder='Enter Phone' onkeypress='return validateContact(event)' ", returnHTML:=True, EnableHTMLEncode:=True))
                'End of addition by Usha Pandit on on 03 JAN 2018

                strHTML.Append("</div>")
                strHTML.Append("<label class='control-label col-sm-3' for='Fax'>Fax</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Fax", "Fax", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Fax ' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='form-group'>	")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Online Contact</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("OnlineContact", "OnlineContact", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Online Contact'", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append("</div>")
                'strHTML.Append("<label class='control-label col-sm-3' for='request type'>Region</label>")
                'strHTML.Append("<div class='col-sm-3'>")
                'Dim sql As String = "select RegionID,RegionName from tbl_CNF_RegionMaster order by RegionName"
                'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Region", sql, 129, , " class='form-control' ", False, True))
                'strHTML.Append("</div>")
                strHTML.Append("</div>")


                strHTML.Append("<div class='form-group'> ")
                strHTML.Append("<div class='right' id='CustomerContact'>")
                GetSubTabAccessRights(90, 54)
                If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveCustomerdetails1()' style='margin-right: 2px;' >Save</button>")
                    strHTML.Append("<button type='button' class='btn btn-default save'   onclick='SaveAddCustomerdetails1()' style='margin-right: 2px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                End If

                strHTML.Append("<button type='button' class='btn btn-default save'  onclick='CancelCustomerContact()' style='margin-right: 2px;'>Cancel</button>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("</form>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")
                strHTML.Append(" </div>")
                strHTML.Append(" </div>")
                strHTML.Append("</div>")




                '2ND TAB

            Else

                If strWhichGrid = "ClientContact" Then
                    strHTML.Append("<div id='ProjectMapping' class='tabcontent4' style='display:block;'>")
                    strHTML.Append("<div class='type-top-bar top-bar'>")
                    GetSubTabAccessRights(3373, 54)
                    If m_objSubTabAccess.Add = True Then
                        strHTML.Append("<ul class='right'>")
                        strHTML.Append("<li class='clearall'><button type='button' onclick='AddClientContact()' class='btn btn-default' style='background-color:white!important;Color:black!important' title='Add Client Contact'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")

                        strHTML.Append("</ul>")
                    End If
                    strHTML.Append("</div>")
                    strHTML.Append("<div class='table-responsive' id='tblProjectMapping'>")
                    'strHTML.Append("<table class='table table-bordered table-stripped' id='tblProjectMapping'>")
                    'strHTML.Append("<thead class='clsSubTagFont'>")
                    'strHTML.Append("<tr>")
                    'strHTML.Append("<th>Project</th>")
                    'strHTML.Append("<th>Default</th>")
                    'strHTML.Append("<th class = 'clsEditCenterAlign'>Edit</th>")
                    'strHTML.Append("<th class = 'clsEditCenterAlign'>Delete</th>")
                    'strHTML.Append("</tr>")
                    'strHTML.Append("</thead>")
                    'strHTML.Append("<tbody>")
                    'strHTML.Append("<tr>")
                    'strHTML.Append("<td>Microlink:SAP Pvt Ltd.</td>")
                    'strHTML.Append("<td>Yes</td>")
                    'strHTML.Append("<td><button class='edit-bt'><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button></td>")
                    'strHTML.Append("<td><button class='delet-btn'><i class='fa fa-trash-o' aria-hidden='true'></i></button></td>")
                    'strHTML.Append("</tr>")
                    'strHTML.Append("</tbody>")
                    'strHTML.Append("</table>")

                    strHTML.Append(WriteMasterGrid("ClientContact", CustomerID))
                    strHTML.Append("</div>")
                    strHTML.Append("<div class='pannel-section'>")
                    strHTML.Append("<div class='col-md-12 col-sm-12'>")

                    strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
                    strHTML.Append("<div class='panel'>")
                    strHTML.Append("<div class='panel-heading' role='tab' id='panelProjectAdd' style='width:100%;'>")
                    strHTML.Append("<h3 style='font-size: 13px;width:20%;'><span style='color:white'>Add New Cilent</span></h3>")
                    strHTML.Append("<h4 class='panel-title'>")
                    'strHTML.Append("<a role='button' data-toggle='collapse' style='margin-top:-0.5%;' data-parent='#accordion' href='#collapseOne22' aria-expanded='true' aria-controls='collapseOne' id='addclient'>")
                    strHTML.Append("<a role='button' data-toggle='collapse' style='margin-top:-0.5%;' data-parent='#accordion' href='#collapseOne22' aria-expanded='true' aria-controls='collapseOne22' id='addclient'>")
                    strHTML.Append("<i class='fa fa-plus' title='Expand' style='color:white!important'></i>")
                    strHTML.Append("<i class='fa fa-minus' title='Hide' style='color:white!important'></i>")
                    strHTML.Append("</a>")
                    strHTML.Append("</h4>")
                    strHTML.Append("</div>")
                    strHTML.Append("<div id='collapseOne22' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
                    strHTML.Append("<div class='panel-body' id='panelProject'>")


                    strHTML.Append("<form class='form-horizontal'>")
                    strHTML.Append("<div class='form-group'>")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>Abbreviated Name*</label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactAbbreviatedName", "ContactAbbreviatedName", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Abbreviated Name' ", returnHTML:=True, EnableHTMLEncode:=True))
                    '<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                    strHTML.Append("</div>")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>Client Name  *</label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    '			<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ClientName", "ClientName", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Client Name' ", returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("<div class='form-group'>")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>Address </label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactAddress", "ContactAddress", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Address' ", returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append("</div>")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>City</label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactCity", "ContactCity", "form-control", , 30, , , , , , , , " class='form-control'  placeholder='Enter City' ", returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")

                    strHTML.Append("<div class='form-group'>")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>State</label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactState", "ContactState", "form-control", , 30, , , , , , , , " class='form-control'  placeholder='Enter State' ", returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append("</div>")
                    strHTML.Append("<label class='control-label col-sm-3' for='Fax'>Email ID </label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("EmailIDClient", "EmailIDClient", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter EmailID ' ", returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")

                    strHTML.Append("<div class='form-group'>	")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>Contact Person *</label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactPerson", "ContactPerson", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Contact Person'", returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append("</div>")
                    'strHTML.Append("<label class='control-label col-sm-3' for='request type'>Region</label>")
                    'strHTML.Append("<div class='col-sm-3'>")
                    'Dim sql As String = "select RegionID,RegionName from tbl_CNF_RegionMaster order by RegionName"
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Region", sql, 129, , " class='form-control' ", False, True))
                    'strHTML.Append("</div>")
                    strHTML.Append("</div>")

                    '/*Changed By Yasmin on 25th july 2018*/
                    strHTML.Append("<div class='form-group'> ")
                    strHTML.Append("<div class='right' id='CustomerContact'>")
                    GetSubTabAccessRights(3373, 54)
                    If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
                        strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveCilentdetails()' style='margin-right:2px;'>Save</button>")
                        strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveAddCilentdetails()' style='margin-right:2px;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                    End If

                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='cancelCilent()' style='margin-right:2px;'>Cancel</button>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</form>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    '<!-- end of panel -->
                    strHTML.Append("</div>")
                    '<!-- end of #accordion -->

                    strHTML.Append("</div>")
                    '<!-- end of wrap -->

                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                End If

            End If
            If strWhichGrid <> "ClientContact" Then
                strHTML.Append(" </div>")
            End If
        End If




        strHTML.Append("</div>")
        strHTML.Append("</div>")




        Return strHTML.ToString
    End Function

    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteRequestTabGrid()	
        ' Purpose               : To Plot the Customer Grid & Form
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 1 Dec 2017
        ' Revisions             : None
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")
        strGridHTML.Append(WriteMasterGrid(strWhichGrid, RequestTypeID))
        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function


    Private Function WriteMasterGrid(ByVal strWhichGrid As String, ByVal RequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : WriteMasterGrid()	
        ' Purpose               : To Plot the Grids
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created               : 1 Dec 2017
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
        str_RequestTypeID = RequestTypeID
        If strWhichGrid.ToUpper = "TYPE" Then
            intNoOfDataColumn = 3
            strDivID = "DivList"
            strSQLQuery = "Usp_NG2_Sel_v_tbl_PM_Customer"
            arrstrActualList = {"CustomerName", "DateSigned", "RegionName", "", ""}
            arrstrUserFriendlyList = {"Customer Name", "Date Signed", "Region", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objTypeGrid
        ElseIf strWhichGrid.ToUpper = "PLOTSUBTAB" Then 'ContactPerson & "##" & Position & "##" & EMailID & "##" & Mobile & "##" & Phone & "##" & Address & "##" & Fax
            intNoOfDataColumn = 6
            strDivID = "divCustomerContact"
            strSQLQuery = "Usp_NG2_Sel_v_tbl_PM_CustomerContact " & RequestTypeID
            arrstrActualList = {"ContactPerson", "Position", "EMailID", "Mobile", "Phone", "Fax", "", ""}
            arrstrUserFriendlyList = {"Contact Person", "Type of Contact", "Email ID", "Mobile", "Phone", "Fax", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objCustomerContactGrid
        ElseIf strWhichGrid.ToUpper = "CLIENTCONTACT" Then 'ClientContact
            intNoOfDataColumn = 6
            strDivID = "divCustomerContactcilent"
            strSQLQuery = "usp_Ng2_sel_v_tbl_PM_Client " & RequestTypeID
            arrstrActualList = {"ClientCode", "ClientName", "ContactPerson", "EmailID", "MobileNumber", "Phone", "", ""}
            arrstrUserFriendlyList = {"Abbreviated Name", "Client Name", "Contact Person", "Email ID", "  Mobile", " Phone", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", "", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

            objGrid = m_objCustomerClientContactGrid

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

            'intRecordCount = m_objGridAttachment.NoOfRows

            objGrid = Nothing
        End If

        Return strGridHTML.ToString
    End Function


    Private Sub m_objTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTypeGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True

            If m_Customer = Args.DataReader("Customer") Then

                Args.StringToBeInserted = "<td align='center' Title = 'Edit Customer'><button type='button' class='edit-bt'  checked=true id=chkCustomer name=chkCustomer onclick='Edit_Customer(" & Args.DataReader("Customer") & ")' value=" & Args.DataReader("Customer") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Customer'><button type='button' class='edit-bt1'  id=chkCustomer name=chkCustomer onclick='Edit_Customer(" & Args.DataReader("Customer") & ")' value=" & Args.DataReader("Customer") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If




        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            ' m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_RequestType " & Args.DataReader("Customer"), True), "0")
            ' <button onclick='DeleteRequestType()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>
            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            'If m_strCanDelete = "1" Then
            '    Args.StringToBeInserted = "<td align='center' Title = 'You can not delete Customer'><input type=checkbox id=chkCustomerDelete name=chkCustomerDelete disabled  value=" & Args.DataReader("Customer") & ">" + "</TD>"
            'Else
            Args.StringToBeInserted = "<td align='center' Title = 'Delete Customer'><button type='button' class='edit-bt1'  checked=true id=chkCustomerDelete name=chkCustomerDelete onclick='Delete_Customer(this," & Args.DataReader("Customer") & ")' value=" & Args.DataReader("Customer") & " ><i class='fa fa-trash-o' aria-hidden='true'></i></button>" + "</TD>"
            'End If
        End If


    End Sub


    Private Sub m_objCustomerContactGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objCustomerContactGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True
            'Dim CustomerContactID As String = ""
            'CustomerContactID = Args.DataReader("CustomerContactID")
            If m_Customer = Args.DataReader("CustomerID") Then

                Args.StringToBeInserted = "<td align='center' Title = 'Edit Customer Contact'><button type='button' class='edit-bt'  checked=true id=chkCustomerContactDelete name=chkCustomerContactDelete onclick='Edit_CustomerContact(this," & Args.DataReader("CustomerID") & "," & Args.DataReader("CustomerContactID") & ")' value=" & Args.DataReader("CustomerContactID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Customer Contact'><button type='button' class='edit-bt1'  id=chkCustomerContactDelete name=chkCustomerContactDelete onclick='Edit_CustomerContact(this," & Args.DataReader("CustomerID") & "," & Args.DataReader("CustomerContactID") & ")' value=" & Args.DataReader("CustomerContactID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If




        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            ' m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_RequestType " & Args.DataReader("Customer"), True), "0")
            ' <button onclick='DeleteRequestType()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>
            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            'If m_strCanDelete = "1" Then
            '    Args.StringToBeInserted = "<td align='center' Title = 'You can not delete Customer'><input type=checkbox id=chkCustomerDelete name=chkCustomerDelete disabled  value=" & Args.DataReader("Customer") & ">" + "</TD>"
            'Else
            Args.StringToBeInserted = "<td align='center' Title = 'Delete Customer Contact'><button type='button' class='edit-bt1' checked=true id=chkCustomerContactDelete name=chkCustomerContactDelete onclick='Delete_CustomerContact(this," & Args.DataReader("CustomerID") & "," & Args.DataReader("CustomerContactID") & ")' value=" & Args.DataReader("CustomerContactID") & " ><i class='fa fa-trash-o' aria-hidden='true'></i></button>" + "</TD>"
            'End If
        End If


    End Sub


    Private Sub m_objCustomerClientContactGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objCustomerClientContactGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True
            'Dim CustomerContactID As String = ""
            'CustomerContactID = Args.DataReader("CustomerContactID")
            If m_Customer = Args.DataReader("Customer") Then

                Args.StringToBeInserted = "<td align='center' Title = 'Edit Client Contact'><button type='button' class='edit-bt' data-toggle='tooltip' checked=true id=chkClientCustomer name=chkClientCustomer onclick='Edit_ClientContact(this," & Args.DataReader("Customer") & "," & Args.DataReader("ClientId") & ")' value=" & Args.DataReader("ClientId") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Client Contact'><button type='button' class='edit-bt1' data-toggle='tooltip' id=chkClientCustomer name=chkClientCustomer onclick='Edit_ClientContact(this," & Args.DataReader("Customer") & "," & Args.DataReader("ClientId") & ")' value=" & Args.DataReader("ClientId") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If




        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            ' m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_RequestType " & Args.DataReader("Customer"), True), "0")
            ' <button onclick='DeleteRequestType()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>
            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            'If m_strCanDelete = "1" Then
            '    Args.StringToBeInserted = "<td align='center' Title = 'You can not delete Customer'><input type=checkbox id=chkCustomerDelete name=chkCustomerDelete disabled  value=" & Args.DataReader("Customer") & ">" + "</TD>"
            'Else
            Args.StringToBeInserted = "<td align='center' Title = 'Delete Client Customer(this,242,4)'><button type='button' class='edit-bt1' checked=true id=chkClientCustomerDelete name=chkClientCustomerDelete onclick='Delete_ClientCustomer(this," & Args.DataReader("Customer") & "," & Args.DataReader("ClientId") & ")' value=" & Args.DataReader("ClientId") & " ><i class='fa fa-trash-o' aria-hidden='true'></i></button>" + "</TD>"
            'End If
        End If


    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCustomer(ByVal Customer As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteCustomer
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	DeleteCustomer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strSQL As String = ""

        Dim index As Integer = 0
        Dim Flag As Integer = 0
        Dim Restult As String = ""


        Try

            strSQL = "exec USP_NG2_DEL_Customer  " & Customer & ""

            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Flag = 1

            Return Restult
        Catch ex As Exception
            Return "Bad Request found"

        End Try


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCustomerContact(ByVal CustomercontactId As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteCustomerContact
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Customer Contact
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strSQL As String = ""

        Dim index As Integer = 0
        Dim Flag As Integer = 0
        Dim Restult As String = ""


        Try

            strSQL = "exec USP_NG2_DEL_tbl_PM_CustomerContact  " & CustomercontactId & ""

            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Flag = 1
            Return Restult

        Catch ex As Exception
            Return "Bad Request found"

        End Try


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteCustomerCilent(ByVal CustomerCilentId As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteCustomerCilent
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Customer Cilent
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   8 Dec 2017
        '=====================================================================

        Dim strSQL As String = ""

        Dim index As Integer = 0
        Dim Flag As Integer = 0
        Dim Restult As String = ""


        Try

            strSQL = "exec USP_NG2_DEL_tbl_pm_client  " & CustomerCilentId & ""

            'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            Restult = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Flag = 1
            Return Restult

        Catch ex As Exception
            Return "Bad Request found"

        End Try


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetCustomerDetails(ByVal CustomerID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCustomerDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of Customer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	dipali Vekhande
        ' Created				:  6rd-Dec-2017
        '=====================================================================



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetCustomerContactDetails(ByVal ContactCustomerId As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCustomerContactDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of Customer 
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	dipali Vekhande
        ' Created				:  6rd-Dec-2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim ContactPerson As String = ""
            Dim Position As String = ""
            Dim EMailID As String = ""
            Dim OnlineContact As String = ""
            Dim Fax As String = ""
            Dim State As String = ""
            Dim Phone As String = ""
            Dim PinCode As String = ""
            Dim CustomerIDnew As String = ""
            Dim Mobile As String = ""

            Dim strReasonForOccurence As String = ""



            Dim strSQL As String = ""
            strSQL = "Usp_NG2_Sel_tbl_PM_CustomerContactEdit " & ContactCustomerId & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                ContactPerson = CommonFunctions.Data.CheckIsDBNull(drTabData("ContactPerson"), "")
                Position = CommonFunctions.Data.CheckIsDBNull(drTabData("Position"), "")
                EMailID = CommonFunctions.Data.CheckIsDBNull(drTabData("EMailID"), "")
                Mobile = CommonFunctions.Data.CheckIsDBNull(drTabData("Mobile"), "")
                Phone = CommonFunctions.Data.CheckIsDBNull(drTabData("Phone"), "")
                OnlineContact = CommonFunctions.Data.CheckIsDBNull(drTabData("OnlineContact"), "")
                Fax = CommonFunctions.Data.CheckIsDBNull(drTabData("Fax"), "")


            End If
            strResult = ContactPerson & "##" & Position & "##" & EMailID & "##" & Mobile & "##" & Phone & "##" & OnlineContact & "##" & Fax


            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetCilentContactDetails(ByVal CilentCustomerId As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetCilentContactDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of Customer
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	dipali Vekhande
        ' Created				:  6rd-Dec-2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim ContactPerson As String = ""
            Dim ClientName As String = ""
            Dim ClientCode As String = ""
            Dim OnlineContact As String = ""
            Dim EmailID As String = ""
            Dim State As String = ""
            Dim Address As String = ""
            Dim PinCode As String = ""
            Dim City As String = ""
            Dim Mobile As String = ""

            Dim strReasonForOccurence As String = ""



            Dim strSQL As String = ""
            strSQL = "usp_Ng2_sel_v_tbl_PM_ClientEdit " & CilentCustomerId & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                ClientCode = CommonFunctions.Data.CheckIsDBNull(drTabData("ClientCode"), "")
                ClientName = CommonFunctions.Data.CheckIsDBNull(drTabData("ClientName"), "")
                Address = CommonFunctions.Data.CheckIsDBNull(drTabData("Address"), "")
                City = CommonFunctions.Data.CheckIsDBNull(drTabData("City"), "")
                State = CommonFunctions.Data.CheckIsDBNull(drTabData("State"), "")
                ContactPerson = CommonFunctions.Data.CheckIsDBNull(drTabData("ContactPerson"), "")
                EmailID = CommonFunctions.Data.CheckIsDBNull(drTabData("EmailID"), "")


            End If
            strResult = ClientCode & "##" & ClientName & "##" & Address & "##" & City & "##" & State & "##" & ContactPerson & "##" & EmailID


            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function PlotSubtab(ByVal CustomerID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubtab
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Dipali V
        ' Created Date           :8 Nov -2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim OBJCRM_CustomerMaster As New CRM_CustomerMaster()

            strGridHTML.Append(OBJCRM_CustomerMaster.RequestTabDetails(Flag, "PlotSubRequestType", CustomerID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function



    'Protected Function WritePlotSubtabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal PlotSubtab As String) As String
    '    '=====================================================================
    '    ' Procedure Name        : WriteSubRequestTabGrid()	
    '    ' Purpose               : To Plot the Request Tab Grid
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : HTML
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Dipali V
    '    ' Created               : 6 Dec 2017
    '    ' Revisions             : None
    '    '=====================================================================
    '    Dim strGridHTML As New StringBuilder("")

    '    strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, PlotSubtab))

    '    If (strGridFlag = "") Then
    '        CommonFunctions.General.WriteHTML(strGridHTML.ToString)
    '    Else
    '        Return strGridHTML.ToString
    '    End If
    'End Function
    'CustomerName: CustomerName, AbbreviatedName: AbbreviatedName,
    '       DateAssigned: DateAssigned, ContractDate: ContractDate, EmailID: EmailID, Address: Address,
    '       City: City, State: State, PinCode: PinCode, CustomerID: CustomerID

    '<System.Web.Services.WebMethod> _


    Public Function SaveCustomerDetails(ByVal CustomerName As String, ByVal AbbreviatedName As String, ByVal Region As String, ByVal DateAssigned As String, ByVal ContractDate As String, ByVal EmailID As String, ByVal Address As String, ByVal City As String, ByVal State As String, ByVal PinCode As String, ByVal CustomerID As String, ByVal strOriginalFileName As String, ByVal strFileName As String, ByVal SeeHelpdeskSLAvalue As String) As String
        '=====================================================================
        ' Procedure Name        : SaveCustomerDetails
        ' Description           : To  Save CustomerDetails
        ' Created Date           : 7th Dec 2017
        '=====================================================================
        Dim m_intUniqueID As Integer = 0
        Dim strListHTML As New StringBuilder("")
        Dim strUsername As String = HttpContext.Current.Session("strUserName")
        Dim strLoginType As String = HttpContext.Current.Session("LoginType")
        Dim strSQL As String
        Dim m_EmployeeId As String = ""
        Dim ResultEmployeeId As String = ""
        Dim ResultFlag As String = ""

        If CustomerName = "" Then
            CustomerName = "Null"
        End If

        If AbbreviatedName = "" Then
            AbbreviatedName = "Null"
        End If

        If DateAssigned = "" Then
            DateAssigned = ""
        End If

        If ContractDate = "" Then
            ContractDate = ""
        End If

        If EmailID = "" Then
            EmailID = ""
        End If



        If City = "" Then
            City = ""
        End If
        If Address = "" Then
            Address = ""
        End If

        If State = "" Then
            State = ""
        End If

        If PinCode = "" Then
            PinCode = "Null"
        End If

        If strOriginalFileName = "" Then
            strOriginalFileName = ""

        End If

        If strFileName = "" Then
            strFileName = ""

        End If

        If Region = "" Then
            Region = ""
        End If

        Try
            If Region = "" Then
                strSQL = "exec usp_NG2_Ins_upd_tbl_PM_Customer  '" & AbbreviatedName & "','" & CustomerName & "',null,'" & Address & "','" & City & "','" & State & "',null," & PinCode & ",null,null,null,null,'" & EmailID & "','" & DateAssigned & "','" & ContractDate & "',null,null,null,null,null,null,null," & SeeHelpdeskSLAvalue & "," & HttpContext.Current.Session("intUserID") & "," & CustomerID & ",'" & strOriginalFileName & "','" & strFileName & "','" & strUsername & "','" & strLoginType & "'"
            Else
                strSQL = "exec usp_NG2_Ins_upd_tbl_PM_Customer  '" & AbbreviatedName & "','" & CustomerName & "',null,'" & Address & "','" & City & "','" & State & "',null," & PinCode & ",null,null,null,null,'" & EmailID & "','" & DateAssigned & "','" & ContractDate & "',null,null,null,null,null,null," & Region & "," & SeeHelpdeskSLAvalue & "," & HttpContext.Current.Session("intUserID") & "," & CustomerID & ",'" & strOriginalFileName & "','" & strFileName & "','" & strUsername & "','" & strLoginType & "'"
            End If



            m_EmployeeId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Dim StrResult As String() = m_EmployeeId.Split("||")
            ResultEmployeeId = StrResult(0)
            ResultFlag = StrResult(2)

            Dim dtTable As DataTable
            Dim dtTable1 As DataTable

            Dim strEmployeeImage As String = ""
            Dim intEmployeeID As Integer = 0

            strEmployeeImage = GetCustomerImagePath(ResultEmployeeId)
            strListHTML.Append("<div class='col-xs-1'id='idUploadImage'>")
            '  strListHTML.Append("<div class='avatar'><div class='bros-btn'><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='' /></a></div></div></div>")
            strListHTML.Append("<div><div><input name='img[]' class='file' id='file' type='file' title='Edit Photo'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='" & strEmployeeImage & "' /></a></div></div></div>")


            CommonFunctions.General.WriteHTML(strListHTML.ToString & "##" & ResultEmployeeId & "##" & ResultFlag)
        Catch ex As Exception

        End Try
        '  Response.Write(strListHTML.ToString)
        Response.End()
    End Function
    Public Function GetCustomerImagePath(ByVal intCustomerID As Integer) As String
        Dim strImageName As String = ""
        Dim strEmployeeImage As String
        Dim strFilePath As String = ""

        strImageName = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Sel_TBL_PM_CustomerPhoto_Attachment " & intCustomerID, True), ""))

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
    'Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue
    <System.Web.Services.WebMethod>
    Public Shared Function checkDuplicateCustomerContactEmailId(ByVal EmailId As String, ByVal CustomerId As String) As String
        Dim dupFlag As Integer = 0
        Dim strSQL As String
        Try
            If CustomerId = "" Then
                CustomerId = "Null"
            End If

            strSQL = "exec usp_CRM_Chk_Duplicate_CustomerContact_EmailId  '" & EmailId & "'," & CustomerId & ""

            dupFlag = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return dupFlag
        Catch ex As Exception
            Return "Bad Request found"

        End Try


    End Function
    'End of Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue
    'Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue
    <System.Web.Services.WebMethod>
    Public Shared Function checkContactPerson(ByVal ContactPerson As String, ByVal CustomerId As String) As String
        Dim dupFlag As Integer = 0
        Dim strSQL As String
        Try
            If CustomerId = "" Then
                CustomerId = "Null"
            End If

            strSQL = "exec usp_CRM_Chk_Duplicate_CustomerContact_ContactPerson  '" & ContactPerson & "'," & CustomerId & ""

            dupFlag = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return dupFlag
        Catch ex As Exception
            Return "Bad Request found"

        End Try


    End Function
    'End of Added by Usha Pandit on 17.05.2019 for Duplicate Email Save Issue


    <System.Web.Services.WebMethod> _
    Public Shared Function SaveCustContactDetails(ByVal ContactPerson As String, ByVal TypeofContact As String, ByVal ContactEmailID As String, ByVal Fax As String, ByVal Phone As String, ByVal Mobile As String, ByVal OnlineContact As String, ByVal CustomerContactID As String, ByVal EditCustomerID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveCustomerDetails
        ' Description           : To  Save Cust Contact Subtab Details
        ' Created Date           : 7th Dec 2017
        '=====================================================================
        Dim m_intUniqueID As Integer = 0
        Dim strSQL As String
        Dim m_EmployeeId As String

        If ContactPerson = "" Then
            ContactPerson = "Null"
        End If

        If TypeofContact = "" Then
            TypeofContact = "Null"
        End If

        If ContactEmailID = "" Then
            ContactEmailID = "Null"
        End If

        If Fax = "" Then
            Fax = ""
        End If

        If Phone = "" Then
            Phone = ""
        End If
        If Mobile = "" Then
            Mobile = ""
        End If



        If OnlineContact = "" Then
            OnlineContact = ""
        End If
        If CustomerContactID = "" Then
            CustomerContactID = ""
        End If


        Try

            strSQL = "exec usp_NG2_Ins_upd_tbl_PM_CustomerContact  " & EditCustomerID & ",'" & ContactPerson & "','" & TypeofContact & "','" & ContactEmailID & "','" & Mobile & "','" & Phone & "','" & Fax & "','" & OnlineContact & "'," & CustomerContactID & ""



            'strSQL +=  & CurrentCity1 & " '""

            m_EmployeeId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return m_EmployeeId
        Catch ex As Exception
            Return "Bad Request found"

        End Try



    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SaveCilentContactDetails(ByVal ContactAbbreviatedName As String, ByVal ClientName As String, ByVal ContactAddress As String, ByVal ContactCity As String, ByVal ContactState As String, ByVal ContactPerson As String, ByVal EmailID As String, ByVal CustomerCilentID As String, ByVal EditCustomerID As String) As String
        '=====================================================================
        ' Procedure Name        : CRM_CustomerMaster
        ' Description           : To  Save Cust Cilent Subtab Details
        ' Created Date           : 7th Dec 2017
        '=====================================================================
        Dim m_intUniqueID As Integer = 0
        Dim strSQL As String
        Dim m_EmployeeId As String

        If ContactAbbreviatedName = "" Then
            ContactAbbreviatedName = "Null"
        End If

        If ClientName = "" Then
            ClientName = "Null"
        End If

        If ContactAddress = "" Then
            ContactAddress = ""
        End If

        If ContactCity = "" Then
            ContactCity = ""
        End If

        If ContactState = "" Then
            ContactState = ""
        End If
        If ContactPerson = "" Then
            ContactPerson = ""
        End If



        If EmailID = "" Then
            EmailID = ""
        End If
        If CustomerCilentID = "" Then
            CustomerCilentID = ""
        End If


        Try

            strSQL = "exec usp_NG2_Ins_upd_tbl_PM_CustomerCilent  " & EditCustomerID & ",'" & ContactAbbreviatedName & "','" & ClientName & "','" & ContactAddress & "','" & ContactCity & "','" & ContactState & "',null,null,null,null,'" & EmailID & "',null,'" & ContactPerson & "'," & CustomerCilentID & ""
            'strSQL +=  & CurrentCity1 & " '""

            m_EmployeeId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))
            Return m_EmployeeId
        Catch ex As Exception
            Return "Bad Request found"

        End Try



    End Function


    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object, ByVal CustomerID As String, ByVal Role As String, ByVal Status As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid
        ' Created Date           : 7th Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_CustomerMaster As New CRM_CustomerMaster()

            strGridHTML.Append(objCRM_CustomerMaster.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", CustomerID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function CheckCustomerAbbName(ByVal Flag As String, ByVal AbbName As String, ByVal CustomerID As String)
        '==================================================================================
        ' Procedure Name	:	CheckCustomerAbbName
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
            If Flag = "Customer" Then
                strSQL = "usp_NG2_Sel_All_CustomerIDExistOrNot '" & AbbName & "'," & CustomerID & ""
            Else

                strSQL = "usp_NG2_Sel_All_CheckExistCustomerCilent '" & AbbName & "'," & CustomerID & ""
            End If
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function

End Class