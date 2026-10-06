Public Class CRM_RequestSubType
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
    Private WithEvents m_objCustomerClientContactGrid As New WebPages.Template.GenericGrid
    Protected Shared m_Customer As Integer = 0

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
#End Region

    Private Property Type_Edit As Boolean

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Protected WithEvents m_objGrid As New WebPages.Template.GenericGrid

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
        strHTML.Append(WriteTabsControls("Type", "Load", "", ""))
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
    Protected Function WriteTabsControls(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal Flag As String, ByVal SubRequestTypeID As String) As String
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

        strHTML.Append("<div id='Subtype' class='tabcontent1 h-type h-form clsSettingstabs'>")
        strHTML.Append(SubRequestTabDetails(strWhichGrid, strGridFlag, SubRequestTypeID))
        strHTML.Append("</div>")
        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function

#Region "Request Tab Section Related Code"
    'Public Function SubRequestTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String)
    '    '=====================================================================
    '    ' Procedure Name        : SubRequestTabDetails()	
    '    ' Purpose               : To Plot the Request Tab Controls
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : HTML
    '    ' Parameters Affected   : None
    '    ' Assumptions           : None
    '    ' Dependencies          : None
    '    ' Author                : Vidya Jadhav
    '    ' Created               : 1 Nov 2017
    '    ' Revisions             : None
    '    '=====================================================================
    '    GetGlobalObject()

    '    Dim strHTML As New StringBuilder("")
    '    strHTML.Append(" <div  id='divScrollSubType'>")
    '    strHTML.Append(" <div class='type-top-bar top-bar'  id='divSubTypeTab'>")
    '    'Commented & Add by Dipali For Searchbox Tooltip & Alignment
    '    'strHTML.Append("    <ul class='left'>")
    '    'strHTML.Append(" <li class='left search-bar'>")
    '    'strHTML.Append("<div class='left search-bar'>")
    '    'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
    '    'strHTML.Append("<input type='text' id='SearchSubRquestType'   placeholder='Search in table' title='Type here to search '>")
    '    'strHTML.Append("</div>")
    '    'strHTML.Append("</li>")
    '    'strHTML.Append("</ul>")

    '    strHTML.Append("<ul class='left'>")
    '    strHTML.Append("<li class='search-bar'>")
    '    strHTML.Append("<div class='left search-bar'>")
    '    strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
    '    strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table' title='Type here to search '>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</li>")
    '    strHTML.Append("</ul>")
    '    'End of Commented & Add by Dipali For Searchbox Tooltip & Alignment
    '    strHTML.Append("<ul class='right'>")
    '    If m_objAccessRights.Add = True Then
    '        strHTML.Append("<li class='clearall'>")
    '        strHTML.Append(" <button type='button' onclick=""document.getElementById('id14').style.display='block'"" class='btn btn-default' title='Inherit Status Flow'>Inherit Status Flow</button></li>")
    '    End If
    '    If m_objAccessRights.Delete = True Then
    '        strHTML.Append("<li class='clearall'>")
    '        strHTML.Append("<button type='button' onclick='AddSubRequestType()' style='color:black!important;background-color:white!important' class='btn btn-default' title='Add'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")

    '        strHTML.Append("</li>")
    '    End If
    '    strHTML.Append("<li class='clearall'>")
    '    strHTML.Append("<button onclick='DeleteSubRequestType()' type='button' style='color:black!important;background-color:white!important'  class='btn btn-default' title='Delete'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
    '    strHTML.Append("</li>")
    '    strHTML.Append(" </ul>")
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='table-responsive' id='divtblSubType'>")
    '    strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
    '    strHTML.Append("</div>")
    '    strHTML.Append(" <div class='bottom-bar' id='divSubTypeBottom'>")
    '    strHTML.Append(" <div class='pannel-section'>")
    '    strHTML.Append("<div class='col-md-12 col-sm-12'  style='padding-left: 15px; padding-right: 15px;'>")
    '    strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
    '    strHTML.Append("<div class='panel'>")
    '    strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'>")
    '    strHTML.Append("<h3><span>Add New Sub Type<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
    '    strHTML.Append("<h4 class='panel-title'>")
    '    strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2'>")
    '    strHTML.Append("<i class='fa fa-plus toggle-plus' id='plus'></i>")
    '    strHTML.Append("<i class='fa fa-minus toggle-plus' id='minus'></i>")
    '    strHTML.Append("</a>")
    '    strHTML.Append("</h4>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2'>")
    '    strHTML.Append("<div class='panel-body' style = 'padding-top: 4px;'>")
    '    strHTML.Append("<form class='form-horizontal'>")
    '    strHTML.Append("<div class='form-group'>")
    '    strHTML.Append("<label class='control-label col-sm-2' for='request type'>Sub Type Code*</label>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SubrequesttypeCode", "SubrequesttypeCode", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Work Hours*</label>")
    '    strHTML.Append(" <div class='col-sm-4'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sub_WorkHrs", "Sub_WorkHrs", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
    '    strHTML.Append(" </div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='form-group'>")
    '    strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Sub Request Type*</label>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sub_requesttype", "Sub_requesttype", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" <label class='control-label col-sm-2' for='request type'>Attachment Mandatory</label>")
    '    strHTML.Append(" <div class='col-sm-4'>")
    '    strHTML.Append("<input type='checkbox' style='width: 11px;' name='ChkAttachment' id='ChkAttachment'>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" <div class='form-group'>")
    '    strHTML.Append(" <label class='control-label col-sm-2' for='request type'>SLA Red Threshold*</label>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SLAThRed", "SLAThRed", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("<label class='control-label col-sm-2' for='request type'>SLA Yellow Threshold*</label>")
    '    strHTML.Append("<div class='col-sm-4'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SLAThYellow", "SLAThYellow", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("<div class='form-group'>")
    '    strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Task Type*</label>")
    '    strHTML.Append(" <div class='col-sm-4'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubrequestTasktype", "usp_Sel_tbl_PM_TaskTypes ", , , "class='form-control' ", , True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append("  </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" <div class='form-group'>")
    '    strHTML.Append("<label class='control-label col-sm-2' for='request type'>Guidelines For Requestor</label>")
    '    strHTML.Append("<div class='col-sm-4'>")

    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtGForRequestor", "txtGForRequestor", , "form-control", , , , , , , , , , , , , , , "", True))
    '    strHTML.Append("</div>")
    '    strHTML.Append("<label class='control-label col-sm-2' for='request type'>Guidelines For Asignee</label>")
    '    strHTML.Append("<div class='col-sm-4'>")
    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtGForAssinee", "txtGForAssinee", , "form-control", , , , , , , , , , , , , , , "", True))
    '    strHTML.Append("   </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append("<div class='form-group'>")
    '    strHTML.Append(" <div class='right'>")
    '    If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
    '        strHTML.Append("<button type='button' onclick='SaveSubRequestType_Onclick(""SaveAdd"")' class='btn btn-default save' style='background-color: #343660; color: #fff;' title='Save'>Save</button>")
    '        strHTML.Append("<button type='button' onclick='SaveAndAddSubRequestType_Onclick(""SaveAdd"")' class='btn btn-default save clsbuttonLinks' style='background-color: #343660; color: #fff; border-left: 1px solid;' title='Save and Add'>Save and Add<i class='fa fa-plus' aria-hidden='true' id='isSaveandAdd'></i></button>")
    '    End If
    '    strHTML.Append(" <button type='button' id='idShowHistory' style='display:none;' onclick='ShowHistory()'  class='btn btn-default save' title='History'>Show History</button>")
    '    strHTML.Append(" <button type='button' onclick='Cancel_SubType()' class='btn btn-default save' style='margin-right: 11px;' title='Cancel'>Cancel</button>")


    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </form>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("  </div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("</div>")
    '    strHTML.Append("  </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    strHTML.Append(" </div>")
    '    Return strHTML.ToString
    'End Function
    'Public Function RequestTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal CustomerID As String)
    Public Function SubRequestTabDetails(ByVal strWhichGrid As String, ByVal strGridFlag As String, ByVal SubRequestTypeID As String)
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
        GetGlobalObject()
        'TagID = 54
        Dim strHTML As New StringBuilder("")
        If strWhichGrid <> "PlotSubtab" And strWhichGrid <> "ClientContact" Then
            strHTML.Append(" <div  id='divScrollSubType'>")
            strHTML.Append(" <div class='type-top-bar top-bar'  id='divSubTypeTab'>")
            'Commented & Add by Dipali For Searchbox Tooltip & Alignment
            'strHTML.Append("    <ul class='left'>")
            'strHTML.Append(" <li class='left search-bar'>")
            'strHTML.Append("<div class='left search-bar'>")
            'strHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
            'strHTML.Append("<input type='text' id='SearchSubRquestType'   placeholder='Search in table' title='Type here to search '>")
            'strHTML.Append("</div>")
            'strHTML.Append("</li>")
            'strHTML.Append("</ul>")
            '/*Changed By Yasmin on 25th july 2018*/
            strHTML.Append("<ul class='left'>")
            strHTML.Append("<li class='search-bar'>")
            strHTML.Append("<div class='left search-bar'>")
            strHTML.Append("<i id='idSearchHistory' class='fa fa-search' aria-hidden='true'></i>")
            strHTML.Append("<input type='text' id='SearchRquestType' placeholder='Search in table'>")
            strHTML.Append("</div>")
            strHTML.Append("</li>")
            strHTML.Append("</ul>")
            'End of Commented & Add by Dipali For Searchbox Tooltip & Alignment
            strHTML.Append("<ul class='right'>")
            If m_objAccessRights.Add = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append(" <button type='button' onclick=""document.getElementById('id14').style.display='block'"" class='btn btn-default' >Inherit Status Flow</button></li>")
            End If
            If m_objAccessRights.Delete = True Then
                strHTML.Append("<li class='clearall'>")
                strHTML.Append("<button type='button' onclick='AddSubRequestType()' style='color:black!important;background-color:white!important' class='btn btn-default' title='Add Sub Request Type'>Add<i class='fa fa-plus' aria-hidden='true'></i></button>")

                strHTML.Append("</li>")
            End If
            strHTML.Append("<li class='clearall'>")
            strHTML.Append("<button onclick='DeleteSubRequestType()' type='button' style='color:black!important;background-color:white!important'  class='btn btn-default' title='Delete Sub Request Type'>Delete<i class='fa fa-trash-o' aria-hidden='true'></i></button>")
            strHTML.Append("</li>")
            strHTML.Append(" </ul>")
            strHTML.Append("</div>")
            strHTML.Append(" <div class='table-responsive' id='divtblSubType'>")
            strHTML.Append(WriteRequestTabGrid(strWhichGrid, strGridFlag, ""))
            strHTML.Append("</div>")
            strHTML.Append(" <div class='bottom-bar' id='divSubTypeBottom'>")
            strHTML.Append(" <div class='pannel-section'>")
            strHTML.Append("<div class='col-md-12 col-sm-12'  style='padding-left: 15px; padding-right: 15px;'>")
            strHTML.Append("<div class='panel-group wrap' id='accordion2' role='tablist' aria-multiselectable='true'>")
            strHTML.Append("<div class='panel'>")
            strHTML.Append("<div class='panel-heading' role='tab' id='headingOne2'>")
            strHTML.Append("<h3><span>Add New Sub Type<i class='fa fa-plus' style='float: none; padding-left: 10px;'></i></span></h3>")
            strHTML.Append("<h4 class='panel-title'>")
            strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2' aria-expanded='true' aria-controls='collapseOne2' id='Addaccordion'>")
            'strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion2' href='#collapseOne2 #divSubRequestType' aria-expanded='true' aria-controls='collapseOne2 divSubRequestType' id='Addaccordion'>")

            strHTML.Append("<i class='fa fa-plus toggle-plus' title='Expand' id='plus'></i>")
            strHTML.Append("<i class='fa fa-minus toggle-plus' title='Hide' id='minus'></i>")
            strHTML.Append("</a>")
            strHTML.Append("</h4>")
            strHTML.Append("</div>")
            strHTML.Append("<div id='collapseOne2' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne2'>")
            strHTML.Append("<div class='panel-body' style = 'padding-top: 4px;'>")
            strHTML.Append("<form class='form-horizontal'>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2' style='white-space:nowrap;' for='request type'>Sub Type Code*</label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SubrequesttypeCode", "SubrequesttypeCode", "form-control", , 30, , , , , , , , " class='form-control' placeholder='Enter Sub request type Code'  ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")

            'strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Work Hours*</label>")
            'strHTML.Append(" <div class='col-sm-4'>")

            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sub_WorkHrs", "Sub_WorkHrs", "form-control", , , , , , , , , , " class='form-control'   ", returnHTML:=True, EnableHTMLEncode:=True))
            'strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <label class='control-label col-sm-2' style='white-space:nowrap;' for='request type'>Sub Request Type*</label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Sub_requesttype", "Sub_requesttype", "form-control", , 100, , , , , , , , " class='form-control'  placeholder='Enter Sub request type' ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append(" </div>")
            strHTML.Append(" <label class='control-label col-sm-2' style='white-space:nowrap;' for='request type'>Attachment Mandatory</label>")
            strHTML.Append(" <div class='col-sm-4'>")
            strHTML.Append("<input type='checkbox' style='width: 11px;' name='ChkAttachment' id='ChkAttachment'>")
            strHTML.Append(" </div>")
            strHTML.Append(" </div>")
            strHTML.Append(" <div class='form-group'>")
            strHTML.Append(" <label class='control-label col-sm-2' style='white-space:nowrap;' for='request type'>SLA Red Threshold*</label>")
            strHTML.Append("<div class='col-sm-4'>")
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SLAThRed", "SLAThRed", "form-control", , 8, , , , , , , , " class='form-control'  placeholder='Enter SLA Red Threshold'  ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("<label class='control-label col-sm-2' style='white-space:nowrap;' for='request type'>SLA Yellow Threshold*</label>")
            strHTML.Append("<div class='col-sm-4'>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("SLAThYellow", "SLAThYellow", "form-control", , 8, , , , , , , , " class='form-control'  placeholder='Enter SLA Yellow Threshold'  ", returnHTML:=True, EnableHTMLEncode:=True))
            strHTML.Append("</div>")
            strHTML.Append("</div>")
            '/*Added By Kashish for ui change*/
            strHTML.Append("<div class=''>")
            'strHTML.Append("  <label class='control-label col-sm-2' for='request type'>Task Type*</label>")
            'strHTML.Append(" <div class='col-sm-4'>")

            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("SubrequestTasktype", "usp_Sel_tbl_PM_TaskTypes ", , , "class='form-control' ", , True))
            'strHTML.Append("</div>")
            'strHTML.Append("<label class='control-label col-sm-2' for='request type'></label>")
            'strHTML.Append("<div class='col-sm-4'>")
            'strHTML.Append("  </div>")
            'strHTML.Append(" </div>")
            strHTML.Append(" <div class='form-group'>")
            strHTML.Append("<label class='control-label col-sm-2' style='white-space:nowrap;' for='request type'>Guidelines For Requestor</label>")
            strHTML.Append("<div class='col-sm-4'>")

            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtGForRequestor", "txtGForRequestor", , "form-control", , , , , , , , , , , , , , , "placeholder='Enter Guidelines For Requestor'", True))
            strHTML.Append("</div>")

            'Commented and added by Usha Pandit on 04 JAN 2018
            'strHTML.Append("<label class='control-label col-sm-2' for='request type'>Guidelines For Asignee</label>")
            strHTML.Append("<label class='control-label col-sm-2' style='white-space:nowrap;' for='request type'>Guidelines For Assignee</label>")
            'End of Added by Usha Pandit on 04 JAN 2018

            strHTML.Append("<div class='col-sm-4'>")

            'Commented and added by Usha Pandit on 04 JAN 2018
            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtGForAssinee", "txtGForAssinee", , "form-control", , , , , , , , , , , , , , , "placeholder='Enter Guidelines For Asignee'", True))
            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtGForAssinee", "txtGForAssinee", , "form-control", , , , , , , , , , , , , , , "placeholder='Enter Guidelines For Assignee'", True))
            'End of Added by Usha Pandit on 04 JAN 2018
            '/*Added By Yasmin on 27th july 2018*/
            strHTML.Append("   </div>")
            strHTML.Append(" </div>")
            strHTML.Append("<div class='form-group'>")
            strHTML.Append(" <div class='right'>")
            If m_objAccessRights.Add = True Or m_objAccessRights.Edit = True Then
                strHTML.Append("<button type='button' onclick='SaveSubRequestType_Onclick(""SaveAdd"")' class='btn btn-default save' style='background-color: #343660; color: #fff;' >Save</button>")
                strHTML.Append("<button type='button' onclick='SaveAndAddSubRequestType_Onclick(""SaveAdd"")' class='btn btn-default save clsbuttonLinks' style='background-color: #343660; color: #fff; border-left: 1px solid;' >Save and Add<i class='fa fa-plus' id='idPlus' aria-hidden='true'style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
            End If
            strHTML.Append(" <button type='button' id='idShowHistory' style='display:none;margin-left: 0px!important' onclick='ShowHistory()'  class='btn btn-default save'  style='margin-left: 1px!imporatnt;'>Show History</button>")
            '/*Added By Kashish for ui change*/
            strHTML.Append(" <button type='button' onclick='Cancel_SubType()' class='btn btn-default save'  style='margin-left: 1px!important;'>Cancel</button>")
            'End of Added by Kashish  for ui change*/


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
            'strHTML.Append(" </div>")
            strHTML.Append("<div id='divSubRequestType'>")
        Else          

                'strHTML.Append("<div id='divSubRequestType'>")
            If strWhichGrid <> "ClientContact" And strWhichGrid <> "PlotSubtab" Then
                strHTML.Append("<div class='clsHideHorizontalDiv' id='DivHorizontal'>")
            End If
                strHTML.Append("<div class='h-tabs'>")

            strHTML.Append("<div class='navtab'>")
                GetSubTabAccessRights(90, 54)
                If m_objSubTabAccess.View = True Then
                    strHTML.Append("<button id='btnConfigureHRM' class='tablinks4 active clsSubtags' onclick='openCity4(event, ""ConfigureHRM"")' id='defaultOpen4'>Templates</button>")
                End If
                GetSubTabAccessRights(3373, 54)
                If m_objSubTabAccess.View = True Then
                    strHTML.Append("<button id='btnProjectMapping' class='tablinks4 clsSubtags' onclick='openCity4(event, ""ProjectMapping"")'>Caption</button>")
                End If

                strHTML.Append("</div>")
                strHTML.Append("</div>")


            If strWhichGrid <> "ClientContact" And strWhichGrid <> "PlotSubtab" Then
                strHTML.Append("<div id='ConfigureHRM' class='tabcontent4' style='display: block;'>")
                strHTML.Append("<div class='type-top-bar top-bar'>")

                GetSubTabAccessRights(90, 54)
                If m_objSubTabAccess.Add = True Then
                    strHTML.Append("<ul class='right'>")
                    strHTML.Append("<li class='clearall'><button type='button' onclick='AddcustomerContact()' style='background-color:white!important;color:black!important' class='btn btn-default'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")
                    strHTML.Append("</ul>")
                End If

                strHTML.Append("</div>")
                strHTML.Append("<div class='table-responsive'  id='tblConfigureHRM' >")
                strHTML.Append(WriteHelpdeskMasterGrid("PlotSubtab", SubRequestTypeID))
                strHTML.Append(" </div>")

                strHTML.Append("<div class='pannel-section' id='customerControl'>")
                strHTML.Append("<div class='col-md-12 col-sm-12'>")

                strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
                strHTML.Append("<div class='panel'>")
                strHTML.Append("<div class='panel-heading' role='tab' id='panelHRMAdd'  style='width: 99%;'>")
                strHTML.Append("<h3 style='font-size: 13px;'><span style='color:white'>Add Customer Contacts </span></h3>")
                strHTML.Append("<h4 class='panel-title'>")
                strHTML.Append("<a role='button' data-toggle='collapse' data-parent='#accordion'href='#collapseOne11' aria-expanded='true' aria-controls='collapseOne'>")
                strHTML.Append("<i class='fa fa-plus' title='Expand' style='color:white!important'></i>")
                strHTML.Append("<i class='fa fa-minus' title='Hide' style='color:white!important'></i>")
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
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("TypeofContact", sql, 291, , " class='form-control clscombo' ", True, True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")
                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Email ID*</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactEmailID", "ContactEmailID", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Email ID' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append("</div>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Mobile</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Mobile", "Mobile", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Mobile' ", returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                strHTML.Append("<div class='form-group'>")
                strHTML.Append("<label class='control-label col-sm-3' for='request type'>Phone</label>")
                strHTML.Append("<div class='col-sm-3'>")
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Phone", "Phone", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Phone' ", returnHTML:=True, EnableHTMLEncode:=True))
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
                    strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveCustomerdetails1()'>Save</button>")
                    strHTML.Append("<button type='button' class='btn btn-default save'   onclick='SaveAddCustomerdetails1()'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                End If

                strHTML.Append("<button type='button' class='btn btn-default save'  onclick='CancelCustomerContact()'>Cancel</button>")
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

                If strWhichGrid = "ClientContact" Or strWhichGrid = "PlotSubtab" Then
                    strHTML.Append("<div id='ProjectMapping' class='tabcontent4' style='display:block;'>")
                    strHTML.Append("<div class='type-top-bar top-bar'>")
                    GetSubTabAccessRights(3373, 54)
                    'If m_objSubTabAccess.Add = True Then
                    '    strHTML.Append("<ul class='right'>")
                    '    strHTML.Append("<li class='clearall'><button type='button' onclick='AddClientContact()' class='btn btn-default' style='background-color:white!important;Color:black!important'>Add<i class='fa fa-plus' aria-hidden='true'></i></button></li>")

                    '    strHTML.Append("</ul>")
                    'End If
                    strHTML.Append("</div>")
                    strHTML.Append("<div class='table-responsive' id='tblProjectMapping'>")
                    strHTML.Append(WriteHelpdeskMasterGrid("ClientContact", SubRequestTypeID))
                    strHTML.Append("</div>")
                    strHTML.Append("<div class='pannel-section'>")
                    strHTML.Append("<div class='col-md-12 col-sm-12'>")

                    strHTML.Append("<div class='panel-group wrap' id='accordion' role='tablist' aria-multiselectable='true'>")
                    strHTML.Append("<div class='panel'>")
                    strHTML.Append("<div class='panel-heading' role='tab' id='panelProjectAdd'>")
                    strHTML.Append("<h3 style='font-size: 12px;width:20%;margin:-1px; '><span style='color:white'>Edit Caption</span></h3>")
                    strHTML.Append("<h4 class='panel-title'>")
                    strHTML.Append("<a role='button' data-toggle='collapse' style='margin-top:-1.5%;font-size: 12px;' data-parent='#accordion' href='#collapseOne22' aria-expanded='true' aria-controls='collapseOne' id='AddCaptionaccordion'>")
                    strHTML.Append("<i class='fa fa-plus' title='Expand'  style='color:white!important'></i>")
                    strHTML.Append("<i class='fa fa-minus' title='Hide'  style='color:white!important'></i>")
                    strHTML.Append("</a>")
                    strHTML.Append("</h4>")
                    strHTML.Append("</div>")
                    strHTML.Append("<div id='collapseOne22' class='panel-collapse collapse in' role='tabpanel' aria-labelledby='headingOne'>")
                    strHTML.Append("<div class='panel-body' id='panelProject'>")


                    strHTML.Append("<form class='form-horizontal'>")
                    strHTML.Append("<div class='form-group'>")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>Field Name*</label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("FieldName", "FieldName", "form-control", , 50, , , , True, , , , " class='form-control'  placeholder='Enter Field Name' ", returnHTML:=True, EnableHTMLEncode:=True))
                    '<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                    strHTML.Append("</div>")
                    strHTML.Append("<label class='control-label col-sm-3' for='request type'>Caption  *</label>")
                    strHTML.Append("<div class='col-sm-3'>")
                    '			<input type="text" style="width:217px;" class="form-control" id="requesttype"  name="requesttype">
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("Caption", "Caption", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Caption' ", returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append("</div>")
                    strHTML.Append("</div>")
                    'strHTML.Append("<div class='form-group'>")
                    'strHTML.Append("<label class='control-label col-sm-3' for='request type'>Address </label>")
                    'strHTML.Append("<div class='col-sm-3'>")
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactAddress", "ContactAddress", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Address' ", returnHTML:=True, EnableHTMLEncode:=True))
                    'strHTML.Append("</div>")
                    'strHTML.Append("<label class='control-label col-sm-3' for='request type'>City</label>")
                    'strHTML.Append("<div class='col-sm-3'>")
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactCity", "ContactCity", "form-control", , 30, , , , , , , , " class='form-control'  placeholder='Enter City' ", returnHTML:=True, EnableHTMLEncode:=True))
                    'strHTML.Append("</div>")
                    'strHTML.Append("</div>")

                    'strHTML.Append("<div class='form-group'>")
                    'strHTML.Append("<label class='control-label col-sm-3' for='request type'>State</label>")
                    'strHTML.Append("<div class='col-sm-3'>")
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactState", "ContactState", "form-control", , 30, , , , , , , , " class='form-control'  placeholder='Enter State' ", returnHTML:=True, EnableHTMLEncode:=True))
                    'strHTML.Append("</div>")
                    'strHTML.Append("<label class='control-label col-sm-3' for='Fax'>Email ID </label>")
                    'strHTML.Append("<div class='col-sm-3'>")
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("EmailIDClient", "EmailIDClient", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter EmailID ' ", returnHTML:=True, EnableHTMLEncode:=True))
                    'strHTML.Append("</div>")
                    'strHTML.Append("</div>")

                    'strHTML.Append("<div class='form-group'>	")
                    'strHTML.Append("<label class='control-label col-sm-3' for='request type'>Contact Person *</label>")
                    'strHTML.Append("<div class='col-sm-3'>")
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("ContactPerson", "ContactPerson", "form-control", , 50, , , , , , , , " class='form-control'  placeholder='Enter Contact Person'", returnHTML:=True, EnableHTMLEncode:=True))
                    'strHTML.Append("</div>")
                    'strHTML.Append("<label class='control-label col-sm-3' for='request type'>Region</label>")
                    'strHTML.Append("<div class='col-sm-3'>")
                    'Dim sql As String = "select RegionID,RegionName from tbl_CNF_RegionMaster order by RegionName"
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("Region", sql, 129, , " class='form-control' ", False, True))
                    'strHTML.Append("</div>")



                    strHTML.Append("<div class='form-group'> ")
                    strHTML.Append("<div class='right' id='CustomerContact'>")
                    GetSubTabAccessRights(117, 919)
                    If m_objSubTabAccess.Edit = True And m_objSubTabAccess.Add = True Then
                        strHTML.Append("<button type='button' class='btn btn-default save' style='height: 25px;'  onclick='SaveCilentdetails()'>Save</button>")
                        'strHTML.Append("<button type='button' class='btn btn-default save'  onclick='SaveAddCilentdetails()'>Save and Add<i class='fa fa-plus' aria-hidden='true' style='display: -webkit-inline-box; padding-left: 5px;color:#fff;'></i></button>")
                    End If

                    strHTML.Append("<button type='button' class='btn btn-default save' style='margin-left:5px;height: 25px;'  onclick='cancelCilent()'>Cancel</button>")
                    strHTML.Append("</div>")
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
            If strWhichGrid <> "ClientContact" And strWhichGrid <> "PlotSubtab" Then
                strHTML.Append(" </div>")
            End If
            End If



        strHTML.Append(" </div>")
            strHTML.Append("</div>")
            strHTML.Append("</div>")




            Return strHTML.ToString
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

        If strWhichGrid.ToUpper = "CLIENTCONTACT" Then
            intNoOfDataColumn = 2
            strDivID = "divCustomerContactcilent"
            strSQLQuery = "Usp_NG2_Sel_tbl_CRM_SubRequestType_Caption_Details " & RequestTypeID
            arrstrActualList = {"FieldName", "Caption", "", ""}
            arrstrUserFriendlyList = {"Field Name", "Caption", "Edit"}
            arrstrLinkArray = {"", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left"}

            objGrid = m_objCustomerClientContactGrid
            'ElseIf strWhichGrid.ToUpper = "PLOTSUBTAB" Then 'ContactPerson & "##" & Position & "##" & EMailID & "##" & Mobile & "##" & Phone & "##" & Address & "##" & Fax
            '    intNoOfDataColumn = 6
            '    strDivID = "divCustomerContact"
            '    strSQLQuery = "Usp_NG2_Sel_v_tbl_PM_CustomerContact " & RequestTypeID
            '    arrstrActualList = {"ContactPerson", "Position", "EMailID", "Mobile", "Phone", "Fax", "", ""}
            '    arrstrUserFriendlyList = {"Contact Person", "Type of Contact", "Email ID", "Mobile", "Phone", "Fax", "Select", "Delete"}
            '    arrstrLinkArray = {"", "", "", "", "", "", "", ""}
            '    arrCheckBoxArray = {"", "", "", "", "", "", "", ""}
            '    arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

            '    objGrid = m_objCustomerContactGrid
            'ElseIf strWhichGrid.ToUpper = "CLIENTCONTACT" Then 'ClientContact
            '    intNoOfDataColumn = 6
            '    strDivID = "divCustomerContactcilent"
            '    strSQLQuery = "usp_Ng2_sel_v_tbl_PM_Client " & RequestTypeID
            '    arrstrActualList = {"ClientCode", "ClientName", "ContactPerson", "EmailID", "MobileNumber", "Phone", "", ""}
            '    arrstrUserFriendlyList = {"Abbreviated Name", "Client Name", "Contact Person", "Email ID", "  Mobile", " Phone", "Select", "Delete"}
            '    arrstrLinkArray = {"", "", "", "", "", "", "", ""}
            '    arrCheckBoxArray = {"", "", "", "", "", "", "", ""}
            '    arrWidthArray = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}

            '    objGrid = m_objCustomerClientContactGrid

        End If


        If Flag = 0 Then
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
        ' Created               : 1 Nov 2017s
        ' Revisions             : None
        '=====================================================================

        Dim strGridHTML As New StringBuilder("")

        'strGridHTML.Append(WriteMasterGrid(strWhichGrid, RequestTypeID))

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
        intNoOfDataColumn = 4

        If strWhichGrid.ToUpper = "PLOTSUBTAB" Or strWhichGrid.ToUpper = "CLIENTCONTACT" Then
            intNoOfDataColumn = 2
            strDivID = "divCustomerContactcilent"
            strSQLQuery = "Usp_NG2_Sel_tbl_CRM_SubRequestType_Caption_Details " & RequestTypeID
            arrstrActualList = {"FieldName", "Caption", "", ""}
            arrstrUserFriendlyList = {"Field Name", "Caption", "Edit"}
            arrstrLinkArray = {"", "", ""}
            arrCheckBoxArray = {"", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=left"}

            objGrid = m_objCustomerClientContactGrid
        Else
            strDivID = "divGridSubRequestType"
            strSQLQuery = "Usp_Sel_NG2_SubRequestType"

            arrstrActualList = {"SubRequestTypeCode", "SubRequestType", "ConfigureStatusFlow", "", ""}
            arrstrUserFriendlyList = {"Sub Request Type Code", "Sub Request Type", "Configure Status Flow", "Edit", "Delete"}
            arrstrLinkArray = {"", "", "", "", ""}
            arrCheckBoxArray = {"", "", "", "", ""}
            arrWidthArray = {"align=left", "align=left", "align=center", "align=left", "align=left"}

            objGrid = m_objSubTypeGrid
        End If
        

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
    Private Sub m_objSubTypeGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSubTypeGrid.DataRowTD_BeforePrint

        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True

            If m_strSubRequestTypeID = Args.DataReader("SubRequestTypeID") Then
                ''Args.StringToBeInserted = "<td align='center' Title = 'Select Checkbox'><a  id=chkRequestTypeSelect name=chkRequestTypeSelect  checked=true onclick='Edit_RequestType(this," & Args.DataReader("RequestTypeID") & ")' value=" & Args.DataReader("RequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></a>" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Sub Request Type'><button type='button' class='edit-bt'  checked=true id=chkSubRequestTypeSelect name=chkSubRequestTypeSelect onclick='Edit_SubRequestType(this," & Args.DataReader("SubRequestTypeID") & ")' value=" & Args.DataReader("SubRequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Sub Request Type'><button type='button' class='edit-bt'  id=chkSubRequestTypeSelect name=chkSubRequestTypeSelect onclick='Edit_SubRequestType(this," & Args.DataReader("SubRequestTypeID") & ")' value=" & Args.DataReader("SubRequestTypeID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            End If
            ''  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeSelect' id='chkRequestTypeSelect_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"
        End If


        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            '  Args.StringToBeInserted = "<td><input type=checkbox name='chkRequestTypeDelete' id='chkRequestTypeDelete_'" & Args.DataReader("RequestTypeID") & " title='Select' /></td>"

            m_strCanSubTypeDelete = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_Chk_Del_tbl_CRM_SubRequestType " & Args.DataReader("SubRequestTypeID"), True), "0")


            If m_strCanSubTypeDelete = "1" Then
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkSubRequestTypeDelete name=chkSubRequestTypeDelete disabled value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Sub Request is in use. Can not be deleted '><input type=checkbox id=chkSubRequestTypeDelete name=chkSubRequestTypeDelete disabled value=" & Args.DataReader("SubRequestTypeID") & ">" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            Else
                'Commented and Added by Usha Pandit on 09 JAN 2018 for delete tooltip
                'Args.StringToBeInserted = "<td align='center' Title = 'Delete'><input type=checkbox id=chkSubRequestTypeDelete name=chkSubRequestTypeDelete onclick='select_checkbox(this)' value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
                Args.StringToBeInserted = "<td align='center' Title = 'Delete Sub Request Type'><input type=checkbox id=chkSubRequestTypeDelete name=chkSubRequestTypeDelete onclick='select_checkbox(this)' value=" & Args.DataReader("SubRequestTypeID") & " >" + "</TD>"
                'End of Added by Usha Pandit on 09 JAN 2018 for delete tooltip
            End If
        End If

        If Args.DataField.ToUpper = "CONFIGURESTATUSFLOW" Then
            Cancel = True
            m_strChkConfigureStatusFlow = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_NG2_Sel_tbl_CRM_StatusFlow " & Args.DataReader("SubRequestTypeID"), True), "0")

            If m_strChkConfigureStatusFlow = "1" Then

                'Commented and added by Usha Pandit on 20.12.2017 for Modal popup
                'Args.StringToBeInserted = "<td align='center' Title = 'Configure Status Flow'><a href='#' onclick=""ConfigureStatusFlow(this," & Args.DataReader("SubRequestTypeID") & ")"">Configure Status Flow</a></TD>"

                Args.StringToBeInserted = "<td align='center' ><a style='color:Red!important' onclick=""ConfigureStatusFlow(this," & Args.DataReader("SubRequestTypeID") & ", &quot;" & Args.DataReader("SubRequestType") & "&quot;)"">Configure Status Flow</a></TD>"

                'end of added by Usha Pandit on 20.12.2017 for Modal popup
            Else

                'Commented and added by Usha Pandit on 21.12.2017 for Modal popup
                'Args.StringToBeInserted = "<td align='center' Title = 'Configure Status Flow'>Configure Status Flow</TD>"
                Args.StringToBeInserted = "<td align='center' ><a  onclick=""ConfigureStatusFlow(this," & Args.DataReader("SubRequestTypeID") & ", &quot;" & Args.DataReader("SubRequestType") & "&quot;)"">Configure Status Flow</a></TD>"
                'end of added by Usha Pandit on 21.12.2017 for Modal popup

            End If
        End If


    End Sub
    Private Sub m_objSubTypeGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objSubTypeGrid.ColumnHeaderTD_BeforePrint




        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True

            Args.StringToBeInserted = "<th><input onclick='DeleteMultiple_SubRequestType()' type=checkbox id=chkAllDeleteSubType name=chkAllDeleteSubType title='Select All' /></th>"
        End If

        'If Args.ColumnName.ToUpper = "SELECT" Then
        '    Cancel = True

        '    Args.StringToBeInserted = "<th><i class='fa fa-pencil-square-o' aria-hidden='true'></i></th>"
        'End If

    End Sub
    Private Sub m_objCustomerClientContactGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objCustomerClientContactGrid.DataRowTD_BeforePrint
        If Args.ColumnName.ToUpper = "EDIT" Then
            Cancel = True
            'Dim CustomerContactID As String = ""
            'CustomerContactID = Args.DataReader("CustomerContactID")
            If m_Customer = Args.DataReader("SubRequestTypeID") Then

                Args.StringToBeInserted = "<td align='center' Title = 'Edit Caption'><button type='button' class='edit-bt'  checked=true id=chkClientCustomer name=chkClientCustomer onclick='Edit_ClientContact(this," & Args.DataReader("SubRequestTypeID") & "," & Args.DataReader("SubRequestTypeCaptionID") & ")' value=" & Args.DataReader("SubRequestTypeCaptionID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
            Else
                Args.StringToBeInserted = "<td align='center' Title = 'Edit Caption'><button type='button' class='edit-bt1' id=chkClientCustomer name=chkClientCustomer onclick='Edit_ClientContact(this," & Args.DataReader("SubRequestTypeID") & "," & Args.DataReader("SubRequestTypeCaptionID") & ")' value=" & Args.DataReader("SubRequestTypeCaptionID") & " ><i class='fa fa-pencil-square-o' aria-hidden='true'></i></button>" + "</TD>"
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
            Args.StringToBeInserted = "<td align='center' Title = 'Delete'><button type='button' class='edit-bt1'  checked=true id=chkClientCustomerDelete name=chkClientCustomerDelete onclick='Delete_ClientCustomer(this," & Args.DataReader("SubRequestTypeID") & "," & Args.DataReader("SubRequestTypeCaptionID") & ")' value=" & Args.DataReader("SubRequestTypeCaptionID") & " ><i class='fa fa-trash-o' aria-hidden='true'></i></button>" + "</TD>"
            'End If
        End If


    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function ShowMailHistoryDetails(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryDetails                              '
        ' Purpose				:   Call ShowMailHistoryGrid function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Dipali Vekhande                                 '
        '*******************************************************************************'
        Try
            Dim objSetting As New CRM_RequestSubType
            Dim strHTML As New StringBuilder("")
            Dim str As String = objSetting.ShowMailHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :    Dipali Vekhande                                      '
        '*******************************************************************************'
        Try
            Dim strHTML As New StringBuilder("")

            If (storedprocedure = Nothing) Then
                txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 919 & "','" & UniqueID & "'")
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
                '.ColNameToolTipOnEachRow = False
                .DIVID = "ShowHistoryGrid"
                .DIVStyle = "overflow: auto"
                .SQL = strSQLQuery
                '.ColNameToolTipOnEachRow = True
                .UseSQL = True
                .returnHTML = True
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode

                strHTML.Append(.DrawGrid())
            End With

            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
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
        ' Author                : Dipali V
        ' Created               : 19-Dec-2017
        ' Revisions             :
        '===============================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim objSetting As New CRM_RequestSubType
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 919, '" & MessageID & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = objSetting.ShowMailHistoryGrid(MessageID, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function




    'Added by Usha Pandit on 20.12.2017 to show modal popup for Configure Status Flow

    <System.Web.Services.WebMethod()>
    Public Shared Function getConfigureData()
        '=====================================================================
        ' Procedure Name        :	getConfigureData
        ' Purpose               :	Get Configure Status Flow Details
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	20-Dec-2017
        ' Revisions             :
        '=====================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            strSQL = "USP_NG2_SEL_StatusFlow "
            Dim dtStatusFlow As DataTable
            dtStatusFlow = CommonFunctions.Data.GetDataTable(strSQL, True)

            strResult = GetSerialized(dtStatusFlow)

            strScript = strResult.Split("|")

            strHTML.Append(strScript(0) + vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function getStatusFlowActiveStatus(ByVal SubRequestTypeID As String, ByVal FromStatusID As String, ByVal ToStatusID As String, ByVal FromStatus As String, ByVal ToStatus As String)
        '=====================================================================
        ' Procedure Name        :	getStatusFlowActiveStatus
        ' Purpose               :	Get Configure Status Flow Active Status Details
        ' Description           :	SubRequestTypeID, FromStatusID, ToStatusID, FromStatus, ToStatus
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Usha Pandit
        ' Created               :	20-Dec-2017
        ' Revisions             :
        '=====================================================================
        Try
            Dim strSQL As String
            Dim strResult As String
            Dim strHTML As New StringBuilder()
            Dim strScript As String()

            If SubRequestTypeID = "" Or SubRequestTypeID Is Nothing Then
                SubRequestTypeID = "0"
            End If

            If FromStatusID = "" Or FromStatusID Is Nothing Then
                FromStatusID = "0"
            End If

            If ToStatusID = "" Or ToStatusID Is Nothing Then
                ToStatusID = "0"
            End If

            If FromStatus = "" Then
                FromStatus = "NULL"
            End If

            If ToStatus = "" Then
                ToStatus = "NULL"
            End If

            strSQL = "USP_NG2_SEL_tbl_CRM_StatusFlow_Checked " & SubRequestTypeID & " , '" & FromStatus & "', '" & ToStatus & "'," & FromStatusID & "," & ToStatusID

            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)


            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteStatusFlowExistingDetails(ByVal SubRequestTypeID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteStatusFlowExistingDetails
        ' Parameters Passed		:	SubRequestTypeID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To delete existing entries from tbl_CRM_StatusFlow for specific SubRequestTypeID
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   20 Dec 2017
        '=====================================================================
        Try
            Dim strSQL As String = ""


        If SubRequestTypeID = "" Or SubRequestTypeID Is Nothing Then
            SubRequestTypeID = "0"
        End If

            'If RequestTypeID = "" Or RequestTypeID Is Nothing Then
            '    strSQL = "EXEC usp_Del_tbl_CRM_Function_RequestTypes_Mapping " & DepartmentID & ", NULL"
            '    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            'Else
            strSQL = "EXEC usp_Del_tbl_CRM_StatusFlow " & SubRequestTypeID & ", NULL, NULL"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            'End If
            'End If
       Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveStatusFlowNewDetails(ByVal SubRequestTypeID As String, ByVal SubRequestType As String, ByVal FromStatusID As String, ByVal ToStatusID As String, ByVal FromStatus As String, ByVal ToStatus As String) As String
        '=====================================================================
        ' Procedure  Name		:	SaveStatusFlowNewDetails
        ' Parameters Passed		:	SubRequestTypeID, SubRequestType, FromStatusID, ToStatusID
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Save New StatusFlow Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Usha Pandit
        ' Created				:   21 Dec 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")

            Dim strResult As String = ""
        If SubRequestTypeID = "" Or SubRequestTypeID Is Nothing Then
            SubRequestTypeID = "0"
        End If

        If SubRequestType = "" Then
            SubRequestType = "NULL"
        End If

        If FromStatusID = "" Or FromStatusID Is Nothing Then
            FromStatusID = "0"
        End If
        If ToStatusID = "" Or ToStatusID Is Nothing Then
            ToStatusID = "0"
        End If

        If FromStatus = "" Then
            FromStatus = "NULL"
        End If

        If ToStatus = "" Then
            ToStatus = "NULL"
        End If
        'strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))

        'drGetRole = CommonFunction.Data.GetDataReader("EXEC USP_NG2_UPD_tbl_PM_DepartmentMaster_Details " & DepartmentID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) HttpContext.Current.Session("strUserName")
        Dim strSQL As String = "EXEC usp_Ins_tbl_CRM_StatusFlow  " & SubRequestTypeID & ", '" & SubRequestType & "', " & FromStatusID & ", " & ToStatusID & ", '" & FromStatus & "', '" & ToStatus & "'"
        strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return "Success"
        Catch ex As Exception
            Return "Bad Request Found"
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
    'End of Added by Usha Pandit on 20.12.2017 to show modal popup for Configure Status Flow

#End Region
#Region "Jquery AJAX Methods"
    '<System.Web.Services.WebMethod> _
    'Public Shared Function RefreshGrid(ByVal GridParameter As Object, ByVal RequestTypeID As String, ByVal Role As String, ByVal Status As String) As String
    '    '=====================================================================
    '    ' Procedure Name        : RefreshGrid
    '    ' Purpose               : To Refresh Grid
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
    '    Dim objSetting As New CRM_RequestSubType()
    '    strGridHTML.Append(objSetting.SubRequestTabDetails(GridParameter("cityName"), "AJAXRefresh", ""))
    '    Return strGridHTML.ToString
    'End Function
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
            Dim objSetting As New CRM_RequestSubType()

        strGridHTML.Append(objSetting.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", ""))



        Return strGridHTML.ToString
        Catch ex As Exception
        Return "Bad Request Found"
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
        ' Author                : Vidya Jadhav
        ' Created Date           :8 Nov -2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objSetting As New CRM_RequestSubType()

            strGridHTML.Append(objSetting.WriteSubRequestTabGrid("PlotSubRequestType", "PlotSubRequestType", RequestTypeID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveSubRequestType(ByVal SubRequestTypeCode As String, ByVal SubRequestType As String, ByVal DefaultWork As String, ByVal IsAttachmentMandatory As String, ByVal TaskType As String, ByVal GuidelinesForRequestor As String, ByVal GuidelinesForAssignee As String, ByVal SLARedLimit As String, ByVal SLAYellowLimit As String, ByVal SubRequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim Sub_RquestTypeID As String = ""
            Dim strSQL As String = "exec Usp_NG2_Ins_Upd_tbl_CRM_SubRequestType  '" & SubRequestTypeCode & "', '" & SubRequestType & "'," & DefaultWork & "," & IsAttachmentMandatory & "," & TaskType & ",'" & GuidelinesForRequestor & "','" & GuidelinesForAssignee & "'," & SLARedLimit & "," & SLAYellowLimit & "," & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("strUserName") & "'," & SubRequestTypeID & ""
            Sub_RquestTypeID = CommonFunctions.Data.GetDataScalar(strSQL, True)

            Return Sub_RquestTypeID.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSubRequestTypeDetails(ByVal SubRequestTypeID As String) As String
        '=====================================================================
        ' Procedure  Name		:	GetSubRequestTypeDetails
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	To Get Data of  SubRequest Type Details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:  7-Nov-2017
        '=====================================================================
        Try
            Dim strResult As String = ""
            Dim drTabData As IDataReader

            Dim strUniqueID As String = ""
            Dim RequestTypeCode As String = ""
            Dim RequestType As String = ""
            Dim strReasonForOccurence As String = ""

            Dim SubRequestTypeCode As String = ""
            Dim SubRequestType As String = ""
            Dim DefaultWork As String = ""
            Dim IsAttachmentMandatory As String = ""
            Dim TaskType As String = ""
            Dim GuidelinesForRequestor As String = ""
            Dim GuidelinesForAssignee As String = ""
            Dim SLARedLimit As String = ""
            Dim SLAYellowLimit As String = ""


            Dim strSQL As String = ""
            strSQL = "Usp_NG2_Sel_tbl_CRM_SubRequestType " & SubRequestTypeID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                strUniqueID = CommonFunctions.Data.CheckIsDBNull(drTabData("SubRequestTypeID"), "")
                SubRequestTypeCode = CommonFunctions.Data.CheckIsDBNull(drTabData("SubRequestTypeCode"), "")
                SubRequestType = CommonFunctions.Data.CheckIsDBNull(drTabData("SubRequestType"), "")
                DefaultWork = CommonFunctions.Data.CheckIsDBNull(drTabData("DefaultWork"), "")
                IsAttachmentMandatory = CommonFunctions.Data.CheckIsDBNull(drTabData("IsAttachmentMandatory"), "")
                TaskType = CommonFunctions.Data.CheckIsDBNull(drTabData("TaskType"), "")
                GuidelinesForRequestor = CommonFunctions.Data.CheckIsDBNull(drTabData("GuidelinesForRequestor"), "")
                GuidelinesForAssignee = CommonFunctions.Data.CheckIsDBNull(drTabData("GuidelinesForAssignee"), "")
                SLARedLimit = CommonFunctions.Data.CheckIsDBNull(drTabData("SLARedLimit"), "")
                SLAYellowLimit = CommonFunctions.Data.CheckIsDBNull(drTabData("SLAYellowLimit"), "")

            End If
            strResult = strUniqueID & "##" & SubRequestTypeCode & "##" & SubRequestType & "##" & DefaultWork & "##" & IsAttachmentMandatory & "##" & TaskType & "##" & GuidelinesForRequestor & "##" & GuidelinesForAssignee & "##" & SLARedLimit & "##" & SLAYellowLimit


            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DeleteSubRequestType(ByVal SubRequestTypeID As String)
        '=====================================================================
        ' Procedure  Name		:	DeleteSubRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Delete Sub Type
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   8 Nov 2017
        '=====================================================================
        Try
            Dim strSQL As String = ""
            Dim arrDelete() As String
            Dim index As Integer = 0
            arrDelete = SubRequestTypeID.Split(",")


            For index = 0 To arrDelete.Length - 1

                strSQL = "exec usp_NG2_Del_tbl_CRM_SubRequestType  " & arrDelete(index) & ""

                CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            Next

        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
    '<System.Web.Services.WebMethod()>
    'Public Shared Function IsDuplicateSubRequestType(ByVal SubRequestType As String) As String
    '    '=====================================================================
    '    ' Procedure  Name		:	IsDuplicateSubRequestType
    '    ' Parameters Passed		:	
    '    ' Returns				:	string
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	Check for duplicate Sub Request Type
    '    ' Description			:	
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	Vidya Jadhav
    '    ' Created				:   8 Nov 2017
    '    '=====================================================================
    '    Dim strResult = "0"
    '    Dim strSQL As String
    '    If (SubRequestType = "") Then
    '        SubRequestType = "NULL"
    '    End If
    '    strSQL = "Usp_NG2_CheckDuplicate_SubRequestType '" & SubRequestType & "'"
    '    strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
    '    Return strResult
    'End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateSubRequestType(ByVal RequestSubType As String, ByVal RequestSubTypeCode As String, ByVal Flag As String, ByVal EditSubRequestTypeID As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateRequestType
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Request Type and Request Type Code
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali V
        ' Created				:   15 Dec 2017
        '=====================================================================
        Try
            Dim strResult As String = "0"
            Dim strSQL As String
            If (RequestSubType = "") Then
                RequestSubType = "NULL"
            End If
            If (RequestSubTypeCode = "") Then
                RequestSubTypeCode = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_SubRequestType '" & RequestSubType & "','" & RequestSubTypeCode & "','" & Flag & "'," & EditSubRequestTypeID & ""
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function IsDuplicateOrderNumber(ByVal OrderNumber As String) As String
        '=====================================================================
        ' Procedure  Name		:	IsDuplicateOrderNumber
        ' Parameters Passed		:	
        ' Returns				:	string
        ' Parameters Affected	:	None
        ' Purpose				:	Check for duplicate Order Number
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vidya Jadhav
        ' Created				:   9 Nov 2017
        '=====================================================================
        Try
            Dim strResult = "0"
            Dim strSQL As String
            If (OrderNumber = "") Then
                OrderNumber = "NULL"
            End If
            strSQL = "Usp_NG2_CheckDuplicate_OrderNumber '" & OrderNumber & "'"
            strResult = CommonFunctions.Data.GetDataScalar(strSQL, True)
            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function InheritStatusFlow(ByVal FromSubRequest As String, ByVal ToSubRequest As String) As String
        '=====================================================================
        ' Procedure Name        : SaveRequestType
        ' Description           : For Refreshing The grid0
        ' Created Date           : 11-Nov-2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim Sub_RquestTypeID As String = ""
        Dim strSQL As String = "usp_INS_InheritStatusFlow_tbl_CRM_StatusFlow  " & FromSubRequest & ", " & ToSubRequest & ""
        CommonFunctions.Data.GetDataScalar(strSQL, True)

        Return "1"
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function PlotSubtab(ByVal SubRequestTypeID As String, ByVal Flag As String) As String
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
            Dim OBJCRM_RequestSubType As New CRM_RequestSubType()

            strGridHTML.Append(OBJCRM_RequestSubType.SubRequestTabDetails("ClientContact", "PlotSubRequestType", SubRequestTypeID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetCilentContactDetails(ByVal SubRequestTypeCaptionID As String) As String
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
            Dim fieldname As String = ""
            Dim Caption As String = ""
            Dim UserFriendlyName As String = ""



            Dim strSQL As String = ""
            strSQL = "select fieldname,Caption,UserFriendlyName from tbl_CRM_SubRequestType_Caption_Details where SubRequestTypeCaptionID= " & SubRequestTypeCaptionID & ""

            drTabData = CommonFunctions.Data.GetDataReader(strSQL, True)

            If drTabData.Read Then
                fieldname = CommonFunctions.Data.CheckIsDBNull(drTabData("fieldname"), "")
                Caption = CommonFunctions.Data.CheckIsDBNull(drTabData("Caption"), "")
                UserFriendlyName = CommonFunctions.Data.CheckIsDBNull(drTabData("UserFriendlyName"), "")

            End If
            strResult = fieldname & "##" & Caption & "##" & UserFriendlyName

            Return strResult
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod> _
    Public Shared Function SaveCilentContactDetails(ByVal Caption As String, ByVal CustomerCilentID As String, ByVal EditSubRequestTypeID As String) As String
        '=====================================================================
        ' Procedure Name        : CRM_CustomerMaster
        ' Description           : To  Save Cust Cilent Subtab Details
        ' Created Date           : 7th Dec 2017
        '=====================================================================
        Try
            Dim m_intUniqueID As Integer = 0
            Dim strSQL As String
        Dim m_EmployeeId As String

        If Caption = "" Then
            Caption = "Null"
        End If



        strSQL = "exec Usp_NG2_Ins_tbl_CRM_SubRequestType_Caption_Details  '" & Caption & "'," & CustomerCilentID & ""
            'strSQL +=  & CurrentCity1 & " '""

            m_EmployeeId = CStr(CommonFunction.Data.GetDataScalar(strSQL, True))




            Return m_EmployeeId
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function RefreshGrid(ByVal GridParameter As Object, ByVal RequestTypeID As String, ByVal Role As String, ByVal Status As String) As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Description           : For Refreshing The grid
        ' Created Date           : 7th Nov 2017
        '=====================================================================
        Try
            Dim strGridHTML As New StringBuilder("")
            Dim objCRM_CustomerMaster As New CRM_RequestSubType()

            'strGridHTML.Append(objCRM_CustomerMaster.SubRequestTabDetails(GridParameter("cityName"), "AJAXRefresh", RequestTypeID))
            strGridHTML.Append(objCRM_CustomerMaster.WriteRequestTabGrid(GridParameter("cityName"), "AJAXRefresh", RequestTypeID))

            Return strGridHTML.ToString
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
#End Region
End Class