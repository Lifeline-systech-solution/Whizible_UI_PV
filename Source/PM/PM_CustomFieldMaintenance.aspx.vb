'=====================================================================
' Class	Name	        :	PM_CustomFieldMaintenance
' Purpose				:	Page to view and handle Custom fields for Task
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	SandipL
' Created				:	17 Jan 2006
' Revisions				:	
'=====================================================================
Public Class PM_CustomFieldMaintenance
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Constants Used in the Class "
    Protected Const MODE_LIST As String = "Custom Field List"
    Protected Const MODE_DETAILS As String = "Custom Field Details"
    Protected Const MODE_ASSIGN_TYPES As String = "Assign Types"
    Protected Const PAGE_CALLEDFROM_PROJECT_MANAGEMENT As String = "PM"
    Protected Const PAGE_CALLEDFROM_CORPORATE As String = "1"

    Protected Const ACTION_SAVE As String = "Save"
    Protected Const ACTION_DELETE As String = "Delete"
    Protected Const ACTION_ADD_CORPORATE_CUSTOMFIELD_TO_PROJECT As String = "Add_CF_To_Project"
    Protected Const ACTION_SUCCESSFULLY_COMPLETED As String = "Action Completed Successfully"

    Protected Const HELPID_CORPORATE As Integer = 3560
    Protected Const HELPID_PROJECT_MANAGEMENT As Integer = 3561

    Private Enum MenuIndex
        'added by SachinR   on 07 Jul 2004
        CONFIGURE_ACCESS
        'addition end
        'Added By Chakshuta H
        APPLICABLE_ATTRIBUTES
        'Ended By Chakshuta H
        ASSIGN_TYPES
        SAVE
        SHOW_HISTORY
        BACK
        DELETE
        SELECTALL
        CLEARALL
        CLOSE
        HELP
    End Enum
    'Chakshuta
    'Private Const m_intMenuItems As Integer = 10
    Private Const m_intMenuItems As Integer = 11
    'Chakshuta
#End Region

#Region " Class Scope Variable Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(m_intMenuItems - 1) As String
    Private m_arrMenuTooltip(m_intMenuItems - 1) As String
    Private m_arrClientSideFunctions(m_intMenuItems - 1) As String
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Protected m_strClientSideScript As String = ""
    Private m_strNbyA As String
    Private m_strPageTitle As String
    Private m_strUserName As String
    Private m_lngUserId As Long
    Private m_lngPostId As Long
    Private m_strLoginType As String
    Private m_lngProjectId As Long
    Protected m_lngTagId As Long
    Private m_intHelpId As Long
    Protected m_strSortBy As String
    Protected m_strSortOrder As String
    Protected m_strEntityName As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_strPageCalledFrom As String
    Protected m_strDBFieldName As String              'Custom Field Name
    Private m_strQueryMessage As String
    'Used while displaying the menu and list of custom fields in LIST MODE
    Private m_lngRowCount As Long = 0

    'Custom Field Details
    Private m_lngUniqueId As Long = 0
    Private m_strUserGivenCaption As String = ""
    Private m_intDataType As Integer = 0
    Private m_strValidationRules As String = ""
    Private m_strControlHeight As String = ""
    Private m_strControlWidth As String = ""
    Private m_intRowNumber As Integer = 0
    Private m_intColumnNumber As Integer = 0
    Private m_strDefaultValue As String = ""
    Private m_strMinValue As String = ""
    Private m_strMaxValue As String = ""
    Private m_strMaxLength As String = ""
    Protected m_bitIsQueryValue As String = "0"
    Private m_strQueryText As String = ""
    Private m_strQueryToValidate As String = ""
    Private m_strDefaultValueType As String = "S"
    Private m_blnDisplay As Boolean = False

    'added by SachinR    on 07 Jul 2004
    Protected m_strUniqueID As String
    'addition end
    'Added By VarunA On 13-Aug-2008 For RequestID - 14439
    Private m_strCorprateCFCaption As String
    'End By VarunA On 13-Aug-2008 For RequestID - 14439
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
        Call GetGlobalObject()
        Call setVariables()
        InitPageMenu()
        If m_strMode = MODE_LIST Then
            If m_strAction = ACTION_SAVE Then
                SaveCustomFieldList()
            ElseIf m_strAction = ACTION_DELETE Then
                DeleteCustomFieldList()
            ElseIf m_strAction = ACTION_ADD_CORPORATE_CUSTOMFIELD_TO_PROJECT Then
                AddCustomFieldToProject()
            End If
        ElseIf m_strMode = MODE_DETAILS Then
            GetCustomFieldDetails()
            If m_strAction = ACTION_SAVE Then
                SaveCustomFieldDetails()
                GetCustomFieldDetails()
            End If
        ElseIf m_strMode = MODE_ASSIGN_TYPES Then
            If m_strAction = ACTION_SAVE Then
                SaveAssignTypes()
            End If
        End If
    End Sub
    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub
#Region " Procedures / Functions For initialization "


    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  SandipL
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
    Private Sub setVariables()
        m_strNbyA = MyBase.GetResourceString("NBYA")
        m_strPageTitle = MyBase.GetResourceString("ASSIGNTYPES")
        If Request.QueryString("UniqueID") <> "" Then
            m_strUniqueID = CommonFunctions.General.CheckIsNothing(Request.QueryString("UniqueID"), "0")
        Else
            m_strUniqueID = CommonFunctions.General.CheckIsNothing(Request.Form("txthdUniqueID"), "0")
        End If
        m_strUserName = m_objGlobal.UserName
        m_lngUserId = m_objGlobal.UserID
        m_lngPostId = m_objGlobal.RoleID
        m_strLoginType = m_objGlobal.LoginType
        m_lngTagId = m_objGlobal.TagID()

        m_strPageCalledFrom = CommonFunctions.General.CheckIsNothing(Request.QueryString("CORP"))
        'If m_strPageCalledFrom = "" Then m_strPageCalledFrom = PAGE_CALLEDFROM_PROJECT_MANAGEMENT
        If m_strPageCalledFrom = PAGE_CALLEDFROM_CORPORATE Then
            m_lngProjectId = 0
            m_intHelpId = HELPID_CORPORATE
        Else
            m_intHelpId = HELPID_PROJECT_MANAGEMENT
            m_lngProjectId = m_objGlobal.ProjectID
        End If

        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Then m_strMode = MODE_LIST

        ' Added BY nitinVs on 27 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11850
        If m_strMode = MODE_LIST Then
            m_strPageTitle = MyBase.GetResourceString("ASSIGNTYPES")
        Else
            m_strPageTitle = m_strMode
        End If

        ' end Modification BY nitinVs on 27 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11850

        m_strDBFieldName = CommonFunctions.General.CheckIsNothing(Request.QueryString("DatabaseFieldName"))

        m_strSortBy = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortBy"))
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("txthidSortOrder"))
        If m_strSortBy = "" Then m_strSortBy = "RowNumber"
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"

        m_strAction = CommonFunctions.General.CheckIsNothing(Request.Form("txthidAction_CustomField"))
        m_strQueryMessage = ""

        'Modified By Amol Changle On: 21 Jul 2009
        m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EntityName"), "")
        If m_strEntityName = "" Then
            m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboEntityName"), "")
        End If
        'End Modification

        If (m_strEntityName = "" Or m_strEntityName Is Nothing) Then m_strEntityName = "Task"

    End Sub
#End Region

#Region " Procedures / Functions Common to All Modes of the Page "


    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub
    Public Sub WritePage()
        If m_strMode = MODE_LIST Then
            WritePage_CustomFieldList()
        ElseIf m_strMode = MODE_DETAILS Then
            WritePage_CustomFieldDetails()
        ElseIf m_strMode = MODE_ASSIGN_TYPES Then
            WritePage_AssignTypes()
        End If

        'Hidden Fields
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction_CustomField", "txthidAction_CustomField", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthdUniqueID", "txthdUniqueID", , , , m_strUniqueID.Trim, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

    End Sub
    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'added by SachinR   on 06 Jul 2004      
        'if field is selected for the project then only show the configure link
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) = MyBase.GetResourceString("MENU_CONFIGURE_ACCESS")
        m_arrMenuTooltip(MenuIndex.CONFIGURE_ACCESS) = MyBase.GetResourceString("MENU_CONFIGURE_ACCESS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CONFIGURE_ACCESS) = "ConfigureAccess_OnClick('" + m_strUniqueID.Trim + "')"
        'addition end 
        'Chakshuta
        'APPLICABLE_ATTRIBUTES
        m_arrMenuItem(MenuIndex.APPLICABLE_ATTRIBUTES) = "Applicable Attributes"
        m_arrMenuTooltip(MenuIndex.APPLICABLE_ATTRIBUTES) = "Applicable Attributes"
        m_arrClientSideFunctions(MenuIndex.APPLICABLE_ATTRIBUTES) = "ApplicableAttributes_OnClick()"

        'Chakshuta

        m_arrMenuItem(MenuIndex.ASSIGN_TYPES) = MyBase.GetResourceString("MENU_IB_ASSIGNTYPES")
        m_arrMenuTooltip(MenuIndex.ASSIGN_TYPES) = MyBase.GetResourceString("MENU_IB_ASSIGNTYPES_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ASSIGN_TYPES) = ""

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.SHOW_HISTORY) = MyBase.GetResourceString("MENU_IB_SHOWHISTORY")
        m_arrMenuTooltip(MenuIndex.SHOW_HISTORY) = MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SHOW_HISTORY) = ""

        m_arrMenuItem(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick()"

        m_arrMenuItem(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE")
        m_arrMenuTooltip(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.DELETE) = "Delete_OnClick()"

        m_arrMenuItem(MenuIndex.SELECTALL) = MyBase.GetResourceString("MENU_SELECTALL")
        m_arrMenuTooltip(MenuIndex.SELECTALL) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SELECTALL) = ""

        m_arrMenuItem(MenuIndex.CLEARALL) = MyBase.GetResourceString("MENU_CLEARALL")
        m_arrMenuTooltip(MenuIndex.CLEARALL) = MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLEARALL) = "ClearAll_OnClick('frmTaskCustomFields','chkType')"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = ""

        MyBase.InitializeResources("AppResources.PM_CustomFieldsMaintenance", "AppResources")
    End Sub
    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Public Sub New()
        ''Commented and Modified By Aniruddh Gujar on 24-Oct-2016 Purpose::To handle security
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True, 2, True, True, True)
        ''End of Commented and Modified By Aniruddh Gujar on 24-Oct-2016 Purpose::To handle security
        MyBase.InitializeResources("AppResources.IB_CustomFieldsMaintenance", "AppResources")
    End Sub
#End Region

