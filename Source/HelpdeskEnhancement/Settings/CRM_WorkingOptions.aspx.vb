Imports CommonFunctions.General
Public Class CRM_WorkingOptions
    Inherits WebPages.Template.WhizTemplate
    Private m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal
    Private TagID As Integer = 1030
    Private m_intRoleID As Integer = 0

    Protected m_strUserName As String = ""
    Protected strLoginType = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        GetAccessRights()
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
        ' Author                :	Usha Pandit
        ' Created               :	25 NOV 2017
        ' Revisions             :
        '=====================================================================
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal

    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function GetCompanyInfoID() As String
        '=====================================================================
        ' Procedure  Name		:	GetCompanyInfoID
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Get CompanyInfoID
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   11 Dec 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String

            strSQL = "USP_NG2_SEL_CompanyInfoID "
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Get_WorkingOptions(ByVal CompanyInfoID As String) As String
        '=====================================================================
        ' Procedure  Name		:	Get_WorkingOptions
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Working Options
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   11 DEC 2017
        '=====================================================================
        Try
            Dim objSetting As New CRM_WorkingOptions
            objSetting.GetAccessRights()
            If objSetting.m_objAccess.View Then

                Dim strResult As String = ""
                Dim strSQL As String = ""
                Dim dtDefectType As DataTable
                Dim strValidation As String = ""
                Dim strPlotHtml As String = ""
                Dim strHTML As New StringBuilder()
                Dim strScript As String()

                ' Dim m_strUserID As String

                strSQL = "USP_NG2_SEL_Working_Options_Settings " & CompanyInfoID

                dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

                strResult = GetSerialized(dtDefectType)

                strScript = strResult.Split("|")

                strHTML.Append(strScript(0) + vbCrLf)
                Return strResult & "|" & strHTML.ToString
            End If
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DecryptPassword(ByVal EncryptedPassword As String) As String
        '=====================================================================
        ' Procedure  Name		:	DecryptPassword
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Decrypt Password
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   11 Dec 2017
        '=====================================================================
        Try
            Dim strResult = "0"

            strResult = DecryptString(EncryptedPassword)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function EncryptPassword(ByVal OriginalPassword As String) As String
        '=====================================================================
        ' Procedure  Name		:	EncryptPassword
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Encrypt Password
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   12 Dec 2017
        '=====================================================================
        Try
            Dim strResult = "0"

            strResult = EncryptString(OriginalPassword)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveWorkingOptions(ByVal clsWorkingOptionsData As clsWorkingOption) As String
        '=====================================================================
        ' Procedure  Name		:	SaveWorkingOptions
        ' Parameters Passed		:	clsWorkingOptionsData
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save Working Option Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   12 Dec 2017
        '=====================================================================

        Try

            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
            Dim CompanyInfoID As String = clsWorkingOptionsData.CompanyInfoID
            Dim DaysPerPersonMonth As String = clsWorkingOptionsData.DaysPerPersonMonth
            Dim ShowPasswordLinks As String = clsWorkingOptionsData.ShowPasswordLinks
            Dim PhysicalDeletionOfDocuments As String = clsWorkingOptionsData.PhysicalDeletionOfDocuments
            Dim AutoServiceForPassword As String = clsWorkingOptionsData.AutoServiceForPassword
            Dim ShowMyProfile As String = clsWorkingOptionsData.ShowMyProfile
            Dim EnableProductExecution As String = clsWorkingOptionsData.EnableProductExecution
            Dim IsAllowExistingAttachment As String = clsWorkingOptionsData.IsAllowExistingAttachment
            Dim IsAllowNewAttachment As String = clsWorkingOptionsData.IsAllowNewAttachment
            Dim NoofDaysAutoclose As String = clsWorkingOptionsData.NoofDaysAutoclose
            Dim IsProRataEnabled As String = clsWorkingOptionsData.IsProRataEnabled
            Dim SMTPServerPort As String = clsWorkingOptionsData.SMTPServerPort

            Dim SMTPDomainName As String = clsWorkingOptionsData.SMTPDomainName
            Dim SMTPServer_InstallationType As String = clsWorkingOptionsData.SMTPServer_InstallationType
            Dim SMTPUserName As String = clsWorkingOptionsData.SMTPUserName
            Dim SMTPServer As String = clsWorkingOptionsData.SMTPServer
            Dim SMTPPassword As String = clsWorkingOptionsData.SMTPPassword
            Dim EmailFormat As String = clsWorkingOptionsData.EmailFormat
            Dim IsSSLEnabled As String = clsWorkingOptionsData.IsSSLEnabled
            Dim TimeZoneID As String = clsWorkingOptionsData.TimeZoneID
            Dim SLAAppliedOn As String = clsWorkingOptionsData.SLAAppliedON
            If CompanyInfoID = "" Or CompanyInfoID Is Nothing Then
                CompanyInfoID = "0"
            End If
            If DaysPerPersonMonth = "" Or DaysPerPersonMonth Is Nothing Then
                DaysPerPersonMonth = "0.0"
            End If
            If ShowPasswordLinks = "" Or ShowPasswordLinks Is Nothing Then
                ShowPasswordLinks = "0.0"
            End If
            If PhysicalDeletionOfDocuments = "" Or PhysicalDeletionOfDocuments Is Nothing Then
                PhysicalDeletionOfDocuments = "0"
            End If
            If AutoServiceForPassword = "" Or AutoServiceForPassword Is Nothing Then
                AutoServiceForPassword = "0"
            End If
            If ShowMyProfile = "" Or ShowMyProfile Is Nothing Then
                ShowMyProfile = "0"
            End If
            If EnableProductExecution = "" Or EnableProductExecution Is Nothing Then
                EnableProductExecution = "0"
            End If
            If IsAllowExistingAttachment = "" Or IsAllowExistingAttachment Is Nothing Then
                IsAllowExistingAttachment = "0"
            End If

            If IsAllowNewAttachment = "" Or IsAllowNewAttachment Is Nothing Then
                IsAllowNewAttachment = "0"
            End If
            If NoofDaysAutoclose = "" Or NoofDaysAutoclose Is Nothing Then
                NoofDaysAutoclose = "0"
            End If
            If IsProRataEnabled = "" Or IsProRataEnabled Is Nothing Then
                IsProRataEnabled = "0"
            End If
            If SMTPServerPort = "" Or SMTPServerPort Is Nothing Then
                SMTPServerPort = "0"
            End If
            If SMTPServer_InstallationType = "" Or SMTPServer_InstallationType Is Nothing Then
                SMTPServer_InstallationType = "null"
            End If

            If IsSSLEnabled = "" Or IsSSLEnabled Is Nothing Then
                IsSSLEnabled = "0"
            End If

            If TimeZoneID = "" Or TimeZoneID Is Nothing Then
                TimeZoneID = "0"
            End If

            Dim strSQL As String = "EXEC USP_NG2_UPD_Working_Options_Settings  " & CompanyInfoID & ", " & DaysPerPersonMonth & "," & ShowPasswordLinks & "," & PhysicalDeletionOfDocuments & "," & AutoServiceForPassword & "," & ShowMyProfile & "," & EnableProductExecution & "," & IsAllowExistingAttachment & "," & IsAllowNewAttachment & "," & NoofDaysAutoclose & "," & IsProRataEnabled & "," & SMTPServerPort & ",'" & SMTPDomainName & "'," & SMTPServer_InstallationType & ",'" & SMTPUserName & "','" & SMTPServer & "','" & SMTPPassword & "','" & EmailFormat & "'," & IsSSLEnabled & "," & TimeZoneID & ",'" & SLAAppliedOn & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return "Success"
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
    Protected Sub PlotHTML()
        '=====================================================================
        ' Procedure  Name		:	PlotHTML
        ' Parameters Passed		:	None
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To show Working Options Settings
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   11 DEC 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")


            strGridHTML.Append("<div id='divMainBlock' style='overflow:auto;width:102%;'>")


            'strGridHTML.Append("<div class='h-tabs'>")


            '''''''''''' General Settings'''''''''''''''''

            strGridHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")
            strGridHTML.Append("<div class='pannel-section'>")
            strGridHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
            strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
            strGridHTML.Append("<div class='panel'>")
            strGridHTML.Append("<div class='panel-heading' role='tab' id='panelGeneralSettings'>")
            strGridHTML.Append("<h3 class='clsSections'><span>General Settings</span></h3>")
            strGridHTML.Append("<h4 class='panel-title'>")
            strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' onclick='ShowHideGeneralSettings()' aria-expanded='true' aria-controls='collapseOne3' ><i id='faplusGeneral' class='fa fa-plus toggle-plus'  title='Expand'></i><i id='faminusGeneral' class='fa fa-minus toggle-plus' title='Hide'></i></a>")
            strGridHTML.Append("</h4>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<div id='collapseGeneralSettings' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne' aria-expanded='true' style=''>")

            strGridHTML.Append("<div class='panel-body' id='idPanelBody'> ")


            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Days per Person Month*</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            '<input type='Textbox' name='txtDaysPerPersonMonth' id='txtDaysPerPersonMonth' class='form-control' style='width:54px  ; text-align:left' value=''></div>")
            'strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboInstallationType", "usp_Sel_tbl_PM_CompanyInformation_SMTPServerInstallationType ", 215, "", "", True, True, "form-control ", False, , , 1).ToString.Replace("'", " "))
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDaysPerPersonMonth", "txtDaysPerPersonMonth", "form-control ", , , , , , , , , , "  class='form-control clsDetailsSection' ", returnHTML:=True, EnableHTMLEncode:=True))
            'strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDaysPerPersonMonth", "txtDaysPerPersonMonth", "form-control", 215, , , , , , , , , " class='form-control'   ", returnHTML:=False, EnableHTMLEncode:=True))
            strGridHTML.Append("</div>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Show Password Links</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            strGridHTML.Append("<input type='checkbox' style='width: 12px;outline: none;' name='ChkShowPasswordLinks' id='ChkShowPasswordLinks'>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("<div class='form-group' style=' border-bottom: 1px solid #ebedf2;'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Delete Attachment Physically</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'><input type='checkbox' style='width: 12px;outline: none;' name='ChkDeleteAttachment' id='ChkDeleteAttachment'>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Auto-email Service for Forgot Password  </label>")
            strGridHTML.Append("<div class='col-sm-4' style='display: inline-flex;padding-left: 0px;'><input type='checkbox' style='width: 22px;outline: none; display: inline;' name='ChkAutoemailService' id='ChkAutoemailService'>")
            strGridHTML.Append("<span style=' font-size: 12px;margin-left: 2%;' class='text-justify'>   [Checking/Unchecking this check box will restrict/allow the Auto-email Service for Forgot Password.]</span>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")


            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Enable My Profile Link")
            strGridHTML.Append("</label>")
            strGridHTML.Append("<div class='col-sm-4' style='display: inline-flex;padding-left: 0px;'>")
            strGridHTML.Append("<input type='checkbox' style='width: 33px;outline: none;' name='ChkShowMyProfile' id='ChkShowMyProfile'>")
            strGridHTML.Append("<span style=' font-size: 12px; display: inline;margin-left: 2%;' class='text-justify'>")
            strGridHTML.Append("[Displays 'My profile' link on information line. This link allows user to change his/her details such as address, qualification, certification and skills etc.]</span>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Enable Product Execution</label>")
            strGridHTML.Append("<div class='col-sm-4' style='display: inline-flex;padding-left: 0px;'>")
            strGridHTML.Append("<input type='checkbox' style='width: 14px;outline: none;' name='ChkEnableProductExecution' id='ChkEnableProductExecution'>")
            strGridHTML.Append("<span style=' font-size: 12px; display: inline;margin-left: 2%;' class='text-justify'>")
            strGridHTML.Append("[Enable Production Management for Help Desk and Issues.]</span>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Attach Files to Mail </label>")
            strGridHTML.Append("<div class='col-sm-4' style='display: inline-flex;padding-left: 0px;'>")
            strGridHTML.Append("<input type='checkbox' style='width: 17px;outline: none;' name='ChkAttachFilestoMail' id='ChkAttachFilestoMail'>")
            strGridHTML.Append("<span style=' font-size: 12px;display: inline;margin-left: 2%;' class='text-justify'>")
            strGridHTML.Append("[If this Checkbox is checked, the uploaded files will get attached to the mail] </span>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Save Files Attached to Mail </label>")
            strGridHTML.Append("<div class='col-sm-4' style= 'display: inline-flex;padding-left: 0px;'>")
            strGridHTML.Append("<input type='checkbox' style='width: 21px;outline: none;' name='ChkSaveFilesAttached' id='ChkSaveFilesAttached'>")
            strGridHTML.Append("<span style=' font-size: 12px; margin-left: 2%;' class='text-justify'>")
            strGridHTML.Append("[If this checkbox is checked, any files uploaded externally to the mail will be available in request]</span>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Autoclose Request after</label>")

            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            'strGridHTML.Append("<input type='Textbox' name='txtAutoclose Request' id='txtAutoclose' class='form-control' style='width:54px; text-align:left; display: inline;' value=''>")
            strGridHTML.Append("<div class='input-group'>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAutoclose", "txtAutoclose", "form-control", , , , , , , , , , "  class='form-control clsWidth clsDetailsSection' ", returnHTML:=True, EnableHTMLEncode:=True))
            strGridHTML.Append("<span style='font-size: 12px;display: inline;margin-top: 1%;margin-left: 2%;' class='text-justify'>days<br>")
            strGridHTML.Append("</span>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<span style=' font-size: 12px;display: inline;margin-top: 1%;' class='text-justify'>")
            strGridHTML.Append("[The request in resolved status will be autoclosed after these specified days]</span>")
            strGridHTML.Append("</div>")
            'strGridHTML.Append("</div>")

            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Apply SLA On</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboApplySLAOn", "EXEC usp_NG2_SLAAppliedON ", 200, , "class='form-control'", , True))
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")



            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            '''''''''''' Leave Settings'''''''''''''''''


            '''''''''''' Leave Settings'''''''''''''''''

            strGridHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")
            strGridHTML.Append("<div class='pannel-section'>")
            strGridHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
            strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
            strGridHTML.Append("<div class='panel'>")
            strGridHTML.Append("<div class='panel-heading' role='tab' id='panelLeaveSettings'>")
            strGridHTML.Append("<h3 class='clsSections'><span style='width:50px;'>Leave Settings</span></h3>")
            strGridHTML.Append("<h4 class='panel-title'>")
            strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' onclick='ShowHideLeaveSettings()' aria-expanded='true' aria-controls='collapseOne3'><i id='faplusLeave' class='fa fa-plus toggle-plus' title='Expand'></i><i id='faminusLeave' class='fa fa-minus toggle-plus' title='Hide'></i></a>")
            strGridHTML.Append("</h4>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<div id='collapseLeaveSettings' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne' aria-expanded='true' style=''>")

            strGridHTML.Append("<div class='panel-body' id='idPanelBody'> ")

            strGridHTML.Append("<div class='form-group' style='border-bottom: 1px solid #ebedf2;'>")

            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Is Pro-rata Enabled </label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            strGridHTML.Append("<input type='checkbox' style='width: 12px; display: inline;outline: none;' name='ChkProrataEnabled' id='ChkProrataEnabled'>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            '''''''''''' Leave Settings'''''''''''''''''
            '''''''''''' Mail Server Settings'''''''''''''''''

            strGridHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")
            strGridHTML.Append("<div class='pannel-section'>")
            strGridHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
            strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
            strGridHTML.Append("<div class='panel'>")
            strGridHTML.Append("<div class='panel-heading' role='tab' id='panelMailServerSettings'>")
            strGridHTML.Append("<h3 class='clsSections'><span>Mail Server Settings</span></h3>")
            strGridHTML.Append("<h4 class='panel-title'>")
            strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' onclick='ShowHideMailServerSettings()' aria-expanded='true' aria-controls='collapseOne3'><i id='faplusMailServer' class='fa fa-plus toggle-plus' title='Expand'></i><i id='faminusMailServer' class='fa fa-minus toggle-plus' title='Hide'></i></a>")
            strGridHTML.Append("</h4>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<div id='collapseMailServerSettings' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne' aria-expanded='true' style=''>")

            strGridHTML.Append("<div class='panel-body' id='idPanelBody'> ")




            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>SMTP Server Port*</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            '<input type='Textbox' name='txtSMTPServerPort' id='txtSMTPServerPort' class='form-control' style='width:54px  ; text-align:left' value=''>
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSMTPServerPort", "txtSMTPServerPort", "form-control", , , , , , , , , , "  class='form-control clsWidth clsDetailsSection' ", returnHTML:=True, EnableHTMLEncode:=True))

            strGridHTML.Append("</div>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>SMTP Domain</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            '<input type='Textbox' name='txtSMTPDomain' id='txtSMTPDomain' class='form-control' style='width:54px  ; text-align:left' value=''></div>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSMTPDomain", "txtSMTPDomain", "form-control", , , , , , , , , , "  class='form-control clsDetailsSection' ", returnHTML:=True, EnableHTMLEncode:=True))
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")

            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>SMTP Server Installation Type</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboInstallationType", "usp_Sel_tbl_PM_CompanyInformation_SMTPServerInstallationType ", 200, "", "", True, True, "form-control clsHeight clsDetailsSection", False, , , 1).ToString.Replace("'", " "))
            strGridHTML.Append("</div>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>SMTP User Name</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            '<input type='Textbox' name='txtSMTPUserName' id='txtSMTPUserName' class='form-control' style='width:54px  ; text-align:left' value=''></div>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSMTPUserName", "txtSMTPUserName", "form-control", , , , , , , , , , "  class='form-control clsDetailsSection' ", returnHTML:=True, EnableHTMLEncode:=True))
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>SMTP Server*</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            '<input type='Textbox' name='txtSMTPServer' id='txtSMTPServer' class='form-control' style='width:54px  ; text-align:left' value=''></div>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSMTPServer", "txtSMTPServer", "form-control", , , , , , , , , , "  class='form-control clsDetailsSection' ", returnHTML:=True, EnableHTMLEncode:=True))
            strGridHTML.Append("</div>")

            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>SMTP Password</label>")
            strGridHTML.Append("<div class='col-sm-4' style= 'padding-left: 0px;'>")
            '<input type='Textbox' name='txtSMTPPassword' id='txtSMTPPassword' class='form-control' style='width:54px  ; text-align:left' value=''></div>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSMTPPassword", "txtSMTPPassword", "form-control", , , , , , , , , , "  class='form-control clsDetailsSection' ", returnHTML:=True, EnableHTMLEncode:=True, IsPassword:=True))
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("<div class='form-group'>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Email Format</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboEmailFormat", "usp_Sel_PB_EmailFormat ", 200, "", "", True, True, "form-control clsHeight clsDetailsSection", False, , , 1).ToString.Replace("'", " "))
            strGridHTML.Append("</div>")
            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Use SSL</label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            strGridHTML.Append("<input type='checkbox' style='width: 12px;outline: none;' name='ChkUseSSL' id='ChkUseSSL'>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            '''''''''''' Mail Server Settings'''''''''''''''''

            '''''''''''' Time Zone Settings'''''''''''''''''

            strGridHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")
            strGridHTML.Append("<div class='pannel-section'>")
            strGridHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
            strGridHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
            strGridHTML.Append("<div class='panel'>")
            strGridHTML.Append("<div class='panel-heading' role='tab' id='panelTimeZoneSettings'>")
            strGridHTML.Append("<h3 class='clsSections'><span>Time Zone Settings</span></h3>")
            strGridHTML.Append("<h4 class='panel-title'>")
            strGridHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' onclick='ShowHideTimeZoneSettings()' aria-expanded='true' aria-controls='collapseOne3'><i id='faplusTimeZone' class='fa fa-plus toggle-plus' title='Expand'></i><i id='faminusTimeZone' class='fa fa-minus toggle-plus' title='Hide'></i></a>")
            strGridHTML.Append("</h4>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("<div id='collapseTimeZoneSettings' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne' aria-expanded='true' style=''>")

            strGridHTML.Append("<div class='panel-body' id='idPanelBody'> ")

            strGridHTML.Append("<div class='form-group' style='border-bottom: 1px solid #ebedf2;'>")

            strGridHTML.Append("<label class='control-label col-sm-2' for=' '>Time Zone </label>")
            strGridHTML.Append("<div class='col-sm-4' style = 'padding-left: 0px;'>")
            'strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboZoneGMT", "usp_SEL_tbl_FCI_ZoneGMTSettings ", 300, "", , True, True))
            strGridHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboZoneGMT", "usp_SEL_tbl_FCI_ZoneGMTSettings ", 215, "", "", True, True, "form-control clsHeight clsDetailsSection", False, , , 1).ToString.Replace("'", " "))

            'strGridHTML.Append("<input type='checkbox' style='width: 11px; display: inline;outline: none;' name='ChkAttachment' id='ChkAttachment'>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")

        

            'strGridHTML.Append("</div>")
            'strGridHTML.Append("</div>")
            'strGridHTML.Append("</div>")
            'strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")

            '''''''''''' Time Zone Settings'''''''''''''''''

            'strGridHTML.Append("</div>")
            'h-tabs div


            '/*Changed by yasmin for pagination alignment on 18 july 2018*/

            strGridHTML.Append("<div class='form-group'  style='margin-top: 6px;'><div class='col-sm-12'>")
            strGridHTML.Append("<div class='left'></div>")
            strGridHTML.Append("<div class='right'>")
            If m_objAccess.Edit Then
                strGridHTML.Append("<button type='button'  id='btnSave' style='font-size: 11px;line-height: 10px;color: white!important;' onclick='SaveWorkingOptions()' class='btn btn-default save'>Save</button>")
            End If
            strGridHTML.Append("<button type='button' class='btn btn-default save'  onclick='minimizePanel()' style='border:none;border-left:1px solid;font-size: 11px;line-height: 12px;color: white!important;'>Clear</button>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")
            strGridHTML.Append("</div>")


            strGridHTML.Append("</div>")




            CommonFunctions.General.WriteHTML(strGridHTML.ToString)

        Catch ex As Exception

        End Try
    End Sub
    'ByVal IsAllowNewAttachment As String, ByVal NoofDaysAutoclose As String, ByVal IsProRataEnabled As String, ByVal SMTPServerPort As String, ByVal SMTPDomainName As String, ByVal SMTPServer_InstallationType As String, ByVal SMTPUserName As String, ByVal SMTPServer As String, ByVal SMTPPassword As String, ByVal EmailFormat As String, ByVal IsSSLEnabled As String, ByVal TimeZoneID As String
    Public Class clsWorkingOption
        Public Property CompanyInfoID() As String
            Get
                Return m_CompanyInfoID
            End Get
            Set(value As String)
                m_CompanyInfoID = value
            End Set
        End Property
        Private m_CompanyInfoID As String

        Public Property DaysPerPersonMonth() As String
            Get
                Return m_DaysPerPersonMonth
            End Get
            Set(value As String)
                m_DaysPerPersonMonth = value
            End Set
        End Property
        Private m_DaysPerPersonMonth As String

        Public Property ShowPasswordLinks() As String
            Get
                Return m_ShowPasswordLinks
            End Get
            Set(value As String)
                m_ShowPasswordLinks = value
            End Set
        End Property
        Private m_ShowPasswordLinks As String

        Public Property PhysicalDeletionOfDocuments() As String
            Get
                Return m_PhysicalDeletionOfDocuments
            End Get
            Set(value As String)
                m_PhysicalDeletionOfDocuments = value
            End Set
        End Property
        Private m_PhysicalDeletionOfDocuments As String


        Public Property AutoServiceForPassword() As String
            Get
                Return m_AutoServiceForPassword
            End Get
            Set(value As String)
                m_AutoServiceForPassword = value
            End Set
        End Property
        Private m_AutoServiceForPassword As String


        Public Property ShowMyProfile() As String
            Get
                Return m_ShowMyProfile
            End Get
            Set(value As String)
                m_ShowMyProfile = value
            End Set
        End Property
        Private m_ShowMyProfile As String

        Public Property EnableProductExecution() As String
            Get
                Return m_EnableProductExecution
            End Get
            Set(value As String)
                m_EnableProductExecution = value
            End Set
        End Property
        Private m_EnableProductExecution As String

        Public Property IsAllowExistingAttachment() As String
            Get
                Return m_IsAllowExistingAttachment
            End Get
            Set(value As String)
                m_IsAllowExistingAttachment = value
            End Set
        End Property
        Private m_IsAllowExistingAttachment As String

        Public Property IsAllowNewAttachment() As String
            Get
                Return m_IsAllowNewAttachment
            End Get
            Set(value As String)
                m_IsAllowNewAttachment = value
            End Set
        End Property
        Private m_IsAllowNewAttachment As String


        Public Property NoofDaysAutoclose() As String
            Get
                Return m_NoofDaysAutoclose
            End Get
            Set(value As String)
                m_NoofDaysAutoclose = value
            End Set
        End Property
        Private m_NoofDaysAutoclose As String

        Public Property IsProRataEnabled() As String
            Get
                Return m_IsProRataEnabled
            End Get
            Set(value As String)
                m_IsProRataEnabled = value
            End Set
        End Property
        Private m_IsProRataEnabled As String

        Public Property SMTPServerPort() As String
            Get
                Return m_SMTPServerPort
            End Get
            Set(value As String)
                m_SMTPServerPort = value
            End Set
        End Property
        Private m_SMTPServerPort As String

        Public Property SMTPDomainName() As String
            Get
                Return m_SMTPDomainName
            End Get
            Set(value As String)
                m_SMTPDomainName = value
            End Set
        End Property
        Private m_SMTPDomainName As String

        Public Property SMTPServer_InstallationType() As String
            Get
                Return m_SMTPServer_InstallationType
            End Get
            Set(value As String)
                m_SMTPServer_InstallationType = value
            End Set
        End Property
        Private m_SMTPServer_InstallationType As String


        Public Property SMTPUserName() As String
            Get
                Return m_SMTPUserName
            End Get
            Set(value As String)
                m_SMTPUserName = value
            End Set
        End Property
        Private m_SMTPUserName As String


        Public Property SMTPServer() As String
            Get
                Return m_SMTPServer
            End Get
            Set(value As String)
                m_SMTPServer = value
            End Set
        End Property
        Private m_SMTPServer As String

        Public Property SMTPPassword() As String
            Get
                Return m_SMTPPassword
            End Get
            Set(value As String)
                m_SMTPPassword = value
            End Set
        End Property
        Private m_SMTPPassword As String

        Public Property EmailFormat() As String
            Get
                Return m_EmailFormat
            End Get
            Set(value As String)
                m_EmailFormat = value
            End Set
        End Property
        Private m_EmailFormat As String

        Public Property IsSSLEnabled() As String
            Get
                Return m_IsSSLEnabled
            End Get
            Set(value As String)
                m_IsSSLEnabled = value
            End Set
        End Property
        Private m_IsSSLEnabled As String


        Public Property TimeZoneID() As String
            Get
                Return m_TimeZoneID
            End Get
            Set(value As String)
                m_TimeZoneID = value
            End Set
        End Property
        Private m_TimeZoneID As String

        Public Property SLAAppliedON() As String
            Get
                Return m_SLAAppliedON
            End Get
            Set(value As String)
                m_SLAAppliedON = value
            End Set
        End Property
        Private m_SLAAppliedON As String
    End Class
End Class