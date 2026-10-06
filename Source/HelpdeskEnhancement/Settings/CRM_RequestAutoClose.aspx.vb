Public Class CRM_RequestAutoClose
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
    Protected Shared RequestTypeTagID As Integer = 918
    Protected Shared SubRequestTypeTagID As Integer = 919
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

    ''Added By Usha Pandit On 21.06.2019 for keeping previously inserted days count as selected in drop down 
    Private blnLatestAutoCloseDaysSet As Boolean = False
    Public strLatestAutoCloseDays As String = "0"
    ''End of Added By Usha Pandit On 21.06.2019 for keeping previously inserted days count as selected in drop down 

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
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
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
        strHTML.Append(WriteTabsControls("Type", "Load", ""))
        If Flag.ToUpper = "LOAD" Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If

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
            Return "Bad Request Found"
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
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        Dim strHTML As New StringBuilder("")

        strHTML.Append("<div id='Autoclose' class='tabcontent1 h-type clsSettingstabs'>")
        strHTML.Append(AutoCloseTabDetails(strWhichGrid, strGridFlag))
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
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        GetGlobalObject(RequestTypeTagID)

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar' id='divTypeTab'>")
        strHTML.Append("<ul class='left'>")

        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' onclick='AddRequestType()' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button onclick='DeleteRequestType()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='divRequestTypes'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divTypeBottom'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne'>")
        strHTML.Append("<h3><span>Add Request Type<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        strHTML.Append("<h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapseOne' aria-expanded='true' aria-controls='collapseOne'>")
        strHTML.Append(" <i class='fa fa-plus'></i>")
        strHTML.Append("<i class='fa fa-minus'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
        strHTML.Append("<div class='panel-body' id='idPanelBody'>")
        strHTML.Append("<form class='form-horizontal' id='frmType' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type code'>Request Type Code*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("requesttypecode", "requesttypecode", "form-control", , , , , , , , , , "  class='form-control' placeholder='Enter Request Type Code' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Type*</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("requesttype", "requesttype", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Request Type' ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='form-group' style='border: none:'>")
        strHTML.Append(" <div class='right'>")
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append(" <button type='button' onclick='SaveRequestType_Onclick()' class='btn btn-default save' style='background-color: #343660; color: #fff;'>Save</button>")
        End If
        strHTML.Append(" <button type='button' onclick='Cancel_RequestType()' class='btn btn-default save' style='margin-right: 19px;'>Cancel</button>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")

        strHTML.Append("<div class='table-responsive' id='divSubRequestType'>")

        strHTML.Append(" </div>")
        strHTML.Append("  </form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Public Function SubRequestTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
        '=====================================================================
        ' Procedure Name        : SubRequestTabDetails()	
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
        GetGlobalObject(SubRequestTypeTagID)

        Dim strHTML As New StringBuilder("")
        strHTML.Append(" <div class='type-top-bar top-bar'  id='divSubTypeTab'>")
        strHTML.Append("    <ul class='left'>")
        strHTML.Append(" <li class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchSubRquestType'   placeholder='Search in table'>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append(" <button type='button' onclick=""document.getElementById('id14').style.display='block'"" class='btn btn-default'>Inherit Status Flow</button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button type='button' onclick='AddSubRequestType()' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
        End If
        strHTML.Append("<li class='clearall'>")
        strHTML.Append("<button onclick='DeleteSubRequestType()' type='button'  class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
        strHTML.Append("</li>")
        strHTML.Append(" </ul>")
        strHTML.Append("</div>")
        strHTML.Append(" <div class='table-responsive' id='divtblSubType'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append(" <div class='bottom-bar' id='divSubTypeBottom'>")
        strHTML.Append(" <div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'>")
        strHTML.Append("<h3><span>Add Sub Type<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        strHTML.Append("<h4 class='panel-title'>")
        strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2'>")
        strHTML.Append("<i class='fa fa-plus toggle-plus'></i>")
        strHTML.Append("<i class='fa fa-minus toggle-plus'></i>")
        strHTML.Append("</a>")
        strHTML.Append("</h4>")
        strHTML.Append("</div>")
        strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2'>")
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Request SubType Code*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SubrequesttypeCode", "SubrequesttypeCode", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'"))
        strHTML.Append("</div>")
        strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Work Hours*</label>")
        strHTML.Append(" <div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sub_WorkHrs", "Sub_WorkHrs", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'"))
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Sub Request Type*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sub_requesttype", "Sub_requesttype", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'"))
        strHTML.Append(" </div>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Attachment Mandatory</label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append("<input type='checkbox' style='width: 11px;' name='ChkAttachment' id='ChkAttachment'>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>SLA Red Threshold*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SLAThRed", "SLAThRed", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'"))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>SLA Yellow Threshold*</label>")
        strHTML.Append("<div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SLAThYellow", "SLAThYellow", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True).Replace("'", "\'"))
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Task Type*</label>")
        strHTML.Append(" <div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubrequestTasktype", "usp_Sel_tbl_PM_TaskTypes ", , , "class='form-control' ", , True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("  </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Guidelines For Requestor</label>")
        strHTML.Append("<div class='col-sm-4'>")

        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtGForRequestor", "txtGForRequestor", , "form-control", , , , , , , , , , , , , , , "", True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Guidelines For Asignee</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtGForAssinee", "txtGForAssinee", , "form-control", , , , , , , , , , , , , , , "", True))
        strHTML.Append("   </div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <div class='right'>")
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' onclick='SaveSubRequestType_Onclick()' class='btn btn-default save' style='background-color: #343660; color: #fff;'>Save</button>")
            strHTML.Append("<button type='button' onclick='SaveAndAddSubRequestType_Onclick()' class='btn btn-default save clsbuttonLinks' style='background-color: #343660; color: #fff; border-left: 1px solid;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px; color: #fff;'></i></button>")
        End If
        strHTML.Append(" <button type='button' onclick='Cancel_SubType()' class='btn btn-default save' style='margin-right: 19px;'>Cancel</button>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </form>")
        strHTML.Append("</div>")
        strHTML.Append("  </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("  </div>")
        strHTML.Append(" </div>")
        strHTML.Append(" </div>")

        Return strHTML.ToString
    End Function
    Public Function RequestStatusTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
        '=====================================================================
        ' Procedure Name        : RequestStatusTabDetails()	
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
        GetGlobalObject(RequestTypeTagID)

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar'  id='divStatusTab'>")
        strHTML.Append("<ul class='left'>")

        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("  <button type='button' onclick='AddRequestStatus()' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("    <button onclick='DeleteRequestStatus()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='tblStatus'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divStatusBottom'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion3' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne3'>")
        strHTML.Append("   <h3><span>Add Status<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        strHTML.Append("  <h4 class='panel-title'>")
        strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion3' href='#collapseOne3' aria-expanded='true' aria-controls='collapseOne3'>")
        strHTML.Append(" <i class='fa fa-plus'></i>")
        strHTML.Append("<i class='fa fa-minus'></i>")
        strHTML.Append(" </a>")
        strHTML.Append(" </h4>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div id='collapseOne3' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne3'>")
        strHTML.Append(" <div class='panel-body'  >")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Status Code*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtStatusCode", "txtStatusCode", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Order Number</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtOrderNumber", "txtOrderNumber", "form-control", 54, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Status*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestStatus", "txtRequestStatus", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>System Status*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboSystemStatus", "Usp_NG2_Sel_tbl_IB_Status_For_Status", , , "class='form-control'  ", False, True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append(" <div class='col-sm-4'>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='right'>")
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save' onclick='SaveStatus()' style='background-color: #343660; color: #fff;'>Save</button>")
            strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddStatus()' style='background-color: #343660; color: #fff; border-left: 1px solid;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px; color: #fff;'></i></button>")
        End If
        strHTML.Append("<button type='button' class='btn btn-default save' onclick='Cancel_Status()' style='margin-right: 19px;'>Cancel</button>")
        strHTML.Append(" </div>")

        strHTML.Append("  </form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Public Function RequestPriorityTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
        '=====================================================================
        ' Procedure Name        : RequestStatusTabDetails()	
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
        GetGlobalObject(917)

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar'  id='divPriorityTab'>")
        strHTML.Append("<ul class='left'>")

        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("  <button type='button' onclick='AddRequestPriority()' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("    <button onclick='DeleteRequestPriority()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='divtblPriority'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divPriorityBottom'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion4' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne4'>")
        strHTML.Append("   <h3><span>Add Status<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        strHTML.Append("  <h4 class='panel-title'>")
        strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion4' href='#collapseOne4' aria-expanded='true' aria-controls='collapseOne4'>")
        strHTML.Append(" <i class='fa fa-plus'></i>")
        strHTML.Append("<i class='fa fa-minus'></i>")
        strHTML.Append(" </a>")
        strHTML.Append(" </h4>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div id='collapseOne4' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne4'>")
        strHTML.Append(" <div class='panel-body'  >")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Priority Code*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestPriorityCode", "txtRequestPriorityCode", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Order Number*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestPriorityOrderNo", "txtRequestPriorityOrderNo", "form-control", 54, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Priority*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestPriority", "txtRequestPriority", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='right'>")
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save' onclick='SaveRequestPriority()' >Save</button>")
            strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddRequestPriority()' style='border-left: 1px solid;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px; color: #fff;'></i></button>")
        End If
        strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' onclick='Cancel_RequestPriority()' style='margin-right: 19px;'>Cancel</button>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Public Function RequestSeverityTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
        '=====================================================================
        ' Procedure Name        : RequestStatusTabDetails()	
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
        GetGlobalObject(917)

        Dim strHTML As New StringBuilder("")
        strHTML.Append("<div class='type-top-bar top-bar'  id='divSeverityTab'>")
        strHTML.Append("<ul class='left'>")

        strHTML.Append("<li class='left search-bar'>")
        strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
        strHTML.Append("</li>")
        strHTML.Append("</ul>")
        strHTML.Append("<ul class='right'>")
        If m_objAccessRights.Add = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("  <button type='button' onclick='Add_RequestSeverity()' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
        End If
        If m_objAccessRights.Delete = True Then
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("    <button onclick='DeleteRequestSeverity()' type='button' class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button></li>")
        End If
        strHTML.Append("</ul>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='table-responsive' id='divtblSeverity'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append("<div class='bottom-bar' id='divSeverityBottom'>")
        strHTML.Append("<div class='pannel-section'>")
        strHTML.Append("<div class='col-md-12 col-sm-12' style='padding-left: 15px; padding-right: 15px;'>")
        strHTML.Append("<div class='panel-group wrap' id='accordion5' role='tablist' aria-multiselectable='true'>")
        strHTML.Append(" <div class='panel'>")
        strHTML.Append(" <div class='panel-heading' role='tab' id='headingOne5'>")
        strHTML.Append("   <h3><span>Add Severity<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
        strHTML.Append("  <h4 class='panel-title'>")
        strHTML.Append("   <a role='button' data-toggle='collapse' data-parent='#accordion5' href='#collapseOne5' aria-expanded='true' aria-controls='collapseOne5'>")
        strHTML.Append(" <i class='fa fa-plus'></i>")
        strHTML.Append("<i class='fa fa-minus'></i>")
        strHTML.Append(" </a>")
        strHTML.Append(" </h4>")
        strHTML.Append(" </div>")
        strHTML.Append(" <div id='collapseOne5' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne5'>")
        strHTML.Append(" <div class='panel-body'  >")
        strHTML.Append("<form class='form-horizontal' action='/action_page.php'>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Request Sevirity Code*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestSeverityCode", "txtRequestSeverityCode", "form-control", 219, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'>Request Severity*</label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtRequestPriorityOrderNo", "txtRequestPriorityOrderNo", "form-control", 54, , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
        strHTML.Append("</div>")
        strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
        strHTML.Append("<div class='col-sm-4'>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='form-group'>")
        strHTML.Append("<div class='right'>")
        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append("<button type='button' class='btn btn-default save' onclick='SaveRequestSeverity()' >Save</button>")
            strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' onclick='SaveAndAddRequestSeverity()' style='border-left: 1px solid;'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px; color: #fff;'></i></button>")
        End If
        strHTML.Append("<button type='button' class='btn btn-default save clsbuttonLinks' onclick='Cancel_Severity()' style='margin-right: 19px;'>Cancel</button>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</form>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Public Function AutoCloseTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
        '=====================================================================
        ' Procedure Name        : AutoCloseTabDetails()	
        ' Purpose               : To Plot the AutoClose Tab Details
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
        GetGlobalObject(22229)

        Dim strHTML As New StringBuilder("")
        strHTML.Append(" <div class='auto-desc'>")
        strHTML.Append("<p>Close Inactive Resolved Incidents</p>")
        strHTML.Append(" <p>Select a duration after which inactive incidents will be moved from resolved state to Closed. Note that an Incident is considered inactive when it has no new comments and no changes are made to the incident ‘s fields ")
        strHTML.Append("</p>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='auto-day-sel'>")
        strHTML.Append(" <div class='form-group'>")
        strHTML.Append(" <label class='control-label col-sm-1' for='In' style='text-align:left;margin-top:1%;PADDING-LEFT:1%'>In</label>")
        strHTML.Append("<div class='col-sm-2' >")
        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("CboAutocloser", "Usp_NG2_Sel_AutocloserDaysConfiguration ", 141, , "class='form-control' ", False, True))
        strHTML.Append("</div>")
        'cOMMENTED & ADDED BY DIPALI V ON 28TH DEC 2020 FOR ALIGNMENT 
        ' strHTML.Append(" <label class='control-label col-sm-1' for='In' style='margin-top:1%'>Days *</label>")
        strHTML.Append(" <label class='control-label col-sm-2' for='In' style='margin-top:1%'>Days *</label>")
        'end of cOMMENTED & ADDED BY DIPALI V ON 28TH DEC 2020 FOR ALIGNMENT 
        strHTML.Append("</div>")
        strHTML.Append("<div class='left auto-sec-btn' style='border:none!important' id='btngroup'>")

        If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
            strHTML.Append(" <button type='button' class='btn updtae-btn' style='background-color: #343660; color: #fff;' onclick='SaveDetails()'>Save</button>")
        End If

        strHTML.Append("<button type='button' class='btn updtae-btn' style='color: #fff;'  onclick='ClearDetails()'>Clear</button>")
        'strHTML.Append("<button type='button' class='btn updtae-btn' style='color: #fff;' title='History' onclick='HistoryDetails()'>History</button>")
        strHTML.Append("  </div>")
        strHTML.Append("</div>")
        'Commented & Added by  pradip on 18-06-2021
        'strHTML.Append(" <div class='col-md-12 col-sm-12' style='margin-top:-1%;margin-left:2%' id='AutoclosePanelDiv'>")
        strHTML.Append(" <div class='col-md-12 col-sm-12' style='' id='AutoclosePanelDiv'>")
        'End of Commented & Added by  pradip on 18-06-2021

        strHTML.Append(" <div class='panel-group wrap' id='accordionauto' role='tablist' aria-multiselectable='true'>")
        strHTML.Append("<div class='panel'>")
        strHTML.Append("<div class='panel-heading' role='tab' id='DivAuto'>")
        strHTML.Append("<h3><span style='font-size:12px!important'>History <a role='button' data-toggle='collapse' data-parent='#accordionauto' href='#accordionauto1' aria-expanded='true' aria-controls='accordionauto1' title='Show History'>")
        strHTML.Append("<i class='fa fa-minus' style=margin-right:-53px;margin-top:-11px;color:white' id='icon'></i>")
        strHTML.Append("     <i class='fa fa-minus'></i>")
        strHTML.Append(" </a></span></h3>")

        strHTML.Append(" </div>")
        strHTML.Append("   <div id='accordionauto1' class='panel-collapse collapse' role='tabpanel' aria-labelledby='headingOne3'>")
        strHTML.Append("<div class='panel-body'>")
        strHTML.Append(" <div class='table-responsive' id='tblCloser'>")
        strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
        strHTML.Append("</div>")
        strHTML.Append("  </div>")
        strHTML.Append("  </div>")
        strHTML.Append("</div>")

        strHTML.Append(" </div>")

        strHTML.Append("</div>")
        Return strHTML.ToString
    End Function
    Protected Function WriteRequestTabGrid(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal RequestTypeID As String) As String
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
        If strWhichGrid = "Type" Then
            GetGlobalObject(RequestTypeTagID)
            'Type_Add = m_objAccessRights.Add
            'Type_Delete = m_objAccessRights.Delete
            'Type_Edit = m_objAccessRights.Edit
            'Type_View = m_objAccessRights.View
        ElseIf strWhichGrid = "Subtype" Then
            GetGlobalObject(RequestTypeTagID)
        End If
        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, RequestTypeID))
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
        ' Author                : Vidya Jadhav
        ' Created               : 1 Nov 2017
        ' Revisions             : None
        '=====================================================================
        Dim strGridHTML As New StringBuilder("")

        strGridHTML.Append(WriteHelpdeskMasterGrid(strWhichGrid, RequestTypeID))

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
    Protected Function DrawRequestTabControls(ByVal strWhichTab As String, ByVal strTabFlag As String) As String
        Dim strGridHTML As New StringBuilder("")

        strGridHTML.Append(WriteHelpdeskMasterControls(strWhichTab))


        If (strTabFlag = "") Then
            CommonFunctions.General.WriteHTML(strGridHTML.ToString)
        Else
            Return strGridHTML.ToString
        End If
    End Function
    Private Function WriteHelpdeskMasterGrid(ByVal strWhichGrid As String, ByVal RequestTypeID As String) As String

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

        intNoOfDataColumn = 7
        strDivID = "divAUTOCLOSER"
        strSQLQuery = "Usp_NG2_Sel_tbl_NG2_CRM_Autocloser_AuditTrail "

        arrstrActualList = {"SrNo", "FieldName", "IntialValue", "NewValue", "Remark", "ModifiedBy", "ModifiedDate"}
        arrstrUserFriendlyList = {"Sr No.", "Field Name", "Old Value", "New Value", "Remark", "Modified By", "Modified Date"}
        arrstrLinkArray = {"", "", "", "", "", "", ""}
        arrCheckBoxArray = {"", "", "", "", "", "", ""}
        arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
        objGrid = m_objSubRequestTypeGrid



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
            ' .PageSize = m_intNoOfRecordInGrid
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            strGridHTML.Append(.DrawGrid())
        End With

        'intRecordCount = m_objGridAttachment.NoOfRows

        objGrid = Nothing

        Return strGridHTML.ToString
    End Function
    Private Function WriteHelpdeskMasterControls(ByVal strWhichTabControls As String) As String
        Dim strHTML As New StringBuilder


        Return strHTML.ToString
    End Function
    Private Sub m_objTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objTypeGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            If m_strRequestTypeID = Args.DataReader("RequestTypeID") Then
                ''Args.StringToBeInserted = "<td align='center' Title = 'Select Checkbox'><a  id=chkRequestTypeSelect name=chkRequestTypeSelect  checked=true onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt'  checked=true id=chkRequestTypeSelect name=chkRequestTypeSelect onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Checkbox'><button type='button' class='edit-bt'  id=chkRequestTypeSelect name=chkRequestTypeSelect onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If

        If Args.DataField.ToUpper = "SUBREQUESTTYPE" Then
            Cancel = True
            Dim DiscussionThreadless As String = ""
            Dim SubRequestType() As String

            If CommonFunction.Data.CheckIsDBNull(Args.DataReader("SubRequestType"), "") <> "" Then
                SubRequestType = Args.DataReader("SubRequestType").Split(",")
                If SubRequestType.Length > 2 Then
                    Args.StringToBeInserted = "<td align='left' Title = 'Sub Request Type'>" & SubRequestType(0) & "," & SubRequestType(1) & "... </TD>"
                Else
                    Args.StringToBeInserted = "<td align='left' Title = 'Sub Request Type'>" & SubRequestType(0) & " </TD>"
                End If


            Else
                Args.StringToBeInserted = "<td align='left' Title = 'Sub Request Type'> </TD>"
            End If

        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_RequestType " & Args.DataReader("RequestTypeID"), True), "0")

            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
            If m_strCanDelete = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete disabled  value=" & Args.DataReader("RequestTypeID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkRequestTypeDelete name=chkRequestTypeDelete  value=" & Args.DataReader("RequestTypeID") & " >" + "</TD>"
            End If
        End If


    End Sub


    Private Sub m_objSubRequestTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSubRequestTypeGrid.DataRowTD_BeforePrint
        ''Added By Usha Pandit On 21.06.2019 for keeping previously inserted days count as selected in drop down 
        If Args.ColumnName.ToUpper = "SR NO." Then
            If blnLatestAutoCloseDaysSet = False Then
                blnLatestAutoCloseDaysSet = True
                strLatestAutoCloseDays = Args.DataReader("NewValue")
            End If

        End If
        ''End of Added By Usha Pandit On 21.06.2019 for keeping previously inserted days count as selected in drop down 
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            m_strIsTypeMapped = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Sel_tbl_CRM_RequestType_SubRequestType " & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID, True), "0")

            m_strCanUnMap = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Unmap_tbl_CRM_SubRequestType " & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID, True), "0")


            If m_strIsTypeMapped = "1" And m_strCanUnMap = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Map Sub Type'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType checked=true disabled onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
            ElseIf m_strIsTypeMapped = "1" And m_strCanUnMap = "0" Then
                If m_objSubTabAccess.Add = True And m_objSubTabAccess.Edit = True Then
                    Args.StringToBeInserted = "<td align='center' Title = 'Map Sub Type'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType checked=true onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
                Else
                    Args.StringToBeInserted = "<td align='center' Title = 'You do not have add or edit access'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType  disabled onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")""  value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
                End If
            Else
                If m_objSubTabAccess.Delete = True Then
                    Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType onclick=""MapSubRequestType(this," & Args.DataReader("SubRequestTypeID") & "," & str_RequestTypeID & ")"" value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
                Else
                    Args.StringToBeInserted = "<td align='center' Title = 'You do not have delete access'><input type=checkbox id=chkMapSubRequestType name=chkMapSubRequestType disabled value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
                End If

            End If
        End If
    End Sub

    Private Sub m_objTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objTypeGrid.ColumnHeaderTD_BeforePrint

        Select Case UCase(Trim(Args.DataField & ""))
            Case "REQUESTTYPECODE"
                Cancel = True
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.TDStyle = " "

                Args.StringToBeInserted = "<th align='center'> Request Code<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "REQUESTTYPE"
                Cancel = True

                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='center'>Request Type<i class='fa fa-sort' aria-hidden='true'></i></th>"

            Case "SUBREQUESTTYPE"
                Cancel = True

                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='center'>Sub Request Type<i class='fa fa-sort' aria-hidden='true'></i></th>"

        End Select

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input onclick='DeleteMultiple_RequestType()' type=checkbox id=chkAllDeleteType name=chkAllDeleteType /></th>"

        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            '  Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
            Args.StringToBeInserted = "<th>Edit</i></th>"
        End If

    End Sub
    Private Sub m_objSubTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSubTypeGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            If m_strSubRequestTypeID = Args.DataReader("SubRequestTypeID") Then
                ''Args.StringToBeInserted = "<td align='center' Title = 'Select Checkbox'><a  id=chkRequestTypeSelect name=chkRequestTypeSelect  checked=true onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt'  checked=true id=chkSubRequestTypeSelect name=chkSubRequestTypeSelect onclick='Edit_SubRequestType(this," & Args.DataReader("SubRequestTypeID") & ")' value=" & Args.DataReader("SubRequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt'  id=chkSubRequestTypeSelect name=chkSubRequestTypeSelect onclick='Edit_SubRequestType(this," & Args.DataReader("SubRequestTypeID") & ")' value=" & Args.DataReader("SubRequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"

            m_strCanSubTypeDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_SubRequestType " & Args.DataReader("SubRequestTypeID"), True), "0")


            If m_strCanSubTypeDelete = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkSubRequestTypeDelete name=chkSubRequestTypeDelete disabled value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkSubRequestTypeDelete name=chkSubRequestTypeDelete  value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
            End If
        End If

        If Args.DataField.ToUpper = "CONFIGURESTATUSFLOW" Then
            Cancel = True
            m_strChkConfigureStatusFlow = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Sel_tbl_CRM_StatusFlow " & Args.DataReader("SubRequestTypeID"), True), "0")

            If m_strChkConfigureStatusFlow = "1" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Configure Status Flow'><a href='#' onclick=""ConfigureStatusFlow(this," & Args.DataReader("SubRequestTypeID") & ")"">Configure Status Flow</a></TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Configure Status Flow'>Configure Status Flow</TD>"
            End If
        End If


    End Sub

    Private Sub m_objSubTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objSubTypeGrid.ColumnHeaderTD_BeforePrint

        Select Case UCase(Trim(Args.DataField & ""))
            Case "SUBREQUESTTYPECODE"
                Cancel = True
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.TDStyle = " "

                Args.StringToBeInserted = "<th align='center'>Sub Request Type Code<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "SUBREQUESTTYPE"
                Cancel = True

                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='center'>Sub Request Type<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "TASKTYPE"
                Cancel = True

                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='left'>Task Type<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "CONFIGURESTATUSFLOW"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='left'>Configure Statusflow <i class='fa fa-sort' aria-hidden='true'></i></th>"

        End Select

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input onclick='DeleteMultiple_SubRequestType()' type=checkbox id=chkAllDeleteSubType name=chkAllDeleteSubType /></th>"
        End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
        End If

    End Sub
    Private Sub m_objStatusGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objStatusGrid.ColumnHeaderTD_BeforePrint

        Select Case UCase(Trim(Args.DataField & ""))
            Case "STATUSCODE"
                Cancel = True
                Args.ApplyHTMLEncode = False
                Args.ApplySorting = False
                Args.StringToBeInserted = "<th align='center'>Status Code<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "STATUS"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='center'>Status<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "STATUSOFSTATUS"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='left'>System Status<i class='fa fa-sort' aria-hidden='true'></i></th>"
            Case "ORDERNUMBER"
                Cancel = True
                Args.ApplySorting = False
                Args.ApplyHTMLEncode = False
                Args.StringToBeInserted = "<th align='left'>Order Number<i class='fa fa-sort' aria-hidden='true'></i></th>"

        End Select

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center'><input onclick='DeleteMultiple_Status()' type=checkbox id=chkAllDeleteStatus name=chkAllDeleteStatus /></th>"
        End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th style='text-align:center'>Edit</th>"
        End If


    End Sub
    Private Sub m_objStatusGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objStatusGrid.DataRowTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td style='text-align:left'><input type=checkbox name='chkStatusSelect' title='select' /></td>"
        'End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            If m_strStatusID = Args.DataReader("StatusID") Then
                ''Args.StringToBeInserted = "<td align='center' Title = 'Select Checkbox'><a  id=chkRequestTypeSelect name=chkRequestTypeSelect  checked=true onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt'  checked=true id=chkStatusSelect name=chkStatusSelect onclick='EditRequestStatus(this," & Args.DataReader("StatusID") & ")' value=" & Args.DataReader("StatusID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt'  id=chkStatusSelect name=chkStatusSelect onclick='EditRequestStatus(this," & Args.DataReader("StatusID") & ")' value=" & Args.DataReader("StatusID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanStatusDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Chk_Del_tbl_CRM_Status " & Args.DataReader("StatusID"), True), "0")

            If m_strCanStatusDelete = "0" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkStatusDelete name=chkStatusDelete   value=" & Args.DataReader("StatusID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = '" & m_strCanStatusDelete & "'><input type=checkbox id=chkStatusDelete disabled name=chkStatusDelete  value=" & Args.DataReader("StatusID") & ">" + "</TD>"
            End If
        End If
    End Sub

    Private Sub m_objPriorityGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objPriorityGrid.ColumnHeaderTD_BeforePrint
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
    Private Sub m_objPriorityGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objPriorityGrid.DataRowTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td><input type=checkbox name='chkPrioritySelect' title='select' /></td>"
        'End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            If m_strSeverityID = Args.DataReader("PriorityID") Then
                Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Edit'><button type='button' class='edit-bt'  checked=true id=chkPrioritySelect name=chkPrioritySelect onclick='EditRequestPriority(this," & Args.DataReader("PriorityID") & ")' value=" & Args.DataReader("PriorityID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Edit'><button type='button' class='edit-bt'  id=chkPrioritySelect name=chkPrioritySelect onclick='EditRequestPriority(this," & Args.DataReader("PriorityID") & ")' value=" & Args.DataReader("PriorityID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanPriorityDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_Priority " & Args.DataReader("PriorityID"), True), "0")

            If m_strCanPriorityDelete = "0" Then
                Args.StringToBeInserted = "<td style='text-align:center;' Title = 'Delete'><input type=checkbox id=chkPriorityDelete name=chkPriorityDelete  value=" & Args.DataReader("PriorityID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td style='text-align:center;'' Title='Delete'><input type=checkbox id=chkPriorityDelete name=chkPriorityDelete disabled value=" & Args.DataReader("PriorityID") & ">" + "</TD>"
            End If
        End If
    End Sub

    Private Sub m_objSeverityGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objSeverityGrid.ColumnHeaderTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        'End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            Args.StringToBeInserted = "<th align='center'><input onclick='DeleteMultiple_Severity()' type=checkbox id=chkAllDeleteSeverity name=chkAllDeleteSeverity /></th>"
        End If

        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<th  align='center'>Edit</th>"
        End If
    End Sub
    Private Sub m_objSeverityGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSeverityGrid.DataRowTD_BeforePrint
        'If Args.DataField.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<td><input type=checkbox name='chkSeveritySelect' title='select' /></td>"
        'End If


        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            If m_strSeverityID = Args.DataReader("SeverityID") Then
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt' checked=true id=chkSeveritySelect name=chkSeveritySelect onclick='EditRequestSeverity(this," & Args.DataReader("SeverityID") & ")' value=" & Args.DataReader("SeverityID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit'><button type='button' class='edit-bt'  id=chkSeveritySelect name=chkSeveritySelect onclick='EditRequestSeverity(this," & Args.DataReader("SeverityID") & ")' value=" & Args.DataReader("SeverityID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            m_strCanSevrityDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_Tbl_CRM_Severity " & Args.DataReader("SeverityID"), True), "0")

            If m_strCanSevrityDelete = "0" Then
                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkSeverityDelete name=chkSeverityDelete  value=" & Args.DataReader("SeverityID") & " >" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkSeverityDelete name=chkSeverityDelete disabled value=" & Args.DataReader("SeverityID") & ">" + "</TD>"
            End If
        End If
    End Sub

    Private Sub m_objDepartmentGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objDepartmentGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input type=checkbox name='chkSubTypeSelect' title='select' /></th>"
        End If
    End Sub
    Private Sub m_objDepartmentGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objDepartmentGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "SELECT" Then
            Cancel = True

            Args.StringToBeInserted = "<td><input type=checkbox name='chkDepartmentSelect' title='select' /></td>"
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
        ' Author                : Vidya Jadhav
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestAutoClose()

            strGridHTML.Append(objSetting.AutoCloseTabDetails(GridParameter("cityName"), "AJAXRefresh"))


            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
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
        ' Author                : Vidya Jadhav
        ' Created Date           : 5th-OCT-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestAutoClose()

            strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))



            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    
    <System.Web.Services.WebMethod> _
    Public Shared Function DrawControls(ByVal TabParameter As Object) As String
        '=====================================================================
        ' Procedure Name        : DrawControls
        ' Purpose               : To Draw Controls
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vidya Jadhav
        ' Created Date           :8 Nov -2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestAutoClose()

            strGridHTML.Append(objSetting.DrawRequestTabControls(TabParameter("cityName"), "AJAXRefresh"))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAutocloserDetails(ByVal NoDays As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveAutocloserDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Save Auto Closer Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali Vekhande
        ' Created				:   20th Nov 2017
        '=====================================================================
        Try
            Dim strResult As Integer = 0
            Dim strUserName As String = ""
            Dim intUserID As Integer
            strUserName = CType(HttpContext.Current.Session("strUserName"), String)
            intUserID = CType(HttpContext.Current.Session("intUserID"), Integer)
            Dim strSQL As String
            If (NoDays = "") Then
                NoDays = "NULL"
            End If


            strSQL = "Usp_NG2_Ins_AutocloserDaysConfiguration " & NoDays & ",'" & strUserName & "'," & intUserID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
#End Region
End Class