#Region " Procedures / Functions Specific to Custom Field Details Mode "
    Private Sub WritePage_CustomFieldDetails()
        Dim strMenu As String

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)

        'Display The Legend 
        WritePageLegend()

        'Display Page Caption
        'Code Commented By Syamantak Chavan On 05 Oct 2011 for whizible 10.0
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Code Added By Syamantak Chavan On 05 Oct 2011 for whizible 10.0
        m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EntityName"), "")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strEntityName + " Custom Fields", , , True))
        'End Code Added By Syamantak Chavan On 05 Oct 2011 for whizible 10.0

        'Display the Custom Fields Details
        DisplayDetails()

        'Display Menu at Footer
        CommonFunctions.General.WriteHTML(strMenu)

        'Insert Hidden Fields
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidUniqueID", "txthidUniqueID", , , , m_lngUniqueId.ToString(), , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidDisplay", "txthidDisplay", , , , m_blnDisplay.ToString(), , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub
    Private Sub DisplayDetails()
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        Dim strFieldValue As String = ""
        Dim drWork As IDataReader
        Dim strHTML As String = ""
        Dim blnTemp As Boolean = False
        Dim intDefaultRowNo As Integer
        Dim intDefaultColNo As Integer


        strHTML = "<div id='divList' style='OVERFLOW: auto; WIDTH: 100%'>"
        strHTML &= "<table cellSpacing='0' class='clsTable' width='99.9%'>"
        strHTML &= "<tr class='clsTREven'><td valign='top' align='right' style='width:40%'>"
        strHTML &= MyBase.GetResourceString("CONTROLCAPTION") & "</td>"
        strHTML &= "<td valign='top' align='left' colspan=3>"
        ''If m_strUserGivenCaption <> "" Then blnTemp = True
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtUserGivenCaption", "txtUserGivenCaption", , 200, 100, m_strUserGivenCaption, , , blnTemp, , , , , True, True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= "</td></tr>"

        'strQuery = "Exec usp_Sel_tbl_IB_ProjectViews_GetFieldList 0, 0, 'D',0, '"
        'strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
        'drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        'If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
        '    strTemp = ","
        '    While drWork.Read()
        '        strFieldValue = drWork.Item("ActualFieldName").ToString().Trim()
        '        strFieldValue = CommonFunctions.General.UnBuildQueryString(strFieldValue)
        '        If InStr(1, strFieldValue.ToUpper(), "CUSTOMFIELD", CompareMethod.Text) = 0 Then
        '            strTemp &= strFieldValue & ","
        '        End If
        '    End While
        'End If
        'CommonFunctions.Data.DisposeDataReader(drWork)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidFieldList", "txthidFieldList", , , , strTemp, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        'Existing Order no
        strTemp = ""
        strQuery = "Exec usp_Sel_PM_CustomFields_Existing_OrderNumber " & m_lngProjectId

        'Added By Amol Changle On: 19 Aug 2009
        'Purpose: To handle Entity specific
        strQuery += ",'" + m_strEntityName + "'"
        'End Addition

        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                'Skip current record
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("OrderNumber"), "").ToString()
                strFieldValue = CommonFunctions.General.UnBuildQueryString(strFieldValue)
                If (m_intRowNumber & m_intColumnNumber).ToString() <> strFieldValue Then
                    strTemp &= strFieldValue & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidOrderNoList", "txthidOrderNoList", , , , strTemp, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'Duplicate custom field names are not allowed					
        'Get the Existing User given field captions for the custom fields.
        strTemp = ""
        strQuery = "Exec Usp_Sel_tbl_PM_CustomFields_Master " & m_lngProjectId
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                'Skip current record
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("UserGivenCaption"), "").ToString()
                strFieldValue = CommonFunctions.General.UnBuildQueryString(strFieldValue)
                If m_strUserGivenCaption <> strFieldValue Then
                    strTemp &= strFieldValue & ","
                End If
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidCFList", "txthidCFList", , , , strTemp, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        'Get the Maximum position at which the Custom Field is placed by the User.
        intDefaultRowNo = 1
        intDefaultColNo = 1
        strQuery = "Exec usp_Sel_PM_CustomFields_Max_Positon " & m_lngProjectId
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                strFieldValue = CommonFunctions.Data.CheckIsDBNull(drWork.Item("RowNumber"), "0").ToString()
                'Maximum allowable Row Number is not 99
                If CType(strFieldValue, Integer) <> 99 Then
                    'Display next Row Number as default for the add new mode
                    intDefaultRowNo = CType(strFieldValue, Integer) + 1
                    intDefaultColNo = 1
                Else
                    intDefaultColNo = -1
                    intDefaultRowNo = -1
                End If
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        strHTML &= "<tr class='clsTREven'><td valign='top' align='right'>"
        strHTML &= MyBase.GetResourceString("CONTROLNAME") & "</td>"
        strHTML &= "<td valign='top' align='left' colspan=3>"
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDatabaseFieldName", "txtDatabaseFieldName", , 200, 100, m_strDBFieldName, , , True, , "", , , True, True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= "</td></tr>"

        strHTML &= "<tr class='clsTREven'><td valign='top' align='right' style='width:40%'>"
        strHTML &= MyBase.GetResourceString("DATATYPE") & "</td>"
        strHTML &= "<td valign='top' align='left' colspan=3>"
        strQuery = "Exec usp_Sel_tbl_UI_FieldDataTypes "

        If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDataType", strQuery, 200, "2", "Disabled", True, True, , True)
        ElseIf InStr(1, UCase(Trim(m_strDBFieldName)), "NUMERIC", CompareMethod.Text) <> 0 Then
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDataType", strQuery, 200, "1", "Disabled", True, True, , True)
        Else
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDataType", strQuery, 200, m_intDataType.ToString(), , True, True, , True)
        End If
        strHTML &= "</td></tr>"

        strHTML &= "<tr class='clsTREven'><td valign='top' align='right' style='width:40%'>"
        strHTML &= MyBase.GetResourceString("CONTROLPOSITION") & "</td>"
        strHTML &= "<td valign='top' align='left' colspan=3>"
        strHTML &= "<label style='width:200'>[" & MyBase.GetResourceString("ROWNUMBER") & "]</label>"
        strHTML &= "<label style='width:200'>[" & MyBase.GetResourceString("COLUMNNUMBER") & "]</label>"
        strHTML &= "<br><label style='width:200'>"
        If m_strUserGivenCaption = "" Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtRowNumber", "txtRowNumber", , 50, 2, intDefaultRowNo.ToString(), "right", , , , , , , True, True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtRowNumber", "txtRowNumber", , 50, 2, m_intRowNumber.ToString(), "right", , , , , , , True, True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
        strHTML &= "</label>"
        strHTML &= "<label style='width:200'>"
        If m_strUserGivenCaption = "" Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtColumnNumber", "txtColumnNumber", , 50, 1, intDefaultColNo.ToString(), "right", , , , , , , True, True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtColumnNumber", "txtColumnNumber", , 50, 1, m_intColumnNumber.ToString(), "right", , , , , , , True, True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
        strHTML &= "</label>"
        strHTML &= "</td></tr>"

        strHTML &= "<tr class='clsTREven'><td valign='top' align='right'>"
        strHTML &= MyBase.GetResourceString("CONTROLSIZE") & "</td>"
        strHTML &= "<td valign='top' align='left' colspan=3>"
        strHTML &= "<label style='width:200'>[" & MyBase.GetResourceString("HEIGHT") & "]</label>"
        strHTML &= "<label style='width:200'>[" & MyBase.GetResourceString("WIDTH") & "]</label>"
        strHTML &= "<br><label style='width:200'>"
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtControlHeight", "txtControlHeight", , 50, 3, m_strControlHeight, "right", , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= "</label>"
        strHTML &= "<label style='width:200'>"
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtControlWidth", "txtControlWidth", , 50, 3, m_strControlWidth, "right", , , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        strHTML &= "</label>"
        strHTML &= "</td></tr>"

        If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) = 0 Then
            strHTML &= "<tr class='clsTREven'><td valign='top' align='right'>"
            strHTML &= MyBase.GetResourceString("VALIDATIONRULES") & "</td>"
            strHTML &= "<td valign='top' align='left'>"
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtValidationRules", "txtValidationRules", , 60, , m_strValidationRules, , , , True, , , "OnPropertyChange='txtValidationRules_OnPropertyChange();'", True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            If m_blnDisplay = True Then
                'Modified By VidyaJ - Browser Issue - IssueID - 809 
                'We need to put javascript function in <A href> tag to make it reconize to Netscape
                Dim strTemp1 As String
                strTemp1 = "<A Href=JavaScript:SelectValidation('" & m_strDBFieldName & "'," & m_lngProjectId.ToString() & ")>"
                strHTML &= "&nbsp;" & strTemp1 & CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , , 12, 12, , True) & "</A>"
                'End addition

                'Commented by Rajashrik for Netscape Implementation on 13/3/2005
                'strTemp = "JavaScript:SelectValidation('" & m_strDBFieldName & "'," & m_lngProjectId.ToString() & ")"
                'strHTML &= "&nbsp;" & CommonFunctions.HTMLControls.DrawImage("../../images/dblclick.gif", "imgValidationRules", , strTemp, 12, 12, , True)
                'End comment
            End If
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='right'>"
            strHTML &= MyBase.GetResourceString("MAXLENGTH") & "</td>"
            strHTML &= "<td valign='top'>"
            If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxLength", "txtMaxLength", , 60, 8, m_strMaxLength, "right", , True, , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            ElseIf InStr(1, "," & m_strValidationRules & ",", ",12,", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxLength", "txtMaxLength", , 60, 8, m_strMaxLength, "right", , , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxLength", "txtMaxLength", , 60, 8, "", "right", , True, , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            strHTML &= "</td></tr>"

            strHTML &= "<tr class='clsTREven'><td valign='top' align='right'>"
            strHTML &= MyBase.GetResourceString("MINIMUMVALUE") & "</td>"
            strHTML &= "<td valign='top' align='left'>"
            If InStr(1, "," & m_strValidationRules & ",", ",18,", CompareMethod.Text) <> 0 _
                Or InStr(1, "," & m_strValidationRules & ",", ",16,", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMinValue", "txtMinValue", , 60, 8, m_strMinValue, "right", , , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMinValue", "txtMinValue", , 60, 8, m_strMinValue, "right", , True, , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='right'>"
            strHTML &= MyBase.GetResourceString("MAXIMUMVALUE") & "</td>"
            strHTML &= "<td valign='top'>"
            If InStr(1, "," & m_strValidationRules & ",", ",18,", CompareMethod.Text) <> 0 _
                Or InStr(1, "," & m_strValidationRules & ",", ",17,", CompareMethod.Text) <> 0 Then
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxValue", "txtMaxValue", , 60, 8, m_strMaxValue, "right", , , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtMaxValue", "txtMaxValue", , 60, 8, m_strMaxValue, "right", , True, , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            strHTML &= "</td></tr>"
        End If


        If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
            strHTML &= "<tr class='clsTREven'><td valign='top' align='right'>"
            strHTML &= MyBase.GetResourceString("DEFAULTVALUE") & "</td>"
            strHTML &= "<td valign='top' align='left' colspan='3'>"
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", "clsTextBoxReadOnly", 200, 100, m_strDefaultValue, , , , True, "", , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= "</td></tr>"
        Else

            strHTML &= "<td valign='top' align='left' style='Display:none' >"
            'If Trim(m_strDefaultValueType & "") = "S" Then
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , True, "S", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            ' Else
            '   strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , , "S", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            'End If
            'strHTML &= MyBase.GetResourceString("STATICVALUE") & "</td>"

            strHTML &= "<td valign='top' align='left' colspan='2' style='Display:none'>"
            'If Trim(m_strDefaultValueType & "") = "F" Then
            'strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , True, "F", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            'Else
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optDefaultValue", "optDefaultValue", , , "F", , "Onclick='JavaScript:optDefaultValue_Onclick()'", True)
            'End If
            'strHTML &= MyBase.GetResourceString("DYNAMICVALUE") & "</td></tr>"
            'Default Value
            strHTML &= "<tr class='clsTREven'><td valign='top' align='right'>"
            strHTML &= MyBase.GetResourceString("DEFAULTVALUE") & "</td>"
            'strHTML &= "<tr class='clsTREven'><td valign='top' align='left'></td>"
            'The default value is static value
            'If Trim(m_strDefaultValueType & "") <> "S" Then
            '    strHTML &= "<td id='TDStaticDefaultValue' valign='top' align='left' colspan='3' style='Display:none'>"
            'Else
            strHTML &= "<td id='TDStaticDefaultValue' valign='top' align='left' colspan='3'>"
            'End If

            'Selected Control is date control
            If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
                'If m_strDefaultValueType = "S" Then
                strHTML &= CommonFunction.HTMLControls.DrawDateControl("txtDefaultValue", "txtDefaultValue", , 80, m_strDefaultValue, , "frmTaskCustomFields", returnHTML:=True)
                '    Else
                '    strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", "clsTextBoxReadOnly", 100, , "", , , , True, "", , , True)
                'End If
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtDefaultValue", "txtDefaultValue", , 200, 100, m_strDefaultValue, , , , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            'If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 And m_blnDisplay = True Then
            '    strHTML &= CommonFunctions.HTMLControls.DrawImage("../../images/Calendar.gif", "", , "javascript:callcalendar('frmTaskCustomFields','txtDefaultValue')", , , , True)
            'End If
            strHTML &= "</td>"

            'If Trim(m_strDefaultValueType & "") = "S" Then
            strHTML &= "<td id='TDCommonFieldDefaultValue' valign='top' align='left' colspan='3' style='Display:none'>"
            'Else
            '    strHTML &= "<td id='TDCommonFieldDefaultValue' valign='top' align='left' colspan='3'>"
            'End If
            'Selected Control is date control
            If InStr(1, UCase(Trim(m_strDBFieldName)), "DATE", CompareMethod.Text) <> 0 Then
                strQuery = "Exec usp_sel_Get_ProjectTasks_Fields " & m_lngProjectId.ToString()
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "',1 "
            Else
                strQuery = "Exec usp_sel_Get_ProjectTasks_Fields " & m_lngProjectId.ToString()
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
            End If
            strHTML &= CommonFunctions.HTMLControls.DrawComboBox("cboDefaultValue", strQuery, 150, m_strDefaultValue, , , True)
            strHTML &= "</td></tr>"
        End If
        'This Section is only applicable for the Combo box Custom Fields
        If InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0 Then
            strHTML &= "<tr class='clsTREven'>"
            strHTML &= "<td valign='top' align='right'>"
            strHTML &= MyBase.GetResourceString("COMBOBOXVALUES")
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='left'>"
            If m_bitIsQueryValue.Trim() = "0" Then
                blnTemp = True
            Else
                blnTemp = False
            End If
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optComboValue", "optComboValue", , blnTemp, "0", , "Onclick='JavaScript:optComboValue_Onclick()'", True)
            strHTML &= MyBase.GetResourceString("CUSTOMVALUES")
            strHTML &= "</td>"
            strHTML &= "<td valign='top' align='left' colspan='2'>"
            If m_bitIsQueryValue.Trim() = "1" Then
                blnTemp = True
            Else
                blnTemp = False
            End If
            strHTML &= CommonFunctions.HTMLControls.DrawOptionButton("optComboValue", "optComboValue", , blnTemp, "1", , "Onclick='JavaScript:optComboValue_Onclick()'", True)
            strHTML &= MyBase.GetResourceString("QUERYORSP")
            strHTML &= "</td>"
            strHTML &= "</tr>"
            If m_bitIsQueryValue.Trim() = "0" Then
                strHTML &= "<tr id='TRQueryText' class='clsTREven' style='display:none'><td valign='top' align='left'></td>"
            Else
                strHTML &= "<tr id='TRQueryText' class='clsTREven'><td valign='top' align='left'></td>"
            End If
            strHTML &= "<td valign='top' align='left' colspan='3'>"
            strHTML &= CommonFunctions.HTMLControls.DrawTextArea("txtQueryText", "txtQueryText", widthInPixel:=450, heightInPixel:=50, value:=m_strQueryText, returnHTML:=True)
            strHTML &= "</td>"
            strHTML &= "</tr>"
            If m_strQueryMessage <> "" Then
                strHTML &= "<TR class='clsTREven'><TD colspan='6'><B><Center>"
                strHTML &= "<FONT COLOR=RED>" & m_strQueryMessage & "</FONT>"
                strHTML &= "</Center></B></TD></TR>"
            End If
        End If
        strHTML &= "</table><br>" + vbCrLf
        CommonFunctions.General.WriteHTML(strHTML)
        strHTML = ""

        'This Section is only applicable for the Combo box Custom Fields
        DisplayComboBoxValues()

        'Only for Query Values
        DisplayQueryValues()

        strHTML = "</div>" & vbCrLf
        CommonFunctions.General.WriteHTML(strHTML)
    End Sub

    Private Sub DisplayComboBoxValues()
        Dim strHTML As String = ""
        Dim strQuery As String = ""
        Dim strTemp As String = ""

        If (InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) = 0) Or (m_bitIsQueryValue.Trim() = "1") Then
            strHTML &= "<div id='divComboboxValues' style='display:none'>"
        Else
            strHTML &= "<div id='divComboboxValues'>"
        End If


        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        strHTML &= "<tr class='clsTRColumnHeader'><td align='left' style='width:70%'>"
        If m_blnDisplay = True Then
            strHTML &= MyBase.GetResourceString("POPULATECOMBO")
        Else
            strHTML &= MyBase.GetResourceString("COMBOBOXVALUES")
        End If
        strHTML &= "</td></tr></table>"


        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        strHTML &= "<tr class='clsTREven'><td align='right' style='width:40%'>&nbsp;</td>"
        strHTML &= "<td align='left' valign='top'>"
        strHTML &= "<label id='lblSelectedValue' name='lblSelectedValue'>&nbsp;</label>"
        strHTML &= "</td></tr>"
        If m_blnDisplay = True Then
            strHTML &= "<tr class='clsTREven'>"
            strHTML &= "<td align='right' style='width:40%'>"
            strHTML &= MyBase.GetResourceString("ENTERTHEVALUE")
            strHTML &= "</td>"
            strHTML &= "<td align='left'>"
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= CommonFunctions.HTMLControls.DrawTextBox("txtValue", "txtValue", , 200, 100, , , , , , , (Not m_blnDisplay), , True, m_blnDisplay, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strHTML &= "</td>"
            strHTML &= "</tr>"
            strHTML &= "<tr class='clsTREven'>"
            strHTML &= "<td align='right'>&nbsp;</td><td align='Left'><label style='width:200;text-align:center'>"
            strHTML &= "|&nbsp;"
            strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:InsertValue_OnClick()'>"
            strHTML &= "<font size='1' face='verdana' color='black'>"
            strHTML &= "<b>" + MyBase.GetResourceString("INSERT") + "</b>"
            strHTML &= "</font></a>&nbsp;|&nbsp;&nbsp;"
            strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:UpdateValue_OnClick()'>"
            strHTML &= "<font size='1' face='verdana' color='black'>"
            strHTML &= "<b>" + MyBase.GetResourceString("UPDATE") + "</b>"
            strHTML &= "</font></a>&nbsp;|&nbsp;&nbsp;"
            strHTML &= "<a style='TEXT-DECORATION: none' HREF='javascript:DeleteValue_OnClick()'>"
            strHTML &= "<font size='1' face='verdana' color='black'>"
            strHTML &= "<b>" + MyBase.GetResourceString("DELETE") + "</b>"
            strHTML &= "</font></a>&nbsp;|&nbsp;&nbsp;"
            strHTML &= "</label></td></tr>"
        End If

        strHTML &= "<tr class='clsTREven'>"
        strHTML &= "<td valign='top' align='right' style='width:40%'>"
        strHTML &= MyBase.GetResourceString("COMBOBOXVALUES")
        strHTML &= "</td><td align='left'>"
        strQuery = "Exec Usp_Sel_tbl_PM_CustomFields_Details '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'," & m_lngProjectId & ",0"
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To select fields Entity Specific
        strQuery += ",'" + m_strEntityName + "'"
        'End Addition
        If m_blnDisplay = True Then strTemp = "ondblclick=""javascript:SelectElement_OnClick('C')"""
        strHTML &= CommonFunctions.HTMLControls.DrawListBox("lstValue", strQuery, 200, 150, , strTemp, ReturnAsHTML:=True, IsMandatory:=True)
        strHTML &= "</td></tr>"

        If m_blnDisplay = True Then
            strHTML &= "<tr class='clsTREven'>"
            strHTML &= "<td align='right'>&nbsp;</td><td align='left' valign='top'>"
            strHTML &= "(" & MyBase.GetResourceString("EDITVALUE") & ")"
            strHTML &= "</td></tr>"
        End If

        strHTML &= "</table>"
        strHTML &= "</div>"

        CommonFunctions.General.WriteHTML(strHTML)
    End Sub

    Private Sub DisplayQueryValues()
        Dim strHTML As String = ""
        Dim strQuery As String = ""
        Dim strTemp As String = ""

        If (InStr(1, UCase(Trim(m_strDBFieldName)), "COMBO", CompareMethod.Text) <> 0) And (m_bitIsQueryValue.Trim() = "1") Then
            strHTML &= "<div id='divQueryValues' Style='display:block'>"
        Else
            strHTML &= "<div id='divQueryValues' Style='display:none'>"
        End If

        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        strHTML &= "<tr class='clsTRColumnHeader'><td align='left' style='width:70%'>"
        strHTML &= MyBase.GetResourceString("COMBOBOXVALUES")
        strHTML &= "</td></tr></table>"


        strHTML &= "<table cellspacing='0' width='99.9%' class='clsTable'>"
        If m_strQueryText.Trim() <> "" And m_strQueryToValidate.Trim() <> "" And m_strQueryMessage.Trim() = "" Then
            strHTML &= "<tr class='clsTREven'><td align='right' valign='top' width='40%'>"
            strHTML &= MyBase.GetResourceString("COMBOBOXVALUES")
            strHTML &= "</td>"
            strHTML &= "<td align='left'>"
            strHTML &= CommonFunctions.HTMLControls.DrawListBox("lstValueQ", m_strQueryToValidate, 200, 150, , "ondblclick=""javascript:SelectElement_OnClick('Q')""", ReturnAsHTML:=True, IsMandatory:=True)
            strHTML &= "</td></tr>"
            If m_blnDisplay = True Then
                strHTML &= "<tr class='clsTREven'>"
                strHTML &= "<td align='right'>&nbsp;</td><td align='left' valign='top'>"
                strHTML &= "(" & MyBase.GetResourceString("SET_VALUE_AS_DEFAULT") & ")"
                strHTML &= "</td></tr>"
            End If
        Else
            strHTML &= "<tr class='clsTREven'><td align=Center>"
            strHTML &= MyBase.GetResourceString("NOITEMS")
            strHTML &= "</td></tr>"
        End If
        strHTML &= "</table>"
        strHTML &= "</div>"

        CommonFunctions.General.WriteHTML(strHTML)
    End Sub

    Private Sub GetCustomFieldDetails()
        m_blnDisplay = True
        Dim strQuery As String
        Dim drCustomField As IDataReader
        Dim blnHasDetails As Boolean = False

        strQuery = "Exec Usp_Sel_tbl_PM_CustomFields_Master " & m_lngProjectId
        strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To select fields Entity Specific
        strQuery += ",0,NULL,'" + m_strEntityName + "'"
        'End Addition
        drCustomField = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If (m_strAction = "" Or m_strAction = ACTION_SUCCESSFULLY_COMPLETED) And m_strQueryMessage = "" Then
            If CommonFunctions.General.CheckIsNothing(drCustomField) <> "" Then
                If drCustomField.Read() Then
                    blnHasDetails = True
                    m_strUserGivenCaption = drCustomField.Item("UserGivenCaption").ToString().Trim()
                    m_strUserGivenCaption = CommonFunctions.General.UnBuildQueryString(m_strUserGivenCaption)
                    m_intDataType = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("DataType"), "0"), Integer)
                    m_strValidationRules = drCustomField.Item("ValidationRules").ToString().Trim()
                    m_strValidationRules = CommonFunctions.General.UnBuildQueryString(m_strValidationRules)
                    m_intRowNumber = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("RowNumber"), "0"), Integer)
                    m_intColumnNumber = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("ColumnNumber"), "0"), Integer)
                    m_strControlHeight = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("ControlHeight"), "").ToString()
                    m_strControlWidth = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("ControlWidth"), "").ToString()
                    m_strDefaultValue = drCustomField.Item("DefaultValue").ToString().Trim()
                    m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                    m_strMinValue = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("MinValue"), "").ToString()
                    m_strMaxValue = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("MaxValue"), "").ToString()
                    m_strMaxLength = CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("MaxLength"), "").ToString()
                    m_lngUniqueId = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("UniqueID"), "0"), Long)
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("IsQueryValue"), "False"), Boolean) = True Then
                        m_bitIsQueryValue = "1"
                    Else
                        m_bitIsQueryValue = "0"
                    End If
                    m_strQueryText = drCustomField.Item("QueryText").ToString().Trim()
                    m_strQueryText = CommonFunctions.General.UnBuildQueryString(m_strQueryText)

                    m_strQueryToValidate = m_strQueryText
                    If InStr(1, m_strQueryToValidate, "<PROJECT_ID>", CompareMethod.Text) <> 0 Then
                        m_strQueryToValidate = Replace(m_strQueryToValidate, "<PROJECT_ID>", m_lngProjectId.ToString())
                    End If
                    If InStr(1, m_strQueryToValidate, "<USER_ID>", CompareMethod.Text) <> 0 Then
                        m_strQueryToValidate = Replace(m_strQueryToValidate, "<USER_ID>", m_lngUserId.ToString())
                    End If

                    m_strDefaultValueType = drCustomField.Item("DefaultType").ToString().Trim()
                    m_strDefaultValueType = CommonFunctions.General.UnBuildQueryString(m_strDefaultValueType)
                End If
            End If
        Else
            m_strUserGivenCaption = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtUserGivenCaption"), ""), 100, False, True)
            m_strUserGivenCaption = CommonFunctions.General.UnBuildQueryString(m_strUserGivenCaption)
            m_intDataType = CType(MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("cboDataType"), ""), 0, True, True), Integer)
            m_strValidationRules = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtValidationRules"), ""), 0, False, False).ToString()
            m_strValidationRules = CommonFunctions.General.UnBuildQueryString(m_strValidationRules)
            m_strControlHeight = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtControlHeight"), ""), 3, True, False)
            m_strControlWidth = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtControlWidth"), ""), 3, True, False)
            m_intRowNumber = CType(MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtRowNumber"), ""), 2, True, True), Integer)
            m_intColumnNumber = CType(MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtColumnNumber"), ""), 1, True, True), Integer)
            m_strMinValue = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtMinValue"), ""), 8, True, False)
            m_strMaxValue = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtMaxValue"), ""), 8, True, False)
            m_strMaxLength = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtMaxLength"), ""), 8, True, False)
            m_lngUniqueId = CType(CommonFunctions.General.CheckIsNothing(Request.Form("txthidUniqueID"), "0"), Long)
            m_bitIsQueryValue = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("optComboValue"), ""), 0, False, False)
            If m_bitIsQueryValue = "" Then m_bitIsQueryValue = "0"
            m_strQueryText = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtQueryText"), ""), 0, False, False).ToString()
            m_strQueryText = CommonFunctions.General.UnBuildQueryString(m_strQueryText)
            m_strQueryToValidate = m_strQueryText
            If InStr(1, CommonFunctions.General.CheckIsNothing(Request.Form("txtDatabaseFieldName")).ToUpper(), "COMBO", CompareMethod.Text) = 0 Then
                m_strDefaultValueType = CommonFunctions.General.CheckIsNothing(Request.Form("optDefaultValue"), "S").ToString()
                If m_strDefaultValueType <> "" Then
                    If m_strDefaultValueType = "S" Then
                        m_strDefaultValue = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtDefaultValue"), ""), 0, False, False).ToString()
                        m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                    Else
                        m_strDefaultValue = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("cboDefaultValue"), ""), 0, False, False).ToString()
                        m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                    End If
                End If
            Else
                m_strDefaultValue = MyBase.FixString(CommonFunction.General.CheckIsNothing(Request.Form("txtDefaultValue"), ""), 0, False, False).ToString()
                m_strDefaultValue = CommonFunctions.General.UnBuildQueryString(m_strDefaultValue)
                m_strDefaultValueType = "S"
            End If
            If CommonFunctions.General.CheckIsNothing(drCustomField) <> "" Then
                If drCustomField.Read() Then
                    blnHasDetails = True
                    m_lngUniqueId = CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("UniqueID"), "0"), Long)
                End If
            End If
        End If
        If m_strPageCalledFrom <> PAGE_CALLEDFROM_PROJECT_MANAGEMENT And blnHasDetails = True Then
            If CType(CommonFunctions.Data.CheckIsDBNull(drCustomField.Item("IsCorporate"), "False"), Boolean) = True Then
                m_blnDisplay = False
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drCustomField)

        m_strUniqueID = m_lngUniqueId.ToString

    End Sub
    Private Sub SaveCustomFieldDetails()
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        Dim strValues As String = ""
        Dim arrValues() As String
        Dim strDataValue As String = ""
        Dim intCtr As Integer = 0
        Dim drWork As IDataReader

        If m_bitIsQueryValue = "1" Then
            If InStr(1, m_strQueryToValidate, "<PROJECT_ID>", CompareMethod.Text) <> 0 Then
                m_strQueryToValidate = Replace(m_strQueryToValidate, "<PROJECT_ID>", m_lngProjectId.ToString())
            End If
            If InStr(1, m_strQueryToValidate, "<USER_ID>", CompareMethod.Text) <> 0 Then
                m_strQueryToValidate = Replace(m_strQueryToValidate, "<USER_ID>", m_lngUserId.ToString())
            End If

            'Modified By NitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression fixes Issue 12408 
            ' to Validate for Invalid sql keywords 
            Dim Pattern As New System.Text.StringBuilder

            Dim strConfigPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory) & "bin\"
            'Create the config manager
            Dim objConfigMgr As New Utilities.Config.ConfigManager(strConfigPath & "Security.Config")
            'Open the config file
            objConfigMgr.Open()
            'Get the config key value
            Pattern.Append(objConfigMgr.GetValue("SQLKeyWords"))
            Pattern.Replace("select|", "")
            Pattern.Replace("exec|", "")
            Pattern.Replace("execute|", "")
            Pattern.Replace("sp_|", "truncate|")
            'Craete the regular exception object
            Dim reEx As New System.Text.RegularExpressions.Regex(Pattern.ToString(), System.Text.RegularExpressions.RegexOptions.IgnoreCase)

            'Clean the string with pattern
            m_strQueryToValidate = reEx.Replace(m_strQueryToValidate, "")
            'Destroy the re object
            reEx = Nothing
            Pattern = Nothing
            'Destroy the object
            objConfigMgr = Nothing

            'End Modification By NitinVS on 19 Apr 2007 for WhizibleSEM SP 8 Regression fixes Issue 12408 

            If CommonFunctions.Data.ValidateQuery(m_strQueryToValidate, MyBase.UseSQL) = False Then
                m_strQueryMessage = MyBase.GetResourceString("INVALIDQUERY")
            End If
        End If
        If m_strQueryMessage = "" Then
            strQuery = "Exec Usp_Upd_tbl_PM_CustomFields_Master " & m_lngProjectId.ToString()
            strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strUserGivenCaption)
            strQuery &= "','" & CommonFunctions.General.BuildQueryString(m_strDBFieldName)
            strQuery &= "'," & m_intDataType.ToString()
            If m_intRowNumber > 0 Then
                strQuery &= "," & m_intRowNumber.ToString()
            Else
                strQuery &= ", NULL"
            End If
            If m_intColumnNumber > 0 Then
                strQuery &= "," & m_intColumnNumber.ToString()
            Else
                strQuery &= ", NULL"
            End If
            If m_strControlHeight <> "" Then
                strQuery &= "," & m_strControlHeight
            Else
                strQuery &= ", NULL"
            End If
            If m_strControlWidth <> "" Then
                strQuery &= "," & m_strControlWidth
            Else
                strQuery &= ", NULL"
            End If
            strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strValidationRules)
            If m_strMaxLength <> "" Then
                strQuery &= "'," & m_strMaxLength
            Else
                strQuery &= "', NULL"
            End If

            If m_strMinValue <> "" Then
                strQuery &= "," & m_strMinValue
            Else
                strQuery &= ", NULL"
            End If
            If m_strMaxValue <> "" Then
                strQuery &= "," & m_strMaxValue
            Else
                strQuery &= ", NULL"
            End If
            strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDefaultValue)
            strQuery &= "','" & CommonFunctions.General.BuildQueryString(m_strUserName) & "',"
            strQuery &= m_bitIsQueryValue

            If m_bitIsQueryValue = "0" Then
                strTemp = "Exec Usp_Sel_tbl_PM_CustomFields_Master  " & m_lngProjectId.ToString()
                strTemp &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                drWork = CommonFunctions.Data.GetDataReader(strTemp, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    If drWork.Read() Then
                        m_lngUniqueId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("UniqueID"), "0"), Long)
                        'Commented and added by ShraddhaM on 20,Aug 2009
                        'No need to pass Query text if Queryvalue=0
                        'strQuery &= ",'" & drWork.Item("QueryText").ToString().Trim() & "'"
                        strQuery &= ",''"
                        'End of comment and addition by ShraddhaM
                    Else
                        'Commented and added by ShraddhaM on 20,Aug 2009
                        'No need to pass Query text if Queryvalue=0
                        'strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strQueryText) & "'"
                        strQuery &= ",''"
                        'End of comment and addition by ShraddhaM
                    End If
                Else
                    'Commented and added by ShraddhaM on 20,Aug 2009
                    'No need to pass Query text if Queryvalue=0
                    'strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strQueryText) & "'"
                    strQuery &= ",''"
                    'End of comment and addition by ShraddhaM
                End If
                CommonFunctions.Data.DisposeDataReader(drWork)
            Else
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strQueryText) & "'"
            End If
            strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDefaultValueType) & "'"
            'Added By Amol Changle On: 21 Jul 2009
            'Purpose: To save fields Entity Specific
            strQuery += ",'" + m_strEntityName + "'"
            'End Addition
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            'If the custom field is a combo box then replace existing values with the new values
            'for that Custom Field.
            If InStr(1, UCase(m_strDBFieldName.Trim()), "COMBO", CompareMethod.Text) <> 0 And m_bitIsQueryValue = "0" Then
                strValues = MyBase.FixString(Request.Form("lstValue"), 0, False, False)
                strValues = CommonFunctions.General.UnBuildQueryString(strValues)
                strTemp = "Usp_Sel_tbl_PM_CustomFields_Details '"
                strTemp &= m_strDBFieldName.Trim().ToUpper() & "'," & m_lngProjectId.ToString() & ",0"
                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To save field details Entity Specific
                strTemp += ",'" + m_strEntityName + "'"
                'End Addition

                drWork = CommonFunctions.Data.GetDataReader(strTemp, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    While drWork.Read()
                        strDataValue = drWork.Item("Value").ToString().Trim()
                        strDataValue = CommonFunctions.General.UnBuildQueryString(strDataValue)
                        If InStr(1, "," & strValues & ",", "," & strDataValue & ",", CompareMethod.Text) = 0 Then
                            strTemp = "EXEC usp_Ins_tbl_PM_AuditTrail " & m_intHelpId.ToString() & ","
                            strTemp &= m_lngUniqueId.ToString() & "," & m_lngProjectId.ToString()
                            strTemp &= ",'" & CommonFunctions.General.BuildQueryString(m_strUserName)
                            strTemp &= "','Value','" & CommonFunctions.General.BuildQueryString(strDataValue) & "'"
                            CommonFunctions.Data.InsertOrUpdateData(strTemp, MyBase.UseSQL)
                        End If
                    End While
                End If
                CommonFunctions.Data.DisposeDataReader(drWork)

                strTemp = "Exec Usp_Del_tbl_PM_CustomFields_Details " & m_lngProjectId.ToString() & ",'"
                strTemp &= CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To delete field details Entity Specific
                strTemp += ",'" + m_strEntityName + "'"
                'End Addition
                CommonFunctions.Data.InsertOrUpdateData(strTemp, MyBase.UseSQL)

                arrValues = strValues.Split(CType(",", Char))
                For intCtr = 0 To arrValues.Length - 1
                    strTemp = "Exec Usp_Ins_tbl_PM_CustomFields_Details " & m_lngProjectId.ToString() & ",'"
                    strTemp &= CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "','"
                    strTemp &= CommonFunctions.General.BuildQueryString(m_strUserGivenCaption) & "','"
                    strTemp &= CommonFunctions.General.BuildQueryString(arrValues(intCtr)) & "','"
                    strTemp &= CommonFunctions.General.BuildQueryString(m_strUserName) & "'"
                    'Added By Amol Changle On: 21 Jul 2009
                    'Purpose: To insert field details Entity Specific
                    strTemp += ",'" + m_strEntityName + "'"
                    'End Addition
                    CommonFunctions.Data.InsertOrUpdateData(strTemp, MyBase.UseSQL)
                Next
            End If
        End If
        m_strAction = ACTION_SUCCESSFULLY_COMPLETED
    End Sub

#End Region

#Region " Procedures / Functions Specific to Assign Types Mode "
    Private Sub WritePage_AssignTypes()
        Dim strMenu As String
        Dim drWork As IDataReader

        'Grid Related Variables
        Dim strQuery As String = ""
        Dim strPrimaryKey As String = ""
        Dim arrActualColumns() As String = {"Type", ""}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("TYPE"), MyBase.GetResourceString("SELECT")}
        Dim arrCheckBoxId() As String = {"", "chkType"}
        Dim arrTDStyle() As String = {"align='left' nowrap", "align='center'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_blnDisplay = True
        strQuery = "Exec Usp_Sel_tbl_PM_CustomFields_Master " & m_lngProjectId.ToString()
        strQuery &= ",'" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To delete field details Entity Specific
        strQuery += ",0,NULL,'" + m_strEntityName + "'"
        'End Addition
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_strUserGivenCaption = drWork.Item("UserGivenCaption").ToString().Trim()
                m_strUserGivenCaption = CommonFunctions.General.UnBuildQueryString(m_strUserGivenCaption)
                If m_strPageCalledFrom <> PAGE_CALLEDFROM_PROJECT_MANAGEMENT Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("IsCorporate"), "False"), Boolean) = True Then m_blnDisplay = False
                End If
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<br>")

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ASSIGNTYPES") + " [" + m_strEntityName + "]", Server.HtmlEncode(m_strDBFieldName & " : " & m_strUserGivenCaption), , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Plot the Grid
        'Modified By Amol Changle On: 21 Jul 2009
        'Purpose: To select "Types to assign" Entity wise 
        '           i.e. TaskType for Tasks & SubRequestType for HelpDesk Request
        'If m_lngProjectId = 0 Then
        '    strQuery = "EXEC usp_Sel_tbl_PM_TaskTypes_For_CustomFields "
        '    strPrimaryKey = "TaskTypeId"
        'Else
        '    strQuery = "EXEC usp_Sel_tbl_PM_Project_TaskTypes " & m_lngProjectId.ToString()
        '    strPrimaryKey = "TaskTypeId"
        'End If
        strQuery = "Usp_SEL_TypesToAssign_For_CustomFields " + m_lngProjectId.ToString()
        strQuery += ",'" + m_strEntityName + "'"
        strPrimaryKey = "TypeID"
        'End Modification

        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBoxId
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = strPrimaryKey
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            ''Commented and Added by Dhanashri S on 13 Oct 2015
            ''.DIVID = "DivList"
            .DIVID = "divList"
            ''End of Comment by Dhanashri S on 13 Oct 2015

            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 1
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        'Display Menu at bottom
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub SaveAssignTypes()
        Dim strQuery As String
        Dim intChkCount As Integer = 0
        Dim strCheckBoxValues As String = ""
        Dim arrValue() As String

        If m_lngProjectId = 0 Then
            strQuery = "usp_Del_tbl_PM_CustomFields_Type '" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
            'Added By Amol Changle On: 21 Jul 2009
            'Purpose: To save Assign Types Entity Specific
            strQuery += ",'" + m_strEntityName + "'"
            'End Addition
        Else
            strQuery = "usp_Del_tbl_PM_Project_CustomFields_Type '" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
            strQuery &= "," & m_lngProjectId.ToString()
            'Added By Amol Changle On: 21 Jul 2009
            'Purpose: To save Assign Types Entity Specific
            strQuery += ",'" + m_strEntityName + "'"
            'End Addition
        End If
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        strCheckBoxValues = MyBase.FixString(Request.Form("chkType"), 0, False, True)
        strCheckBoxValues = CommonFunctions.General.UnBuildQueryString(strCheckBoxValues)
        If strCheckBoxValues <> "" Then
            arrValue = strCheckBoxValues.Split(CType(",", Char))
            For intChkCount = 0 To arrValue.Length - 1
                If arrValue(intChkCount) <> "" Then
                    If m_lngProjectId = 0 Then
                        strQuery = "usp_Ins_tbl_PM_CustomFields_Type '" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                        strQuery &= "," & arrValue(intChkCount)
                        'Added By Amol Changle On: 21 Jul 2009
                        'Purpose: To save Assign Types Entity Specific
                        strQuery += ",'" + m_strEntityName + "'"
                        'End Addition
                    Else
                        strQuery = "usp_Ins_tbl_PM_Project_CustomFields_Type '" & CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'"
                        strQuery &= "," & m_lngProjectId.ToString()
                        strQuery &= ",'" & CommonFunctions.General.BuildQueryString(arrValue(intChkCount)) & "'"
                        'Added By Amol Changle On: 21 Jul 2009
                        'Purpose: To save Assign Types Entity Specific
                        strQuery += ",'" + m_strEntityName + "'"
                        'End Addition
                    End If
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                End If
            Next
        End If
        m_strAction = ACTION_SUCCESSFULLY_COMPLETED
    End Sub
