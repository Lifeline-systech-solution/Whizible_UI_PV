Imports System.IO
Imports System.IO.Compression
Imports System.Xml
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Linq
Public Class CRM_ApplySLA
    '' Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private WithEvents m_objApplySLAGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objEmployeeGrid As New WebPages.Template.GenericGrid
    Private WithEvents objGrid As WebPages.Template.GenericGrid
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Private m_dsGrid As DataSet
    Protected m_intNoOfRecordInGrid As Int16 = 5
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected m_objAccessRights As WebPages.Security.cAccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface. 
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
    Protected Shared strInputDateFormat As String
#End Region

    Private Property Type_Edit As Boolean

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        m_lngLoginID = CommonFunctions.General.CheckIsNothing(CType(Session("intLOGINID"), Long), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        strUserName = CType(Session("strUserName"), String)
        intUserID = CType(Session("intUserID"), Integer)
        m_intRoleID = CommonFunctions.General.CheckIsNothing(CType(Session("intPostID"), Long), 0)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
        strInputDateFormat = GetInputDateFormat()
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
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")


        strHTML.Append("<div id='ApplySLA' class='tabcontent1 h-type h-form clsSettingstabs'>")
        strHTML.Append(PlotApplySLATabDetails(strWhichGrid, "LoadSLA", "ApplySLA"))
        strHTML.Append("</div>")
        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function

    Public Function PlotApplySLATabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal strFlag As String)
        '=====================================================================
        ' Procedure Name        : PlotApplySLATabDetails()	
        ' Purpose               : To Plot the Apply SLA Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 11 Dec 2017
        ' Revisions             : None
        '=====================================================================
        GetGlobalObject(917)

        Dim strHTML As New StringBuilder("")
        If strGridFlag = "LoadSLA" Then
            strHTML.Append("<div  id='divScrollApplySLA'>")
            strHTML.Append("<div class='type-top-bar top-bar'  id='divApplySLATab' style='display:inline-flex;'>")
            strHTML.Append("<ul class='left'>")

            'strHTML.Append("<li class='left search-bar'>")
            'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
            'strHTML.Append("<input type='text' id='SearchSLA' placeholder='Search in table'>")
            'strHTML.Append("</li>")

            strHTML.Append("<div class='left search-bar'>    ")
            strHTML.Append(" <i class='fa fa-search faSettingSearch' aria-hidden='true'>")
            strHTML.Append("</i> ")
            strHTML.Append("<input type='text' id='SearchSLA' placeholder='Search in table'>")

          
            strHTML.Append("</div>")
            strHTML.Append("</li>")

            strHTML.Append("</ul>")
            strHTML.Append("<div id='divCustomerFilter' class='col-sm-2'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCustomerFilter", "usp_NG2_Sel_Customer", , , "class='form-select clsFormControl' style='width:140px!important'  onchange=GetDepartment()", False, True, , False))
            strHTML.Append("</div>")
            strHTML.Append("<div id='divDepartmentFilter' class='col-sm-2'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartmentFilter", "usp_NG2_Sel_ApplySLA_tbl_PM_DepartmentMaster_Filter", , , "class='form-select clsFormControl' style='width:140px!important'  onchange=GetFilterList()", False, True, , False))
            strHTML.Append("</div>")
            strHTML.Append("<div id='divSLATypeFilter' class='col-sm-2'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTypeFilter", "usp_NG2_Sel_CRM_ApplySLA_Type_Filter", , , "class='form-select clsFormControl'  style='width:140px!important' onchange=GetFilterList()", False, True, , False))
            strHTML.Append("</div>")

            strHTML.Append("<ul class='right'>")
            If m_objAccessRights.Add = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append("<button type='button' style='margin-top: 8px;' onclick='AddApplySLA()' title='Add SLA' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
            End If
            'If m_objAccessRights.Delete = True Then
            '    strHTML.Append("<li class='clearall'>")
            '    strHTML.Append("    <button onclick='DeleteRequestApplySLA()' type='button'  title='Del'  class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
            'End If
            strHTML.Append("</ul>")
            strHTML.Append(" </div>")
            strHTML.Append("<div class='table-responsive' id='divtblApplySLA'>")
            strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag))
            strHTML.Append("</div>")


            strHTML.Append("<div class='container-fluid  tabz '>")
            strHTML.Append("<div id='exTab2' class='container-fluid'> ")
            strHTML.Append("<ul class='nav nav-tabs' id='navApplySLAtabs'>")
            strHTML.Append(" <li class='' id='DivHorizontal'>")
            strHTML.Append(" <a  data-bs-toggle='tab' class='tablinks1 xxx active' style='font-weight: 600;font-size: 13px;color: #000000;'  onclick='OpenTabs(event, ""ApplySLA"")'  >Apply SLA</a>")
            strHTML.Append("</li>")
            strHTML.Append("  <li id='idSLADetailsTab' style='display:none;'><a data-bs-toggle='tab' style='font-weight: 600; font-size: 13px;    color: #000000;'  onclick='OpenTabs(event, ""SLADetails"")'  >SLA Details</a>")
            strHTML.Append("</li>")
            strHTML.Append("  <li id='liConfigureUserTab' style='display:none;'><a data-bs-toggle='tab' style='font-weight: 600; font-size: 13px;    color: #000000;'  onclick='OpenTabs(event, ""ConfigureGropus"")'  >Configure User Group</a>")
            strHTML.Append("</li>")
            strHTML.Append("</ul>")

            strHTML.Append("<div id='divTabs' >")
            If strFlag = "ApplySLA" Then
                strHTML.Append(PlotApplySLATabs(""))
            End If
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")
        Else
            If strFlag = "ApplySLA" Then
                strHTML.Append(PlotApplySLATabs(""))
            ElseIf strFlag = "ConfigureGropus" Then
                strHTML.Append(PlotConfigureUserGroupsTabs("1", ""))
            ElseIf strFlag = "SLADetails" Then
                strHTML.Append(WriteSLAtargetTabGrid("", "", "", ""))
            End If

        End If



        'strHTML.Append("<div class='tab-pane col-sm-12' id='2' >")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='tab-pane' id='3' >")
        'strHTML.Append("</div>")

        Return strHTML.ToString
    End Function
    Public Function PlotApplySLATabs(ByVal SLADetailsID As String)
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = ""
        ''  Dim dtSLADetails As IDataReader
        Dim dtSLADetails As IDataReader
        Dim TemplateID As String = ""
        Dim RequestTypeID As String = ""
        Dim SubRequestTypeID As String = ""
        Dim DepartmentID As String = ""
        Dim CustomerID As String = ""
        Dim SLATemplateID As String = ""
        Dim TimezoneID As String = ""
        Dim SLAEffectiveFrom As String = ""
        Dim SLAAppliedOn As String = ""
        Dim SendAlertApplicable As String = ""
        Dim SendAlertNorm As String = ""
        Dim SendAlertUnit As String = ""
        Dim SendReminderApplicable As String = ""
        Dim SendReminderNorm As String = ""
        Dim SendReminderUnit As String = ""
        Dim EscalationLevel1Applicable As String = ""
        Dim EscalationLevel1Norm As String = ""
        Dim EscalationLevel1Unit As String = ""
        Dim EscalationLevel2Applicable As String = ""
        Dim EscalationLevel2Norm As String = ""
        Dim EscalationLevel2Unit As String = ""
        Dim EscalationLevel3Applicable As String = ""
        Dim EscalationLevel3Norm As String = ""
        Dim EscalationLevel3Unit As String = ""
        Dim EscalationLevel4Applicable As String = ""
        Dim EscalationLevel4Norm As String = ""
        Dim EscalationLevel4Unit As String = ""
        Dim SLAType As String = "C"

        If SLADetailsID = "" Then
            SLADetailsID = "NULL"
        End If
        strSQL = "Exec usp_NG2_Sel_ApplyHelpdeskSLADetails " & SLADetailsID & ""

        ''     dtSLADetails = CommonFunctions.Data.GetDataReader(strSQL, True)
        dtSLADetails = CommonFunctions.Data.GetDataReader(strSQL, True)



        If dtSLADetails.Read() Then
            RequestTypeID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("RequestTypeID").ToString, "")
            SubRequestTypeID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SubRequestTypeID").ToString, "")
            DepartmentID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("DepartmentID").ToString, "")
            CustomerID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("CustomerID").ToString, "")
            SLATemplateID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SLATemplateID").ToString, "")
            TimezoneID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("TimezoneID").ToString, "")
            SLAEffectiveFrom = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SLAEffectiveFrom").ToString, "")
            SendAlertApplicable = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SendAlertApplicable").ToString, "")
            SendAlertNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SendAlertNorm").ToString, "")
            SendAlertUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SendAlertUnit").ToString, "")

            SendReminderApplicable = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SendReminderApplicable").ToString, "")
            SendReminderNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SendReminderNorm").ToString, "")
            SendReminderUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SendReminderUnit").ToString, "")

            EscalationLevel1Applicable = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel1Applicable").ToString, "")
            EscalationLevel1Norm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel1Norm").ToString, "")
            EscalationLevel1Unit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel1Unit").ToString, "")
            EscalationLevel2Applicable = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel2Applicable").ToString, "")
            EscalationLevel2Norm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel2Norm").ToString, "")
            EscalationLevel2Unit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel2Unit").ToString, "")
            EscalationLevel3Applicable = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel3Applicable").ToString, "")
            EscalationLevel3Norm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel3Norm").ToString, "")
            EscalationLevel3Unit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel3Unit").ToString, "")
            'EscalationLevel4Applicable = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel4Applicable").ToString, "")
            'EscalationLevel4Norm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel4Norm").ToString, "")
            'EscalationLevel4Unit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("EscalationLevel4Unit").ToString, "")
            SLATemplateID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SLATemplateID").ToString, "")
            SLAType = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SLAType").ToString, "")
            SLAAppliedOn = CommonFunctions.Data.CheckIsDBNull(dtSLADetails("SLAAppliedOn").ToString, "")
            'End If
        End If

        strHTML.Append("<div class='tab-content container-fluid ' >")
        strHTML.Append(" <div class='tab-pane active' id='1' >")

        ''Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue
        'strHTML.Append(" <div class='type-top-bar' id='EmployeeFilter' style='border-bottom: 1px solid #dddddd;'>")
        strHTML.Append(" <div class='type-top-bar' id='EmployeeFilter' style='border-bottom: 1px solid #dddddd;padding-left: 0px!important;'>")
        ''End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue

        strHTML.Append("<div class='row' style='display:contents;'>")
        strHTML.Append("<div class='col-sm-12 left' style='display:block;'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append(" <div class='col-sm-3'>")
        'If SLATemplateID = "" Then
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTemplateMaster", "usp_NG2_SEL_tbl_NG2_CRM_SLA_templateMaster", , , "class='form-control clsFormControl' onchange=Template_Onchange(this)", False, True, , False))
        'Else
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTemplateMaster", "usp_NG2_SEL_tbl_NG2_CRM_SLA_templateMaster", , SLATemplateID, "class='form-control clsFormControl'   onchange=Template_Onchange(this)", False, True, , False))
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CboTemplateMasterOld", "CboTemplateMasterOld", , , , SLATemplateID, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
        ' End If
        'strHTML.Append("  <input type='hidden' id='hdnSLATemplateID' name='hdnSLATemplateID' value='" & SLATemplateID & "'/>")
        'strHTML.Append("  <input type='hidden' id='hdnSLAAppliedOn' name='hdnSLAAppliedOn' value='" & SLAAppliedOn & "'/>")
        strHTML.Append(" </div> ")

        strHTML.Append("<div class=' col-sm-3'>")
        If SLAAppliedOn = "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboType", "usp_NG2_Sel_CRM_ApplySLA_Type", , , "class='form-control clsFormControl' onchange=Type_Onchange(this)", False, True, , False))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboType", "usp_NG2_Sel_CRM_ApplySLA_Type", , SLAAppliedOn, "class='form-control clsFormControl' disabled onchange=Type_Onchange(this)", False, True, , False))
        End If

        strHTML.Append("  </div>  ")

        strHTML.Append(" <div class='col-sm-6' id='divInternal'>")
        strHTML.Append(" <label class='control-label' id-'lblInternal' for='Internal'>Internal</label>")
        If SubRequestTypeID = "" Then
            strHTML.Append(" <input type='checkbox' id='chkInternal' name='chkInternal' onclick='CheckInternal(this)' value=''>")
        Else
            If SLAType = "C" Then
                strHTML.Append(" <input type='checkbox' id='chkInternal' name='chkInternal' onclick='CheckInternal(this)' disabled value=''>")
            Else
                strHTML.Append(" <input type='checkbox' id='chkInternal' name='chkInternal' onclick='CheckInternal(this)' disabled checked=true value='checked'>")
            End If
        End If


        strHTML.Append(" </div> ")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append(" <div class='type-top-bar' id='EmployeeFilter' >")
        strHTML.Append("<div class='row' style='display:contents;'>")

        ''Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue
        'strHTML.Append("<div class='col-sm-12 left'>")
        strHTML.Append("<div class='col-sm-12 left' style ='padding-left: 0px!important;display:flex;'>")
        ''End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue

        'If CustomerID = "" Then
        '    strHTML.Append("<div class='col-sm-3' id='divCboCustomer'>")
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_NG2_Sel_Customer", , , "class='form-control clsFormControl' onchange=Customer_Onchange(this)", False, True, , False))
        '    strHTML.Append("</div>")
        'Else
        If SLAType = "C" Then
            If CustomerID = "" Then
                strHTML.Append("<div class='col-sm-3 pl-0' id='divCboCustomer'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_NG2_Sel_Customer", , , "class='form-control clsFormControl' onchange=Customer_Onchange(this)", False, True, , False))
                strHTML.Append("</div>")
            Else
                strHTML.Append("<div class='col-sm-3 pl-0' id='divCboCustomer'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_NG2_Sel_Customer", , CustomerID, "class='form-control clsFormControl' disabled onchange=Customer_Onchange(this)", False, True, , False))
                strHTML.Append("</div>")
            End If
        Else
            strHTML.Append("<div class='col-sm-3 pl-0' id='divCboCustomer' style='display:none'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboCustomer", "usp_NG2_Sel_Customer", , , "class='form-control clsFormControl'  onchange=Customer_Onchange(this)", False, True, , False))
            strHTML.Append("</div>")
        End If



        ''strSQL = "Exec usp_NG2_Sel_ApplySLA_tbl_PM_DepartmentMaster " & CustomerID & ""

        ''Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue
        'strHTML.Append("  <div class='col-sm-3 ' style=''>")
        strHTML.Append("  <div class='col-sm-3 ' style='padding-left: 2px!important;'>")
        ''End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue

        If DepartmentID <> "" Then
            If CustomerID = "" Then
                CustomerID = "NULL"
            End If
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_NG2_Sel_ApplySLA_tbl_PM_DepartmentMaster " & CustomerID & "", , DepartmentID, "class='form-control clsFormControl'  disabled onchange=Department_Onchange(this)", False, True, , False))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "Select 'Select Department'", , , "class='form-control clsFormControl'  onchange=Department_Onchange(this)", False, True, , False))
        End If

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-3 ' style='padding-left: 10px;'>")
        If RequestTypeID <> "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", "usp_NG2_Sel_RequestTypes  " & DepartmentID & "," & CustomerID & "", , RequestTypeID, "class='form-control clsFormControl'  disabled onchange=RequestType_Onchange(this)", False, True, , False))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", "select 'Select Request Type'", , , "class='form-control clsFormControl'  onchange=RequestType_Onchange(this)", False, True, , False))
        End If
        strHTML.Append("  </div>")
        strHTML.Append("<div class='col-sm-3 ' style='padding-left: 10px;'>")
        If SubRequestTypeID <> "" Then
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", "usp_NG2_Sel_SubRequestTypes " & RequestTypeID & "," & CustomerID & "," & SubRequestTypeID & "," & SLADetailsID & "," & DepartmentID & ",'" & SLAAppliedOn & "'", , SubRequestTypeID, "class='form-control clsFormControl'  disabled onchange=SubRequestType_Onchange(this)", False, True, , False))
        Else
            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", "select 'Select Sub Request Type'", , SubRequestTypeID, "class='form-control clsFormControl'  disbaled onchange=SubRequestType_Onchange(this)", False, True, , False))
        End If

        strHTML.Append("</div>")

        strHTML.Append(" </div>")

        strHTML.Append("</div>")
        strHTML.Append(" </div>")

        strHTML.Append("<div class='type-top-bar' id='EmployeeFilter' >")
        strHTML.Append(" <div class='row'>")

        ''Commented And Added By Usha Pandit On 24.06.2019 For Alignment Issue
        'strHTML.Append("<div class='col-sm-12 left'>")
        strHTML.Append("<div class='col-sm-12 left' style = 'padding-left: 0px!important;display:flex;'>")
        ''End Of Added By Usha Pandit On 24.06.2019 For Alignment Issue

        strHTML.Append("<div class=' col-sm-3'>")


        '' If TimezoneID = "" And (SLADetailsID = "NULL" Or SLADetailsID = "0") Then
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , , "class='form-control clsFormControl'", False, True, , False))
        'ElseIf SLADetailsID <> "NULL" And TimezoneID = "" Then
        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimezoneID, "class='form-control clsFormControl' disabled ", False, True, , False))
        'Else

        '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboTimeZone", "usp_sel_tbl_FCI_GMTZones", , TimezoneID, "class='form-control clsFormControl' disabled ", False, True, , False))
        'End If

        strHTML.Append("  </div>  ")

        strHTML.Append("<div class=' col-sm-9' style='/* float: left; */'>")

        strHTML.Append("<div class='form-group' style='display:flex;'>")

        strHTML.Append("  <div class='col-sm-5' style='font-size: 14px'>")
        strHTML.Append("   <label class='col-sm-12' id='idEffeciveDate' style='font-weight: 600; '>SLA Effective From(Default Now):   </label>")
        strHTML.Append("</div>")
        'Added By Dipali V On 24th June 2019 For Date Formate Issue
        Dim strInputDateFormat As String = GetInputDateFormat()
        strInputDateFormat = strInputDateFormat.Replace("D", "d")
        strInputDateFormat = strInputDateFormat.Replace("Y", "y")
        Dim strDate As String = Date.Now.ToString(strInputDateFormat, System.Globalization.CultureInfo.InvariantCulture)
        strInputDateFormat = strInputDateFormat.Replace("M", "m")
        strInputDateFormat = strInputDateFormat.Replace("yyyy", "yy")

        strHTML.Append("<div class='col-sm-5' style='display: inline-flex; margin-left: -34px;'>")
        If SLAEffectiveFrom = "" Then
            'Commented and Added by Usha Pandit on 09 JAN 2018 for giving place holder
            'strHTML.Append("<div class='col-sm-5' style=''><input type='text' value='' title='SLA Effective From' class='form-control inp' id='dtEffectivedate' placeholder=''>")
            strHTML.Append("<div class='' style=''><input type='text' value=''  class='form-control inp' id='dtEffectivedate' placeholder='SLA Effective From'>")
            'End of Commented and Added by Usha Pandit on 09 JAN 2018 for giving place holder

            strHTML.Append("</div>")
            'strHTML.Append("<div class='' ><i class='fa fa-calendar fcal' id='idCalender' style='font-size: 14px; margin-right: 10px;' onclick=""$('#dtEffectivedate').datepicker();$('#dtEffectivedate').datepicker('show');""></i>")
            strHTML.Append("<div class='' ><i class='fa fa-calendar' id='idCalender'  style='font-size: 14px; margin-right: 10px;'  onclick=""$('#dtEffectivedate').datepicker({minDate: 0, dateFormat:'" & strInputDateFormat & "'});$('#dtEffectivedate').datepicker('show');""></i>")
            strHTML.Append("</div>")

        Else
            strHTML.Append("<div class='' style=''><input type='text'  value='" & SLAEffectiveFrom & "' class='form-control inp' disabled id='dtEffectivedate' placeholder=''>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='' ><i class='fa fa-calendar fcal' id='idCalender' style='font-size: 14px; margin-right: 10px;' disabled ></i>")
            strHTML.Append("</div>")
        End If
        'End of Added By Dipali V On 24th June 2019 For Date Formate Issue
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='panel-heading' id='AlertSection' style='margin-top: -10px;   background-color: #cbddfa;  height: 23px; '>")
        strHTML.Append(" <span class='fs' style='font-weight: 600'>Configure Alerts and Escalation</span>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div class='' id='DivAlertSettings' >")
        strHTML.Append(" <div class='col-sm-12 marg' >")
        strHTML.Append("<div class='col-sm-3 clsControl'>")
        Dim Style1 As String = "disabled"
        strHTML.Append(" <div class='row'>")
        If SendReminderApplicable = "True" Then
            strHTML.Append("<input type='checkbox' id='chkSendReminder' name='chkSendReminder' onclick=""CheckAlert(this,'SendReminder')""  checked=true value='Checked'>")
            Style1 = ""
        Else
            strHTML.Append("<input type='checkbox' id='chkSendReminder' name='chkSendReminder' onclick=""CheckAlert(this,'SendReminder')""  value=''>")
        End If

        strHTML.Append(" <label class='control-label col-sm-10' for='Send Reminder'>Send Reminder</label>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append("<div class='form-group' >")
        strHTML.Append("  <div class='form-group'><div class='col-sm-2'>")
        '  strHTML.Append("<input type='Textbox' name='txtSendReminder' id='txtSendReminder' class='form-control inp clsTxtControls' style='text-align:left' value=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSendReminder", "txtSendReminder", "form-control", , , SendReminderNorm, , , , , , , " class='form-control inp clsTxtControls' style='text-align:left'   placeholder='Norm'  " & Style1 & " ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 clsCboCotrols'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSendReminder", "usp_NG2_Sel_CRM_UnitCombo", , SendReminderUnit, "class='form-control clscboControls clscbo' " & Style1 & "", False, True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4 clsControl'>")
        strHTML.Append("<p style='font-size: 13px;font-weight: normal !important;' for='Before SLA Target'>Before SLA Target </p>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("  </div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append(" <div class='col-sm-12 marg' >")
        strHTML.Append("<div class='col-sm-3 clsControl'>")
        strHTML.Append(" <div class='row'>")
        Dim Style2 As String = "disabled"
        If SendAlertApplicable = "True" Then
            strHTML.Append(" <input type='checkbox' id='chkSendAlert' name='chkSendAlert' checked=true onclick=""CheckAlert(this,'SendAlert')"" value='Checked'>")
            Style2 = ""
        Else
            strHTML.Append(" <input type='checkbox' id='chkSendAlert' name='chkSendAlert' onclick=""CheckAlert(this,'SendAlert')"" value=''>")
        End If

        strHTML.Append(" <label class='control-label col-sm-10' for='Send Alert'>Send Alert</label>")
        strHTML.Append("  </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append("  <div class='form-group' style>")
        strHTML.Append("  <div class='form-group'><div class='col-sm-2'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSendAlert", "txtSendAlert", "form-control", , , SendAlertNorm, , , , , , , " " & Style2 & " class='form-control inp clsTxtControls' style='text-align:left'   placeholder='Norm'  ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 clsCboCotrols'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSendAlert", "usp_NG2_Sel_CRM_UnitCombo", , SendAlertUnit, " " & Style2 & " class='form-control clscboControls clscbo' ", False, True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4 clsControl'>")
        strHTML.Append("<p style='font-size: 13px; font-weight: normal !important;' for='Before SLA Target'>After SLA Target </p>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("   </div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-12 marg'>")
        strHTML.Append("<div class='col-sm-3 clsControl'>")

        strHTML.Append(" <div class='row'>")
        Dim Style3 As String = "disabled"
        If EscalationLevel1Applicable = "True" Then
            strHTML.Append(" <input type='checkbox' id='ChkEscalateLevel1' name='ChkEscalateLevel1'   onclick=""CheckAlert(this,'Escalation1')"" checked=true value='Checked'>")
            Style3 = ""
        Else
            strHTML.Append(" <input type='checkbox' id='ChkEscalateLevel1' name='ChkEscalateLevel1'  onclick=""CheckAlert(this,'Escalation1')"" value=''>")
        End If

        strHTML.Append("<label class='control-label col-sm-10' for='Escalation Level 1'>Escalation Level 1</label>")

        strHTML.Append("  </div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append(" <div class='form-group' style=''>")
        strHTML.Append("   <div class='form-group'><div class='col-sm-2'>")
        ' strHTML.Append(" <input type='Textbox' name='txtEscalateLevel1' id='txtEscalateLevel1' class='form-control inp clsTxtControls' style='text-align:left' value=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEscalateLevel1", "txtEscalateLevel1", "form-control", , , EscalationLevel1Norm, , , , , , , " class='form-control inp clsTxtControls' " & Style3 & " style='text-align:left'  placeholder='Norm'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 clsCboCotrols' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEscalateLevel1", "usp_NG2_Sel_CRM_UnitCombo", , EscalationLevel1Unit, "class='form-control clscboControls clscbo' " & Style3 & "", False, True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4 clsControl'>")
        strHTML.Append(" <label class='control-label' style='font-size: 13px;font-weight: normal !important;' for='After SLA Target'>After SLA Target</label>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-12 marg'>")
        strHTML.Append("<div class='col-sm-3 clsControl'>")

        strHTML.Append("<div class='row'>")
        Dim Style4 As String = "disabled"
        If EscalationLevel2Applicable = "True" Then
            strHTML.Append(" <input type='checkbox' id='ChkEscalateLevel2' name='ChkEscalateLevel2'  onclick=""CheckAlert(this,'Escalation2')"" checked=true value='Checked'>")
            Style4 = ""
        Else
            strHTML.Append(" <input type='checkbox' id='ChkEscalateLevel2' name='ChkEscalateLevel2'  onclick=""CheckAlert(this,'Escalation2')"" value=''>")
        End If

        strHTML.Append("   <label class='control-label col-sm-10' for='request type'>Escalation Level 2</label>")

        strHTML.Append("</div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append("<div class='form-group' >")
        strHTML.Append("   <div class='form-group'><div class='col-sm-2'>")
        '   strHTML.Append("<input type='Textbox' name='txtEscalateLevel2' id='txtEscalateLevel2' class='form-control inp clsTxtControls' style='text-align:left' value=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEscalateLevel2", "txtEscalateLevel2", "form-control", , , EscalationLevel2Norm, , , , , , , " class='form-control inp clsTxtControls' " & Style4 & " style='text-align:left'    placeholder='Norm' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 clsCboCotrols'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEscalateLevel2", "usp_NG2_Sel_CRM_UnitCombo", , EscalationLevel2Unit, "class='form-control clscboControls clscbo' " & Style4 & "", False, True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4 clsControl'>")
        strHTML.Append(" <p style='font-size: 13px;font-weight: normal !important;' for='After SLA Target'>After SLA Target </p>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("   </div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>")
        strHTML.Append("  <div class='col-sm-12 marg'>")
        strHTML.Append("<div class='col-sm-3 clsControl'>")

        strHTML.Append("   <div class='row'>")
        Dim Style5 As String = "disabled"
        If EscalationLevel3Applicable = "True" Then
            strHTML.Append(" <input type='checkbox' id='EscalateLevel3' name='EscalateLevel3'  onclick=""CheckAlert(this,'Escalation3')"" checked=true value='Checked'>")
            Style5 = ""
        Else
            strHTML.Append(" <input type='checkbox' id='EscalateLevel3' name='EscalateLevel3'  onclick=""CheckAlert(this,'Escalation3')"" value=''>")
        End If

        strHTML.Append(" <label class='control-label col-sm-10' for='Escalete Level 3'>Escalation Level 3</label>")

        strHTML.Append("   </div>")

        strHTML.Append("</div>")

        strHTML.Append("<div class='col-sm-9'>")
        strHTML.Append("<div class='form-group' >")
        strHTML.Append("<div class='form-group'><div class='col-sm-2'>")
        ' strHTML.Append("<input type='Textbox' name='txtEscalateLevel3' id='txtEscalateLevel3' class='form-control inp clsTxtControls' style='text-align:left' value=''>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtEscalateLevel3", "txtEscalateLevel3", "form-control", , , EscalationLevel3Norm, , , , , , , " class='form-control inp clsTxtControls' " & Style5 & " style='text-align:left' placeholder='Norm'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-3 clsCboCotrols'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboEscalateLevel3", "usp_NG2_Sel_CRM_UnitCombo", , EscalationLevel3Unit, "class='form-control clscboControls clscbo' " & Style5 & "", False, True))
        strHTML.Append("</div>")
        strHTML.Append("<div class='col-sm-4 clsCoSntrol'>")
        strHTML.Append(" <p style='font-size: 13px; font-weight: normal !important;' for='After SLA Target'>After SLA Target </p>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")


        strHTML.Append("  </div>")
        strHTML.Append("</div>")

        strHTML.Append("</div>  ")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '''''''''Escalation Level 4
        'strHTML.Append("<div class='col-sm-12 marg'>")
        'strHTML.Append("<div class='col-sm-3 clsControl'>")
        'strHTML.Append("<div class='row'>")
        'If EscalationLevel4Applicable = "True" Then
        '    strHTML.Append("<input type='checkbox' id='ChkEscalateLevel4' name='ChkEscalateLevel4' checked=true value='Checked'>")
        'Else
        '    strHTML.Append("<input type='checkbox' id='ChkEscalateLevel4' name='ChkEscalateLevel4' value=''>")
        'End If

        'strHTML.Append("<label class='control-label col-sm-10' for='Escalete Level 4'>Escalete Level 4</label>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-9'>")
        'strHTML.Append("<div class='form-group' >")
        'strHTML.Append("<div class='form-group'><div class='col-sm-2'>")
        ' ''strHTML.Append("<input type='Textbox' name='txtChkEscalateLevel4' id='txtChkEscalateLevel4' class='form-control inp clsTxtControls' style='text-align:left' value=''>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtChkEscalateLevel4", "txtChkEscalateLevel4", "form-control", , , EscalationLevel4Norm, , , , , , , " class='form-control inp clsTxtControls' style='text-align:left'    ", returnHTML:=True, EnableHTMLEncode:=True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-3 clsCboCotrols'>")
        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboChkEscalateLevel4", "usp_NG2_Sel_CRM_UnitCombo", , EscalationLevel4Unit, "class='form-control clscboControls clscbo' ", False, True))
        'strHTML.Append("</div>")
        'strHTML.Append("<div class='col-sm-4 clsControl'>")
        'strHTML.Append("<label class='control-label ' style='font-size: 13px;font-weight: normal !important;' for='After SLA Target'>After SLA Target</label>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '/*Changed By Yasmin on 25th july 2018*/
        '/*Changed By Yasmin on 27th july 2018*/
        strHTML.Append("</div>")
        '' data-bs-toggle='modal' data-bs-target='#myLogOut'
        strHTML.Append("<span><div class='form-group' style=' padding-top: 10px ;    border-top: 1px solid #ccc'> <div class='right'><button type='button' class='btn btn-default save '   onclick='ApplySLA()'  style=' border:1px solid #ccc !important;'>Save</button><button style='margin-left: 5px; border:1px solid #ccc !important;' type='button' class='btn btn-default save ' onclick='Cancel_ApplySLA()' >Cancel</button></div></div></span>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function WriteSLAtargetTabGrid(ByVal SLADetailsID As String, ByVal SLAType As String, ByVal SLATypeID As String, ByVal SLATemplateID As String) As String
        Dim strGridHTML As New StringBuilder("")
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String
        ''  str_RequestTypeID = SLATemplateID
        Dim dtSLADetails As DataTable
        Dim TypeName As String = ""
        Dim TypeNameID As String = ""
        intNoOfDataColumn = 8
        Dim drSLADetails As DataTable
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = ""
        Dim Counter As Integer = 0
        Dim SLATypeIDSelect As Integer = 0

        Dim AcknowlwdgeWithinNorm As String = ""
        Dim AcknowlwdgeWithinUnit As String = ""
        Dim ResolveWithinNorm As String = ""
        Dim ResolveWithinUnit As String = ""
        Dim ResponseWithinNorm As String = ""
        Dim ResponseWithinUnit As String = ""
        Dim CloseWithinNorm As String = ""
        Dim CloseWithinUnit As String = ""
        Dim EscalationEmail As String = ""
        Dim ConsiderWorkHrs As String = ""
        Dim ExcludeHoldPeriod As String = ""
        Dim Flag As Integer = 0
        Dim CountRows As Integer = 0
        '  Dim SLADetailsID As String
        Dim FieldDictionary As New System.Collections.Specialized.StringDictionary
        Dim FieldCaptionDictionary As New System.Collections.Specialized.StringDictionary
        strDivID = "DivHelpDeskSLADetails"
        If SLATemplateID = "" Then
            SLATemplateID = "NULL"
        End If

        If SLAType = "Priority" Then
            SLATypeIDSelect = 1
            ' SLAType = "Priority"
        End If

        If SLAType = "Severity" Then
            ' SLAType = "Severity"
            SLATypeIDSelect = 2
        End If
        'If SLAType = "1" Then
        '    ' SLAType = "Priority"
        '    SLATypeIDSelect = 1
        'End If

        If SLATypeID = "" Then
            SLATypeID = ""
        End If

        strSQLQuery = "usp_NG2_Sel_CRM_PriorityOrSeveritySLA '" & SLAType & "'"

        drSLADetails = CommonFunction.Data.GetDataTable(strSQLQuery, True)


        strHTML.Append("<div class='table-responsive' id='tblTypeSLADetails'>  ")
        strHTML.Append(" <table class='table'>")
        strHTML.Append("<thead class='clsTRColumnHeader'>")
        strHTML.Append(" <tr>")
        strHTML.Append("<th id='idSLAType'>" & SLAType & "</th>")
        strHTML.Append("<th style='text-align:center'>Acknowledge Within</th>")
        strHTML.Append("<th style='text-align:center'>Respond Within</th>")
        strHTML.Append("<th style='text-align:center'>Resolve Within</th>")
        strHTML.Append("<th style='text-align:center'>Close Within</th>")
        strHTML.Append("<th style='text-align:center'>Escalation Email</th>")
        strHTML.Append("<th style='text-align:center'>Consider Work Hours</th>")
        strHTML.Append("<th style='text-align:center'>Exclude Hold Period</th>")
        strHTML.Append(" </tr>")
        strHTML.Append("</thead>")
        strHTML.Append("<tbody>")


        'For i As Integer = 0 To drSLADetails.Rows.Count - 1
        '    If SLAType.ToUpper = "PRIORITY" Then
        '        TypeName = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("Priority"), ""), String)
        '        TypeNameID = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("PriorityID"), "0"), String)
        '    ElseIf SLAType.ToUpper = "SEVERITY" Then
        '        TypeName = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("Severity"), ""), String)
        '        TypeNameID = CType(CommonFunctions.General.CheckIsNothing(drSLADetails.Rows(i)("SeverityID"), "0"), String)
        '    End If

        'For i As Integer = 0 To dtSLADetails.Rows.Count - 1
        ''Flag = 1

        ' strSQL = "Exec usp_NG2_tbl_NG2_CRM_SLA_Details " & SLATemplateID & ",'" & SLAType & "'"

        strSQL = "Exec usp_NG2_sel_SLADetails_Templatewise_Details " & SLATemplateID & ",'" & SLAType & "'," & SLADetailsID & ""

        dtSLADetails = CommonFunctions.Data.GetDataTable(strSQL, True)

        Flag = 0
        '  CountRows = 1

        For i As Integer = 0 To dtSLADetails.Rows.Count - 1
            ''If dtSLADetails.Rows.Count - 1 > 0 And Flag = 0 Then
            ' If dtSLADetails.Rows(i)("Priority").ToString = FieldDictionary.Item(drSLADetails.Rows(i)("PriorityID").ToString) Then
            Flag = 1

            TypeName = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("Priority").ToString, "")
            TypeNameID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("PriorityID").ToString, "")
            AcknowlwdgeWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("AckNorm").ToString, "")
            AcknowlwdgeWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("AckUnit").ToString, "")
            ResolveWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ResNorm").ToString, "")
            ResolveWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ResUnit").ToString, "")
            ResponseWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("RespNorm").ToString, "")
            ResponseWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("RespUnit").ToString, "")
            CloseWithinNorm = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("CloseNorm").ToString, "")
            CloseWithinUnit = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("CloseUnit").ToString, "")
            EscalationEmail = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("EscalationEmail").ToString, "")
            ConsiderWorkHrs = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ConsiderWorkHrs").ToString, "")
            ExcludeHoldPeriod = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("ExcludeHoldPeriod").ToString, "")
            ' SLADetailsID = CommonFunctions.Data.CheckIsDBNull(dtSLADetails.Rows(i)("SLADetailsID").ToString, "")
            'End If
            Dim strDisabled As String = ""
            ''Added By Usha Pandit On 22.07.2019 For Norm Validation
            If AcknowlwdgeWithinNorm = "0.00" Or AcknowlwdgeWithinNorm = "0" Then
                AcknowlwdgeWithinNorm = ""
            End If
            If ResolveWithinNorm = "0.00" Or ResolveWithinNorm = "0" Then
                ResolveWithinNorm = ""
            End If
            If ResponseWithinNorm = "0.00" Or ResponseWithinNorm = "0" Then
                ResponseWithinNorm = ""
            End If
            If CloseWithinNorm = "0.00" Or CloseWithinNorm = "0" Then
                CloseWithinNorm = ""
            End If
            ''End Of Added By Usha Pandit On 22.07.2019 For Norm Validation
            If AcknowlwdgeWithinNorm = "" And ResolveWithinNorm = "" And ResponseWithinNorm = "" And CloseWithinNorm = "" Then
                strDisabled = "disabled"
            End If

            If SLADetailsID = "" Then
                SLADetailsID = "0"
            End If
            Dim strTypenameSubString As String = ""
            If TypeName.Length > 20 Then
                strTypenameSubString = TypeName.Substring(0, 20) & "..."
            Else
                strTypenameSubString = TypeName
            End If

            strHTML.Append("<tr>")
            strHTML.Append("<Input type='hidden' name='hdnCountType' id='hdnCountType'   value='" & Counter & "' />")
            strHTML.Append("<Input type='hidden' name='hdnDetailsID' id='hdnDetailsID " & SLATypeIDSelect & "_" & Counter & "'   value='" & SLADetailsID & "' />")
            strHTML.Append("<td><label data-bs-toggle='tooltip' title='" & TypeName & "' style='word-break: break-all;font-weight:normal'>" & strTypenameSubString & "</label><Input type='hidden' name='hdnTypeNameID' id='hdnTypeNameID_" & SLATypeIDSelect & "_" & Counter & "'   value='" & TypeNameID & "' /></TD>")

            'Commented And Added By Usha Pandit On 03.07.2019 For enabling Escalation Email chkbox on Norm set

            'strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtAkNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtAkNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , AcknowlwdgeWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_1'  placeholder='Norm'", True, EnableHTMLEncode:=True) & "</div>")
            'strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboAkUnit_" & SLATypeIDSelect & "_" & Counter & "" & "", "usp_NG2_Sel_CRM_UnitCombo", , AcknowlwdgeWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_1' ", False, True) & "</div></div></td>")

            'strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtResNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtResNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , ResponseWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_2'  placeholder='Norm'", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            'strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboResUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , ResponseWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_2' ", False, True) & "</div></div></td>")

            'strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtResolveNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtResolveNorm_" & SLATypeIDSelect & "_" & Counter, "form-control clsTxtControls", , , ResolveWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_3' placeholder='Norm'", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            'strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboResolveUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , ResolveWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_3' ", False, True) & "</div></div></td>")


            'strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtcloseNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtcloseNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , CloseWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_4'   placeholder='Norm'", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            'strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CbocloseUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , CloseWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_4'", False, True) & "</div></div></td>")

            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtAkNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtAkNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , AcknowlwdgeWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_1'  placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboAkUnit_" & SLATypeIDSelect & "_" & Counter & "" & "", "usp_NG2_Sel_CRM_UnitCombo", , AcknowlwdgeWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_1' ", False, True) & "</div></div></td>")

            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtResNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtResNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , ResponseWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_2'  placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboResUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , ResponseWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_2' ", False, True) & "</div></div></td>")

            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtResolveNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtResolveNorm_" & SLATypeIDSelect & "_" & Counter, "form-control clsTxtControls", , , ResolveWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_3' placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CboResolveUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , ResolveWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_3' ", False, True) & "</div></div></td>")


            strHTML.Append("<td style='text-align:center'><div class='form-group'><div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawTextBox("txtcloseNorm_" & SLATypeIDSelect & "_" & Counter & "", "txtcloseNorm_" & SLATypeIDSelect & "_" & Counter & "", "form-control clsTxtControls", , , CloseWithinNorm, , , , , , , "  class='form-control clsTextBox_" & SLATypeIDSelect & "_" & Counter & "_4'   placeholder='Norm' onkeyup=EnableControls(this," & SLATypeIDSelect & "," & Counter & ")", returnHTML:=True, EnableHTMLEncode:=True) & "</div>")
            strHTML.Append("<div class='col-sm-4'>" & CommonFunctions.HTMLControls.DrawComboBox("CbocloseUnit_" & SLATypeIDSelect & "_" & Counter & "", "usp_NG2_Sel_CRM_UnitCombo", , CloseWithinUnit, "class='form-control clscboControls clscbo_" & SLATypeIDSelect & "_" & Counter & "_4'", False, True) & "</div></div></td>")

            'End Of Added By Usha Pandit On 03.07.2019 For enabling Escalation Email chkbox on Norm set

            If EscalationEmail = "True" Then
                strHTML.Append("<td style='text-align:center' title='Escalation Email'> <Input type='checkbox' name='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' id='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & EscalationEmail & "'   checked " & strDisabled & "/></TD>")
            Else
                strHTML.Append("<td style='text-align:center' title='Escalation Email'> <Input type='checkbox' name='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' id='chkEsc_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & EscalationEmail & "'  " & strDisabled & "/></TD>")
            End If
            If ConsiderWorkHrs = "True" Then
                strHTML.Append("<td style='text-align:center' title='Consider Work Hours'> <Input type='checkbox' name='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' id='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & ConsiderWorkHrs & "'  checked  " & strDisabled & "/></TD>")
            Else
                strHTML.Append("<td style='text-align:center' title='Consider Work Hours'> <Input type='checkbox' name='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' id='chkWrkhrs_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox' value='" & ConsiderWorkHrs & "'  " & strDisabled & " /></TD>")
            End If
            If ExcludeHoldPeriod = "True" Then
                strHTML.Append("<td style='text-align:center' title='Exclude Hold Period'> <Input type='checkbox' name='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' id='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox'   value='" & ExcludeHoldPeriod & "' checked " & strDisabled & "/></TD>")
            Else
                strHTML.Append("<td style='text-align:center' title='Exclude Hold Period'> <Input type='checkbox' name='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' id='chkEHoldP_" & SLATypeIDSelect & "_" & Counter & "' class='clsCheckBox'  value='" & ExcludeHoldPeriod & "'  " & strDisabled & "/></TD>")
            End If
            strHTML.Append("</tr>")


            Counter += 1

        Next

        ' Next
        strHTML.Append("</tbody>")
        strHTML.Append("</table>")

        strHTML.Append("</div>")
        strHTML.Append(" <form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        'col-sm-offset-9 col-sm-3
        strHTML.Append(" <div class='right'>")

        strHTML.Append("<button type='button' class='btn btn-default save' onclick='SaveHelpDeskSLA()'>Save</button>")
        strHTML.Append("<button type='button' class='btn btn-default save' id='idCancel'  onclick='Cancel_HelpDeskSLA()'>Cancel</button>")

        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")

        Return strHTML.ToString
    End Function

    Protected Function WriteSubRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String) As String
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

        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid))

        If (strGridFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function
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
        ' Created               :	1 Nov  2016
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

    Private Sub m_objApplySLAGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objApplySLAGrid.ColumnHeaderTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        'End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteMultiple_Priority()' type=checkbox id=chkAllDeletePriority name=chkAllDeletePriority /></th>"
        End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center;'>Edit</th>"
        End If

    End Sub
    Private Sub m_objApplySLAGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objApplySLAGrid.DataRowTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td><input type=checkbox name='chkPrioritySelect' title='select' /></td>"
        'End If

        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True

            'If m_strSeverityID = Args.DataReader("PriorityID") Then
            Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Edit SLA Details'><button type='button' class='edit-bt'  id=chkSLASelect name=chkSLASelect onclick=""EditApplySLADetails(this," & Args.DataReader("SLAID") & "," & Args.DataReader("SLATemplateID") & ",'" & Args.DataReader("SLAAppliedOn") & "')"" value=" & Args.DataReader("SLAID") & " ><i class='far fa-edit' aria-hidden='true'></i></button>" + "</TD>"
            'Else
            ' Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Edit'><button type='button' class='edit-bt' data-bs-toggle='tooltip' id=chkPrioritySelect name=chkPrioritySelect onclick='EditRequestPriority(this," & Args.DataReader("PriorityID") & ")' value=" & Args.DataReader("PriorityID") & " ><i class='far fa-edit' aria-hidden='true'></i></button>" + "</TD>"
            'End If
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            'm_strCanPriorityDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_Priority " & Args.DataReader("PriorityID"), True), "0")

            'If m_strCanPriorityDelete = "0" Then
            '    Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Delete'><input type=checkbox id=chkPriorityDelete name=chkPriorityDelete  value=" & Args.DataReader("PriorityID") & " >" + "</TD>"
            'Else
            Args.StringToBeInserted = "<td style='text-align:center;'' Title='Delete'><input type=checkbox id=chkPriorityDelete name=chkPriorityDelete disabled value=''>" + "</TD>"
            ' End If
        End If
    End Sub

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
            Dim objSetting As New CRM_ApplySLA()
            strGridHTML.Append(objSetting.PlotApplySLATabDetails(GridParameter("cityName"), "AJAXRefresh", "ApplySLA"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
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
            Dim objSetting As New CRM_ApplySLA()

            strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh"))



            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    ''Public Shared Function SaveApplySLA(ByVal CboTemplateMaster As String ,ByVal CboCustomer As String,ByVal CboDepartment As String, ByVal CboRequestType As String,ByVal CboSubRequestType As String ,ByVal dtEffectivedate As String ,ByVal IsInternal As String,
    <System.Web.Services.WebMethod>
    Public Shared Function SaveApplySLA(ByVal ApplySLAData As Object) As String
        '==================================================================
        ' Procedure  Name		:	SaveApplySLA
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Request Priority
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   10 Nov 2017
        '=====================================================================

        ' Dim RequestID As String = ApplySLAData(0)("RequestID")
        Try
            Dim CboTemplateMaster As String
            Dim CboCustomer As String
            Dim CboDepartment As String
            Dim CboRequestType As String
            Dim CboSubRequestType As String
            Dim dtEffectivedate As String
            Dim IsInternal As String
            Dim IsSendAlert As String
            Dim IsSendReminder As String
            Dim SendReminderNorm As String
            Dim SendReminderUnit As String
            Dim SendAlertUnit As String
            Dim IsEscalateLevel1 As String
            Dim EscalateLevel1Norm As String
            Dim IsEscalateLevel2 As String
            Dim EscalateLevel1Unit As String
            Dim EscalateLevel2Norm As String
            Dim EscalateLevel2Unit As String
            Dim IsEscalateLevel3 As String
            Dim EscalateLevel3Norm As String
            Dim EscalateLevel3Unit As String
            Dim IsEscalateLevel4 As String
            Dim EscalateLevel4Norm As String
            Dim EscalateLevel4Unit As String
            Dim SendAlertNorm As String
            Dim TimeZone As String
            Dim SLAID As String
            Dim Type As String
            Dim Confirm As String
            Dim OldTempalteID As String
            CboTemplateMaster = ApplySLAData(0)("CboTemplateMaster")
            CboCustomer = ApplySLAData(0)("CboCustomer")
            CboDepartment = ApplySLAData(0)("CboDepartment")
            CboRequestType = ApplySLAData(0)("CboRequestType")
            CboSubRequestType = ApplySLAData(0)("CboSubRequestType")
            dtEffectivedate = ApplySLAData(0)("dtEffectivedate")
            IsInternal = ApplySLAData(0)("IsInternal")
            Type = ApplySLAData(0)("Type")
            IsSendAlert = ApplySLAData(0)("IsSendAlert")
            SendAlertNorm = ApplySLAData(0)("SendAlertNorm")
            SendAlertUnit = ApplySLAData(0)("SendAlertUnit")
            IsSendReminder = ApplySLAData(0)("IsSendReminder")
            SendReminderNorm = ApplySLAData(0)("SendReminderNorm")
            SendReminderUnit = ApplySLAData(0)("SendReminderUnit")
            IsEscalateLevel1 = ApplySLAData(0)("IsEscalateLevel1")
            EscalateLevel1Norm = ApplySLAData(0)("EscalateLevel1Norm")
            EscalateLevel1Unit = ApplySLAData(0)("EscalateLevel1Unit")
            IsEscalateLevel2 = ApplySLAData(0)("IsEscalateLevel2")
            EscalateLevel2Norm = ApplySLAData(0)("EscalateLevel2Norm")
            EscalateLevel2Unit = ApplySLAData(0)("EscalateLevel2Unit")
            IsEscalateLevel3 = ApplySLAData(0)("IsEscalateLevel3")
            EscalateLevel3Norm = ApplySLAData(0)("EscalateLevel3Norm")
            EscalateLevel3Unit = ApplySLAData(0)("EscalateLevel3Unit")
            ' IsEscalateLevel4 = ApplySLAData(0)("IsEscalateLevel4")
            'EscalateLevel4Norm = ApplySLAData(0)("EscalateLevel4Norm")
            'EscalateLevel4Unit = ApplySLAData(0)("EscalateLevel4Unit")
            TimeZone = ApplySLAData(0)("TimeZone")
            SLAID = ApplySLAData(0)("SLAID")
            Confirm = ApplySLAData(0)("Confirm")
            OldTempalteID = ApplySLAData(0)("OldTempalteID")

            If SendAlertNorm = "" Then
                SendAlertNorm = "0.0"
            End If

            If SendReminderNorm = "" Then
                SendReminderNorm = "0.0"
            End If

            If EscalateLevel1Norm = "" Then
                EscalateLevel1Norm = "0.0"
            End If

            If EscalateLevel2Norm = "" Then
                EscalateLevel2Norm = "0.0"
            End If

            If EscalateLevel3Norm = "" Then
                EscalateLevel3Norm = "0.0"
            End If

            Dim strGridHTML As New StringBuilder("")
            Dim UniqueID As String = ""
            ''" & IsInternal & "
            ''Dim strSQL As String = "usp_NG2_ApplyHelpdeskSLA  " & CboTemplateMaster & ", " & CboCustomer & "," & CboDepartment & "," & CboRequestType & "," & CboSubRequestType & "," & TimeZone & ",'" & dtEffectivedate & "','" & Type & "','" & IsSendAlert & "','" & SendAlertNorm & "','" & SendAlertUnit & "','" & IsSendReminder & "','" & SendReminderNorm & "','" & SendReminderUnit & "','" & IsEscalateLevel1 & "','" & EscalateLevel1Norm & "','" & EscalateLevel1Unit & "','" & IsEscalateLevel2 & "','" & EscalateLevel2Norm & "','" & EscalateLevel2Unit & "','" & IsEscalateLevel3 & "','" & EscalateLevel3Norm & "','" & EscalateLevel3Unit & "','" & IsEscalateLevel4 & "','" & EscalateLevel4Norm & "','" & EscalateLevel4Unit & "','" & HttpContext.Current.Session("strUserName") & "'"

            Dim strSQL As String = "usp_NG2_ApplyHelpdeskSLA  " & CboTemplateMaster & ", " & CboCustomer & "," & CboDepartment & "," & CboRequestType & "," & CboSubRequestType & "," & TimeZone & ",'" & dtEffectivedate & "','" & Type & "'," & SLAID & ",'" & IsSendAlert & "','" & SendAlertNorm & "','" & SendAlertUnit & "','" & IsSendReminder & "','" & SendReminderNorm & "','" & SendReminderUnit & "','" & IsEscalateLevel1 & "','" & EscalateLevel1Norm & "','" & EscalateLevel1Unit & "','" & IsEscalateLevel2 & "','" & EscalateLevel2Norm & "','" & EscalateLevel2Unit & "','" & IsEscalateLevel3 & "','" & EscalateLevel3Norm & "','" & EscalateLevel3Unit & "','" & HttpContext.Current.Session("strUserName") & "'," & OldTempalteID & "," & Confirm & ""
            UniqueID = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return UniqueID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetRequestType(ByVal TypeID As String, ByVal WhichList As String, ByVal RequestTypeID As String, ByVal CustomerID As String, ByVal SLAAppliedON As String)
        '=====================================================================
        ' Procedure  Name		:	GetRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get RequestType
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   11 Oct 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()
            Dim dr As IDataReader
            Dim objCRM_AddNewRequest As New CRM_AddNewRequest
            Dim strReturnHtml1 As New StringBuilder("")
            Dim ShowProductCombo As String = "0"
            Dim m_strRequestedEmployee As String = ""
            Dim m_intRequestedEmployeePost As String = ""
            Dim m_strRequestedEmployeeUN As String = ""
            ' Dim m_strUserID As String
            If TypeID = "" Then
                TypeID = 0
            End If

            If RequestTypeID = "" Then
                RequestTypeID = 0
            End If

            If WhichList.ToUpper = "REQUESTTYPE" Then
                '   If CustomerID <> 0 Then
                'strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
                'strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
                'strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
                'strSQL += "  and RoleID =23 AND functionID = " & TypeID
                '' Else

                strSQL = "usp_NG2_Sel_RequestTypes " & TypeID & "," & CustomerID & ""

                ''strSQL = "Exec usp_CRM_RequestTypes  " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0,0"



            Else

                strSQL = "usp_NG2_Sel_SubRequestTypes " & RequestTypeID.ToString & "," & CustomerID & ",NULL,NULL," & TypeID & ",'" & SLAAppliedON & "'"
                'Else
                '    If EmployeeID <> 0 Then
                '        strSQL = "usp_CRM_RequestSubTypes " & TypeID & ",'" & m_strRequestedEmployeeUN & "','E',0," & RequestTypeID.ToString & ",0"
                '    Else
                '        strSQL = "usp_CRM_RequestSubTypes " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0," & RequestTypeID & ""
                '    End If
                'End If

                '' strSQL = "usp_CRM_RequestSubTypes " & TypeID & ", '" & HttpContext.Current.Session("strUserName").ToString & "','" & HttpContext.Current.Session("LoginType").ToString & "',0," & RequestTypeID & ""

            End If

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")
            'strValidation = strScript(1)
            strHTML.Append(strScript(0) + vbCrLf)


            Return strResult & "|" & strHTML.ToString & "|" & strReturnHtml1.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDepartment(ByVal CustomerID As String)
        '=====================================================================
        ' Procedure  Name		:	GetDepartment
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Departments
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   11 Dec 2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String = ""
            Dim dtDefectType As DataTable
            Dim strValidation As String = ""
            Dim strPlotHtml As String = ""
            Dim strHTML As New StringBuilder()
            Dim strScript As String()
            If CustomerID = "" Then
                CustomerID = "NULL"
            End If
            strSQL = "Exec usp_NG2_Sel_ApplySLA_tbl_PM_DepartmentMaster " & CustomerID & ""

            dtDefectType = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtDefectType)

            strScript = strResult.Split("|")
            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
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

    <System.Web.Services.WebMethod>
    Public Shared Function PlotSubtab(ByVal SLATemplateID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubtab
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           :13 Dec 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_ApplySLA As New CRM_ApplySLA()

            strGridHTML.Append(objCRM_ApplySLA.PlotApplySLATabDetails("AJAX", SLATemplateID, Flag))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod>
    Public Shared Function GetSLADetails(ByVal SLADetailsID As String, ByVal Flag As String, ByVal SLATemplateID As String, ByVal Type As String) As String
        '=====================================================================
        ' Procedure Name        : PlotSubtab
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           :13 Dec 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_ApplySLA As New CRM_ApplySLA()

            If Flag = "ApplySLA" Then
                strGridHTML.Append(objCRM_ApplySLA.PlotApplySLATabs(SLADetailsID))
            ElseIf Flag = "ConfigureGropus" Then
                strGridHTML.Append(objCRM_ApplySLA.PlotConfigureUserGroupsTabs("1", SLADetailsID))
            ElseIf Flag = "SLADetails" Then
                strGridHTML.Append(objCRM_ApplySLA.WriteSLAtargetTabGrid(SLADetailsID, Type, "", SLATemplateID))
            End If


            ' strGridHTML.Append(objCRM_ApplySLA.PlotApplySLATabDetails("AJAX", SLATemplateID, Flag))
            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function



    <System.Web.Services.WebMethod>
    Public Shared Function SaveHelpDeskSLATemplate(ByVal SaveSLADetialsData As Object) As String
        '=====================================================================
        ' Procedure Name        : SaveHelpDeskSLATemplate
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save HelpDesk SLA Template
        ' Description           :   To Save HelpDesk SLA Template
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created Date           : 21-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim Sub_RquestTypeID As String = ""
            Dim objCRM_RequestSLA As New CRM_ApplySLA()
            Dim SLATemplateID As String = SaveSLADetialsData(0)("SLATemplateID")
            Dim SLATemplateName As String
            Dim SLATemplateDescription As String
            Dim strFromEmailID As String
            Dim strToMailID As String
            Dim strCCToMailID As String
            Dim strSubject, strMessage As String
            Dim objCRM_AddNewRequest As New CRM_RequestDetailsNew
            Dim strHTML As New StringBuilder
            Dim drProductCombo As IDataReader
            Dim strAcknowledgeWithinNorm As String
            Dim strAcknowledgeWithinUnit As String
            Dim strResolveWithinNorm As String
            Dim strResolveWithinUnit As String
            Dim strRespondWithinNorm As String
            Dim strRespondWithinUnit As String
            Dim strCloseeWithinNorm As String
            Dim strCloseeWithinUnit As String
            Dim ExcalationEmail As String
            Dim ConsiderWorkHrs As String
            Dim ExcludeHoldPeriod As String
            Dim Priority As String
            Dim Severity As String
            Dim TypeID As String = ""
            Dim StrSql As String = ""
            Dim StrUniqueID As String = ""
            Dim SLADetailsID As String = ""

            strAcknowledgeWithinNorm = SaveSLADetialsData(0)("strAcknowledgeWithinNorm")
            ' strAcknowledgeWithinNorm = SaveSLADetialsData(0)("strAcknowledgeWithinNorm")
            strAcknowledgeWithinUnit = SaveSLADetialsData(0)("strAcknowledgeWithinUnit")
            strResolveWithinNorm = SaveSLADetialsData(0)("strResolveWithinNorm")
            strResolveWithinUnit = SaveSLADetialsData(0)("strResolveWithinUnit")
            strRespondWithinNorm = SaveSLADetialsData(0)("strRespondWithinNorm")
            strRespondWithinUnit = SaveSLADetialsData(0)("strRespondWithinUnit")
            strCloseeWithinNorm = SaveSLADetialsData(0)("strCloseeWithinNorm")
            strCloseeWithinUnit = SaveSLADetialsData(0)("strCloseeWithinUnit")
            ExcalationEmail = SaveSLADetialsData(0)("ExcalationEmail")
            ConsiderWorkHrs = SaveSLADetialsData(0)("ConsiderWorkHrs")
            ExcludeHoldPeriod = SaveSLADetialsData(0)("ExcludeHoldPeriod")
            Priority = SaveSLADetialsData(0)("Priority")
            Severity = SaveSLADetialsData(0)("Severity")
            TypeID = SaveSLADetialsData(0)("Type")
            SLADetailsID = SaveSLADetialsData(0)("SLADetailsID")




            Dim AcknowledgeWithinNorm As String() = strAcknowledgeWithinNorm.Split(",")
            Dim AcknowledgeWithinUnit As String() = strAcknowledgeWithinUnit.Split(",")
            Dim ResolveWithinNorm As String() = strResolveWithinNorm.Split(",")
            Dim ResolveWithinUnit As String() = strResolveWithinUnit.Split(",")
            Dim RespondWithinNorm As String() = strRespondWithinNorm.Split(",")
            Dim RespondWithinUnit As String() = strRespondWithinUnit.Split(",")
            Dim CloseeWithinNorm As String() = strCloseeWithinNorm.Split(",")
            Dim CloseeWithinUnit As String() = strCloseeWithinUnit.Split(",")
            Dim IsConsiderWorkHrs As String() = ConsiderWorkHrs.ToString.Split(",")
            Dim IsExcalationEmail As String() = ExcalationEmail.Split(",")
            Dim IsExcludeHoldPeriod As String() = ExcludeHoldPeriod.Split(",")
            Dim PriorityID = Priority.Split(",")
            Dim SeverityID = Severity.Split(",")

            Dim strSuccess As String = ""


            If SLATemplateID <> "" Or SLATemplateID <> "0" Or SLATemplateID <> "NULL" Then
                If TypeID = "1" Then
                    For ires As Integer = 0 To PriorityID.Length - 1
                        strSuccess = objCRM_RequestSLA.SaveTemplateSLADetails(SLATemplateID, PriorityID(ires), "0", AcknowledgeWithinNorm(ires), AcknowledgeWithinUnit(ires), RespondWithinNorm(ires), RespondWithinUnit(ires), ResolveWithinNorm(ires), ResolveWithinUnit(ires), CloseeWithinNorm(ires), CloseeWithinUnit(ires), IsExcalationEmail(ires), IsConsiderWorkHrs(ires), IsExcludeHoldPeriod(ires), TypeID, SLADetailsID)
                    Next
                ElseIf TypeID = "2" Then
                    For ires As Integer = 0 To SeverityID.Length - 1
                        strSuccess = objCRM_RequestSLA.SaveTemplateSLADetails(SLATemplateID, "0", SeverityID(ires), AcknowledgeWithinNorm(ires), AcknowledgeWithinUnit(ires), RespondWithinNorm(ires), RespondWithinUnit(ires), ResolveWithinNorm(ires), ResolveWithinUnit(ires), CloseeWithinNorm(ires), CloseeWithinUnit(ires), IsExcalationEmail(ires), IsConsiderWorkHrs(ires), IsExcludeHoldPeriod(ires), TypeID, SLADetailsID)
                    Next
                End If

            End If
            Return strSuccess.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    Public Function SaveTemplateSLADetails(ByVal SLATemplateID As String, ByVal PriorityID As String, ByVal SeverityID As String, ByVal AcknowlwdgeWithinNorm As String, ByVal AcknowlwdgeWithinUNIT As String, ByVal RespondWithinNorm As String, ByVal RespondWithinUNIT As String, ByVal ResolveWithinNorm As String, ByVal ResolveWithinUNIT As String, ByVal CloseeWithinNorm As String, ByVal CloseWithinUNIT As String, ByVal ExcalationEmail As String, ByVal ConsiderWorkHrs As String, ByVal ExcludeHoldPeriod As String, ByVal TypeID As String, ByVal SLADetailsID As String) As String
        Dim StrSql As String = ""
        Dim StrSLASql As String = ""
        Dim StrUniqueID As String = ""
        Dim StrSLAType As String = ""
        If PriorityID = "" Then
            PriorityID = "NULL"
        End If

        If SeverityID = "" Then
            SeverityID = "NULL"
        End If
        If SLATemplateID = "" Then
            SLATemplateID = "0"
        End If

        If AcknowlwdgeWithinNorm = "" Then
            AcknowlwdgeWithinNorm = "NULL"
        End If
        If ResolveWithinNorm = "" Then
            ResolveWithinNorm = "NULL"
        End If
        If RespondWithinNorm = "" Then
            RespondWithinNorm = "NULL"
        End If
        If CloseeWithinNorm = "" Then
            CloseeWithinNorm = "NULL"
        End If
        'If DetailsID = "" Then
        '    DetailsID = "0"
        'End If
        If SLATemplateID <> "" Or SLATemplateID <> "0" Then
            'StrSql = "Usp_NG2_Ins_Upd_tbl_NG2_CRM_SLA_Details  '" & SLATemplateName & "','" & Description & "'," & PriorityID & "," & SeverityID & "," & AcknowlwdgeWithinNorm & ",'" & AcknowlwdgeWithinUNIT & "'," & RespondWithinNorm & ",'" & RespondWithinUNIT & "'," & ResolveWithinNorm & ",'" & ResolveWithinUNIT & "'," & CloseeWithinNorm & ",'" & CloseWithinUNIT & "'," & ExcalationEmail & ",'" & ConsiderWorkHrs & "'," & ExcludeHoldPeriod & "," & SLATemplateID & "," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'"
            'CommonFunctions.Data.GetDataScalar(StrSql, True)

            If TypeID = "1" Then
                StrSLAType = "Priority"
            End If
            If TypeID = "2" Then
                StrSLAType = "Severity"
            End If
            StrSLASql = "usp_NG2_INS_UPD_tbl_CRM_SLATemplatesDetails_ApplySLA  " & SLATemplateID & ",'" & StrSLAType & "'," & PriorityID & "," & SeverityID & "," & AcknowlwdgeWithinNorm & ",'" & AcknowlwdgeWithinUNIT & "'," & RespondWithinNorm & ",'" & RespondWithinUNIT & "'," & ResolveWithinNorm & ",'" & ResolveWithinUNIT & "'," & CloseeWithinNorm & ",'" & CloseWithinUNIT & "'," & ExcalationEmail & "," & ConsiderWorkHrs & "," & ExcludeHoldPeriod & "," & SLADetailsID & ",'" & HttpContext.Current.Session("strUserName") & "'"
            CommonFunctions.Data.GetDataScalar(StrSLASql, True)


        End If

        Return StrUniqueID
    End Function



#Region "Request Tab Section Related Code"
    Public Function PlotConfigureUserGroupsTabs(ByVal GroupID As String, ByVal SLAID As String)
        '=====================================================================
        ' Procedure Name        : PlotApplySLATabDetails()	
        ' Purpose               : To Plot the Apply SLA Tab Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created               : 11 Dec 2017
        ' Revisions             : None
        '=====================================================================

        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = ""
        Dim Counter As Integer
        Dim dtConfigureGroups As DataTable
        strHTML.Append("<div  id='divScrollConfigureGroups'>")
        strHTML.Append("<div class='container-fluid  tabz '>")
        strHTML.Append("<div id='exTab2' class='container-fluid'> ")
        strHTML.Append("<ul class='nav nav-tabs' id='navConfigureTabs'>")
        strSQL = "usp_NG2_SEL_tbl_NG2_SLAConfigurableGroups"
        dtConfigureGroups = CommonFunctions.Data.GetDataTable(strSQL, True)
        For i As Integer = 0 To dtConfigureGroups.Rows.Count - 1
            If i = 0 Then
                strHTML.Append("<li  data-value='" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupID").ToString, "") & "'  TabColor='" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupColor").ToString, "") & "'  class='clstabs clsActiveTabs'  id='" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupID").ToString, "") & "'><a  data-bs-toggle='tab' class='active clsConfigureTabs'  onclick=""ConfigureGroupsTab_Click(" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupID").ToString, "") & ",this)"">" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("Group").ToString, "") & "</a></li>")
            Else
                strHTML.Append("<li class='LiclsConfigureTabs clstabs' data-value='" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupID").ToString, "") & "'  TabColor='" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupColor").ToString, "") & "'  id='" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupID").ToString, "") & "'><a data-bs-toggle='tab' class='clsConfigureTabs'    onclick=""ConfigureGroupsTab_Click(" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("GroupID").ToString, "") & ",this)"">" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroups.Rows(i)("Group").ToString, "") & "</a></li>")
            End If

            Counter += 1
        Next
        strHTML.Append("</ul>")

        strHTML.Append("<div id='divUsersTabs' >")
        strHTML.Append(PlotConfigureTabDetails(GroupID, SLAID))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        'Else
        'If strFlag = "ApplySLA" Then
        '    strHTML.Append(PlotApplySLATabs(""))
        'ElseIf strFlag = "ConfigureGropus" Then
        '    strHTML.Append(PlotApplySLATabs(""))
        'ElseIf strFlag = "SLADetails" Then
        '    strHTML.Append(WriteSLAtargetTabGrid("1", "", "", ""))
        'End If

        'End If



        'strHTML.Append("<div class='tab-pane col-sm-12' id='2' >")
        'strHTML.Append("</div>")
        'strHTML.Append(" <div class='tab-pane' id='3' >")
        'strHTML.Append("</div>")

        Return strHTML.ToString
    End Function

    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String) As String
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
        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid))
        Return strGridHTML.ToString

    End Function
    Protected Sub GetGlobalObject()
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
        ' Created               :	1 Nov  2016
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
    Private Function WriteHelpdeskMasterGrid(ByVal strWhichGrid As String, Optional ByVal CustomerID As String = "", Optional ByVal DepartmentID As String = "", Optional ByVal SLAAppliedOn As String = "") As String

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
        ' str_RequestTypeID = RequestTypeID
        intNoOfDataColumn = 5
        strDivID = "divApplySLA"
        strSQLQuery = "usp_NG2_SEL_V_tbl_CNF_HelpdeskSLA "
        If CustomerID = "" Then
            strSQLQuery &= " NULL"
        Else
            strSQLQuery &= CustomerID
        End If
        If DepartmentID = "" Then
            strSQLQuery &= ",NULL"
        Else
            strSQLQuery &= "," & DepartmentID
        End If
        If SLAAppliedOn = "" Then
            strSQLQuery &= ",Null"
        Else
            strSQLQuery &= ",'" & SLAAppliedOn & "'"
        End If
        'arrstrActualList = {"SLATemplateName", "CustomerName", "Department", "RequestType", "SubRequestType", "SLAAppliedOn", ""}
        'arrstrUserFriendlyList = {"Template Name", "Customer", "Department", "Request Type", "Sub Request Type", "SLA Applied On", "Edit"}

        arrstrActualList = {"CustomerName", "Department", "RequestType", "SubRequestType", "SLAAppliedOn", ""}
        arrstrUserFriendlyList = {"Customer", "Department", "Request Type", "Sub Request Type", "SLA Applied On", "Edit"}

        arrstrLinkArray = {"", "", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

        objGrid = m_objApplySLAGrid
        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
        strGridHTML.Append("<input type=hidden id=FilterApplySLA value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue
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

        Return strGridHTML.ToString
    End Function
    Public Function PlotConfigureTabDetails(ByVal GroupID As String, ByVal SLAID As String)
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = ""
        GetGlobalObject()
        strHTML.Append("<div class='row' style='margin-top: 15px; margin-bottom: 15px;'>")
        'strHTML.Append("<div class='hd panel-heading'>")
        'strHTML.Append("<span class='' style='line-height: 20px; padding-left: 5px; '>Add User</span>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        ''style='border-bottom: 1px solid red'
        strHTML.Append("<div >")
        strHTML.Append("<div style='width: 41.67%;; float:left;'>")
        strHTML.Append("<div class='form-group' style=''>")
        strHTML.Append("<div id='EmployeeFilter'>")
        strHTML.Append("<ul class=''>")
        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append(" <input type='text' id='SearchEmployee'  placeholder='Search '  onkeyup=EmployeeSearch()>")
        strHTML.Append("</li>")
        strHTML.Append("<li  class='left search-bar'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_NG2_Sel_tbl_PM_DepartmentMaster", 129, , " onchange='DepartMentFilter_OnChange(this)' class='form-control' ", False, True))
        strHTML.Append("</li>	")
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")

        strHTML.Append(" </div>")
        strHTML.Append("<div class='col-md-12 form-group cutom-view-list' style=''> ")
        strHTML.Append("<div class='col-md-9' style='' id='divEmployeeList' >")
        strHTML.Append(PlotEmployeeList(GroupID, "", SLAID))
        strHTML.Append("</div>")
        ' If m_objAccessRights.Add Or m_objAccessRights.Edit Then
        strHTML.Append(" <div class='col-md-3 bottom-bar' style='float: right!important; margin-top: 50px'>")
        strHTML.Append("<ul class='nav-stacked'>")
        strHTML.Append("<li id='liAddUsers'><button type='button' class='btn btn-default save' id='add' title='Add Users' style='background-color: #364660;color: #ffffff;margin:  0;' onclick='AddConfigureUserGroups()'><i class='  fa fa-angle-double-right' style='margin-left: 8px;'></i></button></li>")
        ''strHTML.Append("<li id='liDeleteUsers'>button type='button' class='btn btn-default save' id='Delete' title='Delete Users' style='background-color: #364660;color: #ffffff;margin:  0;' onclick='DeleteConfigureUserGruoups()'><i class='  fa fa-angle-double-left' style='margin-left: 8px;'></i></button></li> ")
        strHTML.Append("<li id='liDeleteUsers'><button type='button' class='btn btn-default save' id='Delete' title='Remove Users' style='background-color: #364660;color: #ffffff;margin:  0;' onclick='DeleteConfigureUserGroups()'><i class='  fa fa-angle-double-left' style='margin-left: 8px;'></i></button></li>")
        strHTML.Append("</ul>")

        'strHTML.Append("<button type='button' class='btn btn-default save' id='add' title='Add Users' style='background-color: #364660;color: #ffffff;margin:  0;' onclick='AddConfigureUserGruoups()'><i class='  fa fa-angle-double-right' style='margin-left: 8px;'></i></button> ")

        strHTML.Append("</div>")

        'strHTML.Append("<button type='button' class='btn btn-default save' id='Delete' title='Delete Users style='background-color: #364660;color: #ffffff;margin:  0;' onclick='DeleteConfigureUserGruoups()'><i class='  fa fa-angle-double-left' style='margin-left: 8px;'></i></button> ")
        '  End If

        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div  style='width:58.33%; float:left; margin-bottom: 10px;'>")
        strHTML.Append("<div id='idSelectedUser' class='custom-search-input col-md-12' style=''>")
        strHTML.Append("<div class='input-group col-md-12'>")
        strHTML.Append("<div class='search-bar'> Selected User")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>    ")
        strHTML.Append("<div class='right_section' id='divSelectGroupEmpList' style='margin-bottom: 10px;'>")
        strHTML.Append(PlotSelectedEmployeeList(GroupID, SLAID))
        strHTML.Append(" </div> ")
        strHTML.Append("</div>")
        ''strHTML.Append("<div class='form-group' style=' padding-top: 10px ;    border-top: 1px solid #ccc'> <div class='col-sm-offset-9 col-sm-3'><button type='button' class='btn btn-default save ' data-bs-toggle='tooltip' style=' border:1px solid #ccc !important;'>Save</button><button style='margin-left: 10px; border:1px solid #ccc !important;' type='button' class='btn btn-default save ' data-bs-toggle='tooltip'>Cancel</button></div></div>")

        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Public Function PlotEmployeeList(ByVal GroupID As String, ByVal DepartmentID As String, ByVal SLAID As String)
        Dim strHTML As New StringBuilder("")
        Dim strSQL As String = ""
        Dim dtConfigureGroupsEmployee As DataTable
        Dim Counter As Integer = 0
        Dim intEmployeeID As String
        Dim strEmployeeImage As String = ""
        If DepartmentID = "" Then
            DepartmentID = "NULL"
        End If
        strSQL = "usp_NG2_SEL_tbl_PM_Employee " & GroupID & "," & SLAID & "," & DepartmentID & ""
        dtConfigureGroupsEmployee = CommonFunctions.Data.GetDataTable(strSQL, True)
        strHTML.Append("<div id='DivEmployeeScroll'>")
        strHTML.Append("<ul class='list-group' id='ulConfigureEmployee'>")
        For i As Integer = 0 To dtConfigureGroupsEmployee.Rows.Count - 1

            intEmployeeID = CInt(CommonFunction.Data.CheckIsDBNull(dtConfigureGroupsEmployee.Rows(i)("EmployeeID"), "0"))
            strEmployeeImage = GetEmployeeImagePath(intEmployeeID)

            strHTML.Append("<li class='list-group-item' style='cursor:pointer' id=" & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroupsEmployee.Rows(i)("EmployeeID").ToString, "") & " onclick='SelectEmployee(this," & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroupsEmployee.Rows(i)("EmployeeID").ToString, "") & ")'><img id='imgUser" & intEmployeeID.ToString & "' src='" & strEmployeeImage & "' alt='No Image' style='height:30px;width:30px;border-radius:50%;' /> &nbsp; " & CommonFunctions.Data.CheckIsDBNull(dtConfigureGroupsEmployee.Rows(i)("EmployeeName").ToString, "") & "<span style='float: right;'></span></li>")
            Counter += 1
        Next
        If dtConfigureGroupsEmployee.Rows.Count = 0 Then
            strHTML.Append("<li class='list-group-item'>There are no items to show in this view.<span style='float: right;'></span></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='list-group' id='ulNoData' style='display:none'>")
        strHTML.Append("<li class='list-group-item'>There are no items to show in this view.</li>")
        strHTML.Append("</ul>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Public Function PlotSelectedEmployeeList(ByVal GroupID As String, ByVal SLAID As String)
        Dim strGridHTML As New StringBuilder()
        Dim strSQLQuery As String = ""
        Dim intNoOfDataColumn As Int16
        Dim strDivID As String = ""
        Dim arrstrActualList() As String
        Dim arrstrUserFriendlyList() As String
        Dim arrstrLinkArray() As String
        Dim arrCheckBoxArray() As String
        Dim arrWidthArray() As String

        intNoOfDataColumn = 2
        strDivID = "divSelectedEmployeeList"
        strSQLQuery = "usp_NG2_SEL_tbl_NG2_ConfigurableUserGroups " & GroupID & "," & SLAID & ""

        arrstrActualList = {"EmployeeName", "EmailID", ""}
        arrstrUserFriendlyList = {"Employee Name", "Email ID", "Remove"}
        arrstrLinkArray = {"", "", ""}
        arrCheckBoxArray = {"", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=center"}

        objGrid = m_objEmployeeGrid
        '/*Changed By Yasmin on 25th july 2018*/
        'Added By Dipali V On 24th March 2023 For Datatable Issue
        Dim dtListCount As New DataTable
        dtListCount = CommonFunctions.Data.GetDataTable(strSQLQuery, True)
        strGridHTML.Append("<input type=hidden id=FilterEmployeeList value='" & dtListCount.Rows.Count & "'>")
        'End of Added By Dipali V On 24th March 2023 For Datatable Issue
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
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With


        objGrid = Nothing

        Return strGridHTML.ToString
    End Function
    Private Sub m_objEmployeeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objEmployeeGrid.ColumnHeaderTD_BeforePrint


        'If Args.ColumnName.ToUpper = "DELETE" Then
        '    Cancel = True
        '    Args.StringToBeInserted = "<th style='text-align:center;'><input onclick='DeleteUsers()' type=checkbox id=chkDeleteUsers name=chkDeleteUsers /></th>"
        'End If


    End Sub
    Private Sub m_objEmployeeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objEmployeeGrid.DataRowTD_BeforePrint


        If Args.ColumnName.ToUpper = "REMOVE" Then
            Cancel = True

            Args.StringToBeInserted = "<td style='text-align:center;'' Title='Remove User'><input type=checkbox id=chkUserDelete name=chkUserDelete  value='" & Args.DataReader("EmployeeID") & " '></TD>"
            ' End If
        End If
    End Sub
#End Region
#Region "Jquery AJAX Methods"
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshEmployeeList(ByVal GroupID As String, ByVal DepartmentID As String, ByVal SLAID As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshEmployeeList
        ' Purpose               : To Refresh Employee List
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           :13-Dec-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_ConfigureGroups As New CRM_ApplySLA()
            strGridHTML.Append(objCRM_ConfigureGroups.PlotEmployeeList(GroupID, DepartmentID, SLAID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    '<System.Web.Services.WebMethod> _
    'Public Shared Function PlotSelectedEmployeeListGrid(ByVal GroupID As Object) As String
    '    '=====================================================================
    '    ' Procedure Name        : PlotSelectedEmployeeListGrid
    '    ' Purpose               : To Plot Selected EmployeeList
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : HTML
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Vidya Jadhav
    '    ' Created Date           :12-Dec-2017
    '    '=====================================================================
    '    Dim strGridHTML As New StringBuilder("")
    '    Dim objCRM_ConfigureGroups As New CRM_ApplySLA()

    '    strGridHTML.Append(objCRM_ConfigureGroups.PlotSelectedEmployeeList(GroupID))



    '    Return strGridHTML.ToString
    'End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function PlotConfigureUsersSubtab(ByVal GroupID As String, ByVal Flag As String) As String
        '=====================================================================
        ' Procedure Name        : PlotConfigureUsersSubtab
        ' Purpose               : Plot Configure Users Subtab
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           :13 Dec 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_ConfigureGroups As New CRM_ApplySLA()

            strGridHTML.Append(objCRM_ConfigureGroups.PlotConfigureUserGroupsTabs(GroupID, ""))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function AddOrDeleteUsers(ByVal GroupID As String, ByVal EmployeeID As String, ByVal strAction As String, ByVal SLAID As String) As String
        Try
            Dim StrSql As String = ""
            Dim StrSLASql As String = ""
            Dim StrUniqueID As String = ""
            Dim StrSLAType As String = ""

            StrSLASql = "usp_NG2_INS_tbl_NG2_ConfigurableUserGroups  " & GroupID & ",'" & EmployeeID & "','" & HttpContext.Current.Session("strUserName") & "','" & strAction & "' ," & SLAID & ""
            CommonFunctions.Data.GetDataScalar(StrSLASql, True)

            Return StrUniqueID
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function PlotTabConfigureUserDetails(ByVal GroupID As String, ByVal SLAID As String) As String

        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_ConfigureGroups As New CRM_ApplySLA()

            strGridHTML.Append(objCRM_ConfigureGroups.PlotConfigureTabDetails(GroupID, SLAID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmployeeImagePath(ByVal intEmployeeID As Integer) As String
        Try
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
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    '<System.Web.Services.WebMethod> _
    'Public Shared Function RefreshEmployeeListGrid(ByVal GroupID As String, ByVal DepartmentID As Object) As String
    '    '=====================================================================
    '    ' Procedure Name        : RefreshEmployeeListGrid
    '    ' Purpose               : To Refresh Employee List Grid
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : HTML
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Vidya Jadhav
    '    ' Created Date           : 5th-OCT-2017
    '    '=====================================================================
    '    Dim strGridHTML As New StringBuilder("")
    '    Dim objCRM_ConfigureGroups As New CRM_ApplySLA()
    '    strGridHTML.Append(objCRM_ConfigureGroups.PlotEmployeeList(GroupID, DepartmentID))

    '    Return strGridHTML.ToString
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateSLAApplied(ByVal Type As String, ByVal TemplateID As String, ByVal SLAID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateSLAApplied
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for SLA Applied ON
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   15 Dec 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String

            strSQL = "usp_NG2_Sel_ValidateSLA " & Type & "," & TemplateID & "," & SLAID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function CheckEffectiveDateValidation(ByVal Effectivedate As String)
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

            strSQL = "usp_NG2_Validate_EffectiveDates '" & Effectivedate & "'"
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function CheckTemplateOverride(ByVal OldTemplateID As String, ByVal NewTemplateID As String, ByVal CustomerID As String, ByVal DepartmentID As String, ByVal RequestTypeID As String, ByVal SubRequestTypeID As String, ByVal SLAAppliedOn As String, ByVal SLAID As String)
        '==================================================================================
        ' Procedure Name	:	CheckTemplateOverride
        ' Purpose			:	To check Leaving date validation
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

            strSQL = "usp_NG2_ChkTemplateOverride " & OldTemplateID & "," & NewTemplateID & "," & CustomerID & "," & DepartmentID & "," & RequestTypeID & "," & SubRequestTypeID & "," & SLAAppliedOn & "," & SLAID & ",'" & HttpContext.Current.Session("strUserName") & "'"
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ChkNormValidation(ByVal OldTemplateID As String, ByVal NewTemplateID As String)
        '==================================================================================
        ' Procedure Name	:	ChkNormValidation
        ' Purpose			:	To check min Norm validation
        '                       
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Vidya Jadhav
        ' Created			:	22 Dec 2917
        ' Revisions			:	
        '==================================================================================
        Try
            Dim strSQL As String
            Dim strResult As String

            strSQL = "usp_NG2_ChkNormValidation " & OldTemplateID & "," & NewTemplateID & ""
            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True))

            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetDepartmentCustomer(ByVal strCustomerID As String)
        Try
            Return CommonFunctions.HTMLControls.DrawComboBox("CboDepartmentFilter", "usp_NG2_Sel_ApplySLA_tbl_PM_DepartmentMaster_Filter " & strCustomerID, , , "class='form-control clsFormControl' style='width:140px!important' title='Department' onchange=GetFilterList()", False, True, , False)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetFilterData(ByVal strCustomerID As String, ByVal strDepartmentID As String, ByVal strSLAAppliedOn As String)
        Try
            Dim objCRM_ApplySLA As New CRM_ApplySLA()
            Return objCRM_ApplySLA.WriteHelpdeskMasterGrid("", strCustomerID, strDepartmentID, strSLAAppliedOn)
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'Added by Usha Pandit on 16 JAN 2018 for Get Input Date Format
    '<System.Web.Services.WebMethod()>
    Public Function GetInputDateFormat() As String
        '=====================================================================
        ' Procedure  Name		:	GetInputDateFormat
        ' Parameters Passed		:	ID
        ' Returns				:	Input Date Format
        ' Parameters Affected	:	None
        ' Purpose				:	Get Input Date Format
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   16 JAN 2018
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim strSQL As String

            strSQL = "usp_NG2_sel_tbl_PM_CompanyInformation"

            Dim drReader As IDataReader

            drReader = CommonFunctions.Data.GetDataReader(strSQL, True)

            If (drReader.Read) Then
                strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drReader("InputDateFormat")))
            End If

            'strResult = CommonFunctions.Data.GetDataReader(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function

    'End of Added by Usha Pandit on 16 JAN 2018 for Get Input Date Format

#End Region
End Class