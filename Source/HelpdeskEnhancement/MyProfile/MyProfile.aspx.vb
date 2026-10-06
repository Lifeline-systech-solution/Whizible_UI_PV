Imports System.IO
Imports CommonFunctions
Public Class MyProfile
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Protected m_objAccess As WebPage.Templates.AccessRights
    Protected m_objAccessAlert As WebPage.Templates.AccessRights
    Private m_objGlobalAlert As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected TagID As String = ""
    Protected m_intRoleID As Integer = 0
    Protected strLoginType = ""
    Protected strEmployeeImage As String = ""
    Private m_blnUseSQL As Boolean
    Private m_Emailid As String = ""
    Private m_strRevieweeIDList As String = ""
    Private m_strEmployeeIDList As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents objGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objEmpGrid As New WebPage.Templates.GenericGrid
    Protected strShowAllFlagEmployee As String = ""
    Protected strShowAllFlagCustomer As String = ""
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim strSQL As String
        If CommonFunction.General.CheckIsNothing(Request.Params("Mode"), "") = "SaveEmployeeProfile" Then
            SaveProfile()
        ElseIf CommonFunction.General.CheckIsNothing(Request.Params("Mode"), "") = "SaveCustomerProfile" Then
            SaveCustomerProfile()
        Else
            m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
            m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
            TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
            strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
            GetAccessRights()
            PageInit()
        End If
    End Sub
    Private Sub PageInit()
        Dim drCustomer As IDataReader
        Dim strSQL As String
        strSQL = "USP_SEL_TBL_PM_FLAGFORTRACKING_CONFIGURE " & CType(Session("intUserID"), String)
        drCustomer = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drCustomer.Read Then
            m_strRevieweeIDList = drCustomer("CustomerID").ToString
            m_strEmployeeIDList = drCustomer("EmployeeList").ToString
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
        ' Author                :	Yogesh Jalamkar
        ' Created               :	08-DEC-2017
        ' Revisions             :
        '=====================================================================
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal
        m_objAccessAlert = New WebPage.Templates.AccessRights
        Dim objGlobalAlert As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, "3707", m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccessAlert.GetAccess(objGlobalAlert)
        m_objGlobalAlert = objGlobalAlert
    End Sub
    Protected Function WriteProfile()
        '=====================================================================
        ' Procedure Name        : WriteProfile()	
        ' Purpose               : To Plot the Profile Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               :14-DEC-2017
        ' Revisions             : None
        '=====================================================================
        If (strLoginType = "C") Then
            WriteCutomerTab()
        Else
            WriteEmpTab()
        End If
    End Function
    Protected Function WriteEmpTab()
        '=====================================================================
        ' Procedure Name        : WriteEmpTab()	
        ' Purpose               : To Plot employee the Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               :14-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim strEmployeeName As String = ""
        Dim strBloodGroup As String = ""
        Dim strBirthDate As String = ""
        Dim strAddress As String = ""
        Dim strCity As String = ""
        Dim strState As String = ""
        Dim strPinCode As String = ""
        Dim strPhone As String = ""
        Dim strCurrentAddress As String = ""
        Dim strCurrentCity As String = ""
        Dim strCurrentState As String = ""
        Dim strCurrentPinCode As String = ""
        Dim strCurrentPhone As String = ""
        Dim SystemFilename As String = ""
        Dim strFilePath As String = ""
        Dim strEmailID As String = ""
        Dim strJoiningDate As String = ""
        Dim drEmployee As IDataReader
        Dim strSQL As String = "usp_NG2_Sel_tbl_PM_Employee_ForProfile " & CommonFunction.General.CheckIsNothing(Session("intUserID"), "")
        drEmployee = CommonFunction.Data.GetDataReader(strSQL, True)
        If (drEmployee.Read) Then
            strEmployeeName = CommonFunction.Data.CheckIsDBNull(drEmployee("EmployeeName"), "")
            strAddress = CommonFunction.Data.CheckIsDBNull(drEmployee("Address"), "")
            strCity = CommonFunction.Data.CheckIsDBNull(drEmployee("City"), "")
            strState = CommonFunction.Data.CheckIsDBNull(drEmployee("State"), "")
            strPinCode = CommonFunction.Data.CheckIsDBNull(drEmployee("PinCode"), "")
            strPhone = CommonFunction.Data.CheckIsDBNull(drEmployee("Phone"), "")
            strCurrentAddress = CommonFunction.Data.CheckIsDBNull(drEmployee("CurrentAddress"), "")
            strCurrentCity = CommonFunction.Data.CheckIsDBNull(drEmployee("CurrentCity"), "")
            strCurrentState = CommonFunction.Data.CheckIsDBNull(drEmployee("CurrentState"), "")
            strCurrentPinCode = CommonFunction.Data.CheckIsDBNull(drEmployee("CurrentPinCode"), "")
            strCurrentPhone = CommonFunction.Data.CheckIsDBNull(drEmployee("CurrentPhone"), "")
            strBloodGroup = CommonFunction.Data.CheckIsDBNull(drEmployee("BloodGroup"), "")
            strBirthDate = CommonFunction.Data.CheckIsDBNull(drEmployee("BirthDate"), "")
            strJoiningDate = CommonFunction.Data.CheckIsDBNull(drEmployee("JoiningDate"), "")
            SystemFilename = CommonFunction.Data.CheckIsDBNull(drEmployee("SystemFileName"), "")
            strEmailID = CommonFunction.Data.CheckIsDBNull(drEmployee("EmailID"), "")
        End If
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
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-right: 15px;' id='DivEmp'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php' id='1' style=''>")
        strHTML.Append("<div class='form-group' >")
        strHTML.Append("<label class='control-label col-sm-2' for='request type' style='text-align: right; font-size: 12px;'>Employee Name*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<input type='Textbox' name='' id='' class='form-control' style='text-align: left' value='' placeholder='Employee Name'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", "form-control", 219, 30, strEmployeeName, , , True, , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type' style='text-align: right; font-size: 12px;'>Blood Group	</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboBloodGroup", "usp_Sel_BloodGroup ", , strBloodGroup, "class='form-control'  ", True, True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group' >")
        strHTML.Append("<label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>Birth Date*</label>")
        strHTML.Append("<div class='col-sm-4' style='display:inline-flex' >")
        strHTML.Append("<div>")
        strHTML.Append("<input type='text' value='" & strBirthDate & "'  class='form-control' id='dtDOB' placeholder=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtJoiningDate", "txtJoiningDate", "form-control", 219, 30, strJoiningDate, , , True, , , True, " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<div>")
        strHTML.Append("<i class='fa fa-calendar' id='idCalender' onclick=""$('#dtDOB').datepicker({orientation: 'right top'});$('#dtDOB').datepicker('show');""></i>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''Added By Aniruddh Gujar on 22-Dec-2017 Purpose::To display the EmailID in My Profile
        strHTML.Append("<label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>Email ID</label>")
        strHTML.Append("<label class='control-label col-sm-4' style='font-size: 12px;'>" & strEmailID & "</label>")
        ''End of Added By Aniruddh Gujar on 22-Dec-2017 Purpose::To display the EmailID in My Profile
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group req-dsk-kn new-req-head'>")
        strHTML.Append(" <label class='control-label col-sm-2 '  style='text-align: right; font-size: 12px; white-space:nowrap'>Permanant Address:</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px; white-space:nowrap'>Current Address:</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Address</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtAddress", "txtAddress", , "form-control", , , , , , , , strAddress, , , , , , , "", True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Current Address</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCurrentAddress", "txtCurrentAddress", , "form-control", , , , , , , , strCurrentAddress, , , , , , , "", True))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>City</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCity", "txtCity", "form-control", 219, 30, strCity, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>Current City</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCurrentCity", "txtCurrentCity", "form-control", 219, 30, strCurrentCity, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>State</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtState", "txtState", "form-control", 219, 30, strState, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append(" <label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Current State</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCurrentState", "txtCurrentState", "form-control", 219, 30, strCurrentState, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("  </div>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>Pin Code</label>")
        strHTML.Append("  <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPin", "txtPin", "form-control", 219, 30, strPinCode, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("  </div>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Current Pin Code</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPin", "txtCurrentPin", "form-control", 219, 30, strCurrentPinCode, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>Phone</label>")
        strHTML.Append("  <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtPhone", "txtPhone", "form-control", 219, 50, strPhone, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append(" <label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>Current Phone</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtCurrentPhone", "txtCurrentPhone", "form-control", 219, 50, strCurrentPhone, , , , , , , " class='form-control'   ", returnHTML:=True, IsPassword:=False, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("  </div>")
        CommonFunction.General.WriteHTML(strHTML.ToString)
    End Function
    Protected Function WriteCutomerTab()
        '=====================================================================
        ' Procedure Name        : WriteCutomerTab()	
        ' Purpose               : To Plot customer the Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               :14-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")
        Dim strCustomerName As String = ""
        Dim strAddress As String = ""
        Dim strCity As String = ""
        Dim strPinCode As String = ""
        Dim strPhone As String = ""
        Dim strEmail As String = ""
        Dim strState As String = ""
        Dim SystemFilename As String = ""
        Dim strFilePath As String = ""
        Dim drCustomer As IDataReader
        Dim strSQL As String = "usp_NG2_Sel_tbl_PM_Customer_ForProfile " & CommonFunction.General.CheckIsNothing(Session("intUserID"), "")
        drCustomer = CommonFunction.Data.GetDataReader(strSQL, True)
        If (drCustomer.Read) Then
            strCustomerName = CommonFunction.Data.CheckIsDBNull(drCustomer("CustomerName"), "")
            strAddress = CommonFunction.Data.CheckIsDBNull(drCustomer("Address"), "")
            strCity = CommonFunction.Data.CheckIsDBNull(drCustomer("City"), "")
            strPinCode = CommonFunction.Data.CheckIsDBNull(drCustomer("PinCode"), "")
            strPhone = CommonFunction.Data.CheckIsDBNull(drCustomer("Phone"), "")
            strEmail = CommonFunction.Data.CheckIsDBNull(drCustomer("EmailID"), "")
            strState = CommonFunction.Data.CheckIsDBNull(drCustomer("State"), "")
            SystemFilename = CommonFunction.Data.CheckIsDBNull(drCustomer("SystemFileName"), "")
        End If
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
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-right: 15px;' id='divCustomerList'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php' id='1' style=''>")
        strHTML.Append("<div class='form-group divlblNote'  >")
        strHTML.Append("<label class='control-label col-sm-2 lblNote'  style='text-align: right; font-size: 12px;'><p style='float:rigth'>Note : Please contact administrator to update profile</p></label>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group clsBorder' >")
        strHTML.Append("<div class='form-group' >")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Customer Name :</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px; '>" & strCustomerName & "</label>")
        strHTML.Append("</div>")
        'strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Address :</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        ''strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCustAddress", "txtCustAddress", , "form-control", , , , , , , , strAddress, , , , , , , "", True))
        'strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strAddress & "</label>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group' >")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Address :</label>")
        strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtCustAddress", "txtCustAddress", , "form-control", , , , , , , , strAddress, , , , , , , "", True))
        strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strAddress & "</label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>City :</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strCity & "</label>")
        strHTML.Append("</div>")
        'strHTML.Append("<label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>State :</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strState & "</label>")
        'strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' style='text-align: right; font-size: 12px;'>State :</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strState & "</label>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Zip :</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strPinCode & "</label>")
        strHTML.Append("</div>")
        'strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Phone :</label>")
        'strHTML.Append("<div class='col-sm-4'>")
        'strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strPhone & "</label>")
        'strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Phone :</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strPhone & "</label>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2'  style='text-align: right; font-size: 12px;'>Email ID :</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<label class='control-label col-sm-2 lblField'  style='font-size: 12px;'>" & strEmail & "</label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("  </div>")
        CommonFunction.General.WriteHTML(strHTML.ToString)
    End Function
    Protected Sub WriteAlerts()
        '=====================================================================
        ' Procedure Name        : WriteAlerts()	
        ' Purpose               : To Set AlertsDays For Employees
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : YOgesh Jalamkar
        ' Created               : 15-DEC-2017
        ' Revisions             :
        '=====================================================================
        Dim drEmail As IDataReader
        Dim drProjectCount As IDataReader
        Dim blnComplete As Boolean
        Dim DueDate As Date
        Dim FlagTo As String = ""
        Dim strContextType As String = ""
        Dim lngContextID As Long
        Dim ConId As Long
        Dim ConType As String
        Dim m_CustomerFlag As Integer
        Dim m_strCustomers As String
        Dim m_blnHelpRequestAfterFlag As Integer
        Dim m_intHelpRequestAfterDays As Integer
        Dim m_lngEntryID As Long
        Dim m_blnHelpRequest As Integer
        Dim m_HelpRequest As Integer
        drEmail = CommonFunctions.Data.GetDataReader("USP_SEL_EMAIL_TBL_PM_EMPLOYEE " + CType(Session("intUserID"), String), m_blnUseSQL)
        If drEmail.Read Then
            m_Emailid = CType(drEmail("Emailid"), String)
        End If
        drProjectCount = CommonFunctions.Data.GetDataReader("USP_SEL_TBL_PM_FLAGFORTRACKING_CONFIGURE " + CType(Session("intUserID"), String), m_blnUseSQL)
        If drProjectCount.Read Then
            m_blnHelpRequest = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("HelpRequestAlertFlag"), "0"), Integer)
            m_HelpRequest = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("HelpRequestAlertDays"), "0"), Integer)
            m_CustomerFlag = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("CustomerFlag"), "0"), Integer)
            m_strCustomers = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("CustomerID"), ""), String)
            m_blnHelpRequestAfterFlag = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("HelpRequestAfterFlag"), "0"), Integer)
            m_intHelpRequestAfterDays = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("HelpRequestAfterDays"), "0"), Integer)
            m_lngEntryID = CType(CommonFunction.Data.CheckIsDBNull(drProjectCount("EntryID"), "0"), Long)
        Else
            m_blnHelpRequest = 0
            m_HelpRequest = 0
            m_CustomerFlag = 0
            m_strCustomers = ""
            m_blnHelpRequestAfterFlag = 0
            m_intHelpRequestAfterDays = 0
            m_lngEntryID = 0
        End If
        With Response
            .Write("<BR>")
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, "Set Alerts"))
            .Write("<BR>")
            .Write("<div id=divList style='overflow:auto'>")
            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            .Write("<TR class=clsTREven>")
            .Write("<TD align=Left>Send me the Following Alerts on - " + m_Emailid + "")
            .Write("</TD>")
            .Write("</TR>")
            .Write("<TR><TD></TD></TR>")
            .Write("</TABLE>")
            .Write("<BR>")
            Dim cObjHelpRequestSectionTitle As New WebPage.Templates.SectionTitle
            With cObjHelpRequestSectionTitle
                Response.Write(.GetSectionTitle("Help-Desk Related Alerts", "DivHelpRequest", "ShowHideHelpRequest", , "", AllowHideShow:=False))
                'Write ClientsideScript in order to show hide the section
                Response.Write("<SCRIPT Language=javascript>")
                Response.Write(.ClientsideScript)
                Response.Write("</SCRIPT>")
            End With
            .Write("<div id=DivHelpRequest style='overflow:auto'>")
            .Write("<Table class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            Dim strsql As String
            Dim blnIsuserAccessEDB As Boolean
            strsql = "select CRMID from tbl_CRM_Function_CRMS "
            strsql += " WHERE CRMID =" + CType(Session("intUserID"), String)
            strsql += " UNION ALL select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " + CType(Session("intUserID"), String)
            strsql += " UNION ALL  SELECT EmployeeID FROM tbl_CRM_EmployeeAccess WHERE EmployeeID = " + CType(Session("intUserID"), String) + " AND ISNULL(AllowToSeeDashboard,0) = 1"
            Dim drViewAccess As IDataReader
            drViewAccess = CommonFunctions.Data.GetDataReader(strsql, m_blnUseSQL)
            If drViewAccess.Read Then
                blnIsuserAccessEDB = True
            Else
                blnIsuserAccessEDB = False
            End If
            CommonFunctions.Data.DisposeDataReader(drViewAccess)
            If blnIsuserAccessEDB = True Then
                Response.Write("<TR class=clsTREven><TD>")
                CommonFunctions.HTMLControls.DrawCheckBox("chkCustomer", "chkCustomer", , CType(m_CustomerFlag, Boolean), , , " onchange=""Javascript:chkCustomer_Change()"" ", , , , , , )
                Response.Write("&nbsp")
                Response.Write("Alert me immediately when Help Request is entered by")
                If CType(m_CustomerFlag, Boolean) = True Then
                    Response.Write("<TD>")
                    Response.Write("<LABEL id=lblCustomers Style='VISIBILITY:visible;'>")
                    Response.Write("<A href='JavaScript:Customer_OnClick()'>Customers</A>")
                    Response.Write("</LABEL>")
                    Response.Write("&nbsp<LABEL id=lblEmployees>")
                    Response.Write("<A href='JavaScript:Employees_OnClick()'>Employees</A>")
                    Response.Write("</LABEL>")
                    Response.Write("</TD>")
                Else
                    Response.Write("<TD>")
                    Response.Write("<LABEL id=lblCustomers Style='VISIBILITY:hidden'>")
                    Response.Write("<A href='JavaScript:Customer_OnClick()'>Customers</A>")
                    Response.Write("</LABEL>")
                    Response.Write("&nbsp")
                    Response.Write("&nbsp<LABEL id=lblEmployees Style='VISIBILITY:hidden'>")
                    Response.Write("<A href='JavaScript:Employees_OnClick()'>Employees</A>")
                    Response.Write("</LABEL>")
                    Response.Write("</TD>")
                End If
                Response.Write("</TR><TR class=clsTREven><TD>")
                CommonFunctions.HTMLControls.DrawCheckBox("chkHelpRequestAfterFlag", "chkHelpRequestAfterFlag", , CType(m_blnHelpRequestAfterFlag, Boolean), , , " onchange=""Javascript:chkHelpRequestAfter_Change()"" ", , , , , , )
                Response.Write("&nbsp")
                Response.Write("Alert me if help request from above selected requestor(s) is not resolved/closed in")
                If CType(m_blnHelpRequestAfterFlag, Boolean) = True Then
                    Response.Write("<TD>")
                    CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequestAfter", "txtHelpRequestAfter", "form-control", 23, 2, CType(m_intHelpRequestAfterDays, String), , , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                    Response.Write("&nbsp")
                Else
                    Response.Write("<TD>")
                    CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequestAfter", "txtHelpRequestAfter", "form-control", 23, 2, CType(m_intHelpRequestAfterDays, String), , , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                    Response.Write("&nbsp")
                End If
                Response.Write("Day(s)")
                Response.Write("</TR>")
            End If
            Response.Write("<TR class=clsTREven><TD>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkHelpRequest", "chkHelpRequest", , CType(m_blnHelpRequest, Boolean), , , " onchange=""Javascript:chkHelpRequest_Change()"" ", , , , , , )
            Response.Write("&nbsp")
            Response.Write("Send Me Reminder")
            If CType(m_blnHelpRequest, Boolean) = True Then
                Response.Write("<TD>")
                CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequest", "txtHelpRequest", "form-control", 23, 2, CType(m_HelpRequest, String), , , , , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                Response.Write("&nbsp")
            Else
                Response.Write("<TD>")
                CommonFunctions.HTMLControls.DrawTextBox("txtHelpRequest", "txtHelpRequest", "form-control", 23, 2, CType(m_HelpRequest, String), , , True, , , , , False, False, , False, False, , EnableHTMLEncode:=True)
                Response.Write("&nbsp")
            End If
            Response.Write("Day(s)before expected resolution date")
            Response.Write("</TR>")
            Response.Write("</TABLE>")
            Response.Write("</div>")
            .Write("</DIV>")
        End With
        CommonFunctions.Data.DisposeDataReader(drEmail)
        CommonFunctions.Data.DisposeDataReader(drProjectCount)
    End Sub
    Protected Function plotReviewerListEmployee(Optional ByVal strFlag As String = "")
        Dim strSQL As String
        Dim strCurrentEmpIDList As String
        Dim objdr As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink
        Dim strFilter As String
        Dim strHTML As New StringBuilder("")
        Dim strReviewstatisticsID As String
        ' Build the query to retrieve the list of resources based on the filtering criteria selected.
        strSQL = "usp_Sel_tbl_PM_Employee_Selection " + CType(Session("intUserID"), String) + ""
        Dim arrColHeader() As String = {"Employee Code", "Employee Name", "Select"}
        Dim arrAN() As String = {"Employee Code", "Employee Name", ""}
        'End Addition
        Dim arrCheckBox() As String = {"", "", "chkSelect"}
        Dim arrCheckBoxCheck() As String = {"", "", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='left'", "align='center'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        If (strFlag <> "") Then
            PageInit()
            strShowAllFlagEmployee = strFlag
        End If
        'create Grid object and set the properties
        objEmpGrid.ActualColumnArray = arrAN
        objEmpGrid.UserFriendlyColumnArray = arrColHeader
        objEmpGrid.CheckBoxIDArray = arrCheckBox
        objEmpGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        objEmpGrid.TDStyleArray = arrTDStyle
        objEmpGrid.PrimaryKey = "CustomerID"
        objEmpGrid.DIVID = "DivListEmp"
        objEmpGrid.DIVHeight = 300
        objEmpGrid.DIVStyle = "overflow: auto"
        objEmpGrid.NoOfDataColumns = 2
        objEmpGrid.PrinterFriendlyVersion = False
        objEmpGrid.VerticalDisplay = False
        objEmpGrid.ColNameToolTipOnEachRow = True
        objEmpGrid.returnHTML = True
        objEmpGrid.EmptyValueReplacement = "-"
        objEmpGrid.SQL = strSQL
        objEmpGrid.UseSQL = MyBase.UseSQL
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        objEmpGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        strHTML.Append(objEmpGrid.DrawGrid())
        objEmpGrid = Nothing
        If (strFlag <> "") Then
            Return strHTML.ToString()
        Else
            CommonFunction.General.WriteHTML(strHTML.ToString)
        End If
    End Function
    Private Sub objEmpGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objEmpGrid.DataRowTR_BeforePrint
        Dim blnChecked As Boolean = False
        Dim strEmpID As String
       
        If (strShowAllFlagEmployee = "1") Then
            'if EmployeeID present in the list then check the checkbox
            strEmpID = Args.DataReader("UserName").ToString + ""
            'strEmpID = "'" + Args.DataReader("Customer ID").ToString + "" + "'"
            If (m_strEmployeeIDList <> "") Or (Not (m_strEmployeeIDList Is Nothing)) Then
                If m_strEmployeeIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                Else
                    Cancel = True
                End If
            End If
        End If
    End Sub
    Private Sub objEmpGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objEmpGrid.DataRowTD_BeforePrint
        Dim blnChecked As Boolean = False
        Dim strEmpID As String
        If Args.CheckBoxId <> "" Then
            'if EmployeeID present in the list then check the checkbox
            strEmpID = Args.DataReader("UserName").ToString + ""
            'strEmpID = "'" + Args.DataReader("Customer ID").ToString + "" + "'"
            If (m_strEmployeeIDList <> "") Or (Not (m_strEmployeeIDList Is Nothing)) Then
                If m_strEmployeeIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                    blnChecked = True
                End If
            End If
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkEmployeeSelect", "chkEmployeeSelect", , blnChecked, strEmpID.Trim, , " ", True) + "</td>"
            Cancel = True
        End If
    End Sub
    Private Sub objEmpGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objEmpGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper = "EMPLOYEE CODE" Then
            Cancel = True
            'Args.ApplySorting = False
            Args.ApplyHTMLEncode = False
            Args.StringToBeInserted = "<th align='center' class='FixedTD'>Employee Code</th>"
        End If
        If Args.ColumnName.ToUpper = "EMPLOYEE NAME" Then
            Cancel = True
            'Args.ApplySorting = False
            Args.ApplyHTMLEncode = False
            Args.StringToBeInserted = "<th align='center' class='FixedTD'>Employee Name</th>"
        End If
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.ApplySorting = False
            Args.ApplyHTMLEncode = False
            Args.StringToBeInserted = "<th align='center' class='FixedTD'>Select</th>"
        End If
    End Sub
    Protected Function plotReviewerListCustomer(Optional ByVal strFlag As String = "")
        '=====================================================================
        ' Procedure Name		:	plotReviewerListCustomer
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plot the controls to show list of resources only and reviewer.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:	15-DEC-2017
        ' Revisions				:	
        '=====================================================================
        Dim strSQL As String
        Dim strCurrentEmpIDList As String
        Dim objdr As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink
        Dim strFilter As String
        Dim strHTML As New StringBuilder("")
        'Added by MrugajaB on 11th Feb 2006 for multiple reviewees feature Issue ID.1835
        Dim strReviewstatisticsID As String
        'End Addition
        strSQL = "usp_Sel_tbl_PM_Customer_Selection " + CType(Session("intUserID"), String) + ""
        Dim arrColHeader() As String = {"Customer ID", "Customer Name", "Select"}
        Dim arrAN() As String = {"Customer ID", "Customer Name", ""}
        'End Addition
        Dim arrCheckBox() As String = {"", "", "chkSelect"}
        Dim arrCheckBoxCheck() As String = {"", "", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='left'", "align='center'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        If (strFlag <> "") Then
            PageInit()
            strShowAllFlagCustomer = strFlag
        End If
        'create Grid object and set the properties
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        objGrid.TDStyleArray = arrTDStyle
        objGrid.PrimaryKey = "Customer ID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 300
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 2
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = True
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSQL
        objGrid.UseSQL = MyBase.UseSQL
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        strHTML.Append(objGrid.DrawGrid())
        objGrid = Nothing
        If (strFlag <> "") Then
            Return strHTML.ToString()
        Else
            CommonFunction.General.WriteHTML(strHTML.ToString)
        End If
    End Function
    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint
        Dim blnChecked As Boolean = False
        Dim strEmpID As String
        If (strShowAllFlagCustomer = "1") Then
              strEmpID = Args.DataReader("Customer ID").ToString + ""
            'strEmpID = "'" + Args.DataReader("Customer ID").ToString + "" + "'"
            If (m_strRevieweeIDList <> "") Or (Not (m_strRevieweeIDList Is Nothing)) Then
                If m_strRevieweeIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                    'm_CustomerList = m_CustomerList + strEmpID + ","
                Else
                    Cancel = True
                End If
            End If
          
        End If
    End Sub
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        Dim blnChecked As Boolean = False
        Dim strEmpID As String
        strEmpID = Args.DataReader("Customer ID").ToString + ""
        If Args.CheckBoxId <> "" Then
            'if EmployeeID present in the list then check the checkbox
            strEmpID = Args.DataReader("Customer ID").ToString + ""
            'strEmpID = "'" + Args.DataReader("Customer ID").ToString + "" + "'"
            If (m_strRevieweeIDList <> "") Or (Not (m_strRevieweeIDList Is Nothing)) Then
                If m_strRevieweeIDList.IndexOf("," + strEmpID.Trim + ",") <> -1 Then
                    blnChecked = True
                    'm_CustomerList = m_CustomerList + strEmpID + ","
                End If
            End If
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkCustomerSelect", "chkCustomerSelect", , blnChecked, strEmpID.Trim, , " onclick=javascript:chkSelect_OnClick(this)", True) + "</td>"
            Cancel = True
        End If
    End Sub
    Private Sub objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper = "CUSTOMER ID" Then
            Cancel = True
            'Args.ApplySorting = False
            Args.ApplyHTMLEncode = False
            Args.StringToBeInserted = "<th align='center' class='FixedTD'>Customer ID</th>"
        End If
        If Args.ColumnName.ToUpper = "CUSTOMER NAME" Then
            Cancel = True
            'Args.ApplySorting = False
            Args.ApplyHTMLEncode = False
            Args.StringToBeInserted = "<th align='center' class='FixedTD'>Customer Name</th>"
        End If
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.ApplySorting = False
            Args.ApplyHTMLEncode = False
            Args.StringToBeInserted = "<th align='center' class='FixedTD'>Select</th>"
        End If
    End Sub
    Public Function SaveProfile()
        '=====================================================================
        ' Procedure  Name		:	SaveProfile
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	save employee profiles
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:  14-DEC
        '=====================================================================
        Dim strSQL As String = "usp_NG2_Upd_tbl_PM_Employee " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "")
        Dim strFlag = ""
        Try
            Dim strFileName As String = ""
            Dim strFileExtension As String = ""
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""
            If Request.Files.Count > 0 Then
                'strOriginalFileName = Request.Files(0).FileName
                ' strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                ' strFileName &= strFileExtension
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
                strOriginalFileName = System.IO.Path.GetFileName(Request.Files(0).FileName)
                'strFileName = objFile.UploadedFileName
                strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension
                Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), strFileName)
                Request.Files(0).SaveAs(fileSavePath)
            End If
            Dim strBloodGroup As String = CommonFunction.General.CheckIsNothing(Request.Params("BloodGroup"))
            Dim strBirthDate As String = CommonFunction.General.CheckIsNothing(Request.Params("DOB"))
            Dim strAddress As String = CommonFunction.General.CheckIsNothing(Request.Params("Address"))
            Dim strCity As String = CommonFunction.General.CheckIsNothing(Request.Params("City"))
            Dim strState As String = CommonFunction.General.CheckIsNothing(Request.Params("State"))
            Dim strPinCode As String = CommonFunction.General.CheckIsNothing(Request.Params("Pin"))
            Dim strPhone As String = CommonFunction.General.CheckIsNothing(Request.Params("Phone"))
            Dim strCurrentAddress As String = CommonFunction.General.CheckIsNothing(Request.Params("CurrentAddress"))
            Dim strCurrentCity As String = CommonFunction.General.CheckIsNothing(Request.Params("CurrentCity"))
            Dim strCurrentState As String = CommonFunction.General.CheckIsNothing(Request.Params("CurrentState"))
            Dim strCurrentPinCode As String = CommonFunction.General.CheckIsNothing(Request.Params("CurrentPin"))
            Dim strCurrentPhone As String = CommonFunction.General.CheckIsNothing(Request.Params("CurrentPhone"))
            strSQL += ",'" & strBloodGroup & "'"
            strSQL += ",'" & strBirthDate & "'"
            strSQL += ",'" & strAddress & "'"
            strSQL += ",'" & strCurrentAddress & "'"
            strSQL += ",'" & strCity & "'"
            strSQL += ",'" & strCurrentCity & "'"
            strSQL += ",'" & strState & "'"
            strSQL += ",'" & strCurrentState & "'"
            strSQL += ",'" & strPinCode & "'"
            strSQL += ",'" & strCurrentPinCode & "'"
            strSQL += ",'" & strPhone & "'"
            strSQL += ",'" & strCurrentPhone & "'"
            strSQL += ",'" & strFileName & "'"
            strSQL += ",'" & strOriginalFileName & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            If (strFileName <> "") Then
                strFlag = strFileName
            Else
                strFlag = "1"
            End If
        Catch ex As Exception
        End Try
        Response.Write(strFlag)
        Response.End()
    End Function
    Public Function SaveCustomerProfile()
        '=====================================================================
        ' Procedure  Name		:	SaveCustomerProfile
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	save employee profiles
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	YOgesh Jalamkar
        ' Created				:  14-DEC
        '=====================================================================
        Dim strSQL As String = "usp_NG_Upd_TBL_PM_CustomerPhoto_Attachment " & CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "")
        Dim strFileName As String = ""
        Dim strFileExtension As String = ""
        Dim strOriginalFileName As String = ""
        Dim strSQLQuery As String = ""
        Dim strAttachmentID As String = ""
        Dim strFlag = ""
        Try
       
        If Request.Files.Count > 0 Then
          
            strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
            strOriginalFileName = System.IO.Path.GetFileName(Request.Files(0).FileName)         
            strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
            strFileName &= strFileExtension
            Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), strFileName)
            Request.Files(0).SaveAs(fileSavePath)
            End If
            strSQL += ",'" & strFileName & "'"
            strSQL += ",'" & strOriginalFileName & "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            If (strFileName <> "") Then
                strFlag = strFileName
            Else
                strFlag = "1"
            End If
        Catch ex As Exception
        End Try
        Response.Write(strFlag)
        Response.End()
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveAlerts(ByVal HelpRequestAfter As Integer, ByVal HelpRequest As Integer, ByVal CustomerFlag As Integer, ByVal HelpRequestAfterFlag As Integer, ByVal HelpRequestFlag As Integer) As String
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
        ' Procedure Name        : SaveAlerts
        ' Description           : To Get RoleDetails
        ' Created Date           : 15-DEC-2017
        'Author:Yogesh Jalamkar
        'Purpose: To save alert details
        '=====================================================================
        Dim strSQL As String
        Dim strFlag As String = ""
        Try
            strSQL = "EXEC USP_INS_TBL_PM_FLAGFORTRACKING_CONFIGURE " & CType(HttpContext.Current.Session("intUserID"), String) & ",NULL,NULL,NULL,NULL," & HelpRequestFlag & "," & HelpRequest & ",NULL,NULL," & CustomerFlag & ",NULL," & HelpRequestAfterFlag & "," & HelpRequestAfter
            ''End of addition by Yogesh Jalamkar Purpose: Whizible Helpdesk Product
            'End Modification
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveCustomers(ByVal strReviewerIDList As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strReviewerIDList = Utilities.Security.SecurityBuilder.CheckUserInput(strReviewerIDList, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : SaveCustomers
        ' Description           : SaveCustomers
        ' Created Date           : 15-DEC-2017
        'Author:Yogesh Jalamkar
        'Purpose: 
        '=====================================================================
        Dim strSQL As String = ""
        Dim strFlag = ""
        Try
     
        If strReviewerIDList.Chars(0) = CChar(",") Then
            strSQL = "usp_Ins_tbl_PM_FlagforTracking_CustomerFlag " + CType(HttpContext.Current.Session("intUserID"), String) + ",'" + strReviewerIDList + "'"
        Else
            strSQL = "usp_Ins_tbl_PM_FlagforTracking_CustomerFlag " + CType(HttpContext.Current.Session("intUserID"), String) + ",'," + strReviewerIDList + "'"
        End If
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveEmployees(ByVal strReviewerIDList As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strReviewerIDList = Utilities.Security.SecurityBuilder.CheckUserInput(strReviewerIDList, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            response.StatusCode = 429
            response.Write("Bad Request found")
            Return "Bad Request found"
        End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : SaveEmployees
        ' Description           : SaveEmployees
        ' Created Date           : 15-DEC-2017
        'Author:Yogesh Jalamkar
        'Purpose: 
        '=====================================================================
        Dim strSQL As String = ""
        Dim strFlag = ""
        Try
            If strReviewerIDList.Chars(0) = CChar(",") Then
                strSQL = "usp_Ins_tbl_PM_FlagforTracking_CustomerFlag_EmployeeList " + CType(HttpContext.Current.Session("intUserID"), String) + ",'" + strReviewerIDList + "'"
            Else
                strSQL = "usp_Ins_tbl_PM_FlagforTracking_CustomerFlag_EmployeeList " + CType(HttpContext.Current.Session("intUserID"), String) + ",'," + strReviewerIDList + "'"
            End If
          
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            strFlag = "1"
            Return strFlag
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ShowSelectedEmployee(ByVal Flag As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
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
        ' Procedure Name        : ShowSelectedEmployee
        ' Description           : ShowSelectedEmployee
        ' Created Date           : 15-DEC-2017
        'Author:Yogesh Jalamkar
        'Purpose: 
        '=====================================================================
        Try
            Dim objMyprofile As New MyProfile()
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objMyprofile.plotReviewerListEmployee(Flag))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ShowSelectedCustomer(ByVal Flag As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
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
        ' Procedure Name        : ShowSelectedCustomer
        ' Description           : ShowSelectedCustomer
        ' Created Date           : 15-DEC-2017
        'Author:Yogesh Jalamkar
        'Purpose: 
        '=====================================================================
        Try
            Dim objMyprofile As New MyProfile()
            Dim strHTML As New StringBuilder("")
            strHTML.Append(objMyprofile.plotReviewerListCustomer(Flag))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
End Class