#End Region

#Region " Procedures / Functions Specific to Custom Field List "
    Private Sub WritePage_CustomFieldList()
        Dim strQuery As String = ""
        Dim drWork As IDataReader
        Dim strMenu As String
        Dim objHeaderFooter As WebPages.Template.HeaderFooter

        'Get the Record count
        m_lngRowCount = 0
        strQuery = "Exec usp_Sel_tbl_PM_CustomFields_Master " & m_lngProjectId.ToString()
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To select fields Entity Specific
        strQuery += ",NULL,0,NULL,'" + m_strEntityName + "'"
        'End Addition

        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                m_lngRowCount += 1
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)

        CommonFunctions.General.WriteHTML("<BR>")
        'Display Page Caption
        'Code Commented By Syamantak Chavan On 05 Oct 2011 for whizible 10.0
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Code Added By Syamantak Chavan On 05 Oct 2011 for whizible 10.0
        m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EntityName"), "")
        If (m_strEntityName = "" Or m_strEntityName Is Nothing) Then m_strEntityName = "Task"
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strEntityName + " Custom Fields", , , True))
        'End Code Added By Syamantak Chavan On 05 Oct 2011 for whizible 10.0
        CommonFunctions.General.WriteHTML("<BR>")

        'Display Page Header
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<BR>")
        'Display Filter Combo
        CommonFunctions.General.WriteHTML("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'><TR align=Left class='clsTRPageFilters'> <td align='Right' colspan='2'> Entity Name :</td><TD align=left title=''>")
        'Modified By Amol Changle On: 21 Jul 2009
        'Purpose: Select statement replaced by Entity Selection SP.
        If m_lngProjectId = 0 Then
            CommonFunctions.HTMLControls.DrawComboBox("cboEntityName", "Usp_SEL_EntityList_CustomFieldMaintainance", 100, m_strEntityName, "onChange=Entity_Onchange(value)")
        ElseIf m_lngProjectId > 0 Then
            'Modified By Syamantak Chavan On 20 Sept 2011 For Whizible SEM 10.0
            'CommonFunctions.HTMLControls.DrawComboBox("cboEntityName", "SELECT	'Task','Task'", 100, m_strEntityName, "onChange=Entity_Onchange(value)")
            CommonFunctions.HTMLControls.DrawComboBox("cboEntityName", "SELECT	'Task','Task' UNION SELECT 'Projects','Projects' UNION SELECT 'Sub Projects','Sub Projects' UNION SELECT 'Resource Master','Resource Master'", 100, m_strEntityName, "onChange=Entity_Onchange(value)")
            'End Modified By Syamantak Chavan On 20 Sept 2011 For Whizible SEM 10.0
        End If

        'End Modification
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        'Display the Custom Fields Details
        DisplayCustomFieldList()

        CommonFunctions.General.WriteHTML("<BR>")
        'Display Footer
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        'Display Menu at Footer
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Sub DisplayCustomFieldList()
        Dim strQuery As String
        'Chakshuta
        Dim intTotalColumns As Integer = 7
        'Dim intTotalColumns As Integer = 8
        'Chakshuta
        Dim intTempTotalColumns As Integer = intTotalColumns
        If m_strPageCalledFrom = PAGE_CALLEDFROM_CORPORATE Then
            intTempTotalColumns = intTotalColumns - 1
        End If
        Dim arrActualColumns(intTempTotalColumns - 1) As String
        Dim arrUserFriendlyColumn(intTempTotalColumns - 1) As String
        Dim arrCheckBoxId(intTempTotalColumns - 1) As String
        Dim arrCheckedOnColumn(intTempTotalColumns - 1) As String
        Dim arrRowLink(intTempTotalColumns - 1) As String
        Dim arrRowLinkTooltip(intTempTotalColumns - 1) As String
        Dim arrTDStyle(intTempTotalColumns - 1) As String
        Dim intIndex As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Initialize the Required arrays for the advanced grid
        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("CONTROLNAME")
        arrActualColumns(intIndex) = "DatabaseFieldName"
        arrCheckBoxId(intIndex) = ""
        arrCheckedOnColumn(intIndex) = ""
        arrRowLink(intIndex) = "CustomField_OnClick('DatabaseFieldName',UniqueID)"
        arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CUSTOMFIELD_TOOLTIP")
        arrTDStyle(intIndex) = ""
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("CONTROLCAPTION")
        arrActualColumns(intIndex) = "UserGivenCaption"
        arrCheckBoxId(intIndex) = ""
        arrCheckedOnColumn(intIndex) = ""
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = ""
        arrTDStyle(intIndex) = ""
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("ROWNUMBER")
        arrActualColumns(intIndex) = "RowNumber"
        arrCheckBoxId(intIndex) = ""
        arrCheckedOnColumn(intIndex) = ""
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = ""
        arrTDStyle(intIndex) = "align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("COLUMNNUMBER")
        arrActualColumns(intIndex) = "ColumnNumber"
        arrCheckBoxId(intIndex) = ""
        arrCheckedOnColumn(intIndex) = ""
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = ""
        arrTDStyle(intIndex) = "align=center"
        intIndex += 1

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("SHOW")
        arrActualColumns(intIndex) = ""
        arrCheckBoxId(intIndex) = "chkActive"
        arrCheckedOnColumn(intIndex) = "Active"
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = ""
        arrTDStyle(intIndex) = "align=center"
        intIndex += 1

        'added by SachinR   on 07 jul 2004
        'to implement the custom field security,if page called from process module then dont show 
        'configure link
        If m_strPageCalledFrom <> PAGE_CALLEDFROM_CORPORATE Then
            arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("CONFIGURE_ACCESS")
            arrActualColumns(intIndex) = MyBase.GetResourceString("CONFIGURE_ACCESS")
            arrCheckBoxId(intIndex) = ""
            arrCheckedOnColumn(intIndex) = ""
            arrRowLink(intIndex) = "ConfigureAccess_OnClick(UniqueID)"
            arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("CONFIGURE_ACCESS_TOOLTIP")
            arrTDStyle(intIndex) = "align=center"
            intIndex += 1
        End If
        'addition end
        'Chakshuta
        'APPLICABLE_ATTRIBUTES
        'If m_strPageCalledFrom <> PAGE_CALLEDFROM_CORPORATE Then
        '    arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("APPLICABLE_ATTRIBUTES")
        '    arrActualColumns(intIndex) = MyBase.GetResourceString("APPLICABLE_ATTRIBUTES")
        '    arrCheckBoxId(intIndex) = ""
        '    arrCheckedOnColumn(intIndex) = ""
        '    arrRowLink(intIndex) = "ApplicableAttributes_OnClick(UniqueID)"
        '    arrRowLinkTooltip(intIndex) = MyBase.GetResourceString("APPLICABLE_ATTRIBUTES_TOOLTIP")
        '    arrTDStyle(intIndex) = "align=center"
        '    intIndex += 1
        'End If
        'Chakshuta

        arrUserFriendlyColumn(intIndex) = MyBase.GetResourceString("DELETE")
        arrActualColumns(intIndex) = ""
        arrCheckBoxId(intIndex) = "chkDelete"
        arrCheckedOnColumn(intIndex) = ""
        arrRowLink(intIndex) = ""
        arrRowLinkTooltip(intIndex) = ""
        arrTDStyle(intIndex) = "align=center"
        intIndex += 1

        strQuery = "Exec Usp_Sel_PM_Get_CustomFields " & m_lngProjectId.ToString()
        strQuery &= ", 'ORDER BY " & m_strSortBy & " " & m_strSortOrder & "'"
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To select fields Entity Specific
        strQuery += ",'" + m_strEntityName + "'"
        'End Addition

        'Set the Generic Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBoxId
            .CheckboxCheckOnColumnArray = arrCheckedOnColumn
            .RowLinkArray = arrRowLink
            .RowLinkToolTipArray = arrRowLinkTooltip
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "DatabaseFieldName"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"

            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intTotalColumns - 3
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub SaveCustomFieldList()
        Dim strQuery As String
        Dim strActiveList As String = ""
        Dim arrActiveCustomField() As String
        Dim intCnt As Integer

        strActiveList = CommonFunctions.General.UnBuildQueryString(Request.Form("chkActive") & "")
        If (strActiveList <> "") Then
            arrActiveCustomField = strActiveList.Split(CType(",", Char))
            strActiveList = ""
            For intCnt = 0 To arrActiveCustomField.Length - 1
                strActiveList &= "'" & CommonFunctions.General.BuildQueryString(arrActiveCustomField(intCnt)) & "',"
            Next
            strActiveList = Left(strActiveList, strActiveList.Length - 1)
        End If
        strQuery = "Usp_Upd_tbl_PM_CustomFields_Master_Active " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strActiveList) & "'"
        'Added by ShraddhaM on 17,Aug 2009 
        strQuery &= ", '" & m_strEntityName & "'"
        'Ended by ShraddhaM

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    Private Sub DeleteCustomFieldList()
        Dim strQuery As String
        Dim strDeleteList As String = ""
        Dim arrCheckedCustomField() As String
        Dim intCnt As Integer

        strDeleteList = CommonFunctions.General.UnBuildQueryString(Request.Form("chkDelete") & "")
        If (strDeleteList <> "") Then
            arrCheckedCustomField = strDeleteList.Split(CType(",", Char))
            strDeleteList = ""
            For intCnt = 0 To arrCheckedCustomField.Length - 1
                strDeleteList &= "'" & CommonFunctions.General.BuildQueryString(arrCheckedCustomField(intCnt)) & "',"
            Next
            strDeleteList = Left(strDeleteList, strDeleteList.Length - 1)
        End If
        strQuery = "Usp_Del_tbl_PM_CustomFields " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strDeleteList) & "'"
        'Added By Amol Changle On: 21 Jul 2009
        'Purpose: To select fields Entity Specific
        strQuery += ",'" + m_strEntityName + "'"
        'End Addition

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub

    Private Sub AddCustomFieldToProject()
        Dim strQuery As String = ""
        Dim strReturn As String = ""
        Dim strMsg As String = ""
        'Added By Syamantak Chavan On 21 Sept 2011 For Whizible SEM 10.0
        m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EntityName"), "")
        'End Added By Syamantak Chavan On 21 Sept 2011 For Whizible SEM 10.0
        strQuery = "DECLARE @strReturn VARCHAR(100)" & vbCrLf
        strQuery &= "Exec usp_Ins_PM_CorporateCustomFields_To_Project " & m_lngProjectId.ToString()
        strQuery &= ", '" & m_strDBFieldName & "'"
        strQuery &= ", @strReturn OUT"
        'Added By Syamantak Chavan On 21 Sept 2011 For Whizible SEM 10.0
        strQuery &= ", '" & m_strEntityName & "'" & vbCrLf
        'End Added By Syamantak Chavan On 21 Sept 2011 For Whizible SEM 10.0
        strQuery &= " SELECT @strReturn" & vbCrLf

        strReturn = CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()
        'Return Value is DatabaseFieldName.

        If strReturn <> "" Then
            If strReturn = "DatabaseFieldName Not Acive" Then
                strMsg = MyBase.GetResourceString("CAN_NOT_ADD_TO_PROJECT", False)
                'strMsg = "Can not be added to Project"
                m_strClientSideScript = "alert(""" & strMsg & """);" & vbCrLf
            Else
                strMsg = MyBase.GetResourceString("SAME_ROW_COLUMN_NUMBER", False)
                strMsg = Replace(strMsg, "<=>", m_strDBFieldName)
                strMsg = Replace(strMsg, "<==>", strReturn)
                m_strClientSideScript = "alert(""" & strMsg & """);" & vbCrLf
            End If
        End If
    End Sub
#End Region

#Region " Menu / Grid Event Handlers "

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print

        If m_strMode = MODE_LIST Then
            'Modified By Bharat T on 25th-Nov-2015 for Clear all link
            If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.DELETE) Or _
              Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Or _
              Args.LinkName = m_arrMenuItem(MenuIndex.CLEARALL) Then
                'End of Modified By Bharat T on 25th-Nov-2015 for Clear all link
                If m_objAccessRights.Edit = False And Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then
                    Cancel = True
                End If
                If (m_objAccessRights.Delete = False Or m_lngRowCount <= 0) And _
                   (Args.LinkName = m_arrMenuItem(MenuIndex.DELETE) Or _
                    Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL)) Then
                    Cancel = True
                Else
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Then
                        Args.FunctionName = "SelectAll_OnClick('frmTaskCustomFields','chkDelete')"
                    End If
                    'Added By Bharat T on 25th-Nov-2015 for Clear all link
                    If Args.LinkName = m_arrMenuItem(MenuIndex.CLEARALL) Then
                        Args.FunctionName = "ClearAll_OnClick('frmTaskCustomFields','chkDelete')"
                    End If
                    'End of Added By Bharat T on 25th-Nov-2015 for Clear all link
                End If
            Else
                '--- Modified By NitinVS to show close link for WhizibleSEM SP 8 Regression Issue 11385 
                If (Args.LinkName <> m_arrMenuItem(MenuIndex.CLOSE) And Args.LinkName <> m_arrMenuItem(MenuIndex.HELP)) Then
                    Cancel = True
                End If
                ' End Modified By NitinVS to show close link for WhizibleSEM SP 8 Regression Issue 11385 
            End If

        ElseIf m_strMode = MODE_ASSIGN_TYPES Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.CLEARALL) Then
                If m_blnDisplay = False Then
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
                       Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Or _
                       Args.LinkName = m_arrMenuItem(MenuIndex.CLEARALL) Then
                        Cancel = True
                        Return
                    End If
                Else
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Then
                        Args.FunctionName = "SelectAll_OnClick('frmTaskCustomFields','chkType')"
                    End If
                End If
            Else
                '--- Modified By NitinVS to show close link for WhizibleSEM SP 8 Regression Issue 11385 
                If (Args.LinkName <> m_arrMenuItem(MenuIndex.CLOSE) And Args.LinkName <> m_arrMenuItem(MenuIndex.HELP)) Then
                    Cancel = True
                End If
                ' End Modified By NitinVS to show close link for WhizibleSEM SP 8 Regression Issue 11385 
            End If
        ElseIf m_strMode = MODE_DETAILS Then
            m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EntityName"), "")
            'Chakshuta
            If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.BACK) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.APPLICABLE_ATTRIBUTES) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) Then
                'If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) Or _
                '    Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
                '    Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Or _
                '    Args.LinkName = m_arrMenuItem(MenuIndex.BACK) Or _
                '    Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) Then
                'Chakshuta
                'Chakshuta
                'APPLICABLE_ATTRIBUTES
                'Args.LinkName = m_arrMenuItem(MenuIndex.APPLICABLE_ATTRIBUTES) Then
                'Chakshuta 
                'Added By Syamantak Chavan On 04-Oct-2011 for Whizible 10.0 to hide Assign type links 
                'Modified and added m_strEntityName.ToUpper <> "Help-Desk" by  NitinC on 19 March 2012 For WhizibleSEM 11.0 [Issue Fix 60632] 
                If m_strEntityName.ToUpper = "GLOBAL PROJECT" Or m_strEntityName.ToUpper = "PROJECTS" Or m_strEntityName.ToUpper = "RESOURCE MASTER" Or m_strEntityName.ToUpper = "SUB PROJECTS" Then
                    'End of Modified and added m_strEntityName.ToUpper <> "Help-Desk" by  NitinC on 19 March 2012 For WhizibleSEM 11.0 [Issue Fix 60632] 
                    If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) Then Cancel = True
                End If
                'End Added By Syamantak Chavan On 04-Oct-2011 for Whizible 10.0 to hide Assign type links 
                If m_strUserGivenCaption = "" Then
                    If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) Then Cancel = True
                End If
                If m_blnDisplay = False Then
                    If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
                       Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Then
                        Cancel = True
                        Return
                    End If
                Else
                    If m_lngUniqueId = 0 Then
                        If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Then Cancel = True
                    End If
                End If
                'added by SachinR   on 07 Jul 2004
                'Chakshuta for Configure_access
                If (m_strUniqueID = "" Or m_strUniqueID = "0" Or m_strPageCalledFrom = PAGE_CALLEDFROM_CORPORATE) And m_strEntityName.ToLower() <> "help-desk" And m_strEntityName.ToLower() <> "global project" And m_strEntityName.ToLower() <> "projects" Then 'Added by NitinC on 13 April 2011 for WhizibleSEM 10.0 and sub projects,projects,resource master ''And m_strEntityName.ToLower() <> "sub projects" And m_strEntityName.ToLower() <> "projects" And m_strEntityName.ToLower() <> "resource master"
                    'Chakshuta for Configure_access
                    If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) Then Cancel = True
                    'Chakshuta
                    'APPLICABLE_ATTRIBUTES
                    'Else
                    'If Args.LinkName = m_arrMenuItem(MenuIndex.APPLICABLE_ATTRIBUTES) Then Cancel = True
                    'Chakshuta
                    'Added by NitinC on 13 April 2011 for WhizibleSEM 10.0 and sub projects,projects,resource master,global project
                Else
                    If (m_strUniqueID = "" Or m_strUniqueID = "0" Or m_strPageCalledFrom = PAGE_CALLEDFROM_CORPORATE) And (m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project") Then
                        If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) Then Cancel = True
                    End If
                End If
                'Chakshuta
                'If (m_strUniqueID = "" Or m_strUniqueID = "0" Or m_strPageCalledFrom = PAGE_CALLEDFROM_CORPORATE) And m_strEntityName.ToLower() <> "help-desk" And m_strEntityName.ToLower() <> "global project" And m_strEntityName.ToLower() <> "projects" Then 'Added by NitinC on 13 April 2011 for WhizibleSEM 10.0 and sub projects,projects,resource master ''And m_strEntityName.ToLower() <> "sub projects" And m_strEntityName.ToLower() <> "projects" And m_strEntityName.ToLower() <> "resource master"
                '    'Chakshuta
                '    If Args.LinkName = m_arrMenuItem(MenuIndex.APPLICABLE_ATTRIBUTES) Then Cancel = True
                'End If
                'Chakshuta
                'End of Added by NitinC on 13 April 2011 for WhizibleSEM 10.0 and sub projects,projects,resource master
                'addition end

            Else
                '--- Modified By NitinVS to show close link for WhizibleSEM SP 8 Regression Issue 11385 
                If (Args.LinkName <> m_arrMenuItem(MenuIndex.CLOSE) And Args.LinkName <> m_arrMenuItem(MenuIndex.HELP)) Then
                    Cancel = True
                    Return
                End If
                ' End Modified By NitinVS to show close link for WhizibleSEM SP 8 Regression Issue 11385 

            End If
        End If

            If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Then
                Args.FunctionName = "ShowHistory_OnClick(" & m_intHelpId & "," & m_lngUniqueId & "," & m_lngProjectId & ")"
            End If
            If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) Then
                Args.FunctionName = "AssignType_OnClick('" & Replace(m_strDBFieldName, "'", "\'") & "')"
            End If
            If Args.LinkName = m_arrMenuItem(MenuIndex.HELP) Then
                Args.FunctionName = "Help_OnClick('" & m_intHelpId & "')"
            End If

            'Addition done by SuchitraP on 14-Aug-2007 for IssueID 14731
            If Request.QueryString("CORP") = "1" Then
                If m_strMode = MODE_LIST Or m_strMode = MODE_DETAILS Then
                    If Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE) Then
                        Cancel = True
                    End If
                End If
            End If
            'End of Addition done by SuchitraP on 14-Aug-2007 for IssueID 14731
            'Added by ShraddhaM on 11,Aug 2009 to hide configure Access and Assign type links in add mode of helpdesk custom field
            If m_strEntityName.ToLower() = "help-desk" And m_strMode = MODE_DETAILS Then
                'Chakshuta
                If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) OrElse Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) Then
                    'If Args.LinkName = m_arrMenuItem(MenuIndex.ASSIGN_TYPES) OrElse Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) OrElse Args.LinkName = m_arrMenuItem(MenuIndex.APPLICABLE_ATTRIBUTES) Then
                    'APPLICABLE_ATTRIBUTES
                    'Chakshuta
                Dim IsDefined As Boolean = False

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''IsDefined = CType(CommonFunction.Data.GetDataScalar("select 1 from tbl_PM_CustomFields_Master WHERE UniqueID = " + m_lngUniqueId.ToString() + " AND ISNULL(RowNumber,0) > 0 AND ISNULL(ColumnNumber,0) > 0", MyBase.UseSQL), Boolean)
                IsDefined = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CustomFields_Master_UniqueID " + m_lngUniqueId.ToString(), MyBase.UseSQL), Boolean)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If IsDefined = False Then
                    Cancel = True
                End If

                End If
            End If
            'select 1 from tbl_PM_CustomFields_Master WHERE UniqueID =  AND ISNULL(RowNumber,0) > 0 AND ISNULL(ColumnNumber,0) > 0
            'Ended by ShraddhaM
            'Added by NitinC on 13 April 2011 to hide configure Access links in add mode of sub projects custom fieldf for WhizibleSEM 10.0
            If m_strEntityName.ToLower() = "sub projects" And m_strMode = MODE_DETAILS Or m_strEntityName.ToLower() = "projects" And m_strMode = MODE_DETAILS Or m_strEntityName.ToLower() = "resource master" And m_strMode = MODE_DETAILS Or m_strEntityName.ToLower() = "global project" And m_strMode = MODE_DETAILS Then
                'Chakshuta
                If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) Then
                    'If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_ACCESS) OrElse Args.LinkName = m_arrMenuItem(MenuIndex.APPLICABLE_ATTRIBUTES) Then
                    'Chakshuta
                    'APPLICABLE_ATTRIBUTES
                Dim IsDefined As Boolean = False

                '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''IsDefined = CType(CommonFunction.Data.GetDataScalar("select 1 from tbl_PM_CustomFields_Master WHERE UniqueID = " + m_lngUniqueId.ToString() + " AND ISNULL(RowNumber,0) > 0 AND ISNULL(ColumnNumber,0) > 0", MyBase.UseSQL), Boolean)
                IsDefined = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CustomFields_Master_UniqueID " + m_lngUniqueId.ToString(), MyBase.UseSQL), Boolean)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If IsDefined = False Then
                    Cancel = True
                End If

                End If
            End If
            'Ended by NitinC
    End Sub
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        If m_strMode = MODE_LIST Then
            Dim strQuery As String
            Dim drWork As IDataReader
            Dim strFieldName As String = ""

            strFieldName = Args.DataReader.Item("DatabaseFieldName").ToString().Trim()
            strFieldName = CommonFunctions.General.UnBuildQueryString(strFieldName)
            'Get the Record count
            m_lngRowCount = 0
            'Added By VarunA On 13-Aug-2008 RequestID - 14439
            'Purpose : To have Custom field name
            m_strCorprateCFCaption = ""
            'End By VarunA On 13-Aug-2008 For RequestID - 14439
            If strFieldName <> "" Then
                strQuery = "Exec usp_Sel_tbl_PM_CustomFields_Master_CheckIsCorpCF " & m_lngProjectId.ToString()
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strFieldName) & "'"
                strQuery &= ",'" & m_strEntityName & "'"

                drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    While drWork.Read()
                        m_lngRowCount += 1
                        'Added By VarunA On 13-Aug-2008 RequestID - 14439
                        'Purpose : To have Custom field name
                        m_strCorprateCFCaption = CommonFunction.Data.CheckIsDBNull(drWork.Item("UserGivenCaption")).ToString
                        'End By VarunA On 13-Aug-2008 For RequestID - 14439
                    End While
                End If
                CommonFunctions.Data.DisposeDataReader(drWork)
            End If
        End If
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If m_strMode = MODE_ASSIGN_TYPES And Args.ColIndex = 1 Then
            Dim drWork As IDataReader
            Dim strQuery As String = ""
            Dim strType As String = ""

            strType = Args.DataReader.Item(0).ToString().Trim()
            strType = CommonFunctions.General.UnBuildQueryString(strType)
            Args.IsCheckBoxChecked = True
            If m_lngProjectId = 0 Then
                strQuery = "usp_Sel_tbl_PM_CustomFields_Type '"
                strQuery &= CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'," & strType
                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To select types Entity Specific
                strQuery += ",'" + m_strEntityName + "'"
                'End Addition
            Else
                strQuery = "usp_Sel_tbl_PM_Project_CustomFields_Type '"
                strQuery &= CommonFunctions.General.BuildQueryString(m_strDBFieldName) & "'," & m_lngProjectId.ToString()
                strQuery &= ",'" & CommonFunctions.General.BuildQueryString(strType) & "'"
                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To select types Entity Specific
                strQuery += ",'" + m_strEntityName + "'"
                'End Addition
            End If
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If Not (drWork.Read()) Then Args.IsCheckBoxChecked = False
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

        ElseIf m_strMode = MODE_LIST Then
            Dim blnShow As Boolean = False
            Dim blnIsCorporate As Boolean = False
            Dim blnActive As Boolean = False
            Dim objLink As WebPages.UI.cDynamicLink

            blnShow = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Show"), "False"), Boolean)
            blnIsCorporate = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("IsCorporate"), "False"), Boolean)
            blnActive = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Active"), "False"), Boolean)
            Select Case Args.ColIndex
                Case 0  'Control Name Column
                    If Not (m_lngRowCount = 0 And _
                       ((m_objAccessRights.Edit And blnShow = True) Or _
                        (m_objAccessRights.Add And blnShow = False))) Then
                        Args.EnableLink = False
                    End If

                Case 1  'Control Caption Column 
                    If m_lngRowCount = 0 Then
                        If blnShow = True Then
                            Args.StringToBeInserted = "<TD>"
                            Args.StringToBeInserted &= Server.HtmlEncode(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("UserGivenCaption")).ToString())
                            Args.StringToBeInserted &= " " & MyBase.GetResourceString("DEFINED")
                            Args.StringToBeInserted &= "</TD>"
                            Cancel = True
                        End If
                    Else
                        objLink = New WebPages.UI.cDynamicLink
                        objLink.FunctionName = "Add_To_Project_OnClick('" & Args.DataReader("DatabaseFieldName").ToString() & "')"
                        objLink.LinkName = MyBase.GetResourceString("ADD_TO_PROJECT")
                        objLink.Tooltip = MyBase.GetResourceString("ADD_TO_PROJECT_TOOLTIP")
                        objLink.ReturnHTML = True
                        'Modified By VarunA on 12-Aug-2008 RequestID-14439
                        'Purpose : To have role level security and custom field name
                        'Args.StringToBeInserted = "<TD>" & MyBase.GetResourceString("DEFINE_AT_CORPORATE_LEVEL")
                        Args.StringToBeInserted = "<TD>" & m_strCorprateCFCaption & " - " & MyBase.GetResourceString("DEFINE_AT_CORPORATE_LEVEL")
                        If m_objAccessRights.Add = False And m_objAccessRights.Edit = False Then
                            Args.StringToBeInserted &= " " & MyBase.GetResourceString("ADD_TO_PROJECT")
                        Else
                            Args.StringToBeInserted &= " " & objLink.GetDynamicLink()
                        End If
                        'End By VarunA on 12-Aug-2008 RequestID-14439
                        Args.StringToBeInserted &= "</TD>"
                        Cancel = True
                    End If

                Case 2  'Row Number Column
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RowNumber"), "0"), Long) = 9999 Then
                        Args.ReplacementValue = m_strNbyA
                    End If

                Case 3  'Column Number Column
                    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ColumnNumber"), "0"), Long) = 9999 Then
                        Args.ReplacementValue = m_strNbyA
                    End If

                Case 4  'Show Checkbox Column
                    If m_objAccessRights.Edit = False Then
                        Cancel = True
                    Else
                        If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then
                        ElseIf blnIsCorporate = True Then
                            Args.StringToBeInserted = "<TD align=center>"
                            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkActive", "chkActive", , blnActive, Args.DataReader.Item("DatabaseFieldName").ToString().Trim(), , "style='display:none'", True)
                            If blnActive = True Then
                                Args.StringToBeInserted &= MyBase.GetResourceString("YES")
                            Else
                                Args.StringToBeInserted &= MyBase.GetResourceString("NO")
                            End If
                            Args.StringToBeInserted &= "</TD>"
                            Cancel = True
                        Else
                            Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
                            Cancel = True
                        End If
                    End If

                    'added by SachinR   on 07 jul 2004
                    'to implement the custom field security 
                Case 5  'Configure access link
                    If m_strPageCalledFrom <> PAGE_CALLEDFROM_CORPORATE Then
                        If IsDBNull(Args.DataReader("UniqueID")) Then
                            Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
                            Cancel = True
                        End If
                    Else  ' Delete column will be sixth in case of no configure access link column
                        If m_objAccessRights.Delete = False Then
                            Cancel = True
                        Else
                            If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then
                            Else
                                Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
                                Cancel = True
                            End If
                        End If
                    End If
                    'addition end 
                    'Added By VarunA on 12-Aug-2008 RequestID-14439
                    'Purpose : To have role level security
                    If m_objAccessRights.Add = False And m_objAccessRights.Edit = False Then
                        If (blnShow = True) Then
                            Cancel = True
                            Args.StringToBeInserted = "<TD align=center>" + MyBase.GetResourceString("CONFIGURE_ACCESS") + "</TD>"
                        End If
                    End If
                    'End By VarunA on 12-Aug-2008 RequestID-14439
                    'APPLICABLE_ATTRIBUTES
                Case 6  'Delete Checkbox Column
                    If m_objAccessRights.Delete = False Then
                        Cancel = True
                    Else
                        If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then
                        Else
                            Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
                            Cancel = True
                        End If
                    End If
                    'Case 7  'Configure access link
                    '    If m_strPageCalledFrom <> PAGE_CALLEDFROM_CORPORATE Then
                    '        If IsDBNull(Args.DataReader("UniqueID")) Then
                    '            Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
                    '            Cancel = True
                    '        End If
                    '    Else  ' Delete column will be sixth in case of no configure access link column
                    '        If m_objAccessRights.Delete = False Then
                    '            Cancel = True
                    '        Else
                    '            If (blnShow = True) And (blnIsCorporate = False) And (m_lngRowCount = 0) Then
                    '            Else
                    '                Args.StringToBeInserted = "<TD align=center>" & m_strNbyA & "</TD>"
                    '                Cancel = True
                    '            End If
                    '        End If
                    '    End If
                    '    'addition end 
                    '    'Added By VarunA on 12-Aug-2008 RequestID-14439
                    '    'Purpose : To have role level security
                    '    If m_objAccessRights.Add = False And m_objAccessRights.Edit = False Then
                    '        If (blnShow = True) Then
                    '            Cancel = True
                    '            Args.StringToBeInserted = "<TD align=center>" + MyBase.GetResourceString("APPLICABLE_ATTRIBUTES") + "</TD>"
                    '        End If
                    '    End If
            End Select
        End If
    End Sub
    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If m_strMode = MODE_LIST Then
            Select Case Args.ColIndex
                Case 4  'Show Checkbox Column
                    If m_objAccessRights.Edit = False Then
                        Cancel = True
                    End If
                Case 5
                    If m_strPageCalledFrom = PAGE_CALLEDFROM_CORPORATE Then
                        If m_objAccessRights.Delete = False Then
                            Cancel = True
                        End If
                    End If
                Case 6  'Delete Checkbox Column
                        If m_objAccessRights.Delete = False Then
                            Cancel = True
                        End If
            End Select
        End If
    End Sub
#End Region
End Class
