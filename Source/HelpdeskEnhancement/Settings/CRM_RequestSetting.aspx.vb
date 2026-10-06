Public Class CRM_RequestSetting
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
    Protected Shared TabID As String = ""
#End Region

    Private Property Type_Edit As Boolean

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

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
        TabID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("TabID"), Integer), 0)
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

        strHTML.Append("<div class='content-wrapper' style='margin-left: 0px !important;'>")

        strHTML.Append("<div class='container-fluid'>")

        ''---------------------------- Vertical Tabs-----------------------------'
        strHTML.Append(" <div class='request-details-pg clsSettings'>")
        strHTML.Append(" <div class='v-tabs'>")
        Dim strSqlForTab As String = "usp_NG2_Sel_CRM_tbl_NG2_SettingsTabs  " & TabID & ""
        Dim dtTabDetails As DataTable = CommonFunctions.Data.GetDataTable(strSqlForTab, True)
        Dim strDisplayPageName1 As String = ""
        For i As Integer = 0 To dtTabDetails.Rows.Count - 1
            strDisplayPageName1 = CommonFunctions.Data.CheckIsDBNull(dtTabDetails.Rows(i)("SettingTabName"), "")
        Next
        strHTML.Append("<div id='Request' class='tabcontent'>")

        strHTML.Append("<div class='setting-src'>")
        strHTML.Append("<div class='row'>")
        strHTML.Append("<div class='col-md-6'>")
        strHTML.Append("<div class='left'>")
        strHTML.Append("<h3>" & strDisplayPageName1 & "</h3>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("<div class='col-md-6'>")
        strHTML.Append("</div>")
        strHTML.Append(" </div>")
        strHTML.Append("</div>")
        '-------------------------------------Request inner Horizontal Tabs---------------------------------------------------------->

        strHTML.Append("<div class='h-tabs'>")
        'Added By Reshma on 19th Feb 2020 For Helpdesk Activity Project New UI Change
        Dim strPageName As String = ""
        If (strDisplayPageName1 <> "Helpdesk Activity Project Mapping") Then
            strHTML.Append("<div class='tab'>")

            Dim strSqlForTag As String = "usp_sel_tbl_NG2_TagMaster  " & TabID & "," & Session("intUserID").ToString & "," & Session("intPostID").ToString & "," & CommonFunction.General.CheckIsNothing(Session("intProjectID"), "NULL") & ",'" & Session("LoginType").ToString & "','SM'"
            Dim dtTagDetails As DataTable = CommonFunctions.Data.GetDataTable(strSqlForTag, True)
            Dim intCounter As Integer = 0
            Dim intCounterToDisplay As Integer = 1
            'Commented By Reshma on 19th Feb 2020 For Helpdesk Activity Project New UI Change
            'Dim strPageName As String = ""

            strHTML.Append("<i id='iPrev' class='fa fa-angle-double-left' onclick='ShowNext(1)' style='display:none'></i>")

            For i As Integer = 0 To dtTagDetails.Rows.Count - 1
                Dim strTagid As String = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("TagID"), "")
                Dim strDisplayPageName As String = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("DisplayPageName"), "")
                Dim strDisplayTagName As String = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("DisplayTagName"), "")
                GetGlobalObject(strTagid)
                If m_objAccessRights.View = True Then
                    Dim intModulo As Integer = i Mod 5
                    If intModulo = 0 And i <> 0 Then
                        intCounterToDisplay += 1
                    End If

                    If intCounterToDisplay > 1 Then
                        strHTML.Append("<button class='tablinks1 " & IIf(intCounter = 0, "active", "") & "' style='display:none' valForDisplay=" & intCounterToDisplay & " onclick=""openCity1(event, '" & strDisplayPageName & "')"" id='defaultOpen" & strTagid & "'>" & strDisplayTagName & "</button>")
                    Else
                        strHTML.Append("<button class='tablinks1 " & IIf(intCounter = 0, "active", "") & "' valForDisplay=" & intCounterToDisplay & " onclick=""openCity1(event, '" & strDisplayPageName & "')"" id='defaultOpen" & strTagid & "'>" & strDisplayTagName & "</button>")
                    End If

                    If strPageName = "" Then
                        strPageName = strDisplayPageName
                    End If
                    intCounter = intCounter + 1
                End If

            Next
            If intCounterToDisplay > 1 Then
                strHTML.Append("<i id='iNext' class='fa fa-angle-double-right' onclick=ShowNext(2)></i>")
            End If
            strHTML.Append("<input type='hidden' id='hdnTabCount' value='1' />")
            strHTML.Append("<input type='hidden' id='hdnLastTabCount' value='" & intCounterToDisplay & "' />")
            'GetGlobalObject(RequestTypeTagID)
            'If m_objAccessRights.View = True Then
            '    strHTML.Append("<button class='tablinks1' onclick=""openCity1(event, 'Type')"" id='defaultOpen1'>Type</button>")
            'End If
            'GetGlobalObject(SubRequestTypeTagID)
            'If m_objAccessRights.View = True Then
            '    strHTML.Append("<button class='tablinks1' onclick=""openCity1(event, 'Subtype')"">Subtype</button>")
            'End If
            'GetGlobalObject(915)
            'If m_objAccessRights.View = True Then
            '    strHTML.Append("<button class='tablinks1' onclick=""openCity1(event, 'Status')"">Status</button>")
            'End If
            'GetGlobalObject(917)
            'If m_objAccessRights.View = True Then
            '    strHTML.Append("<button class='tablinks1' onclick=""openCity1(event, 'Priority')"">Priority</button>")
            'End If
            'GetGlobalObject(3741)
            'If m_objAccessRights.View = True Then
            '    strHTML.Append(" <button class='tablinks1' onclick=""openCity1(event, 'Severity')"">Severity</button>")
            'End If
            'GetGlobalObject(396)
            'If m_objAccessRights.View = True Then
            '    strHTML.Append(" <button class='tablinks1' onclick=""openCity1(event, 'Department')"">Department</button>")
            'End If
            'If m_objAccessRights.View = True Then
            '    strHTML.Append("<button class='tablinks1' onclick=""openCity1(event, 'Autoclose')"">Autoclose</button>")
            'End If
            strHTML.Append("</div>")

            'strHTML.Append("<div id='Type' class='tabcontent1 h-type'>")
            'strHTML.Append(RequestTabDetails(strWhichGrid, strGridFlag))

            'Added By Reshma on 19th Feb 2020 For Helpdesk Activity Project New UI Change
        Else
            Dim strSqlForTag As String = "usp_sel_tbl_NG2_TagMaster  " & TabID & "," & Session("intUserID").ToString & "," & Session("intPostID").ToString & "," & CommonFunction.General.CheckIsNothing(Session("intProjectID"), "NULL") & ",'" & Session("LoginType").ToString & "','SM'"
            Dim dtTagDetails As DataTable = CommonFunctions.Data.GetDataTable(strSqlForTag, True)

            For i As Integer = 0 To dtTagDetails.Rows.Count - 1
                Dim strTagid As String = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("TagID"), "")
                Dim strDisplayPageName As String = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("DisplayPageName"), "")
                Dim strDisplayTagName As String = CommonFunctions.Data.CheckIsDBNull(dtTagDetails.Rows(i)("DisplayTagName"), "")
                GetGlobalObject(strTagid)
                If m_objAccessRights.View = True Then
                    If strPageName = "" Then
                        strPageName = strDisplayPageName
                    End If

                ElseIf m_objAccessRights.Add = True And m_objAccessRights.Edit = True And m_objAccessRights.View = False And strTagid = 8041 Then
                    If strPageName = "" Then
                        strPageName = strDisplayPageName
                    End If

                ElseIf m_objAccessRights.View = False And strTagid = 8041 Then

                    strHTML.Append("<div style='text-align:center;width:100%;background-color:white;'><b><center>You are not authorized to view this record. </center></b></div>")

                End If
            Next
            'End Added By Reshma on 19th Feb 2020 For Helpdesk Activity Project New UI Change
        End If

		'Modified By Pradip on 18-06-2021
        'strHTML.Append("<iframe id='frmTagNavigation' style='width:100%;' src='" & strPageName & "'></iframe>")
        strHTML.Append("<iframe id='frmTagNavigation' style='width:100%;' scrolling='yes' src='" & strPageName & "'></iframe>")
        strHTML.Append("</div>")

        'strHTML.Append("<div id='Subtype' class='tabcontent1 h-type h-form'>")
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='Status' class='tabcontent1 h-type h-form'>")
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='Priority' class='tabcontent1 h-type h-form'>")
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='Severity' class='tabcontent1 h-type h-form'>")
        'strHTML.Append("</div>")

        'strHTML.Append("<div id='Autoclose' class='tabcontent1 h-type'>")
        'strHTML.Append("</div>")
        'strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        strHTML.Append("</div>")
        If (strGridFlag.ToUpper = "LOAD") Then
            CommonFunctions.General.WriteHTML(strHTML.ToString)
        Else
            Return strHTML.ToString
        End If
    End Function

#Region "Request Tab Section Related Code"

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


#End Region
#Region "Jquery AJAX Methods"


#End Region
End Class