Imports System.IO

Public Class CRM_CompanyInformation
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    '============================================================================================================================='
    '                           Added By Varsha Jorwekar   Purpose ::: Company Information Page                                   '
    '============================================================================================================================='

    Protected m_intRoleID As String
    Protected strLoginType As String
    Protected strUserName As String
    Protected intUserID As String

    Protected companyname As String
    Protected companyshortname As String
    Protected address As String
    Protected city As String
    Protected state As String
    Protected country As String
    Protected zip As String
    Protected email As String

    'Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format

    Protected outputdateformat As String
    Protected inputdateformat As String

    'End of Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format

    Protected weekdays As Integer
    Protected dayhours As Integer
    Protected originalfilenm As String

    Protected Shared m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.

    Public CompanyInformationTagID As Integer = 1029

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        GetGlobalObject(CompanyInformationTagID)
        Dim strFileName As String = ""
        If Request.Params("Mode") = "UploadPhoto" Then


            'Dim strFileName As String = "CustomerLogo"
            Dim strFileExtension As String = ".gif"
            Dim strOriginalFileName As String = ""
            Dim strSQLQuery As String = ""
            Dim strAttachmentID As String = ""

            If Request.Files.Count > 0 Then

                strOriginalFileName = System.IO.Path.GetFileName(Request.Files(0).FileName)
                ' the system file name
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
                'strFileExtension = System.IO.Path.GetExtension(strOriginalFileName)
                strFileName &= strFileExtension

                Dim fileSavePath As String = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/"), strFileName)
                Request.Files(0).SaveAs(fileSavePath)

            End If
            companyname = Request.Params("companyname")
            companyshortname = Request.Params("companyshortname")
            address = Request.Params("address")
            city = Request.Params("city")
            state = Request.Params("state")
            country = Request.Params("country")
            zip = Request.Params("zip")
            email = Request.Params("email")

            'Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format
            outputdateformat = Request.Params("outputdateformat")
            inputdateformat = Request.Params("inputdateformat")
            'End of Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format

            weekdays = Request.Params("weekdays")
            dayhours = Request.Params("dayhours")
            originalfilenm = Request.Params("originalfilenm")
            If (strFileName = "") Then
                strFileName = GetEmployeeImagePath()
            End If

            'Commented and Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format
            'UpdateCompanyInformationDetails(companyname, companyshortname, address, city, state, country, zip, email, weekdays, dayhours, originalfilenm, strFileName)
            UpdateCompanyInformationDetails(companyname, companyshortname, address, city, state, country, zip, email, outputdateformat, inputdateformat, weekdays, dayhours, originalfilenm, strFileName)
            'End of Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format


            Response.End()
        End If


        '

    End Sub

    Public Function PageInit()
        '*******************************************************************************'
        ' Function Name	        :	PageInit                                            '
        ' Purpose				:   Plotting the page                                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       ' 
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'

        Dim strHTML As New StringBuilder("")
        Dim objSetting As New CRM_CompanyInformation

        If (m_objAccessRights.View) Then
            Dim str As String = objSetting.DrawPage()
            strHTML.Append(str)
        End If

        CommonFunctions.General.WriteHTML(strHTML.ToString)
    End Function

    Public Function DrawPage()

        '*******************************************************************************'
        ' Function Name	        :	DrawPage                                            '
        ' Purpose				:   Plotting the page                                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Dim str As String = ""
        Dim strHTML As New StringBuilder("")

        Dim strFileName As String = GetEmployeeImagePath()

        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intLOGINID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)

        'Commented and Added by Usha Pandit on 19.12.2017 to apply scroll
        'strHTML.Append("<div id='CompanyInfoDiv' style='overflow:auto;width:100%;margin-left: 0px !important;'>")

        strHTML.Append("<div id='CompanyInfoDiv' style='overflow:auto;width:102%;margin-left: 0px !important;'>")

        'End of addition by Usha Pandit on 19.12.2017 to apply scroll

        strHTML.Append("<div class='content-wrapper' style='margin-left: 0px !important;'>")
        strHTML.Append("<div class='container-fluid'>")
        strHTML.Append("<div class='request-details-pg clsSettings' style='margin-top:0px;'>")
        strHTML.Append("<div class='v-tabs' style='width: 100%;'>")

        strHTML.Append("<div id='' class='tabcontent'>")
        strHTML.Append("<div class='h-tabs' style='width: 100%;'>")

        strHTML.Append("<div class='type-top-bar top-bar' id='EmployeeFilter' style='height: 2EM;'>")

        'Commented and added by Usha Pandit on 20.12.2017 to plot edit button below image logo
        'strHTML.Append("<div class='form-group' id='UploadImage' title='Click here to change logo/Image' style='width:10%;MARGIN-TOP: -0.1%;'>")
        'strHTML.Append("<div class='col-xs-1' >")
        'strHTML.Append("<div><div class='selectedfilecls' ><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' class='selectedfilecls' style='BORDER: NONE;' filecount='0'><img id='imgUser' onclick='SelectFile();' style='margin-top: -1%;margin-left: -20%;' class='selectedfilecls' alt='Upload Image' src='" & strFileName & "' /></a></div></div></div>")

        strHTML.Append("<div class='form-group' id='UploadImage'>")
        strHTML.Append("<div class='col-xs-1' >")

        strHTML.Append("<img id='imgUser' onclick='SelectFile();'  class='selectedfilecls' alt='Upload Image' src='" & strFileName & "' />")
        strHTML.Append("<div class='edit' style ='margin-left: 40px;margin-top: 3px;'>")
        strHTML.Append("<input name='img[]' class='file' id='file' type='file'>")
        strHTML.Append("<a data-toggle='tooltip' data-bs-original-title='Click here to change logo/Image' id='btnSelectFile' style='text-align: center; font-weight: normal; font-size: 11px !important;' onclick='SelectFile()' filecount='0'>")
        strHTML.Append("<i class='fas fa-pencil-alt' style='font-size: 16px'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        'End of addition by Usha Pandit on 20.12.2017 to plot edit button below image logo
        strHTML.Append("</div>")

        strHTML.Append("<ul class='right' id='idyearend'>")
        strHTML.Append("<li class='clearall'>")
        'commented by Dipali V On 19th Dec 2017 For link not requried 
        'If (m_objAccessRights.Access) Then
        strHTML.Append("<button type='button' class='btn btn-default' style='background-color:white;text-decoration:underline;'  onclick='YearEndProcess()'>Year End Process</button></li>")
        'End If
        'End of commented by Dipali V On 19th Dec 2017 For link not requried 
        strHTML.Append("</ul>")

        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id=''>")
        strHTML.Append("<div class='container'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-7 col-md-offset-3'>")

        strHTML.Append("<form class='form-horizontal' action='/action_page.php' style=''>")

        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Company Name * </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("companynamebox", "companynamebox", "form-control", 215, , , , , , , , , "  class='form-control' placeholder='Enter Company Name' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Company Short Name * </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("companyshortnamebox", "companyshortnamebox", "form-control", 215, , , , , , , , , "  class='form-control' placeholder='Enter Company Short Name' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Address</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("addressbox", "addressbox", , "form-control", , , , , 215, , , , , "  class='form-control' placeholder='Enter Hours' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>City</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("citybox", "citybox", "form-control", 215, , , , , , , , , "  class='form-control' placeholder='Enter City' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>State</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("statebox", "statebox", "form-control", 215, , , , , , , , , "  class='form-control' placeholder='Enter State' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Country</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("countrybox", "countrybox", "form-control", 215, , , , , , , , , "  class='form-control' placeholder='Enter Country' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Zip</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("zipbox", "zipbox", "form-control", 215, , , , , , , , , "  class='form-control' placeholder='Enter Zip Code' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Email </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("<input type='Email' name='' id='emailbox' class='form-control' style='text-align: left; width: 215px; margin-top: 0px' value='' placeholder='Enter Email'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Output Date Format </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOutputDateFormat", "usp_NG2_sel_tbl_PM_DateFormats", 215, "", "", True, True, "form-control", False, , , 1).ToString.Replace("'", " "))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Input Date Format  </label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboInputDateFormat", "usp_sel_tbl_PM_CompanyInformation_InputeDateFormat", 215, "", "", True, True, "form-control", False, , , 1).ToString.Replace("'", " "))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group bxs' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 captionlbl labelControlCaption' for='request type'>Financial Year Start Date      </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append("<label class='control-label' id='yearstartlbl' for='request type' style='font-size: 12px; padding-top: 8%;margin-left: -1px;'></label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group bxs' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 captionlbl labelControlCaption' for='request type'>Financial Year End Date      </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append("<label class='control-label'  id='yearendlbl'  for='request type' style='font-size: 12px; padding-top: 8%;margin-left: -1px;'></label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 captionlbl labelControlCaption' for='request type' style='font-size: 12px; padding-top: 8px; text-align: right; padding-left: 0px; padding-right: 12px'>Number of Users      </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append("<label class='control-label' id='usernolbl' for='request type' style='font-size: 12px; padding-top: 8px;'>   </label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Week Days * </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("weekdaysbox", "weekdaysbox", "form-control", 173, , , , , , , , , "  class='form-control' placeholder='Enter Week Days' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type'>Hours in a Day * </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("dayhoursbox", "dayhoursbox", "form-control", 173, , , , , , , , , "  class='form-control' placeholder='Enter Hours' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 captionlbl labelControlCaption' for='request type' style='padding-left: 0px; padding-right: 12px'>LLS Email Id</label>")
        strHTML.Append("<div class='col-sm-12'>")
        strHTML.Append("<label class='control-label' id='emailbox' for='request type'>support@lls_sys.com </label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type' style='padding-left: 0px; padding-right: 12px'>LLS Phone Number     </label>")
        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append("<label class='control-label' id='phonelbl' for='request type' style='width: 130%;font-size: 12px; padding-top: 11px;'>+91 20 30200777 / 778 </label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='form-group' style='margin-top: 5px;'>")
        strHTML.Append("<label class='control-label col-sm-3 labelControlCaption' for='request type' style='padding-left: 0px; padding-right: 12px'>Product Version     </label>")

        strHTML.Append("<div class='col-sm-3'>")
        strHTML.Append("<label class='control-label' id='productversionlbl' for='request type' style='font-size: 12px; padding-top: 11px;'>11.0    </label>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='type-top-bar top-bar' id='' style='height: 42px;'>")

        strHTML.Append("<ul class='right'>")
        strHTML.Append("<div class='form-group' style='border-bottom: none; margin-top: 5px;'>")
        strHTML.Append("<div class='right' style='margin-right: 15px;'>")

        If m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save' onclick='SaveCompanyInformation()' style='background-color: #343660; color: #ffffff'>Save</button>")
        End If

        strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' style='margin-right: 19px; margin-left: 5px; background-color: #343660; color: #ffffff' onclick='Cancelinformation(""1"")'>Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("</ul>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        '<!-- /.content-wrapper -->
        '<!-- Bootstrap core JavaScript -->
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>") 'CompanyInfoDiv closed
        Return strHTML.ToString()
    End Function

    'Commented and added by Usha Pandit on 18.12.2017 for Save Validate operation
    '<System.Web.Services.WebMethod()>
    'Public Shared Function GetCompanyInformation()
    '    '================================================================================
    '    ' Procedure Name        : GetCompanyInformation()	
    '    ' Purpose               : Get Company Information details 
    '    ' Description           : Get Company Information details 
    '    ' Parameters Passed     : None.
    '    ' Returns               : Datatable (String format)
    '    ' Parameters Affected   : None.
    '    ' Assumptions           : None.
    '    ' Dependencies          : None.
    '    ' Author                : Varsha Jorwekar
    '    ' Created               : 08-Dec-2017
    '    ' Revisions             :
    '    '===============================================================================
    '    Dim strSQL As String
    '    Dim strResult As String
    '    Dim dt As DataTable
    '    strSQL = "usp_NG2_sel_tbl_PM_CompanyInformation"
    '    dt = CommonFunctions.Data.GetDataTable(strSQL, True)

    '    strResult = GetSerialized(dt)
    '    Return strResult

    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetCompanyInformation()
        '================================================================================
        ' Procedure Name        : GetCompanyInformation()	
        ' Purpose               : Get Company Information details 
        ' Description           : Get Company Information details 
        ' Parameters Passed     : None.
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : None.
        ' Dependencies          : None.
        ' Author                : Varsha Jorwekar
        ' Created               : 08-Dec-2017
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim drCompanyInformation As IDataReader
            Dim CompanyName As String
            Dim ShortCompanyName As String
            Dim Address As String

            Dim City As String
            Dim State As String
            Dim Country As String

            Dim ZipCode As String
            Dim Email As String
            Dim DateFormatID As String


            Dim InputDateFormat As String
            Dim FinancialYearStart As String
            Dim FinancialYearEnd As String

            Dim NoOfUsers As String
            Dim WeekDays As String
            Dim HoursPerDay As String

            Dim CSPLEmail As String
            Dim CSPLPhone As String
            Dim ProductVersion As String


            Dim SystemFilename As String

            Dim strLogo As String
            Dim strFilePath As String = ""

            strSQL = "usp_NG2_sel_tbl_PM_CompanyInformation"
            drCompanyInformation = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drCompanyInformation.Read Then
                CompanyName = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("CompanyName").ToString, "")
                ShortCompanyName = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("ShortCompanyName").ToString, "")
                Address = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("Address").ToString, "")

                City = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("City").ToString, "")
                State = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("State").ToString, "")
                Country = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("Country").ToString, "")
                ZipCode = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("ZipCode").ToString, "")
                Email = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("Email").ToString, "")
                DateFormatID = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("DateFormatID").ToString, "")

                InputDateFormat = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("InputDateFormat").ToString, "")
                FinancialYearStart = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("FinancialYearStart").ToString, "")
                FinancialYearEnd = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("FinancialYearEnd").ToString, "")
                NoOfUsers = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("NoOfUsers").ToString, "")
                WeekDays = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("WeekDays").ToString, "")
                HoursPerDay = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("HoursPerDay").ToString, "")

                CSPLEmail = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("CSPLEmail").ToString, "")   '15
                CSPLPhone = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("CSPLPhone").ToString, "") '16
                ProductVersion = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("ProductVersion").ToString, "") '17

                SystemFilename = CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("SystemFilename").ToString, "")  '18

                Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
                strLogo = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1)
                strLogo = strLogo.Replace("\", "/")

                If Not SystemFilename Is Nothing Then
                    strFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/Photo/"), SystemFilename)
                End If

                If File.Exists(strFilePath) = False Or CommonFunctions.General.CheckIsNothing(SystemFilename) = "" Then
                    strLogo = strLogo + "/Images/Photo/no-photo.png"
                Else
                    strLogo = strLogo + "/Images/Photo/" + SystemFilename
                End If
            End If

            Return CompanyName & "#$#" & ShortCompanyName & "#$#" & Address & "#$#" & City & "#$#" & State & "#$#" & Country & "#$#" & ZipCode & "#$#" & Email & "#$#" & DateFormatID & "#$#" & InputDateFormat & "#$#" & FinancialYearStart & "#$#" & FinancialYearEnd & "#$#" & NoOfUsers & "#$#" & WeekDays & "#$#" & HoursPerDay & "#$#" & CSPLEmail & "#$#" & CSPLPhone & "#$#" & ProductVersion & "#$#" & strLogo

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    'End of addition by Usha Pandit on 18.12.2017 for Save Validate operation

    'Commented and Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format
    '<System.Web.Services.WebMethod()>
    'Public Shared Function UpdateCompanyInformationDetails(ByVal companyname As String, ByVal companyshortname As String, ByVal address As String, ByVal city As String, ByVal state As String, ByVal country As String, ByVal zip As String, ByVal email As String, ByVal weekdays As Integer, ByVal dayhours As Double, ByVal originalfilenm As String, ByVal encryptedfilenm As String)
    '    '======================================================================================
    '    ' Procedure Name        : UpdateCompanyInformationDetails
    '    ' Purpose               : save/update Company Information Details for selected entry
    '    ' Description           : save/update Company Information Details for selected entry
    '    ' Parameters Passed     : Company Details
    '    ' Returns               : Nothing.
    '    ' Parameters Affected   : None.
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Varsha Jorwekar
    '    ' Created               : 08-Dec-2017
    '    ' Revisions             :
    '    '=====================================================================================
    '    Dim strSQL As String
    '    Dim strResult As Integer = 0
    '    Dim strEmployeeImage As String = ""
    '    Dim strListHTML As New StringBuilder("")
    '    Dim pgobj As New CRM_CompanyInformation

    '    'Added by Usha Pandit on 20.12.2017 for Image alignment
    '    If encryptedfilenm.Contains("/") Then
    '        encryptedfilenm = encryptedfilenm.Substring(encryptedfilenm.LastIndexOf("/") + 1)
    '    End If
    '    'End of addition by Usha Pandit on 20.12.2017 for Image alignment

    '    'Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
    '    strSQL = "usp_NG2_upd_tbl_PM_CompanyInformation '" & address & "',"
    '    strSQL = strSQL & "'" & companyshortname & "',"
    '    strSQL = strSQL & "'" & city & "',"
    '    strSQL = strSQL & "'" & country & "',"
    '    strSQL = strSQL & "'" & state & "',"
    '    strSQL = strSQL & "'" & companyname & "',"
    '    strSQL = strSQL & "'" & zip & "',"
    '    strSQL = strSQL & "'" & email & "',"
    '    strSQL = strSQL & "" & weekdays & ","
    '    strSQL = strSQL & "" & dayhours & ","
    '    strSQL = strSQL & "'" & originalfilenm & "',"
    '    strSQL = strSQL & "'" & encryptedfilenm & "'"


    '    strResult = CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

    '    strEmployeeImage = pgobj.GetEmployeeImagePath()
    '    strListHTML.Append("<div class='col-xs-1' >")
    '    '  strListHTML.Append("<div class='avatar'><div class='bros-btn'><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='' /></a></div></div></div>")

    '    'Commented and added by Usha Pandit on 20.12.2017 to plot edit button below image logo
    '    'strListHTML.Append("<div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='" & strEmployeeImage & "' /></a></div></div></div>")

    '    strListHTML.Append("<img id='imgUser' onclick='SelectFile();' class='selectedfilecls' alt='Upload Image' src='" & strEmployeeImage & "' />")
    '    strListHTML.Append("<div class='edit' style ='margin-left: 40px;margin-top: 3px;'>")
    '    strListHTML.Append("<input name='img[]' class='file' id='file' type='file'>")
    '    strListHTML.Append("<a  title='Click here to change logo/Image'    id='btnSelectFile' style='text-align: center; font-weight: normal; font-size: 11px !important;' onclick='SelectFile()' filecount='0'>")
    '    strListHTML.Append("<i class='fas fa-pencil-alt' style='font-size: 16px'></i>")
    '    strListHTML.Append("</a>")
    '    strListHTML.Append("</div>")

    '    strListHTML.Append("</div>")

    '    'End of addition by Usha Pandit on 20.12.2017 to plot edit button below image logo
    '    CommonFunctions.General.WriteHTML(strListHTML.ToString)

    '    'Return strResult

    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function UpdateCompanyInformationDetails(ByVal companyname As String, ByVal companyshortname As String, ByVal address As String, ByVal city As String, ByVal state As String, ByVal country As String, ByVal zip As String, ByVal email As String, ByVal outputdateformat As String, ByVal inputdateformat As String, ByVal weekdays As Integer, ByVal dayhours As Double, ByVal originalfilenm As String, ByVal encryptedfilenm As String)
        '======================================================================================
        ' Procedure Name        : UpdateCompanyInformationDetails
        ' Purpose               : save/update Company Information Details for selected entry
        ' Description           : save/update Company Information Details for selected entry
        ' Parameters Passed     : Company Details
        ' Returns               : Nothing.
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 08-Dec-2017
        ' Revisions             :
        '=====================================================================================
        Try
            Dim strSQL As String
            Dim strResult As Integer = 0
            Dim strEmployeeImage As String = ""
            Dim strListHTML As New StringBuilder("")
            Dim pgobj As New CRM_CompanyInformation

            'Added by Usha Pandit on 20.12.2017 for Image alignment
            If encryptedfilenm.Contains("/") Then
                encryptedfilenm = encryptedfilenm.Substring(encryptedfilenm.LastIndexOf("/") + 1)
            End If
            'End of addition by Usha Pandit on 20.12.2017 for Image alignment

            'Dim strFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            strSQL = "usp_NG2_upd_tbl_PM_CompanyInformation '" & address & "',"
            strSQL = strSQL & "'" & companyshortname & "',"
            strSQL = strSQL & "'" & city & "',"
            strSQL = strSQL & "'" & country & "',"
            strSQL = strSQL & "'" & state & "',"
            strSQL = strSQL & "'" & companyname & "',"
            strSQL = strSQL & "'" & zip & "',"
            strSQL = strSQL & "'" & email & "',"
            strSQL = strSQL & "" & weekdays & ","
            strSQL = strSQL & "" & dayhours & ","
            strSQL = strSQL & "'" & originalfilenm & "',"
            strSQL = strSQL & "'" & encryptedfilenm & "'"

            'Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format
            strSQL = strSQL & "," & outputdateformat & ","
            strSQL = strSQL & "'" & inputdateformat & "'"
            'End of Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format

            strResult = CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            strEmployeeImage = pgobj.GetEmployeeImagePath()
            strListHTML.Append("<div class='col-xs-1' >")
            '  strListHTML.Append("<div class='avatar'><div class='bros-btn'><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='' /></a></div></div></div>")

            'Commented and added by Usha Pandit on 20.12.2017 to plot edit button below image logo
            'strListHTML.Append("<div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' alt='Upload Image' src='" & strEmployeeImage & "' /></a></div></div></div>")

            strListHTML.Append("<img id='imgUser' onclick='SelectFile();' class='selectedfilecls' alt='Upload Image' src='" & strEmployeeImage & "' />")
            strListHTML.Append("<div class='edit' style ='margin-left: 40px;margin-top: 3px;'>")
            strListHTML.Append("<input name='img[]' class='file' id='file' type='file'>")
            strListHTML.Append("<a data-toggle='tooltip' title='Click here to change logo/Image' id='btnSelectFile' style='text-align: center; font-weight: normal; font-size: 11px !important;' onclick='SelectFile()' filecount='0'>")
            strListHTML.Append("<i class='fas fa-pencil-alt' style='font-size: 16px'></i>")
            strListHTML.Append("</a>")
            strListHTML.Append("</div>")

            strListHTML.Append("</div>")

            'End of addition by Usha Pandit on 20.12.2017 to plot edit button below image logo
            CommonFunctions.General.WriteHTML(strListHTML.ToString)

            'Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'End of Added by Usha Pandit on 16 JAN 2018 for saving Output Date Format and Input Date Format
    <System.Web.Services.WebMethod()>
    Public Shared Function YearEndProcessInformation()
        '============================================================================================
        ' Procedure Name        : YearEndProcessInformation
        ' Purpose               : Update Year End Process Information details for selected entry
        ' Description           : Update Year End Process Information details for selected entry
        ' Parameters Passed     : Messageid, subject, body, purpose 
        ' Returns               : Nothing.
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 08-Dec-2017
        ' Revisions             :
        '===========================================================================================
        Try
            Dim strSQL As String
            Dim strResult As Integer = 0

            strSQL = "usp_UPD_LeaveBalance_ForYearEndProcess"
            strResult = CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Protected Sub GetGlobalObject(ByVal TagID As String)
        '=============================================================================
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
        '=============================================================================

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = TagID
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub


    Public Function GetEmployeeImagePath() As String
        Dim strImageName As String = ""
        Dim strEmployeeImage As String
        Dim strFilePath As String = ""

        strImageName = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_systemfilename_tbl_PM_CompanyInformation", True), ""))

        Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
        strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1)
        strEmployeeImage = strEmployeeImage.Replace("\", "/")

        'Added by Usha Pandit on 20.12.2017 for Image Path
        If strImageName.Contains("/") Then
            strImageName = strImageName.Substring(strImageName.LastIndexOf("/") + 1)
        End If
        'End of addition by Usha Pandit on 20.12.2017 for Image Path

        If Not strImageName Is Nothing Then
            strFilePath = Path.Combine(HttpContext.Current.Server.MapPath("../../../Images/"), strImageName)
        End If

        If File.Exists(strFilePath) = False Or CommonFunctions.General.CheckIsNothing(strImageName) = "" Then
            strEmployeeImage = strEmployeeImage + "/Images/Photo/no-photo.png"
        Else
            strEmployeeImage = strEmployeeImage + "/Images/Photo/" + strImageName
        End If

        Return strEmployeeImage

    End Function


    '============================================================================================================================='
    '                          End of Added By Varsha Jorwekar   Purpose ::: Company Information Page                             '
    '============================================================================================================================='

#Region "Jquery AJAX Web Methods"

    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        Dim jsonString As String = ""

        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                If col.DataType = GetType(DateTime) Then
                    col.DateTimeMode = DataSetDateTime.Unspecified
                End If
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        jsonString = serializer.Serialize(rows)

        Return jsonString
    End Function
#End Region
End Class