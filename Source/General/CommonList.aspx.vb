'DECLARATION: THIS IS A FRAMEWORK CODE ITEM. IT IS NOT EXPECTED TO MODIFY THIS AT THE APPLICATION LEVEL
Public Class CommonList
    Inherits WebPages.Template.WhizTemplate
    'Private  -> Protected 
    'Local variables
    Protected m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccess As WebPage.Templates.AccessRights
    'Create the object of cCLSQL class
    Private m_cObjCLSQL As CommonEngine.CommonList.cCLSQL
    Private m_cObjFilters As CommonEngine.CommonList.cDynamicFilters
    'Parameters to be persisted
    Private m_strPagingAlphabet As String = ""
    Private m_strSortBy As String = ""
    Private m_strSortOrder As String = ""
    Protected m_strCommonQueryString As String = "" 'Make it Protected UJ 13 Aug 2007 Request ID: 272
    Private m_strFilterFunction As String = "setFilter"
    Private m_strUserFilter As String = ""
    Private m_strInformativeMessage As String = ""
    Protected m_strQuerystringDefaultParameters As String = "" 'Make it Protected UJ 13 Aug 2007 Request ID: 272
    Private m_blnDisplaySubTags As Boolean = False
    Protected m_blnIgnoreDelete As Boolean = False
    Private m_strAccessFirstTime As String = ""

    Private Const FUNCTION_NAME_EDIT_ONCLICK As String = "EditOnclick"
    Private Const FUNCTION_NAME_PAGE_ONCLICK As String = "Page_Onclick"
    Private Const FUNCTION_NAME_SHOW_HIDE_SUBTAG As String = "ShowHideSubTag"

    'Hotfix... 1.0.0-SP1-WAF
    Private Const FUNCTION_NAME_SUBTAG_INFORMATION As String = "DisplayTooltipCL"

    Private Const SHOW_SUBTAG_IMAGE_SOURCE As String = "../../Images/plus.gif"
    Private Const HIDE_SUBTAG_IMAGE_SOURCE As String = "../../Images/minus.gif"
    Private Const SHOW_SUBTAG_IMAGE_TOOLTIP As String = "Show"
    Private Const HIDE_SUBTAG_IMAGE_TOOLTIP As String = "Hide"
    Protected Const DELETION_CHECKBOX_NAME As String = "chkDelete"
    Private Const FUNCTION_NAME_EXPAND_SECTION As String = "expandSections"
    Private Const DIV_TAG As String = "divListPageTag" 'Modified By NileshD on 4 Mar 2006 ReqID WAF3_PB_17

    'Added By UmeshJ on 23 Nov 2004
    Protected Const VALIDATE_FILTER As String = "validateTagFilter"
    'End
    Protected m_strSectionClientsideScript As String = ""

    Protected WithEvents m_cObjMenu As WebPage.Templates.DynamicMenu
    Private WithEvents m_cObjPageCaption As WebPage.Templates.PageCaption
    Private WithEvents m_cObjHeaderFooter As WebPage.Templates.HeaderFooter
    Private WithEvents m_cObjPageLegends As WebPage.Templates.PageLegends
    Private m_objGeneral As EventHandlers.WAF_General
    Private WithEvents m_cObjSectionTitle As WebPage.Templates.SectionTitle
    ' **************************************************************************
    ' Added Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
    ' **************************************************************************
    Private WithEvents m_objGrid As WebPage.Templates.GenericGrid
    ' **************************************************************************
    ' End Addition Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
    ' **************************************************************************
    'Code Added:RajeshB         17 Jan 2005
    'Purpose:CommonList object
    Protected strListPage As String = "CommonList.aspx"
    Protected strFormPage As String = "CommonPage.aspx"

    'To fix IssueId 19587. Added by PrasannaP on 23rd June 2005
    Protected strSubTagPage As String = "../General/CommonSubTag.aspx" 'Aug 09, 2007 Modified By UmeshJ; Issue ID: 14570 [no. 6]
    'Added By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10
    Private m_strNavigationControl As String = ""
    Private m_intPagingNo As Integer = 1
    Private m_strPagingAction As String = ""
    Private m_intNumericPagingDisplayPosition As Integer
    'End Addition

    ' Public ReturnCodes As [Type] = CommonEngine.General.cEventHandlers.ReturnCodes
    'Addition Ends.
    '==========================================================================================================
    'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
    '==========================================================================================================
    Protected m_strConnectionString As String = ""
    Protected m_intConnectionID As Integer
    '==========================================================================================================
    ' Addition End By : Ninad   Req Id : WAF3_PB_33
    '==========================================================================================================

    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
    'Reason   - For sowing contetx menu in grid.
    '-------------------------------------------------------------------------------------------------------------
    Private m_blnConsiderContextMenu As Boolean = False
    Private m_strContextMenuJsFunction As String = ""
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
    '-------------------------------------------------------------------------------------------------------------
    Protected m_blnIsDesignMode As Boolean = Nothing        'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 25 May 2007
    'Added By NikhilM 16 Nov 2010 for language support functionality
    Private m_bIsLangEnabled As Boolean = False
    'Addition End By NikhilM 16 Nov 2010 for language support functionality
    'Added by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
    Private m_strShortcutsAndFunction(0), m_strTagID(0) As String
    Dim blnIsSubTag(0) As Boolean
    'strKeyboardShortcutsAndFunctions : - This variable is provided for specifying shortcut for custom objects such as button, link etc in inherited page
    'developer must set this variable before plotting menu, it is recommended to set this variable in page load
    'This variable contains Keyboard shortcut followed by Event handler (with parameter if any)
    'Note: Specify supported shortcuts only.
    'e.g Alt + I, OpenMyPage1('www.yahoo.com'),Shift + F2, OpenMyPage2('www.rediffmail.com')  
    Protected strKeyboardShortcutsAndFunctions As String = ""
    'End Addition by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    'Private -> Protected Overridable
    Protected Overridable Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


        Dim a As String = Request.Url.ToString()
      
        ''Apply Security
        'MyBase.ApplySecurity()
        ''Create the WhizGlobal class object
        'MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'm_objGlobal = MyBase.GlobalObject
        '____Added By UmeshJ on 16-June-2005.....Call the Event to allow change in the WhizGlobal object properties
        '____Code for FillGlobalObject and Apply security is moved to GetGlobalObject() function
        'Get the WhizGlobal object details
        Call GetGlobalObject()
        '____End of addition By UmeshJ on 16-June-2005
        '==========================================================================================================
        'Added By NinadP :	16 Nov 2006 : Requirement Tag - WAF3_PB_33 
        '==========================================================================================================
        GetConnection()
        '==========================================================================================================
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================
        'Put user code to initialize the page here
        'Resequencing of the function calls done by PrasannaP
        'Hotfix for fields not appearing on the filters pager for first time.
        Call GetUserFilter()
        Call GetParameters()
        Call GetAccessRights()
        Call ApplyView()
        Call GetCLSQL()
        'Added By Chakshuta H on 30th-Oct-2015
        Call WritePluginScriptBlock(True)
        'Ended By Chakshuta H on 30th-Oct-2015
        Call PageDetails()
    End Sub

    Private Sub ApplyView()
        '=====================================================================
        ' Procedure Name        :	ApplyView
        ' Purpose               :	Apply the selected view along with the filter
        ' Description           :	R. No. WAF3_PB_24
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	July 13, 2006 
        ' Revisions             :
        '=====================================================================
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ApplyView")) = "" Then Return
        Dim strViewID As String = UCase(MyBase.GetFormValue("cboMyViews"))
        Dim strTagID As String = CStr(m_objGlobal.TagID)
        Dim strUserID As String = CStr(m_objGlobal.UserID)
        Dim strLoginType As String = CStr(m_objGlobal.LoginType)
        CommonEngine.CommonPage.cDataManagement.ApplyView(strViewID, strTagID, strUserID, strLoginType)
    End Sub
    Protected Overridable Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New CommonEngine.CommonPage.cDataManagement(m_objGlobal)
    End Function
    Private Sub GetParameters()
        '=====================================================================
        ' Procedure Name        :	GetParameters
        ' Purpose               :	Get the request Parameters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        If Not Request("PagingAlphabet") Is Nothing Then m_strPagingAlphabet = CommonFunctions.General.CheckIsNothing(Microsoft.VisualBasic.Strings.Replace(Replace(Microsoft.VisualBasic.Strings.Replace(Request("PagingAlphabet").ToString, CommonFunction.Constants.PAGING_SPECIAL_CHAR_AND, "&"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_HASH, "#"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_PLUS, "+"))
        If Not Request("SortBy") Is Nothing Then m_strSortBy = Request("SortBy").ToString
        If Not Request("SortOrder") Is Nothing Then m_strSortOrder = Request("SortOrder").ToString
        If CommonFunction.General.CheckIsNothing(Request("DYNAMIC_ACTION"), "") = "1" Then
            'Action executed
            Dim strMsgActionExecuted As String = MyBase.GetResourceString("ACTION_EXECUTED")
            m_strInformativeMessage = "window.status='" + strMsgActionExecuted + "';"
        End If
        m_strAccessFirstTime = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("AccessFirstTime"), "1")
        m_strQuerystringDefaultParameters = CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal) + m_strQuerystringDefaultParameters 'Request ID 272 UmeshJ 14 Aug 2007; Consider values set in the inherited page (if any)
        'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
        If Not Request("PagingNumber") Is Nothing Then
            m_intPagingNo = CType(CommonFunctions.General.CheckIsNothing(Request("PagingNumber"), "1"), Integer)
        Else
            m_intPagingNo = CType(CommonFunctions.General.CheckIsNothing(Request.Form("PagingNumber"), "1"), Integer)
        End If
        If Not Request("PagingNavigation") Is Nothing Then m_strPagingAction = CommonFunctions.General.CheckIsNothing(Request("PagingNavigation"), "")
        'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
    End Sub

    Private Sub MemoryCleanUp()
        '=====================================================================
        ' Procedure Name        :	MemoryCleanUp
        ' Purpose               :	Remove the unused objects from the memory
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Destroy the exists objects
        If Not m_objAccess Is Nothing Then m_objAccess = Nothing
        If Not m_objGlobal Is Nothing Then m_objGlobal = Nothing
        If Not m_cObjCLSQL Is Nothing Then m_cObjCLSQL = Nothing
        If Not m_cObjFilters Is Nothing Then m_cObjFilters = Nothing
    End Sub

    Private Sub PageDetails()
        '=====================================================================
        ' Procedure Name        :	PageDetails
        ' Purpose               :	This is a main function to plot the Page Details
        ' Description           :	This function internally calls different functions 
        '                           to plot the page details
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Modified By NileshD on 22 Sep REQID- WAF3_PB_10
        'm_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + m_strQuerystringDefaultParameters
        If m_strPagingAction <> "" Then
            'Integrated By VarunA on 25-Nov-2008 
            'Purpose : Numeric text paging wasn't working in query builder.
            'Modified By Shrikant B On 19 Nov 2008 For Issue ID 21854
            Dim strControlName As String
            strControlName = CommonFunctions.General.CheckIsNothing(Request("PagingControl"), "txtNumPaging1")
            m_intPagingNo = CType(CommonFunctions.General.CheckIsNothing(Request.Form(strControlName), "1"), Integer)
            'Modification End By Shrikant B On 19 Nov 2008 For Issue ID 21844
            'End By VarunA on 25-Nov-2008 
            If UCase(m_strPagingAction) = "PREV" Then
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                ''m_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + (m_intPagingNo - 1).ToString + m_strQuerystringDefaultParameters
                m_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + (m_intPagingNo - 1).ToString + m_strQuerystringDefaultParameters
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
                m_intPagingNo = m_intPagingNo - 1
            ElseIf UCase(m_strPagingAction) = "NEXT" Then
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                'm_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + (m_intPagingNo + 1).ToString + m_strQuerystringDefaultParameters
                m_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + (m_intPagingNo + 1).ToString + m_strQuerystringDefaultParameters
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
                m_intPagingNo = m_intPagingNo + 1
            ElseIf UCase(m_strPagingAction) = "CURR" Then
                'Integrated By VarunA on 25-Nov-2008 
                'Purpose : Numeric text paging wasn't working in query builder.
                'Commented By Shrikant B On 19 Aug 2008 
                'Dim strControlName As String
                'strControlName = CommonFunctions.General.CheckIsNothing(Request("PagingControl"), "txtNumPaging1")
                '  m_intPagingNo = CType(CommonFunctions.General.CheckIsNothing(Request.Form(strControlName), "1"), Integer)
                'Commented End  By Shrikant B On 19 Aug 2008 
                'End By VarunA on 25-Nov-2008 
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                'm_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + m_intPagingNo.ToString + m_strQuerystringDefaultParameters
                m_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + m_intPagingNo.ToString + m_strQuerystringDefaultParameters
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            End If
        Else
            'm_intPagingNo = 1
            If Not Request("SetFilter") Is Nothing Then
                If Request("SetFilter") = "1" Then
                    m_intPagingNo = 1
                End If
            ElseIf Not Request("SetPagingAlphabet") Is Nothing Then
                If Request("SetPagingAlphabet") = "1" Then
                    m_intPagingNo = 1
                End If
            End If
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            'm_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + m_intPagingNo.ToString + m_strQuerystringDefaultParameters
            m_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&SortBy=" + m_strSortBy + "&SortOrder=" + m_strSortOrder + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + "&PagingNumber=" + m_intPagingNo.ToString + m_strQuerystringDefaultParameters
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        End If
        'End Of Modification By NileshD on 22 Sep REQID- WAF3_PB_10

        Call FillGeneralObject()
        Call CreateForm()
        Call Page_PreRender()
        Call CreateHiddenParameters()
        'By UmeshJ on 21-July-2006 Request ID: 145
        'Change 1st parameter from IsPagingEnabled to enmDisplayPosition
        Call GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.LIST_HEAD, True)
        Call PlotPageLegends()
        Call PlotUserFilters()
        Call PlotPageCaption()
        Call PlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER, m_cObjCLSQL.PageHeader)
        If CommonFunction.General.CheckIsNothing(m_cObjCLSQL.PageHeader).Trim <> "" Then Response.Write("<BR>")
        'Plot grid
        'Call PlotGrid()
        Call PlotSections()
        'Added By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10
        If m_strNavigationControl <> "" Then
            If m_intNumericPagingDisplayPosition = 1 Or m_intNumericPagingDisplayPosition = 2 Then
                m_strNavigationControl = m_strNavigationControl.Replace("txtNumPaging1", "txtNumPaging2")
                HttpContext.Current.Response.Write(m_strNavigationControl)
            Else
                Response.Write("<BR>")
            End If
        Else
            Response.Write("<BR>")
        End If
        If m_strPagingAction <> "" Then
            'If UCase(m_strPagingAction) = "PREV" Then
            '    Response.Write("<INPUT type=hidden id='PagingNumber' name='PagingNumber' value='" + (m_intPagingNo).ToString + "'>")
            'ElseIf UCase(m_strPagingAction) = "NEXT" Then
            '    Response.Write("<INPUT type=hidden id='PagingNumber' name='PagingNumber' value='" + (m_intPagingNo).ToString + "'>")
            'End If
            Response.Write("<INPUT type=hidden id='PagingNumber' name='PagingNumber' value='" + (m_intPagingNo).ToString + "'>")
        Else
            Response.Write("<INPUT type=hidden id='PagingNumber' name='PagingNumber' value='" + m_intPagingNo.ToString + "'>")
            'Response.Write("<INPUT type=hidden id='PagingNumber' name='PagingNumber' value='1'>")
        End If

        'End Of Addition By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10

        If m_cObjCLSQL.ShowRecordCountOnCL = True Then Call WriteTotalRecords()
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        'Call PlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER, m_cObjCLSQL.PageFooter)
        If CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
            Call PlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER, m_cObjCLSQL.PageFooter)
        End If
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        If CommonFunction.General.CheckIsNothing(m_cObjCLSQL.PageFooter).Trim <> "" Then Response.Write("<BR>")
        'By UmeshJ on 21-July-2006 Request ID: 145
        'Change 1st parameter from IsPagingEnabled to enmDisplayPosition
        '############## WAF3_PB_41 UJ 23-Mar-07
        'WAF3_PB_42 April 06, 2007 UmeshJ
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        'If m_cObjCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
        If (m_cObjCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL AndAlso CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled")) Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            If m_cObjCLSQL.SmartNavigation_IsEnabled = False Or (m_cObjCLSQL.SmartNavigation_IsEnabled = True AndAlso m_cObjCLSQL.SmartNavigation_Schema = "V") Then
                Call GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.LIST_FOOT, True)
            End If
        End If
        'WAF3_PB_42 April 06, 2007 UmeshJ
        '############## WAF3_PB_41 UJ 23-Mar-07
        'Added By Chakshuta H on 30th-Oct-201

        'Added By ShrikantB on 16 Nov. 2010 for Modal Dialog Popup
        ' To be displayed only if Framework key for the same is enabled.
        If CBool(CommonFunctions.General.GetFrameworkSettings("PB_SHOW_MODAL_POPUP", "Enabled")) = True Then
            Call PlotDivForModalDialog()
        End If
        'Addition End By ShrikantB for Modal Dialog Popup

        'Ended By Chakshuta H on 30th-Oct-2015

        'Client side functions
        Call WriteClientsideScript()
        'If Deletion Result is specified then display it
        If m_cObjCLSQL.DeletionResult.Trim <> "" Then Call WriteClientsideScript_DeletionResult()
        'Call Post Render Event
        Call Page_PostRender()
        Call EndForm()
    End Sub
    'Added By Chakshuta H on 30th-Oct-2015
    Private Sub PlotDivForModalDialog()
        '=====================================================================
        ' Procedure Name        :	PlotDivForModalDialog
        ' Purpose               :	This function is used to plot the Modal Dialog Popup
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	The Framework Key for the same must be enabled.
        ' Dependencies          :	None.
        ' Author                :	ShrikantB
        ' Created               :	Nov 16, 2010
        ' Revisions             :
        '=====================================================================

        Dim sbHTMLForModalDialogDivs As New System.Text.StringBuilder

        With sbHTMLForModalDialogDivs

            'Lookup Div - This Div will show up as a popup

            .AppendLine("<div id=""dModal"" class=""clsDivModalDialog"" style=""display:none;position:absolute;"" title=""Double Click to Drag"" ondragend=""ShowMousePos()"" ondblclick=""SelectText(this)"">")
            .AppendLine("    <table id=""tblModal"" class=""clsTableModalDlg"">")
            .AppendLine("       <tr>")
            .AppendLine("           <td id=""tdFirstRow"" width=""95%"" class=""clsTDFirstRow"">")
            .AppendLine("               <span id=""wndCaption"" class=""clsMdlDlgCaption""></span>")
            .AppendLine("           </td>")
            .AppendLine("           <td width=""5%"" class=""clsTDClose"">")
            .AppendLine("                <img src='../../Images/mdlclose.gif' onclick=""CloseDivForModalPopUp()"" />")
            .AppendLine("           </td>")
            .AppendLine("       </tr>")
            .AppendLine("       <tr>")
            .AppendLine("           <td colspan='2'>")
            .AppendLine("               <iframe id=""iFrmMdl"" width=100% frameborder=""0"" scrolling=""no"" onload=""calcHeight(this)"">")
            .AppendLine("               </iframe>")
            .AppendLine("           </td>")
            .AppendLine("       </tr>")
            .AppendLine("   </table>")
            .AppendLine("</div>")

            'Masking Div - This Div will apply the opaque mask onto the frame.

            .AppendLine("<div id=""MaskedDiv"" class=""clsMaskDiv"" style=""display:none;position:absolute;"">")
            .AppendLine("</div>")

        End With


        Response.Write(sbHTMLForModalDialogDivs.ToString)

        sbHTMLForModalDialogDivs = Nothing

    End Sub
    'Ended By Chakshuta H on 30th-Oct-2015
    Private Sub FillGeneralObject()
        'Prepare General Object
        With m_objGeneral
            .IsListPage = True
            .MasterPrimaryKeyValue = ""
            .PrimaryKeyValue = ""
        End With
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
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Create Object of the Access Rights class from the ProjectByNet Template
        m_objAccess = New WebPage.Templates.AccessRights
        'Get the Access Rights 
        m_objAccess.GetAccess(m_objGlobal)
        '__________________Added By PrasannaP on 27-June-2005
        ' Requirement ID        : AR_EV_01
        'Get Page Speicific Access Rights
        Call GetPageSpecificAccessRights(m_objGlobal, m_objAccess)

        '__________________End of modificaton
    End Sub

    Protected Overridable Sub GetPageSpecificAccessRights(ByVal objGlobal As WebPages.Template.IGlobal, ByRef objAccess As WebPage.Templates.AccessRights)
        '=====================================================================
        ' Procedure Name        :	GetPageSpecificAccessRights
        ' Purpose               :	This overridable function overrides the current access rights
        '                           and triggers a event in the Page Specific Behaviour
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	PrasannaP
        ' Created               :	June 27, 2005
        ' Revisions             :
        ' Requirement ID        : AR_EV_01
        '=====================================================================
        Call CommonEngine.General.cPageSpecificBehavior.GetPageSpecificAccessRights(objGlobal, objAccess)
    End Sub

    Protected Overridable Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New CommonEngine.CommonList.cDynamicFilters(m_objGlobal)
    End Function
    Private Sub GetUserFilter()
        '=====================================================================
        ' Procedure Name        :	GetUserFilter
        ' Purpose               :	Get User Filter details
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 21, 2003 
        ' Revisions             :
        '=====================================================================
        'Create object of the dynamic filters
        'Code Modified:RajeshB      28 Jan 2005
        'Purpose CL as an Object
        m_cObjFilters = InitDynamicFilters() 'New CommonEngine.CommonList.cDynamicFilters(m_objGlobal)
        'Addition Ends
        With m_cObjFilters
            'Save the filter settings
            If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
                .SaveUserFilter(MyBase.GetFormCollectionHashTable)
            End If
            '==========================================================================================================
            'Added By NinadP :	15 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .ReturnHTML = True
            .FunctionName = m_strFilterFunction
            'Added By UmeshJ on 23 Nov 2004
            .FormName = "frmCommonList"
            .ValidationFunction = VALIDATE_FILTER
            'End
            .IsDesignMode = m_blnIsDesignMode 'Added By NinadP :	Requirement Tag - WAF3_PB_48
            m_strUserFilter = .PlotFilters()
            'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
            If m_strUserFilter.Trim <> "" Then
                .GetFilterClause()
            End If
            'End Addition By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
            'Code Added:RajeshB	14 October, 2004
            'Purpose: Check if event is to be raised
            Dim blnCheckEventCall As Boolean
            blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                "After_Getting_FilterClause")
            If blnCheckEventCall = True Then
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************
                'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                ExtensionArgs.FilterClause = m_cObjFilters.FilterClause

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                        "After_Getting_FilterClause", ExtensionArgs)

                If Not ExtensionArgs Is Nothing Then
                    ExtensionArgs = Nothing
                End If
                'Modification Ends
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                Call After_Getting_FilterClause(m_cObjFilters.FilterClause)
            End If
            'addition ends.

        End With
    End Sub

    Private Sub PlotUserFilters()
        '=====================================================================
        ' Procedure Name        :	PlotUserFilters
        ' Purpose               :	Plot User Filters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 21, 2003 
        ' Revisions             :
        '=====================================================================
        If m_strUserFilter.Trim <> "" Then
            Response.Write(m_strUserFilter)
            Response.Write("<BR>")
        End If
    End Sub
    Protected Overridable Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New CommonEngine.CommonList.cCLSQL(m_objGlobal)
    End Function
    Private Sub GetCLSQL()
        '=====================================================================
        ' Procedure Name        :	GetCLSQL
        ' Purpose               :	Get the Page Details from the database
        ' Description           :	This method access the cCLSQL class to retrieve 
        '                           the page details required to plot the Common List 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        Dim strAdvanceFilter As String = ""
        If m_objGlobal.ParentTagID = 0 Then
            strAdvanceFilter = CommonFunction.General.CheckIsNothing(Session("AdvanceFilter" + m_objGlobal.TagID.ToString))
            If strAdvanceFilter.Trim <> "" Then strAdvanceFilter = " and (" + strAdvanceFilter + ")"
        End If
        'Code Modified:RajeshB      29 Jan 2005
        'Purpose CL as an Object
        m_cObjCLSQL = InitCLSQL() 'New CommonEngine.CommonList.cCLSQL(m_objGlobal)
        'Addition Ends.
        With m_cObjCLSQL
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .Add = m_objAccess.Add
            .Edit = m_objAccess.Edit
            .Delete = m_objAccess.Delete
            .View = m_objAccess.View
            'Modified By NileshD on 23 Sep 2005 WAF3_PB_10 
            '.PagingAlphabet = m_strPagingAlphabet
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .FilterClause = m_cObjFilters.FilterClause
            .AdvancedFilter = strAdvanceFilter
            .EditClickFunction = FUNCTION_NAME_EDIT_ONCLICK
            .GetSettings()
            'Added By NIleshD on 23 Sep 2005 REQID WAF3_PB_10
            If .PagingColumnName <> "" Then
                If m_strPagingAlphabet.Trim <> "" Then
                    .PagingAlphabet = m_strPagingAlphabet
                End If
            Else
                .PagingAlphabet = "-1"
            End If
            'End Of Addition By NIleshD on 23 Sep 2005 REQID WAF3_PB_10

            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToUpper = "DELETE" Then
                'If .IsIdentityOn = False Then
                '    .DeletionIDList = CommonFunctions.General.ConvertCommaSepNumbersToString(CommonFunctions.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)))
                'Else
                .DeletionIDList = CommonFunctions.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME))
                'End If
                Call Page_BeforeDelete()
                'If Ignore Delete flag is set the do not delete
                If m_blnIgnoreDelete = False Then .DeleteRecords()
                Call Page_AfterDelete()
            End If
            .GetGridSQL()
            'UJ_27062006 START ISSUE EXPORT DATA PAGE EXPIRED ALERT
            HttpContext.Current.Session("CLCP_ExportSQL" + m_objGlobal.ParentTagID.ToString + "-" + m_objGlobal.TagID.ToString) = .ExportDataSQL
            'HttpContext.Current.Session("CLCP_ExportId") = m_objGlobal.ParentTagID.ToString + CommonFunctions.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS + m_objGlobal.TagID.ToString
            'UJ_27062006 END
            m_blnDisplaySubTags = .HasSubTags
        End With

        'Modified By NileshD on 23 Jan 2006 Support ReqID:81
        'If m_strPagingAlphabet.Trim = "" Then m_strPagingAlphabet = m_cObjCLSQL.PagingAlphabet
        m_strPagingAlphabet = m_cObjCLSQL.PagingAlphabet
        'End Of Modification By NileshD on 23 Jan 2006 Support ReqID:81

        'Access Rights check depend upon the Tag Level Flag
        If m_cObjCLSQL.ApplyRoleLevelAccess = False Then
            'if the Role Level Access flag is false then set all access rights as TRUE
            m_objAccess.Add = True
            m_objAccess.Delete = True
            m_objAccess.Edit = True
            m_objAccess.View = True
        Else
            'Added By UmeshJ for WAF2_PB_65 on Saturday, November 06, 2004
            Call CheckPageAccess()
            'End of Addion By UmeshJ for WAF2_PB_65 on Saturday, November 06, 2004
        End If
        'Added By NinadP : 26 March 2007 : Requirement Tag - WAF3_PB_41 - Smart Navigation
        'Modified By Ninad on 2 July 2009 IssueID-31555  If m_objAccess.Add AndAlso added
        If m_objAccess.Add AndAlso m_cObjCLSQL.SmartNavigation_IsEnabled = True And CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RefreshList")) <> "1" Then RefreshCP() 'AndAlso m_cObjCLSQL.RecordCount = 0
        'Addition End By : Ninad Req Id : WAF3_PB_41 - Smart Navigation
    End Sub

    Private Sub RefreshCP()
        '########### WAF3_PB_41 UJ 20 Mar 2007
        'Smart Nav is Enabled for this form and No records present on the list.
        'Open the Form Page in Add New Mode
        HttpContext.Current.Response.Write(vbCrLf + "<script language=javascript>")
        'WAF3_PB_44
        Dim sQueryString As String = "Mode=ADD_NEW&FromCL=1&MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + m_strQuerystringDefaultParameters
        HttpContext.Current.Response.Write("parent.frames['whizFRMECP'].location.href=""" + strFormPage + "?" + sQueryString + """")
        'WAF3_PB_44
        HttpContext.Current.Response.Write("</script>")
    End Sub


    Private Sub CheckPageAccess()
        '=====================================================================
        ' Procedure Name        :	CheckPageAccess
        ' Purpose               :	Check if the user has Page Access (A,E,D or V)
        ' Description           :	If user do not have access then redirect to the invalid access page 
        ' Parameters Passed     :   None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Saturday, November 06, 2004
        ' Revisions             :
        '=====================================================================
        If m_objAccess.Access = False Then
            'Write the Log in the database
            Call CommonFunctions.General.WriteLog_InvalidAccess(m_cObjCLSQL.PageCaption, m_objGlobal.TagID, m_objGlobal.ParentTagID)
            'Clean the objects from memory
            Call MemoryCleanUp()
            'Rediert to the Message page: EXIT
            'Code Modified:RajeshB      19 Jan 2005
            Dim strRedirectPagePath As String = "" & strFormPage & "?MasterTagId=" + CommonFunctions.Constants.TAG_INVALID_ACCESS.ToString
            'Modification Ends
            HttpContext.Current.Server.Transfer(strRedirectPagePath)
        End If
    End Sub
    'Private -> Protected Overridable
    Private Sub Page_PreRender()
        '=====================================================================
        ' Procedure Name        :	Page_PreRender
        ' Purpose               :	This method will call the Pre render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 29, 2003 
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                "PageListPreRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageListPreRender", ExtensionArgs)

            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.PageListPreRender(m_objGlobal)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = PageListPreRender(m_objGlobal, strActionCode)
            cobjEventHndlr.ActionCode = strActionCode
            '--Modification Ends.

            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.
        cobjEventHndlr = Nothing

    End Sub
    Protected Overridable Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        PageListPreRender = cobjEventHndlr.PageListPreRender(m_objGlobal)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub Page_PostRender()
        '=====================================================================
        ' Procedure Name        :	Page_PostRender
        ' Purpose               :	This method will call the Post render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 06, 2004
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                "PageListPostRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageListPostRender", ExtensionArgs)

            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************

            ' Modified:RajeshB                   8th October, 2004
            ' ### Fixing bug for calling page list post render event.
            ' There was a call to PageUIPostRender event.
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.PageListPostRender(m_objGlobal)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = PageListPostRender(m_objGlobal, strActionCode)
            cobjEventHndlr.ActionCode = strActionCode
            '--Modification Ends.
            ' Modification Ends.

            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
            cobjEventHndlr = Nothing
        End If
        'addition ends
    End Sub
    Protected Overridable Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        PageListPostRender = cobjEventHndlr.PageListPostRender(m_objGlobal)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub Page_BeforeDelete()
        '=====================================================================
        ' Procedure Name        :	Page_BeforeDelete
        ' Purpose               :	This method will call the before delete event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 27, 2003 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                "BeforeDelete")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.DeletedIDList = CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME))

           


            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "BeforeDelete", ExtensionArgs)

            m_objGlobal = ExtensionArgs.m_global
            m_blnIgnoreDelete = ExtensionArgs.Cancel

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB                      17th January, 2005
            'Purpose: Wrap the call into an overridable function.
            '******************************************************************
            'Dim strAction As String = cobjEventHndlr.BeforeDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal)
            Dim strActionCode As String
            Dim strAction As String = BeforeDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal, strActionCode)
            'This is referred to in the ExecuteAction function
            cobjEventHndlr.ActionCode = strActionCode
            '*******************************************************************    
            ' Modification Ends - RajeshB
            '******************************************************************
            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.     
        cobjEventHndlr = Nothing
    End Sub

    Protected Overridable Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        BeforeDelete = cobjEventHndlr.BeforeDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString

    End Function

    Public Sub WriteClientsideScript_ExecuteAction(ByRef cobjEventHndlr As CommonEngine.General.cEventHandlers, ByVal strAction As String)
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ExecuteAction
        ' Purpose               :	WriteClientsideScript for Executing event Action
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, Feb 23, 2004
        ' Revisions             :
        '=====================================================================
        ' ***************************************************************************************
        ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
        ' ***************************************************************************************
        ' calling common proc. to write the action code
        Select Case cobjEventHndlr.ActionCode
            Case cobjEventHndlr.ReturnCodes.ON_LOAD.ToString        '#######    EXECUTE SCRIPT IN WINDOW ON LOAD
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.WRITE)

            Case cobjEventHndlr.ReturnCodes.OPEN_WINDOW.ToString    '#######    OPEN NEW WINDOW  
                WriteActionClientSideScript(strAction, ActionType.OPEN)

            Case cobjEventHndlr.ReturnCodes.REDIRECT.ToString       '#######    REDIRECT 
                WriteActionClientSideScript(strAction, ActionType.REDIRECT)

            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE.ToString  '#######    IGNORE DELETE
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.WRITE)
                'Ignore Delete
                m_blnIgnoreDelete = True

            Case cobjEventHndlr.ReturnCodes.DO_NOTHING.ToString     '#######    DO NOTHING

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
                ' ***************************************************************************************
            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE_AND_ON_LOAD.ToString
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.WRITE)
                'Ignore Delete
                m_blnIgnoreDelete = True

            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE_AND_OPEN_WINDOW.ToString
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.OPEN)
                'Ignore Delete
                m_blnIgnoreDelete = True

            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE_AND_REDIRECT.ToString
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.REDIRECT)
                'Ignore Delete
                m_blnIgnoreDelete = True

            Case cobjEventHndlr.ReturnCodes.IGNORE_SAVE_AND_ON_LOAD.ToString
                'Execute the Action
                WriteActionClientSideScript(strAction, ActionType.WRITE)

            Case cobjEventHndlr.ReturnCodes.IGNORE_SAVE_AND_OPEN_WINDOW.ToString
                'Execute the Action
                WriteActionClientSideScript(strAction, ActionType.OPEN)

            Case cobjEventHndlr.ReturnCodes.IGNORE_SAVE_AND_REDIRECT.ToString
                'Execute the Action
                WriteActionClientSideScript(strAction, ActionType.REDIRECT)

                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
                ' ***************************************************************************************
        End Select
        ' ***************************************************************************************
        ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
        ' ***************************************************************************************
    End Sub


    ' ***************************************************************************************
    ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
    ' ***************************************************************************************

    Private Enum ActionType
        OPEN
        REDIRECT
        WRITE
    End Enum

    Private Sub WriteActionClientSideScript(ByVal strAction As String, ByVal ActionType As ActionType)
        '=====================================================================
        ' Procedure Name        :	WriteActionClientSideScript
        ' Purpose               :	This proc is used to write the action script
        '                           based on action type
        ' Description           :	Same as above 
        ' Parameters Passed     :	Action, Action Type
        ' Parameters Affected   :	None
        ' Returns               :	NA
        ' Assumptions           :	
        ' Dependencies          :	
        ' Author                :	Rajanikant Khethawatt
        ' Created               :	Monday, Aug 30, 2004
        ' Revisions             :
        '=====================================================================
        If Trim(strAction & "") = "" Then Exit Sub
        CommonFunction.General.WriteHTML("<Script Laguage=javascript>")
        Select Case ActionType
            Case ActionType.OPEN : CommonFunction.General.WriteHTML("	window.open (" + Chr(34) + strAction + Chr(34) + ",null,""resizable=yes,scrollbars=yes,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 350) / 2 + "",width=600,height=350"");")
            Case ActionType.REDIRECT : CommonFunction.General.WriteHTML("	window.location.href=" + Chr(34) + strAction + Chr(34))
            Case ActionType.WRITE : CommonFunction.General.WriteHTML(strAction)
        End Select
        CommonFunction.General.WriteHTML("</Script>")
    End Sub

    ' ***************************************************************************************
    ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
    ' ***************************************************************************************

    Private Sub Page_AfterDelete()
        '=====================================================================
        ' Procedure Name        :	Page_AfterDelete
        ' Purpose               :	This method will call the After delete event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 27, 2003 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Added by PrasannaP on 9th May 2005 to store the tag list from the CLCacheTagIDList parameter.
        'Requirement ID = CL_CH_01
        Dim strTagList As String()
        Dim strTag As String
        Dim strWebConfigSettingForCLCache As String = CommonFunctions.General.GetApplicationKeySetting("CLCacheTagIDList")
        'End Addition

        'Added by PrasannaP on 6th May 2005 to set the dirty bit which will refill the Hashtable while plotting.
        'Requirement ID = CL_CH_01
        If CommonFunctions.General.GetFrameworkSettings("CL_CACHING", "Enabled") Then
            If Not IsNothing(strWebConfigSettingForCLCache) Then
                strTagList = Split(strWebConfigSettingForCLCache.ToString().Trim(), ",")
                For Each strTag In strTagList
                    If InStr(Trim(Split(strTag, "-")(0)), m_objGlobal.TagID.ToString(), CompareMethod.Text) > 0 Then
                        CommonEngines.HashTables.CreateHashTables.CreateHashTableCLDirtyBit(m_objGlobal.TagID.ToString(), "1")
                        Exit For
                    End If

                    If InStr("|" + strTag + "|", "|" + m_objGlobal.TagID.ToString() + "|", CompareMethod.Text) > Split(strTag, "-")(0).Length Then
                        CommonEngines.HashTables.CreateHashTables.CreateHashTableCLDirtyBit(Trim(Split(strTag, "-")(0)), "1")
                        Exit For
                    End If
                Next
            End If
        End If
        'End Addition

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                "AfterDelete")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.DeletedIDList = CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME))
            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "AfterDelete", ExtensionArgs)

            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.

            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************

            '******************************************************************
            'Code Modified:RajeshB                      17th January, 2005
            'Purpose: Wrap the call into an overridable function.
            '******************************************************************
            'Dim strAction As String = cobjEventHndlr.AfterDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal)
            Dim strActionCode As String
            Dim strAction As String = AfterDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal, strActionCode)
            'This is referred to in the ExecuteAction function
            cobjEventHndlr.ActionCode = strActionCode
            '*******************************************************************    
            ' Modification Ends - RajeshB
            '******************************************************************
            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.       
        cobjEventHndlr = Nothing
    End Sub
    Protected Overridable Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        AfterDelete = cobjEventHndlr.AfterDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Protected Overridable Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CommonEngine.CommonList.cPlotGrid(m_objGlobal)
    End Function
    'Private Sub PlotGrid()
    '    '=====================================================================
    '    ' Procedure Name        :	PlotGrid
    '    ' Purpose               :	Plot the CommonList Grid using the cPlotGrid class
    '    ' Description           :	Same as above
    '    ' Parameters Passed     :	None.
    '    ' Parameters Affected   :	None.
    '    ' Returns               :	None
    '    ' Assumptions           :	None.
    '    ' Dependencies          :	None.
    '    ' Author                :	UmeshJ
    '    ' Created               :	October 13, 2003 
    '    ' Revisions             :   PrasannaP on 30th May 2005
    '    '                           Issue ID 28888
    '    '=====================================================================
    '    'Create the object of main CPlotGrid class
    '    'Code Modified:RajeshB      28 Jan 2005
    '    Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
    '    cObjGrid = InitPlotGrid() 'New CommonEngine.CommonList.cPlotGrid(m_objGlobal)
    '    'Modification Ends.
    '    Dim intDivHeight As Integer = 0 ' 400
    '    'Added By NileshD on 8 Feb 2006 For SuportRequestID :99
    '    Dim objSection() As CommonEngines.HashTables.UITagSections
    '    If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
    '        'Local culture ID is same as the default culture id
    '        objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
    '    Else
    '        'Culture ID is other than the default culture id
    '        'Check if the Culture is supported by the system
    '        objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-1")
    '        If objSection Is Nothing Then
    '            'No. Culture is NOT supported. Retrieve the data from the defualt culture 
    '            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
    '        End If
    '    End If
    '    intDivHeight = CType(objSection(0).HeightCL, Integer)
    '    objSection = Nothing
    '    'End of Addition By NileshD on 8 Feb 2006 For SuportRequestID :99
    '    With cObjGrid
    '        'Form Property values
    '        '==========================================================================================================
    '        'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
    '        '==========================================================================================================
    '        .ConnectionString = m_strConnectionString
    '        .ConnectionID = m_intConnectionID
    '        '==========================================================================================================
    '        ' Addition End By : Ninad   Req Id : WAF3_PB_33
    '        '==========================================================================================================
    '        .GridSQL = m_cObjCLSQL.GridSQL
    '        'Added by PrasannaP on 3rd May 2005 to identify the 
    '        .OrderClause = m_cObjCLSQL.OrderClause
    '        .WhereClause = m_cObjCLSQL.WhereClause
    '        'End Addition

    '        'Use CSS table style
    '        'Modified/Commented by PrasannaP on 30th May 2005
    '        'Issue ID 28888
    '        '.TableStyle = "cellspacing=0 cellpadding=0"
    '        'End Modification
    '        .PrimaryKey = m_cObjCLSQL.PrimaryKey
    '        .SortBy = m_cObjCLSQL.SortBy
    '        .SortOrder = m_cObjCLSQL.SortOrder
    '        .CommonQueryString = m_strCommonQueryString
    '        .EditMode_UIPageOpenInWindow = m_cObjCLSQL.EditMode_UIPageOpenInWindow
    '        'UI Page with Dynamic Parameter Values
    '        .EditMode_UIPage = ReplaceParameters(m_cObjCLSQL.EditMode_UIPage)
    '        .MessageForNoRecords = MyBase.GetResourceString("NO_RECORDS")
    '        'WAF2_PB_2: Added By UmeshJ on 27th August 2004 
    '        .CaptionForDeleteColumn = m_cObjCLSQL.CaptionofDeleteColumn.Trim
    '        .ApplySorting = m_cObjCLSQL.EnableSorting
    '        .EnableHTMLEncode = m_cObjCLSQL.EnableHTMLEncode
    '        .ShowDeleteColumn = m_cObjCLSQL.ShowDeleteColumn
    '        .ShowDeleteColumnFirst = m_cObjCLSQL.ShowDeleteColumnFirst 'Added By - Ninad : Req ID - WAF3_PB_58 : Dt 28 Jan 2008
    '        'End of Addition
    '        'WAF2_PB_6: Sorting Column array
    '        .ColumnSortingArray = m_cObjCLSQL.ColumnSortingArray
    '        'WAF2_PB_6: End of Addtion
    '        'From Parameter values
    '        .ActualColumnArray = m_cObjCLSQL.ActualColumnArray
    '        .UserFriendlyColumnArray = m_cObjCLSQL.UserFriendlyColumnArray
    '        .RowLinkArray = m_cObjCLSQL.RowLinkArray
    '        .RowLinkToolTipArray = m_cObjCLSQL.RowLinkToolTipArray
    '        .FieldDataTypeArray = m_cObjCLSQL.FieldDataTypeArray
    '        .ColumnAlignmentArray = m_cObjCLSQL.ColumnAlignmentArray
    '        .ColumnNoWrapArray = m_cObjCLSQL.ColumnNoWrapArray
    '        .GroupHeader = m_cObjCLSQL.GroupHeader
    '        .RecordCount = m_cObjCLSQL.RecordCount
    '        .Delete = m_objAccess.Delete
    '        .DivHeight = intDivHeight
    '        .ReturnHTML = False
    '        'ProjectBtNet Template Common Grid Properties
    '        .ColumnNameTooltipOnEachRow = True
    '        .clsColumnHeader = "clsTRColumnHeader"
    '        'Changed By NileshD on 14 Sep 2005 For IssueID:20886
    '        .clsTable = "clsGridTable"
    '        'End of changed By NileshD on 14 Sep 2005 For IssueID:20886
    '        'Modified By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
    '        'Use base class CSS classes
    '        '.clsTREven = "clsTREven"
    '        '.clsTROdd = "clsTROdd"
    '        'End of modification By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
    '        .clsTRGroupHeader = "clsTRSectionHeader"
    '        .clsSortingColumn = "clsTDSortColHeader"
    '        .DivID = "" '"divList"
    '        '.DivStyle = "overflow:auto;width:100%"
    '        .SortingFunctionName = "SortBy"
    '        .SortByImage = "../../Images/SortBy.gif"
    '        .SortDownImage = "../../Images/Sort_Down.gif"
    '        .SortUpImage = "../../Images/Sort_up.gif"
    '        .BoolTrueHTML = MyBase.GetResourceString("YES")
    '        .BoolFalseHTML = MyBase.GetResourceString("NO")
    '        .DisplaySubTags = m_blnDisplaySubTags
    '        .ShowHideSubTag_FunctionName = FUNCTION_NAME_SHOW_HIDE_SUBTAG

    '        .SubTagInformation_FunctionName = FUNCTION_NAME_SUBTAG_INFORMATION
    '        .ShowSubTag_ImgSrc = SHOW_SUBTAG_IMAGE_SOURCE

    '        .ShowSubTag_Tooltip = SHOW_SUBTAG_IMAGE_TOOLTIP
    '        .DeletionCheckboxName = DELETION_CHECKBOX_NAME
    '        .PrimaryColumn = m_cObjCLSQL.LinkColumn
    '        .ShowPrimaryColumnTooltipOnEachRow = True
    '        'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: Added By UmeshJ on 1st Sept 2004 for WAF2 Build1
    '        .ListActionForControlArray = m_cObjCLSQL.ListActionForControlArray
    '        .ListConditionalControlValueArray = m_cObjCLSQL.ListConditionalControlValueArray
    '        .ListConditionClauseArray = m_cObjCLSQL.ListConditionClauseArray
    '        'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: End of addition
    '        'WAF2_PB_4: Added By UmeshJ on 6th Sep 2004 for Summary Functions
    '        .SummaryFuncActualColumnArray = m_cObjCLSQL.SummaryFuncActualColumnArray
    '        .SummaryFuncLevelArray = m_cObjCLSQL.SummaryFuncLevelArray
    '        .SummaryFuncNameArray = m_cObjCLSQL.SummaryFuncNameArray
    '        .SummaryGroupTitle = m_cObjCLSQL.SummaryGroupTitle
    '        .SummaryTotalTitle = m_cObjCLSQL.SummaryTotalTitle
    '        'WAF2_PB_4: End of addition
    '        'WAF2_PB_68: Added By UmeshJ on 17th Nov 2004 for Optional Tooltip
    '        .ShowColumnTooltip = m_cObjCLSQL.ShowColumnTooltip
    '        'WAF2_PB_68: End of addition
    '        'To fix IssueId 19587. Added by PrasannaP on 23rd June 2005
    '        .SubTagPageName = strSubTagPage
    '        'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
    '        .CurrentPageNo = m_intPagingNo
    '        'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
    '        'Added By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
    '        .IsStaticColumn = m_cObjCLSQL.IsStaticColumn
    '        'End Of Addition By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
    '        .GridDataRows = m_cObjCLSQL.GridDataRows 'WAF3_PB_38
    '        .SmartNavigation_IsEnabled = m_cObjCLSQL.SmartNavigation_IsEnabled  '##########WAF3_PB_41 UJ 20 Mar 2007

    '        '-------------------------------------------------------------------------------------------------------------
    '        'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
    '        'Reason   - For showing context menu in the grid. 
    '        '-------------------------------------------------------------------------------------------------------------
    '        'Modified By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0 : Removed the code for setting m_blnConsiderContextMenu
    '        .EnableContextMenu = m_cObjCLSQL.EnableContextMenu
    '        .ShowInContextMenuArray = m_cObjCLSQL.ShowInContextMenuArray
    '        .ContextMenuLinkColumn = m_cObjCLSQL.ContextMenuLinkColumn  'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
    '        '-------------------------------------------------------------------------------------------------------------
    '        'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
    '        '-------------------------------------------------------------------------------------------------------------
    '        .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
    '        Response.Write(.PlotGrid())

    '        m_strContextMenuJsFunction = .ContextMenuJsFunction 'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
    '        m_blnConsiderContextMenu = .EnableContextMenu 'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
    '        'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
    '        m_strNavigationControl = .NavigationControl
    '        m_intNumericPagingDisplayPosition = .NumericPagingDisplayPosition
    '        'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
    '    End With
    '    'Destroy the object    
    '    cObjGrid = Nothing
    'End Sub
    Private Sub PlotGrid()
        '=====================================================================
        ' Procedure Name        :	PlotGrid
        ' Purpose               :	Plot the CommonList Grid using the cPlotGrid class
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :   PrasannaP on 30th May 2005
        '                           Issue ID 28888
        '=====================================================================
        'Create the object of main CPlotGrid class
        'Code Modified:RajeshB      28 Jan 2005
        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid() 'New CommonEngine.CommonList.cPlotGrid(m_objGlobal)
        'Modification Ends.
        Dim intDivHeight As Integer = 0 ' 400
        'Added By NileshD on 8 Feb 2006 For SuportRequestID :99
        Dim objSection() As CommonEngines.HashTables.UITagSections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-1")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
            End If
        End If
        intDivHeight = CType(objSection(0).HeightCL, Integer)
        objSection = Nothing
        'End of Addition By NileshD on 8 Feb 2006 For SuportRequestID :99
        ''Added by nilesh gundecha for Project QuickView Link on Project List Page 
        Dim strsql1 As String
        Dim dr As IDataReader
        Dim flag As Integer = 0
        Dim intRoleAccessQuickview As Integer = 0
        strsql1 = "usp_Sel_tbl_PM_QuickView "
        dr = CommonFunctions.Data.GetDataReader(strsql1, True)

        While dr.Read()

            Dim temp As Integer
            temp = CType(CommonFunctions.Data.CheckIsDBNull(dr("TagID"), "0"), Integer)
            If temp = m_objGlobal.TagID Then
                'Added By Vaijat K ON 07/03/2016 For Check User Access of Project Quickview Link 
                strsql1 = "usp_Sel_tbl_pm_role_QuickView_CheckAccess " & CommonFunction.General.CheckIsNothing(Session("intPostID"), 0)
                intRoleAccessQuickview = Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strsql1, True))

                If intRoleAccessQuickview = 0 Then
                    flag = 0
                ElseIf intRoleAccessQuickview = 1 Then
                    flag = 1
                End If
                'Ended
            End If
        End While
        ''Commented by Vaijat K ON 09/05/2016 For Project Listing Performance Issue
        'If (flag = 1) Then
        '    'PlotQuickView()
        'End If
        'If (flag = 0) Then
        ''end of commented Vaijat K
        With cObjGrid
            'Form Property values
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            .ConnectionID = m_intConnectionID
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .GridSQL = m_cObjCLSQL.GridSQL
            'Added by PrasannaP on 3rd May 2005 to identify the 
            .OrderClause = m_cObjCLSQL.OrderClause
            .WhereClause = m_cObjCLSQL.WhereClause
            'End Addition

            'Use CSS table style
            'Modified/Commented by PrasannaP on 30th May 2005
            'Issue ID 28888
            '.TableStyle = "cellspacing=0 cellpadding=0"
            'End Modification
            .PrimaryKey = m_cObjCLSQL.PrimaryKey
            .SortBy = m_cObjCLSQL.SortBy
            .SortOrder = m_cObjCLSQL.SortOrder
            .CommonQueryString = m_strCommonQueryString
            .EditMode_UIPageOpenInWindow = m_cObjCLSQL.EditMode_UIPageOpenInWindow
            'UI Page with Dynamic Parameter Values
            .EditMode_UIPage = ReplaceParameters(m_cObjCLSQL.EditMode_UIPage)
            .MessageForNoRecords = MyBase.GetResourceString("NO_RECORDS")
            'WAF2_PB_2: Added By UmeshJ on 27th August 2004 
            .CaptionForDeleteColumn = m_cObjCLSQL.CaptionofDeleteColumn.Trim
            .ApplySorting = m_cObjCLSQL.EnableSorting
            .EnableHTMLEncode = m_cObjCLSQL.EnableHTMLEncode
            .ShowDeleteColumn = m_cObjCLSQL.ShowDeleteColumn
            .ShowDeleteColumnFirst = m_cObjCLSQL.ShowDeleteColumnFirst 'Added By - Ninad : Req ID - WAF3_PB_58 : Dt 28 Jan 2008
            'End of Addition
            'WAF2_PB_6: Sorting Column array
            .ColumnSortingArray = m_cObjCLSQL.ColumnSortingArray
            'WAF2_PB_6: End of Addtion
            'From Parameter values
            .ActualColumnArray = m_cObjCLSQL.ActualColumnArray
            .UserFriendlyColumnArray = m_cObjCLSQL.UserFriendlyColumnArray
            .RowLinkArray = m_cObjCLSQL.RowLinkArray
            .RowLinkToolTipArray = m_cObjCLSQL.RowLinkToolTipArray
            .FieldDataTypeArray = m_cObjCLSQL.FieldDataTypeArray
            .ColumnAlignmentArray = m_cObjCLSQL.ColumnAlignmentArray
            .ColumnNoWrapArray = m_cObjCLSQL.ColumnNoWrapArray
            .GroupHeader = m_cObjCLSQL.GroupHeader
            .RecordCount = m_cObjCLSQL.RecordCount
            .Delete = m_objAccess.Delete
            .DivHeight = intDivHeight
            .ReturnHTML = False
            'ProjectBtNet Template Common Grid Properties
            .ColumnNameTooltipOnEachRow = True
            .clsColumnHeader = "clsTRColumnHeader"
            'Changed By NileshD on 14 Sep 2005 For IssueID:20886
            .clsTable = "clsGridTable"
            'End of changed By NileshD on 14 Sep 2005 For IssueID:20886
            'Modified By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
            'Use base class CSS classes
            '.clsTREven = "clsTREven"
            '.clsTROdd = "clsTROdd"
            'End of modification By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
            .clsTRGroupHeader = "clsTRSectionHeader"
            .clsSortingColumn = "clsTDSortColHeader"
            .DivID = "" '"divList"
            '.DivStyle = "overflow:auto;width:100%"
            .SortingFunctionName = "SortBy"
            .SortByImage = "../../Images/SortBy.gif"
            .SortDownImage = "../../Images/Sort_Down.gif"
            .SortUpImage = "../../Images/Sort_up.gif"
            .BoolTrueHTML = MyBase.GetResourceString("YES")
            .BoolFalseHTML = MyBase.GetResourceString("NO")
            .DisplaySubTags = m_blnDisplaySubTags
            .ShowHideSubTag_FunctionName = FUNCTION_NAME_SHOW_HIDE_SUBTAG
            .SubTagInformation_FunctionName = FUNCTION_NAME_SUBTAG_INFORMATION
            .ShowSubTag_ImgSrc = SHOW_SUBTAG_IMAGE_SOURCE
            .ShowSubTag_Tooltip = SHOW_SUBTAG_IMAGE_TOOLTIP
            .DeletionCheckboxName = DELETION_CHECKBOX_NAME
            .PrimaryColumn = m_cObjCLSQL.LinkColumn
            .ShowPrimaryColumnTooltipOnEachRow = True
            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: Added By UmeshJ on 1st Sept 2004 for WAF2 Build1
            .ListActionForControlArray = m_cObjCLSQL.ListActionForControlArray
            .ListConditionalControlValueArray = m_cObjCLSQL.ListConditionalControlValueArray
            .ListConditionClauseArray = m_cObjCLSQL.ListConditionClauseArray
            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: End of addition
            'WAF2_PB_4: Added By UmeshJ on 6th Sep 2004 for Summary Functions
            .SummaryFuncActualColumnArray = m_cObjCLSQL.SummaryFuncActualColumnArray
            .SummaryFuncLevelArray = m_cObjCLSQL.SummaryFuncLevelArray
            .SummaryFuncNameArray = m_cObjCLSQL.SummaryFuncNameArray
            .SummaryGroupTitle = m_cObjCLSQL.SummaryGroupTitle
            .SummaryTotalTitle = m_cObjCLSQL.SummaryTotalTitle
            'WAF2_PB_4: End of addition
            'WAF2_PB_68: Added By UmeshJ on 17th Nov 2004 for Optional Tooltip
            .ShowColumnTooltip = m_cObjCLSQL.ShowColumnTooltip
            'WAF2_PB_68: End of addition
            'To fix IssueId 19587. Added by PrasannaP on 23rd June 2005
            .SubTagPageName = strSubTagPage
            'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
            .CurrentPageNo = m_intPagingNo
            'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
            'Added By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            .IsStaticColumn = m_cObjCLSQL.IsStaticColumn
            'End Of Addition By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            .GridDataRows = m_cObjCLSQL.GridDataRows 'WAF3_PB_38
            .SmartNavigation_IsEnabled = m_cObjCLSQL.SmartNavigation_IsEnabled  '##########WAF3_PB_41 UJ 20 Mar 2007

            '-------------------------------------------------------------------------------------------------------------
            'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            'Reason   - For showing context menu in the grid. 
            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0 : Removed the code for setting m_blnConsiderContextMenu
            .EnableContextMenu = m_cObjCLSQL.EnableContextMenu
            .ShowInContextMenuArray = m_cObjCLSQL.ShowInContextMenuArray
            .ContextMenuLinkColumn = m_cObjCLSQL.ContextMenuLinkColumn  'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            '-------------------------------------------------------------------------------------------------------------
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
            Response.Write(.PlotGrid())

            m_strContextMenuJsFunction = .ContextMenuJsFunction 'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            m_blnConsiderContextMenu = .EnableContextMenu 'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
            'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
            m_strNavigationControl = .NavigationControl
            m_intNumericPagingDisplayPosition = .NumericPagingDisplayPosition
            'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
        End With
        'Destroy the object    
        cObjGrid = Nothing
        'End If
    End Sub
    ''Added by nilesh gundecha for Dynamic Plot QuickView Column on Page
    Private Sub PlotQuickView()
        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid() 'New CommonEngine.CommonList.cPlotGrid(m_objGlobal)
        'Modification Ends.
        Dim intDivHeight As Integer = 0 ' 400
        'Added By NileshD on 8 Feb 2006 For SuportRequestID :99
        Dim objSection() As CommonEngines.HashTables.UITagSections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-1")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
            End If
        End If
        intDivHeight = CType(objSection(0).HeightCL, Integer)
        objSection = Nothing
        Dim arr As String()
        Dim i As Integer
        Dim tmpList As New List(Of String)
        tmpList.Add("QuickViewID")
        For i = 0 To m_cObjCLSQL.ActualColumnArray.Length - 1
            tmpList.Add(m_cObjCLSQL.ActualColumnArray(i))
        Next
        arr = tmpList.ToArray


        Dim arr1 As String()
        Dim tmpList1 As New List(Of String)
        tmpList1.Add("Project Progress")
        For i = 0 To m_cObjCLSQL.UserFriendlyColumnArray.Length - 1
            tmpList1.Add(m_cObjCLSQL.UserFriendlyColumnArray(i))
        Next
        arr1 = tmpList1.ToArray


        Dim arr2 As String()
        Dim tmpList2 As New List(Of String)
        tmpList2.Add(" ")
        For i = 0 To m_cObjCLSQL.RowLinkArray.Length - 1
            tmpList2.Add(m_cObjCLSQL.RowLinkArray(i))
        Next
        arr2 = tmpList2.ToArray

        Dim arr3 As String()
        Dim tmpList3 As New List(Of String)
        tmpList3.Add(" ")
        For i = 0 To m_cObjCLSQL.RowLinkToolTipArray.Length - 1
            tmpList3.Add(m_cObjCLSQL.RowLinkToolTipArray(i))
        Next
        arr3 = tmpList3.ToArray

        Dim arr4 As String()
        Dim tmpList4 As New List(Of String)
        tmpList4.Add("null")
        For i = 0 To m_cObjCLSQL.FieldDataTypeArray.Length - 1
            tmpList4.Add(m_cObjCLSQL.FieldDataTypeArray(i))
        Next
        arr4 = tmpList4.ToArray

        Dim arr5 As String()
        Dim tmpList5 As New List(Of String)
        tmpList5.Add("Center")
        For i = 0 To m_cObjCLSQL.ColumnAlignmentArray.Length - 1
            tmpList5.Add(m_cObjCLSQL.ColumnAlignmentArray(i))
        Next
        arr5 = tmpList5.ToArray

        Dim arr6 As Boolean()
        Dim tmpList6 As New List(Of Boolean)
        tmpList6.Add(False)
        For i = 0 To m_cObjCLSQL.ColumnNoWrapArray.Length - 1
            tmpList6.Add(m_cObjCLSQL.ColumnNoWrapArray(i))
        Next
        arr6 = tmpList6.ToArray

        Dim arr7 As String()
        Dim tmpList7 As New List(Of String)
        tmpList7.Add("")
        For i = 0 To m_cObjCLSQL.ListActionForControlArray.Length - 1
            tmpList7.Add(m_cObjCLSQL.ListActionForControlArray(i))
        Next
        arr7 = tmpList7.ToArray

        Dim arr8 As String()
        Dim tmpList8 As New List(Of String)
        tmpList8.Add("")
        For i = 0 To m_cObjCLSQL.ListConditionalControlValueArray.Length - 1
            tmpList8.Add(m_cObjCLSQL.ListConditionalControlValueArray(i))
        Next
        arr8 = tmpList8.ToArray

        Dim arr9 As String()
        Dim tmpList9 As New List(Of String)
        tmpList9.Add("")
        For i = 0 To m_cObjCLSQL.ListConditionClauseArray.Length - 1
            tmpList9.Add(m_cObjCLSQL.ListConditionClauseArray(i))
        Next
        arr9 = tmpList9.ToArray

        Dim arr10 As Boolean()
        Dim tmpList10 As New List(Of Boolean)
        tmpList10.Add(False)
        For i = 0 To m_cObjCLSQL.ShowInContextMenuArray.Length - 1
            tmpList10.Add(m_cObjCLSQL.ShowInContextMenuArray(i))
        Next
        arr10 = tmpList10.ToArray

        Dim ColumnSortingArray1 As Boolean()
        Dim tmpList11 As New List(Of Boolean)
        tmpList11.Add(False)
        For i = 0 To m_cObjCLSQL.ColumnSortingArray.Length - 1
            tmpList11.Add(m_cObjCLSQL.ColumnSortingArray(i))
        Next
        ColumnSortingArray1 = tmpList11.ToArray

        Dim IsStaticColumn1 As Boolean()
        Dim tmpList12 As New List(Of Boolean)
        tmpList12.Add(False)
        For i = 0 To m_cObjCLSQL.IsStaticColumn.Length - 1
            tmpList12.Add(m_cObjCLSQL.IsStaticColumn(i))
        Next
        IsStaticColumn1 = tmpList12.ToArray
        'End of Addition By NileshD on 8 Feb 2006 For SuportRequestID :99
        With cObjGrid
            'Form Property values
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            .ConnectionID = m_intConnectionID
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .GridSQL = m_cObjCLSQL.GridSQL
            'Added by PrasannaP on 3rd May 2005 to identify the 
            .OrderClause = m_cObjCLSQL.OrderClause
            .WhereClause = m_cObjCLSQL.WhereClause
            'End Addition

            'Use CSS table style
            'Modified/Commented by PrasannaP on 30th May 2005
            'Issue ID 28888
            '.TableStyle = "cellspacing=0 cellpadding=0"
            'End Modification
            .PrimaryKey = m_cObjCLSQL.PrimaryKey
            .SortBy = m_cObjCLSQL.SortBy
            .SortOrder = m_cObjCLSQL.SortOrder
            .CommonQueryString = m_strCommonQueryString
            .EditMode_UIPageOpenInWindow = m_cObjCLSQL.EditMode_UIPageOpenInWindow
            'UI Page with Dynamic Parameter Values
            .EditMode_UIPage = ReplaceParameters(m_cObjCLSQL.EditMode_UIPage)
            .MessageForNoRecords = MyBase.GetResourceString("NO_RECORDS")
            'WAF2_PB_2: Added By UmeshJ on 27th August 2004 
            .CaptionForDeleteColumn = m_cObjCLSQL.CaptionofDeleteColumn.Trim
            .ApplySorting = m_cObjCLSQL.EnableSorting
            .EnableHTMLEncode = m_cObjCLSQL.EnableHTMLEncode
            .ShowDeleteColumn = m_cObjCLSQL.ShowDeleteColumn
            .ShowDeleteColumnFirst = m_cObjCLSQL.ShowDeleteColumnFirst 'Added By - Ninad : Req ID - WAF3_PB_58 : Dt 28 Jan 2008
            'End of Addition
            'WAF2_PB_6: Sorting Column array
            .ColumnSortingArray = ColumnSortingArray1
            'WAF2_PB_6: End of Addtion
            'From Parameter values

            '.ActualColumnArray = m_cObjCLSQL.ActualColumnArray

            '.UserFriendlyColumnArray = m_cObjCLSQL.UserFriendlyColumnArray
            '.RowLinkArray = m_cObjCLSQL.RowLinkArray
            '.RowLinkToolTipArray = m_cObjCLSQL.RowLinkToolTipArray
            '.FieldDataTypeArray = m_cObjCLSQL.FieldDataTypeArray
            '.ColumnAlignmentArray = m_cObjCLSQL.ColumnAlignmentArray
            '.ColumnNoWrapArray = m_cObjCLSQL.ColumnNoWrapArray

            .ActualColumnArray = arr

            .UserFriendlyColumnArray = arr1
            .RowLinkArray = arr2
            .RowLinkToolTipArray = arr3
            .FieldDataTypeArray = arr4
            .ColumnAlignmentArray = arr5
            .ColumnNoWrapArray = arr6

            .GroupHeader = m_cObjCLSQL.GroupHeader
            .RecordCount = m_cObjCLSQL.RecordCount
            .Delete = m_objAccess.Delete
            .DivHeight = intDivHeight
            .ReturnHTML = False
            'ProjectBtNet Template Common Grid Properties
            .ColumnNameTooltipOnEachRow = True
            .clsColumnHeader = "clsTRColumnHeader"
            'Changed By NileshD on 14 Sep 2005 For IssueID:20886
            .clsTable = "clsGridTable"
            'End of changed By NileshD on 14 Sep 2005 For IssueID:20886
            'Modified By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
            'Use base class CSS classes
            '.clsTREven = "clsTREven"
            '.clsTROdd = "clsTROdd"
            'End of modification By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
            .clsTRGroupHeader = "clsTRSectionHeader"
            .clsSortingColumn = "clsTDSortColHeader"
            .DivID = "" '"divList"
            '.DivStyle = "overflow:auto;width:100%"
            .SortingFunctionName = "SortBy"
            .SortByImage = "../../Images/SortBy.gif"
            .SortDownImage = "../../Images/Sort_Down.gif"
            .SortUpImage = "../../Images/Sort_up.gif"
            .BoolTrueHTML = MyBase.GetResourceString("YES")
            .BoolFalseHTML = MyBase.GetResourceString("NO")
            .DisplaySubTags = m_blnDisplaySubTags
            .ShowHideSubTag_FunctionName = FUNCTION_NAME_SHOW_HIDE_SUBTAG
            .SubTagInformation_FunctionName = FUNCTION_NAME_SUBTAG_INFORMATION
            .ShowSubTag_ImgSrc = SHOW_SUBTAG_IMAGE_SOURCE
            .ShowSubTag_Tooltip = SHOW_SUBTAG_IMAGE_TOOLTIP
            .DeletionCheckboxName = DELETION_CHECKBOX_NAME
            .PrimaryColumn = m_cObjCLSQL.LinkColumn
            .ShowPrimaryColumnTooltipOnEachRow = True
            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: Added By UmeshJ on 1st Sept 2004 for WAF2 Build1

            '.ListActionForControlArray = m_cObjCLSQL.ListActionForControlArray
            '.ListConditionalControlValueArray = m_cObjCLSQL.ListConditionalControlValueArray
            '.ListConditionClauseArray = m_cObjCLSQL.ListConditionClauseArray
            .ListActionForControlArray = arr7
            .ListConditionalControlValueArray = arr8
            .ListConditionClauseArray = arr9

            '.ListConditionalControlValueArray = arr7
            '.ListConditionClauseArray = m_cObjCLSQL.ListConditionClauseArray

            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: End of addition
            'WAF2_PB_4: Added By UmeshJ on 6th Sep 2004 for Summary Functions
            .SummaryFuncActualColumnArray = m_cObjCLSQL.SummaryFuncActualColumnArray
            .SummaryFuncLevelArray = m_cObjCLSQL.SummaryFuncLevelArray
            .SummaryFuncNameArray = m_cObjCLSQL.SummaryFuncNameArray
            .SummaryGroupTitle = m_cObjCLSQL.SummaryGroupTitle
            .SummaryTotalTitle = m_cObjCLSQL.SummaryTotalTitle
            'WAF2_PB_4: End of addition
            'WAF2_PB_68: Added By UmeshJ on 17th Nov 2004 for Optional Tooltip
            .ShowColumnTooltip = m_cObjCLSQL.ShowColumnTooltip
            'WAF2_PB_68: End of addition
            'To fix IssueId 19587. Added by PrasannaP on 23rd June 2005
            .SubTagPageName = strSubTagPage
            'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
            .CurrentPageNo = m_intPagingNo
            'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
            'Added By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            .IsStaticColumn = IsStaticColumn1
            'End Of Addition By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            .GridDataRows = m_cObjCLSQL.GridDataRows 'WAF3_PB_38
            .SmartNavigation_IsEnabled = m_cObjCLSQL.SmartNavigation_IsEnabled  '##########WAF3_PB_41 UJ 20 Mar 2007

            '-------------------------------------------------------------------------------------------------------------
            'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            'Reason   - For showing context menu in the grid. 
            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0 : Removed the code for setting m_blnConsiderContextMenu
            .EnableContextMenu = m_cObjCLSQL.EnableContextMenu
            '.ShowInContextMenuArray = m_cObjCLSQL.ShowInContextMenuArray

            .ShowInContextMenuArray = arr10
            .ContextMenuLinkColumn = m_cObjCLSQL.ContextMenuLinkColumn  'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            '-------------------------------------------------------------------------------------------------------------
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
            Response.Write(.PlotGrid())

            m_strContextMenuJsFunction = .ContextMenuJsFunction 'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            m_blnConsiderContextMenu = .EnableContextMenu 'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
            'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
            m_strNavigationControl = .NavigationControl
            m_intNumericPagingDisplayPosition = .NumericPagingDisplayPosition
            'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
        End With
        'Destroy the object    
        cObjGrid = Nothing

    End Sub

    Private Sub WriteTotalRecords()
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        'Display Total Records at the end
        CommonFunction.General.WriteHTML(CommonFunction.General.WriteTotalRecordsHTML(m_cObjCLSQL.RecordCount, MyBase.GetResourceString("TOTAL_RECORDS"), , "clsTREven"))
        'WAF3_PB_42 April 06, 2007 UmeshJ START
        If m_cObjCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
            'Modified By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10
            If m_strNavigationControl = "" Then
                Response.Write("<BR>")
                'Response.Write("<BR>")
            Else
                If m_intNumericPagingDisplayPosition = 0 Then
                    'Response.Write("<BR>")
                    Response.Write("<BR>")
                Else
                    Response.Write("<BR>")
                End If
            End If
            'End Of Modification By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10
        End If
        'WAF3_PB_42 April 06, 2007 UmeshJ END
    End Sub

    Private Sub GetMenu(ByVal enmDisplayPosition As WebPage.Templates.DynamicMenu.LinkDisplayPosition, ByVal blnReturnClientsideScript As Boolean)
        'Private Sub GetMenu(ByVal blnEnablePaging As Boolean, ByVal blnReturnClientsideScript As Boolean)
        '=====================================================================
        ' Procedure Name        :	GetMenu
        ' Purpose               :	Plot the Menu using the DynamicMenu class
        ' Description           :	Same as above
        ' Parameters Passed     :	blnEnablePaging - If Enable Paging then 
        '                           also plot the paging details  
        '                           blnReturnClientsideScript - If true then 
        '                           Return Clientside Script for the dynamic links
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :   By UmeshJ on 21-July-2006 Request ID: 145
        '                           Change 1st parameter from IsPagingEnabled to enmDisplayPosition
        '=====================================================================
        Dim blnEnablePaging As Boolean = False
        m_cObjMenu = New WebPage.Templates.DynamicMenu
        'Code Added:RajeshB         18 Jan 2005
        m_cObjMenu.CommonListPage = strListPage
        m_cObjMenu.CommonFormPage = strFormPage
        'Addition Ends
        With m_cObjMenu
            '==========================================================================================================
            'Added By NinadP :	16 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionID = m_intConnectionID
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .CommonQueryString = m_strCommonQueryString
            .EnabledControls = ""
            .ValidationRules = ""
            .IsListPageLink = True
            .ReturnClientsideScript = blnReturnClientsideScript
            .MessageForDeleteConfirm = MyBase.GetResourceString("DELETE_CONFIRM")
            .MessageForPagingSelect = MyBase.GetResourceString("SELECT")
            If GetSectionPreferences(CommonFunctions.Constants.SECTION_HEADER) = 1 Then
                'Added By UmeshJ on 27th August 2004. WAF2 Build 1.  WAF2_PB_2
                .ShowDeleteLink = m_cObjCLSQL.ShowDeleteColumn
                'End of addition
            Else
                .ShowDeleteLink = False
            End If
            'Added By UmeshJ on 27th August 2004. WAF2 Build 1.  WAF2_PB_5
            .ShowConfimationforDelete = m_cObjCLSQL.ShowConfimationforDelete
            'End of addition
            .RecordCount = m_cObjCLSQL.RecordCount
            .AddNewMode_UIPage = ReplaceParameters(m_cObjCLSQL.AddNewMode_UIPage)
            .AddNewMode_UIPageOpenInWindow = m_cObjCLSQL.AddNewMode_UIPageOpenInWindow
            .PagingFunctionName = FUNCTION_NAME_PAGE_ONCLICK
            .DeletionCheckboxName = DELETION_CHECKBOX_NAME
            'Added BY NIleshD on 22 Sep 2005 REQID WAF3_PB_10
            .PagingColumnName = m_cObjCLSQL.PagingColumnName
            'End Of Addition BY NIleshD on 22 Sep 2005 REQID WAF3_PB_10
            'Modified by UmeshJ on 21-July-2006 Request ID: 145
            'Paging is Optional; Hence if Paging Column is blank then DO NOT PLOT paging
            If enmDisplayPosition.ToString = WebPages.Template.DynamicMenu.LinkDisplayPosition.LIST_HEAD.ToString And m_cObjCLSQL.PagingColumnName <> "" Then
                blnEnablePaging = True
                .LinkSQL = m_cObjCLSQL.LinkSQL
            End If
            .Displayposition = enmDisplayPosition
            'End Of Addition by UmeshJ on 21-July-2006 Request ID: 145
            'WAF3_PB_42 April 03, 2007 UJ START
            If m_cObjCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.CLASSICAL
            Else
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.DROPDOWN
                Dim hdControl As String = m_cObjCLSQL.DropdownMenu_HideControls
                If hdControl <> "" Then hdControl = "," + hdControl
                .DropdownMenu_HideControls = "cboMyViews,view" + hdControl
                .DropdownMenu_EnclosingDiv = ""
                .DropdownMenu_Width = m_cObjCLSQL.DropdownMenu_Width
                .DropdownMenu_TopFillFactor = 1
            End If
            'WAF3_PB_42 April 03, 2007 UJ END
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 25 May 2007
            .PagingAlphabets = m_cObjCLSQL.PagingAlphabets 'Added By Ninad on 7 Feb 2008, Req ID WAF3_PB_59 - Avoid Link SQL - Use Dataset and calculate the paging alphabets
            Response.Write(.DrawMenu(m_objGlobal, m_objAccess.Add, m_objAccess.Edit, m_objAccess.Delete, m_objAccess.View, False, blnEnablePaging, m_cObjCLSQL.PagingAlphabet, True, m_cObjCLSQL.WindowHeight, m_cObjCLSQL.WindowWidth))
            'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
            Dim strClientsideScript As String
            strClientsideScript = .ClientsideScript
            'The ClientsideScript now returns the <ACTION_LINK_KEYBOARD_SHORTCUTS>...</ACTION_LINK_KEYBOARD_SHORTCUTS> node which contains the keyboard shortcuts and the corresponding function calls
            If strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>") <> -1 Then
                ReDim Preserve m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0) + 1)
                ReDim Preserve m_strTagID(m_strTagID.GetUpperBound(0) + 1)
                ReDim Preserve blnIsSubTag(blnIsSubTag.GetUpperBound(0) + 1)
                m_strTagID(m_strTagID.GetUpperBound(0)) = m_objGlobal.TagID.ToString
                blnIsSubTag(blnIsSubTag.GetUpperBound(0)) = False
                m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0)) = strClientsideScript.Substring(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>")).Replace("<ACTION_LINK_KEYBOARD_SHORTCUTS>", "").Replace("</ACTION_LINK_KEYBOARD_SHORTCUTS>", "")
                strClientsideScript = strClientsideScript.Remove(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>"))
            End If
            Response.Write(strClientsideScript)
            'End Modification by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        End With
        'Destroy the object
        m_cObjMenu = Nothing
    End Sub

    Public Shared Function ReplaceParameters(ByVal strUIPage As String) As String
        '=====================================================================
        ' Procedure Name        :	ReplaceParameters
        ' Purpose               :	Replace Parameters by their values from the query string
        ' Description           :	Same as above
        ' Parameters Passed     :	strUIPage - UI page with parameter list
        ' Parameters Affected   :	None.
        ' Returns               :	UI Page URL after replacing parameter place holders by their actual values
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 29, 2003 
        ' Revisions             :
        '=====================================================================
        'No UI Page Exit
        If CommonFunction.General.CheckIsNothing(strUIPage) = "" Then Return ""
        'UI Page does not containt Dynamic Parameters
        If InStr(1, strUIPage, "<", CompareMethod.Text) = 0 And InStr(1, strUIPage, ">", CompareMethod.Text) = 0 Then Return strUIPage
        'Split the Page URL on >
        Dim strPage As String() = Split(strUIPage, ">")
        Dim intNoOfParameters As Integer = strPage.Length - 1
        Dim intParameterIndex As Integer
        'For each parameter
        For intParameterIndex = 0 To intNoOfParameters
            'Split the Parameter sub string on < e.g  Parameter1=<Parameter1
            Dim strParameter() As String = Split(strPage(intParameterIndex), "<")
            'It will split the string in two parts e.g. Parameter1= and Parameter1
            If strParameter.Length = 2 Then
                'The second part in the Request parameters
                If CommonFunction.General.CheckIsNothing(strParameter(1)) <> "" Then
                    strParameter(1) = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request(strParameter(1)))
                End If
                'Prepare the string with Value for the Parameter e.g. UniqueID=23
                strPage(intParameterIndex) = Join(strParameter, "")
            End If
        Next
        Return Join(strPage, "")
    End Function

    Private Sub CreateForm()
        '=====================================================================
        ' Procedure Name        :	CreateForm
        ' Purpose               :	Create Form tag
        ' Description           :	This method will plot the initial portion 
        '                           for the page and form tag
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        Response.Write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>")
        'Response.Write("<!DOCTYPE html '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'>")
        Response.Write("<HTML>")
        Dim strInsertInHEADTag As String = GetStringToBeInsertedInHEADTag(m_objGlobal)

        'Head Tag
        ' ***************************************************************************************
        ' Modified Aug 27,2004 Rajanikant Khethawatt R.No.WAF2_PB_32
        ' ***************************************************************************************
        ' Passing the TagID for any tag specific stylesheets
        Response.Write(CommonFunction.General.PlotPageHeadTag(m_cObjCLSQL.PageCaption, , , , strInsertInHEADTag, True, m_objGlobal.TagID))
        ' ***************************************************************************************
        ' End Modification Aug 27,2004 Rajanikant Khethawatt
        ' ***************************************************************************************
        '######### WAF3_PB_41 UJ 23-Mar-2007
        Dim strclsBody As String = "clsBody"
        If m_cObjCLSQL.SmartNavigation_IsEnabled = True Then
            If m_cObjCLSQL.SmartNavigation_Schema = "V" Then
                strclsBody = "clsVerticalNavBody"
            Else
                strclsBody = "clsHorizontalNavBody"
            End If
        End If

        Response.Write("<BODY class='" + strclsBody + "' onload='CL_window_onload()' onresize='CL_window_onresize()' onkeyup='try{OnBodyKeyUp(event);} catch(e){}' >") 'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        Response.Write("<FORM id='frmCommonList' name='frmCommonList' method=post>")

        '######### WAF3_PB_41 UJ 23-Mar-2007
        If m_blnDisplaySubTags = True Then
            'Div tag required for Sub Tag Information Display
            Response.Write("<DIV class=""FadingTooltip"" id=""FADINGTOOLTIP"" style=""Z-INDEX: 500; LEFT: 200px; TOP: 50px; VISIBILITY: hidden; POSITION: absolute""></DIV>")
        End If
    End Sub
    Public Shared Function GetStringToBeInsertedInHEADTag(ByVal WhizGlobal As WebPages.Template.IGlobal) As String
        '=====================================================================
        ' Procedure Name        :	GetStringToBeInsertedInHEADTag
        ' Purpose               :	Get String To Be Inserted In the HEAD <HEAD></HEAD> Tag
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	String To Be Inserted In the HEAD <HEAD></HEAD> Tag
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 02, 2004
        ' Revisions             :
        '=====================================================================
        Dim objUITagMaster As CommonEngines.HashTables.UITagMaster
        Dim lngTagID As Long
        If WhizGlobal.ParentTagID = 0 Then
            lngTagID = WhizGlobal.TagID
        Else
            lngTagID = WhizGlobal.ParentTagID
        End If

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = WhizGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID)
        Else
            'Culture ID is other than the default culture id Check if the Culture is supported by the system
            'Yes. Culture is supported. Retrieve the data specific to that Culture 
            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterCultureObject(lngTagID.ToString.Trim & WhizGlobal.LCID.ToString)
            If objUITagMaster Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defual culture 
                objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID)
            End If
        End If
        GetStringToBeInsertedInHEADTag = ""
        If Not objUITagMaster Is Nothing Then
            'String To Be Inserted In the HEAD <HEAD></HEAD> Tag
            GetStringToBeInsertedInHEADTag = objUITagMaster.InsertInHEADTag
        End If
        objUITagMaster = Nothing
    End Function

    Private Sub WriteClientsideScript()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript
        ' Purpose               :	Write Clientside Script
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        If strKeyboardShortcutsAndFunctions.Trim <> "" Then
            'Remove the last comma if specified
            If strKeyboardShortcutsAndFunctions.Trim.Substring(strKeyboardShortcutsAndFunctions.Length - 1) = "," Then
                strKeyboardShortcutsAndFunctions = strKeyboardShortcutsAndFunctions.Trim.Remove(strKeyboardShortcutsAndFunctions.Length - 1)
            End If
            'Remove the first comma if specified
            If strKeyboardShortcutsAndFunctions.Trim.Substring(0, 1) = "," Then
                strKeyboardShortcutsAndFunctions = strKeyboardShortcutsAndFunctions.Trim.Remove(0, 1)
            End If
            'Attach the shortcut to the Tags Shortcut and functions list
            m_strShortcutsAndFunction(0) += strKeyboardShortcutsAndFunctions
        End If
        CommonFunctions.General.WriteKeyboardShortcuts_FunctionCall(m_strShortcutsAndFunction, blnIsSubTag, m_strTagID)
        m_strShortcutsAndFunction = Nothing
        blnIsSubTag = Nothing
        m_strTagID = Nothing
        'End Modification by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" & vbCrLf)
        Response.Write(vbCrLf + "    var objfrm;")
        Response.Write(vbCrLf + "   var objdivlist;")
        Response.Write(vbCrLf + "   objfrm = GetFormReference('frmCommonList')")
        'Added/ Modified By NileshD on 4 Mar 2006 ReqID WAF3_PB_17
        Response.Write(vbCrLf + "   objdivlistPage=GetObjectReference('frmCommonList','" + DIV_TAG + "')" + vbCrLf)
        Response.Write(vbCrLf + "   objdivlist=GetObjectReference('frmCommonList','divListTag')" + vbCrLf)
        'End Of Addition By NileshD on 4 Mar 2006 ReqID WAF3_PB_17
        If m_strInformativeMessage.Trim <> "" Then
            Response.Write(vbCrLf + m_strInformativeMessage)
        Else
            Response.Write(vbCrLf + "window.status='';")
        End If
        'Window_OnResize and Window_OnReload
        Call WriteClientsideScript_WindowOnload_Resize()
        'Sorting
        Call WriteClientsideScript_Sorting()
        'Paging
        Call WriteClientsideScript_Paging()
        'Edit Link
        Call WriteClientsideScript_EditLink()
        'My Views On Change Script R. No. WAF3_PB_24
        If m_cObjCLSQL.EnableViews = True Then Call WriteClientsideScript_MyViews()
        'Section script
        Response.Write(vbCrLf + m_strSectionClientsideScript)
        'Dynamic Links
        If m_cObjCLSQL.RecordCount > 0 Then Call WriteClientsideScript_Links()
        'User Filters
        If m_strUserFilter.Trim <> "" Then Call WriteClientsideScript_Filter()
        'Sub Tag hide-show
        If m_blnDisplaySubTags = True Then
            Call WriteClientsideScript_ShowHideSubTag()

            'Call WriteClientsideScript_SubTagInformation()
        End If
        'WAF3_PB_35


        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
        'Reason   - For showing contetx menu in grid.
        '-------------------------------------------------------------------------------------------------------------
        If m_blnConsiderContextMenu AndAlso CommonFunctions.General.CheckIsNothing(m_strContextMenuJsFunction) <> "" Then
            Response.Write(vbCrLf)
            Response.Write(m_strContextMenuJsFunction)
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
        '-------------------------------------------------------------------------------------------------------------

        If CType(CommonFunction.General.GetApplicationKeySetting("Environment"), String) = "P" Then Response.Write(vbCrLf + "disableRightClick();")
        Response.Write(vbCrLf + "</SCRIPT>" & vbCrLf)
        'Call WriteClientsideScript_DisableWindowStatus()
    End Sub


    Private Sub WriteClientsideScript_WindowOnload_Resize()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_WindowOnload_Resize
        ' Purpose               :	Write Clientside Script 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2003
        ' Revisions             :   WAF3_PB_42 April 09, 2007 UmeshJ
        '=====================================================================
        'Modified By NileshD on 3 Mar 2006 ReqID WAF3_PB_17
        Const HEIGHT_FACTOR As Int16 = 40
        Dim intHeightFactor As Integer = HEIGHT_FACTOR
        If CommonFunction.General.CheckIsNothing(m_cObjCLSQL.CLLegend).Trim <> "" Then intHeightFactor += 10
        'If CommonFunction.General.CheckIsNothing(m_cObjCLSQL.PageHeader).Trim <> "" Then intHeightFactor += 5
        If m_strUserFilter.Trim <> "" Then intHeightFactor += 5
        If m_cObjCLSQL.AllowNumericPaging = True Then 'WAF3_PB_42 April 09, 2007 UmeshJ 
            intHeightFactor += 7
        End If
        If m_cObjCLSQL.ShowRecordCountOnCL = True Then intHeightFactor += 15
        If CommonFunction.General.CheckIsNothing(m_cObjCLSQL.PageFooter).Trim <> "" Then intHeightFactor += 10
        'If the page DO NOT have - Header, Footer, Filter and Numeric Paging then add xtra 10 into height factor
        If intHeightFactor = HEIGHT_FACTOR + 15 Then
            intHeightFactor += 10
        ElseIf intHeightFactor = HEIGHT_FACTOR + 20 Then
            'Filter and record count only
            intHeightFactor += 7
        ElseIf intHeightFactor = HEIGHT_FACTOR + 37 Then
            'Have - Page Header, Filter, Numeric Paging
            intHeightFactor -= 10
        End If
        'WAF3_PB_42 April 06, 2007 UmeshJ
        If m_cObjCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.DROPDOWN Then intHeightFactor = intHeightFactor - 30
        'WAF3_PB_42 April 06, 2007 UmeshJ

        Response.Write(vbCrLf + "//window resize for Common list")
        Response.Write(vbCrLf + "var divHeight=0;")
        Response.Write(vbCrLf + "	function CL_window_onresize()")
        Response.Write(vbCrLf + "	{")
        Response.Write(vbCrLf + "		var intDivHeight ;")
        Response.Write(vbCrLf + "		var intDivHeightRisk;")
        Response.Write(vbCrLf + "		var intDivListPageHeight ;")

        ''ADDED AND COMMENTED BY NILESH G ON 18/12/2015 FOR FOOTER ISSUE

        ''Added By NileshD on 8 Feb 2006 For SuportRequestID :99
        'Response.Write(vbCrLf + "		if (objdivlistPage != null) {")
        ''End of Addition By NileshD on 8 Feb 2006 For SuportRequestID :99

        ''-------------------------------------------------------------------------------------------------------------
        ''Modified By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. - WAF3_GEN_NE_16_06_2006
        ''Reason      - For Support Req. ID. - 139
        ''              In mozilla based browsers, instead of document.body.offsetHeight, use window.innerHeight.
        ''-------------------------------------------------------------------------------------------------------------
        'Response.Write(vbCrLf + "		if (navigator.appName == 'Microsoft Internet Explorer'){")
        'Response.Write(vbCrLf + "		intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - " + intHeightFactor.ToString + ";")
        'Response.Write(vbCrLf + "		}")
        'Response.Write(vbCrLf + "		else{")
        'Response.Write(vbCrLf + "		intDivHeight = window.innerHeight - objdivlistPage.offsetTop - " + intHeightFactor.ToString + ";")
        'Response.Write(vbCrLf + "		}")
        ''-------------------------------------------------------------------------------------------------------------
        ''Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. - WAF3_GEN_NE_16_06_2006 
        ''                       Support Req. ID. - 139
        ''-------------------------------------------------------------------------------------------------------------

        'Response.Write(vbCrLf + "		if (intDivHeight < 100)")
        'Response.Write(vbCrLf + "			intDivHeight = 100;")
        'Response.Write(vbCrLf + "				")
        'Response.Write(vbCrLf + "		objdivlistPage.style.height = intDivHeight	;}")

        ''Added By NileshD on 3 Mar 2006 ReqID WAF3_PB_17
        'Response.Write(vbCrLf + "		if (objdivlist != null) {")
        'Response.Write(vbCrLf + "		intDivListPageHeight = intDivHeight - 5 ;")
        'Response.Write(vbCrLf + "		if (parseFloat(objdivlist.style.height) > intDivListPageHeight){objdivlist.style.height = intDivListPageHeight;}")
        'Response.Write(vbCrLf + "		else if(parseFloat(objdivlist.style.height) < intDivListPageHeight)")
        'Response.Write(vbCrLf + "		{if(divHeight < intDivListPageHeight){objdivlist.style.height = divHeight;}")
        'Response.Write(vbCrLf + "		 else if(divHeight > intDivListPageHeight){objdivlist.style.height = intDivListPageHeight;}}")
        'Response.Write(vbCrLf + "		}")
        ''End Of Addition By NileshD on 3 Mar 2006 ReqID WAF3_PB_17

        ''For Sub Tag

        Response.Write(vbCrLf + "		var MasterTagID = getParameterByName('MasterTagID');")
        Response.Write(vbCrLf + "		var Mode = getParameterByName('MODE');")
        Response.Write(vbCrLf + "       var brw = isIE();")
        Response.Write(vbCrLf + "		if (objdivlistPage != null) {")
        Response.Write(vbCrLf + "		intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - " + intHeightFactor.ToString + ";")
        Response.Write(vbCrLf + "      if(brw == 'IE')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlistPage.style.height = intDivHeight-8 +'px';}")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'CR')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlistPage.style.height = intDivHeight-8 +'px';}")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'FF')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlistPage.style.height = intDivHeight-11+'px';}")
        Response.Write(vbCrLf + "      else")

        Response.Write(vbCrLf + "		objdivlistPage.style.height = intDivHeight;}")

        Response.Write(vbCrLf + "		if (objdivlist != null) {")
        Response.Write(vbCrLf + "       if(MasterTagID=='3700' && Mode=='Change')")
        Response.Write(vbCrLf + "       { objdivlist.style.height = intDivHeight-52 +'px';}")
        Response.Write(vbCrLf + "       else")
        Response.Write(vbCrLf + "      if(brw == 'IE')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlist.style.height = intDivHeight-13 +'px';}")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'CR')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlist.style.height = intDivHeight-13 +'px'; }")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'FF')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlist.style.height = intDivHeight-16+'px'; }")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "	   objdivlist.style.height = intDivHeight+'px';")
        Response.Write(vbCrLf + "		}")

        ''END OF ADDED AND COMMENTED BY NILESH G ON 18/12/2015 FOR FOOTER ISSUE

        If m_blnDisplaySubTags = True Then Response.Write(vbCrLf + "      UpdateWindowSize(true,true);")
        Response.Write(vbCrLf + "	try{hideAll();} catch(e){}}")

        Response.Write(vbCrLf + "	//window onload for Common list")
        Response.Write(vbCrLf + "	function CL_window_onload()")
        Response.Write(vbCrLf + "	{  var brw = isIE(); if(brw=='FF') ")
        'Added BY NileshD on 24 Oct 2005 for Support REQID:43

        'Modified by swapnil aswale on 21-1-2016 for browser compatibility issue [url copying security]
        Response.Write(vbCrLf + "	{  ")
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            '  Response.Write(vbCrLf + "if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
        End If
        Response.Write(vbCrLf + "	} else {  ")

        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
        End If
        Response.Write(vbCrLf + "	}  ")
        ''Ended

        'End Of Addition BY NileshD on 24 Oct 2005 for Support REQID:43
        'Response.Write(vbcrlf+"		document.body.onresize = '';")
        Response.Write(vbCrLf + "		var intDivHeight ;")
        Response.Write(vbCrLf + "		var intDivListPageHeight ;")
        Response.Write(vbCrLf + "		var intDivHeightRisk;")
        Response.Write(vbCrLf + "		var lc;")
        ''ADDED AND COMMENTED BY NILESH G ON 18/12/2015 FOR FOOTER ISSUE

        ''Added By NileshD on 8 Feb 2006 For SuportRequestID :99
        'Response.Write(vbCrLf + "		if (objdivlistPage != null) {")
        ''End of Addition By NileshD on 8 Feb 2006 For SuportRequestID :99
        ''-------------------------------------------------------------------------------------------------------------
        ''Modified By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. - WAF3_GEN_NE_16_06_2006
        ''Reason      - For Support Req. ID. - 139
        ''              In mozilla based browsers, instead of document.body.offsetHeight, use window.innerHeight.
        ''-------------------------------------------------------------------------------------------------------------
        'Response.Write(vbCrLf + "		if (navigator.appName == 'Microsoft Internet Explorer'){")

        'Response.Write(vbCrLf + "		intDivHeight = document.body.offsetHeight - objdivlistPage.offsetTop - " + intHeightFactor.ToString + ";")

        'Response.Write(vbCrLf + "		}")

        'Response.Write(vbCrLf + "		else{")
        'Response.Write(vbCrLf + "		intDivHeight = window.innerHeight - objdivlistPage.offsetTop - " + intHeightFactor.ToString + ";")
        'Response.Write(vbCrLf + "		}")
        ''-------------------------------------------------------------------------------------------------------------
        ''Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. - WAF3_GEN_NE_16_06_2006 
        ''                       Support Req. ID. - 139
        ''-------------------------------------------------------------------------------------------------------------

        'Response.Write(vbCrLf + "		if (intDivHeight < 100)")
        'Response.Write(vbCrLf + "			intDivHeight = 100;")
        'Response.Write(vbCrLf + "		objdivlistPage.style.height = intDivHeight;}")

        ''Added By NileshD on 3 Mar 2006 ReqID WAF3_PB_17
        'Response.Write(vbCrLf + "		if (objdivlist != null) {")
        'Response.Write(vbCrLf + "		intDivListPageHeight = intDivHeight;")
        'Response.Write(vbCrLf + "		if(isNaN(parseFloat(objdivlist.style.height))){objdivlist.style.height=intDivListPageHeight;}divHeight=parseFloat(objdivlist.style.height);")
        'Response.Write(vbCrLf + "		if (parseFloat(objdivlist.style.height) > intDivListPageHeight){objdivlist.style.height = intDivListPageHeight;}}")
        ''End Of Addition By NileshD on 3 Mar 2006 ReqID WAF3_PB_17



        Response.Write(vbCrLf + "		if (objdivlistPage != null) {")
        Response.Write(vbCrLf + "		intDivHeight = window.innerHeight - objdivlistPage.offsetTop - " + intHeightFactor.ToString + ";")
        Response.Write(vbCrLf + "		var MasterTagID = getParameterByName('MasterTagID');")
        Response.Write(vbCrLf + "		var Mode = getParameterByName('MODE');")
        'Response.Write(vbCrLf + "       var brw = isIE();")
        Response.Write(vbCrLf + "      if(brw == 'IE')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlistPage.style.height = intDivHeight-8 +'px';}")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'CR')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlistPage.style.height = intDivHeight-8 +'px'; }")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'FF')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlistPage.style.height = intDivHeight-11+'px'; }")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "	   objdivlistPage.style.height = intDivHeight+'px'; }")

        Response.Write(vbCrLf + "		if (objdivlist != null) {")
        Response.Write(vbCrLf + "       if(MasterTagID=='3700' && Mode=='Change')")
        Response.Write(vbCrLf + "       { objdivlist.style.height = intDivHeight-52 +'px';}")
        Response.Write(vbCrLf + "       else")
        Response.Write(vbCrLf + "      if(brw == 'IE')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlist.style.height = intDivHeight-13 +'px';}")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'CR')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlist.style.height = intDivHeight-13 +'px'; }")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "      if(brw == 'FF')")
        Response.Write(vbCrLf + "      { ")
        Response.Write(vbCrLf + "      objdivlist.style.height = intDivHeight-16+'px'; }")
        Response.Write(vbCrLf + "      else")
        Response.Write(vbCrLf + "	   objdivlist.style.height = intDivHeight+'px';")
        Response.Write(vbCrLf + "		}")

        ''END OF ADDED AND COMMENTED BY NILESH G ON 18/12/2015 FOR FOOTER ISSUE
        If m_blnDisplaySubTags = True Then Response.Write(vbCrLf + "      WindowLoading(true,true);")
        'Response.Write(vbcrlf+"		document.body.onResize = 'CL_window_onresize()';")
        Response.Write(vbCrLf + "	}")
    End Sub

    Private Sub WriteClientsideScript_MyViews()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_MyViews
        ' Purpose               :	Write Clientside Script for My Views
        ' Description           :	R. No. WAF3_PB_24
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	July 13, 2006
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function cboMyViews_OnChange()")
        Response.Write(vbCrLf + "{")
        If m_strQuerystringDefaultParameters.Trim = "" Then
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?ApplyView=1&PagingNumber=1&PagingAlphabet=-1""")
        Else
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?ApplyView=1&PagingNumber=1&PagingAlphabet=-1" + m_strQuerystringDefaultParameters + """") 'RequestID: 272 UJ 13 AUg 2007
        End If
        Response.Write(vbCrLf + "   objfrm.submit();")
        Response.Write(vbCrLf + "}")
    End Sub
    Private Sub WriteClientsideScript_Sorting()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Sorting
        ' Purpose               :	Write Clientside Script for sorting
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function SortBy(strFieldName,strAscDesc)")
        Response.Write(vbCrLf + "{")
        If m_strQuerystringDefaultParameters.Trim = "" Then
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?SortBy="" + strFieldName + ""&SortOrder="" + strAscDesc ")
        Else
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?SortBy="" + strFieldName + ""&SortOrder="" + strAscDesc + """ + m_strQuerystringDefaultParameters + """")
        End If
        Response.Write(vbCrLf + "   objfrm.submit();")
        Response.Write(vbCrLf + "}")
    End Sub

    Private Function ReplacePlaceHolders(ByVal strInput As String) As String
        '=====================================================================
        ' Procedure Name        :	ReplacePlaceHolders
        ' Purpose               :	Replace the Place Holders by actual values
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	String with actual values for the place holders
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Thursday, September 11, 2003 
        ' Revisions             :
        '=====================================================================
        If strInput = "" Then Return ""
        strInput = Microsoft.VisualBasic.Replace(strInput, "<UNIQUE_ID>", """ + lngUniqueID + ""&PKToken="" + PKToken + """) 'WAF3_PB_26
        strInput = Microsoft.VisualBasic.Replace(strInput, "<USER_NAME>", m_objGlobal.UserName)
        strInput = Microsoft.VisualBasic.Replace(strInput, "<PROJECT_ID>", m_objGlobal.ProjectID.ToString)
        strInput = Microsoft.VisualBasic.Replace(strInput, "<USER_ID>", m_objGlobal.UserID.ToString)
        strInput = Microsoft.VisualBasic.Replace(strInput, "<LOGIN_TYPE>", m_objGlobal.LoginType)
        strInput = Microsoft.VisualBasic.Replace(strInput, "<ROLE_ID>", m_objGlobal.RoleID.ToString)
        If m_objGlobal.ParentTagID <> 0 Then
            strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", m_objGlobal.ParentTagID.ToString)
            strInput = Microsoft.VisualBasic.Replace(strInput, "<SUBTAG_ID>", m_objGlobal.TagID.ToString)
        Else
            strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", m_objGlobal.TagID.ToString)
        End If

        'Added By - NinadP On - 25 Feb 2008 Support Req. ID. - 19143
        'Query string place holders
        If InStr(strInput, "<#", CompareMethod.Text) <> 0 Then
            'For these place holders check the syntax <#PLACE_HOLDER>
            'Place holder exists e.g. usp_sel 4545,<#DataId>,<#Data2>
            Dim arrInput() As String = Split(strInput, "<")
            Dim intIndex As Integer
            Dim intLastIndex As Integer = arrInput.Length - 1
            For intIndex = 0 To intLastIndex
                'For each item in the array
                If Left(arrInput(intIndex), 1) = "#" Then
                    'if first character is # then it is a Query String Place holder
                    Dim arrPlaceHolder() As String = Split(arrInput(intIndex), ">")
                    If arrPlaceHolder.Length = 2 Then
                        'First item will be #PLACE_HOLDER and Second will be some string
                        arrPlaceHolder(0) = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request(Right(arrPlaceHolder(0), arrPlaceHolder(0).Length - 1)))
                        arrInput(intIndex) = Join(arrPlaceHolder, "")
                    Else
                        'Not a valid Place holder
                        If intIndex > 0 Then arrInput(intIndex) = "<" + Join(arrPlaceHolder, ">")
                    End If
                Else
                    If intIndex > 0 Then
                        'Not a valid Place holder
                        arrInput(intIndex) = "<" + arrInput(intIndex)
                    End If
                End If
            Next
            'Recreate the query
            strInput = Join(arrInput, "")
        End If
        'End Addition By - NinadP On - 25 Feb 2008 Support Req. ID. - 19143
        Return strInput
    End Function

    Private Sub WriteClientsideScript_Links()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Links
        ' Purpose               :	Write Clientside Script for grid links
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :   By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43, to get link details from hash table
        '=====================================================================
        'Get all the Links Details (Dynamic links and hyperlink controls)
        'Dim strSQL As String = "usp_Sel_v_tbl_UI_ControlTagMaster_List_Links " + m_objGlobal.TagID.ToString
        'Dim drLinks As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'Dim objLinks As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function

        'Do While drLinks.Read()
        '    'Prepare Grid links object
        '    With objLinks
        '        .AccessRights = CommonFunction.Data.CheckIsDBNull(drLinks("AccessRights")).ToString.Trim
        '        .ClientSideFunctionName = CommonFunction.Data.CheckIsDBNull(drLinks("ClientSideFunctionName")).ToString.Trim
        '        .HREF_Parameters = CommonFunction.Data.CheckIsDBNull(drLinks("HREF_Parameters")).ToString.Trim
        '        .HREF_URL = CommonFunction.Data.CheckIsDBNull(drLinks("HREF_URL")).ToString.Trim
        '        .Identifier = CommonFunction.Data.CheckIsDBNull(drLinks("Identifier")).ToString.Trim
        '        If drLinks("Type").ToString = "DYNAMIC_LINK" Then
        '            .IsHyperlink = False
        '        Else
        '            .IsHyperlink = True
        '        End If
        '        .LinkType = CommonFunction.Data.CheckIsDBNull(drLinks("LinkType")).ToString.Trim
        '        .SPToExecute = CommonFunction.Data.CheckIsDBNull(drLinks("SpToExecute")).ToString.Trim
        '        .UniqueID = CType(CommonFunction.Data.CheckIsDBNull(drLinks("UniqueID"), "0"), Long)
        '        .ToBeInserted = CommonFunction.Data.CheckIsDBNull(drLinks("InsertInFunction")).ToString.Trim
        '    End With
        'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
        Dim objLinks As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function
        Dim objArrListLinksForClientSideScripts As CommonEngines.HashTables.ListLinksForClientSideScripts()
        objArrListLinksForClientSideScripts = CommonEngines.HashTables.GetHashTableObject.GetHashTableListLinksTagMasterHashTable_ForClientSideScripts(m_objGlobal.TagID)
        If Not objArrListLinksForClientSideScripts Is Nothing Then
            Dim objListLinksForClientSideScripts As CommonEngines.HashTables.ListLinksForClientSideScripts
            For Each objListLinksForClientSideScripts In objArrListLinksForClientSideScripts
                'Prepare Grid links object
                With objLinks
                    .AccessRights = objListLinksForClientSideScripts.AccessRights
                    .ClientSideFunctionName = objListLinksForClientSideScripts.ClientSideFunctionName
                    .HREF_Parameters = objListLinksForClientSideScripts.HREF_Parameters
                    .HREF_URL = objListLinksForClientSideScripts.HREF_URL
                    .Identifier = objListLinksForClientSideScripts.Identifier
                    If objListLinksForClientSideScripts.Type = "DYNAMIC_LINK" Then
                        .IsHyperlink = False
                    Else
                        .IsHyperlink = True
                    End If
                    .LinkType = objListLinksForClientSideScripts.LinkType
                    .SPToExecute = objListLinksForClientSideScripts.SpToExecute
                    .UniqueID = objListLinksForClientSideScripts.UniqueID
                    .ToBeInserted = objListLinksForClientSideScripts.InsertInFunction
                End With
                'End Addition By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
                Dim blnCancel As Boolean = False
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "Before_GridLinksFunction_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = blnCancel
                    ExtensionArgs.m_gridlinks_Function = objLinks
                    ExtensionArgs.m_global = m_objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                        "Before_GridLinksFunction_Print", ExtensionArgs)
                    blnCancel = ExtensionArgs.Cancel
                    objLinks = ExtensionArgs.m_gridlinks_Function
                    m_objGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    'Call before print event
                    'Code Modified:RajeshB          19 Jan 2005
                    ' Purpose: Wrap the call into overridable function
                    Call Before_GridLinksFunction_Print(blnCancel, objLinks, m_objGlobal)
                End If
                'addition ends.
                If blnCancel = False Then
                    If objLinks.IsHyperlink = False Then
                        Response.Write(vbCrLf + "function " & Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(Replace(objLinks.ClientSideFunctionName, " ", ""), "[", ""), "]", "") & "(lngUniqueID,PKToken) {")  'WAF3_PB_26
                        Response.Write(vbCrLf + objLinks.ToBeInserted)
                        If objListLinksForClientSideScripts.LinkType = "D" Then 'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
                            Response.Write(vbCrLf + "window.open (" & Chr(34) & ReplacePlaceHolders(objLinks.HREF_URL) & Chr(34) & ");" & vbCrLf)
                        Else
                            Response.Write(vbCrLf + "   objfrm.action = """ & strFormPage & "?Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + objLinks.UniqueID.ToString + "&UniqueValue="" + lngUniqueID + ""&PKToken="" + PKToken + ""&IsListPageLink=1" + m_strQuerystringDefaultParameters + """") 'WAF3_PB_26
                            Response.Write(vbCrLf + "   objfrm.submit();")
                        End If
                        Response.Write(vbCrLf + "}")
                    Else
                        Response.Write(vbCrLf + "function " & Microsoft.VisualBasic.Strings.Replace(objLinks.ClientSideFunctionName, " ", "") & "(")
                        Dim strURL As String = objLinks.HREF_URL
                        Dim sbURL As New System.Text.StringBuilder
                        If objLinks.HREF_Parameters <> "" And InStr(strURL, "<PARAMETERS>") <> 0 Then
                            'If the parametrs are specified then prepare the function definition and URL accordingly
                            Dim strParametersArray As String() = Split(objLinks.HREF_Parameters, CommonFunction.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS)
                            Dim intIndex As Integer
                            Dim intUBound As Integer = strParametersArray.GetUpperBound(0)
                            For intIndex = 0 To intUBound
                                Response.Write(strParametersArray(intIndex))
                                If intIndex < intUBound Then Response.Write(",")
                                'More than 1 parameters    
                                If intIndex > 0 Then sbURL.Append(" + ""&")
                                sbURL.Append("" + strParametersArray(intIndex) + "="" + " & strParametersArray(intIndex))
                            Next
                            'Replace the place holder <PARAMETERS> by actual values
                            strURL = Microsoft.VisualBasic.Strings.Replace(strURL, "<PARAMETERS>", sbURL.ToString)
                        End If

                        strURL = ReplacePlaceHolders(strURL) 'Added By - NinadP On - 25 Feb 2008 Support Req. ID. - 19143

                        Response.Write(")")
                        Response.Write(vbCrLf + "{")
                        Response.Write(vbCrLf + objLinks.ToBeInserted)
                        Response.Write(vbCrLf + "window.open (" + Chr(34) + strURL + ");")
                        Response.Write(vbCrLf + "}")
                        'Destroy the object
                        sbURL = Nothing
                    End If
                End If
                'Loop
            Next
            objListLinksForClientSideScripts = Nothing 'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
        End If
        'drLinks.Dispose()
        'drLinks.Close()
        'drLinks = Nothing
        objArrListLinksForClientSideScripts = Nothing 'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
        objLinks = Nothing
    End Sub
    Public Overridable Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonEngine.General.CLCP_Events_DynamicActions.Before_GridLinksFunction_Print(Cancel, Args, m_objGlobal)
    End Sub
    Private Sub WriteClientsideScript_Filter()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Filter
        ' Purpose               :	Write Clientside Script for Page Filters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " & m_strFilterFunction & "(strHiddenControlName,e,IsText)")
        Response.Write(vbCrLf + "{")
        Response.Write(vbCrLf + "	if (IsText==false) {")
        Response.Write(vbCrLf + "	    objControl = GetObjectEvent(e);")
        Response.Write(vbCrLf + "	    objHiddenControl = GetObjectReference('frmCommonList',strHiddenControlName);")
        'Added By NileshD on 9 Nov 2005
        Response.Write(vbCrLf + "	        if(" + VALIDATE_FILTER + "()==false){return};")
        'End
        Response.Write(vbCrLf + "	    if (objHiddenControl != null) ")
        Response.Write(vbCrLf + "			{")
        Response.Write(vbCrLf + "				objHiddenControl.value = objControl.options[objControl.selectedIndex].innerText;")
        Response.Write(vbCrLf + "	        }")
        Response.Write(vbCrLf + "	}")
        Response.Write(vbCrLf + "	else {")
        Response.Write(vbCrLf + "	    var code;")
        Response.Write(vbCrLf + "	    if (e.keyCode) code = e.keyCode;")
        Response.Write(vbCrLf + "	    else if (e.which) code = e.which;")
        Response.Write(vbCrLf + "	    if(code==13) {")
        'Added By UmeshJ on 23 Nov 2004
        Response.Write(vbCrLf + "	        if(" + VALIDATE_FILTER + "()==false){return};")
        'End
        Response.Write(vbCrLf + "	        objControl = GetObjectEvent(e);")
        Response.Write(vbCrLf + "	        objHiddenControl = GetObjectReference('frmCommonList',strHiddenControlName);")
        Response.Write(vbCrLf + "	        if (objHiddenControl != null) ")
        Response.Write(vbCrLf + "	        {objHiddenControl.value = objControl.value;}")
        Response.Write(vbCrLf + "	    }")
        Response.Write(vbCrLf + "	    else {return;}")
        Response.Write(vbCrLf + "	}")
        Dim strToBeInsertedInFilterFunction As String = ""
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
        "Before_Applying_Filter")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.ToBeInsertedInFunction = strToBeInsertedInFilterFunction

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                    "Before_Applying_Filter", ExtensionArgs)
            strToBeInsertedInFilterFunction = ExtensionArgs.ToBeInsertedInFunction

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            Call Before_Applying_Filter(strToBeInsertedInFilterFunction)
        End If
        'addition ends

        If strToBeInsertedInFilterFunction.Trim <> "" Then
            Response.Write(vbCrLf + strToBeInsertedInFilterFunction.Trim)
        End If
        'Modified By UmeshJ on 29Jun2004 : Persist the Query string default filter parameters on the filter change event
        If m_strQuerystringDefaultParameters.Trim <> "" Then
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?SetFilter=1" + m_strQuerystringDefaultParameters + """")
        Else
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?SetFilter=1""")
        End If
        'End of modification
        Response.Write(vbCrLf + "	objfrm.submit();")
        Response.Write(vbCrLf + "}" + vbCrLf)
    End Sub

    Private Sub WriteClientsideScript_ShowHideSubTag()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ShowHideSubTag
        ' Purpose               :	Write Clientside Script for Show hide sub tag
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 02, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " + FUNCTION_NAME_SHOW_HIDE_SUBTAG + "(hdnColumn,hdnDetails)")
        Response.Write(vbCrLf + "{")
        Response.Write(vbCrLf + "   var objhdnDetails = document.getElementById(hdnDetails);")
        Response.Write(vbCrLf + "   var objhdnColumn = document.getElementById(hdnColumn);")
        Response.Write(vbCrLf + "   if (objhdnDetails.style.display == ""none"") { ")
        Response.Write(vbCrLf + "       objhdnDetails.style.display="""";")
        'Hide.......Sub Tags
        Response.Write(vbCrLf + "       objhdnColumn.src='" + HIDE_SUBTAG_IMAGE_SOURCE + "';")
        If HIDE_SUBTAG_IMAGE_TOOLTIP.Trim <> "" Then
            Response.Write(vbCrLf + "       objhdnColumn.title='" + HIDE_SUBTAG_IMAGE_TOOLTIP + "';")
        End If
        Response.Write(vbCrLf + "   }")
        Response.Write(vbCrLf + "   else { ")
        Response.Write(vbCrLf + "       objhdnDetails.style.display=""none"";")
        'Show Sub Tags
        Response.Write(vbCrLf + "       objhdnColumn.src='" + SHOW_SUBTAG_IMAGE_SOURCE + "';")
        If SHOW_SUBTAG_IMAGE_TOOLTIP.Trim <> "" Then
            Response.Write(vbCrLf + "       objhdnColumn.title='" + SHOW_SUBTAG_IMAGE_TOOLTIP + "';")
        End If
        Response.Write(vbCrLf + "   }")
        Response.Write(vbCrLf + "}")
    End Sub

    Private Sub WriteClientsideScript_SubTagInformation()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SubTagInformation
        ' Purpose               :	Write Clientside Script for function to 
        '                           open the page to show the Sub Tag Information
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 05, 2004
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " + FUNCTION_NAME_SUBTAG_INFORMATION + "(lngSubTagID,strPrimaryKey)")
        Response.Write(vbCrLf + "{")
        Response.Write(vbCrLf + "   window.open (""CommonSubTag.aspx?SubTagID="" + lngSubTagID + ""&ForeignKeyValue="" + strPrimaryKey + ""&TagID=" + m_objGlobal.TagID.ToString + """ , ""_popup"", ""resizable=yes,scrollbars=yes,left="" + ((window.screen.width - 500)/2) + "",top="" + ((window.screen.height - 300)/2) + "",width=500,height=300"");")
        Response.Write(vbCrLf + "}")
    End Sub

    Private Sub WriteClientsideScript_Paging()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Paging
        ' Purpose               :	Write Clientside Script for Paging
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " + FUNCTION_NAME_PAGE_ONCLICK + "(strPagingAlphabet)")
        Response.Write(vbCrLf + "{")
        If m_strQuerystringDefaultParameters.Trim = "" Then
            'Modified By NileshD on 26 Sep 2005 REQID-WAF3_PB_10
            'Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?PagingAlphabet="" +  strPagingAlphabet;")
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?SetPagingAlphabet=1&PagingAlphabet="" +  URLEncode(strPagingAlphabet);") 'Modified By Shrikant IssueID 20608
            'End Of Modification By NileshD on 26 Sep 2005 REQID-WAF3_PB_10
        Else
            'Modified By NileshD on 26 Sep 2005 REQID-WAF3_PB_10
            'Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?PagingAlphabet="" +  strPagingAlphabet + """ + m_strQuerystringDefaultParameters + """;")
            Response.Write(vbCrLf + "   objfrm.action = """ & strListPage & "?SetPagingAlphabet=1&PagingAlphabet="" +  URLEncode(strPagingAlphabet) + """ + m_strQuerystringDefaultParameters + """;") 'Modified By Shrikant IssueID 20608
            'End Of Modification By NileshD on 26 Sep 2005 REQID-WAF3_PB_10
        End If
        Response.Write(vbCrLf + "   objfrm.submit();")
        Response.Write(vbCrLf + "}")
    End Sub

    Private Sub WriteClientsideScript_DisableWindowStatus()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_DisableWindowStatus
        ' Purpose               :	Write Clientside Script for disabling the window status
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.WriteHTML("<script language='JavaScript'>")
        CommonFunction.General.WriteHTML(vbCrLf + "<!--")
        CommonFunction.General.WriteHTML("document.onmouseover = function ( e ) {   ")
        CommonFunction.General.WriteHTML("if ( !e ) e = window.event;   ")
        CommonFunction.General.WriteHTML("var el = e.target ? e.target : e.srcElement;   ")
        CommonFunction.General.WriteHTML("while ( el != null && el.tagName != 'A') el = el.parentNode;   ")
        CommonFunction.General.WriteHTML("if ( el == null ) return;   ")
        CommonFunction.General.WriteHTML("if ( e.preventDefault ) e.preventDefault();   ")
        CommonFunction.General.WriteHTML("else e.returnValue = true;};")
        CommonFunction.General.WriteHTML("-->")
        CommonFunction.General.WriteHTML("</script>")
    End Sub

    Private Sub WriteClientsideScript_EditLink()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_EditLink
        ' Purpose               :	Write Clientside Script for Edit links
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " + FUNCTION_NAME_EDIT_ONCLICK + "(strUniqueID,PKToken) {") 'WAF3_PB_26
        Dim strPKSuffix As String = ""
        Dim strUIPage As String = ReplaceParameters(m_cObjCLSQL.EditMode_UIPage.Trim)
        If InStr(1, strUIPage.ToUpper, "" & strFormPage & "", CompareMethod.Text) <> 0 Then strPKSuffix = "_PK"
        If m_cObjCLSQL.EditMode_UIPageOpenInWindow = False Then
            If m_strCommonQueryString.Trim = "" Then
                If InStr(1, strUIPage, "?", CompareMethod.Text) = 0 Then
                    Response.Write(vbCrLf + "     window.location.href=" + Chr(34) + strUIPage + "?" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) & ";" + vbCrLf) 'WAF3_PB_26
                Else
                    Response.Write(vbCrLf + "     window.location.href=" + Chr(34) + strUIPage + "&" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) + ";" + vbCrLf) 'WAF3_PB_26
                End If
            Else
                If InStr(1, strUIPage, "?", CompareMethod.Text) = 0 Then
                    Response.Write(vbCrLf + "     window.location.href=" + Chr(34) + strUIPage + "?" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strCommonQueryString & Chr(34) + ";" + vbCrLf) 'WAF3_PB_26
                Else
                    Response.Write(vbCrLf + "     window.location.href=" + Chr(34) + strUIPage + "&" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strCommonQueryString & Chr(34) + ";" + vbCrLf) 'WAF3_PB_26
                End If
            End If
        Else
            If m_strCommonQueryString.Trim = "" Then
                If InStr(1, strUIPage, "?", CompareMethod.Text) = 0 Then
                    Response.Write(vbCrLf + "     window.open(" + Chr(34) + strUIPage + "?" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken , """", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_cObjCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_cObjCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_cObjCLSQL.WindowWidth.ToString + ",height=" + m_cObjCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
                Else
                    Response.Write(vbCrLf + "     window.open(" + Chr(34) + strUIPage + "&" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken , """", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_cObjCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_cObjCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_cObjCLSQL.WindowWidth.ToString + ",height=" + m_cObjCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
                End If
            Else
                If InStr(1, strUIPage, "?", CompareMethod.Text) = 0 Then
                    Response.Write(vbCrLf + "     window.open(" + Chr(34) + strUIPage + "?" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken + ""&" + m_strCommonQueryString & Chr(34) + ", """", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_cObjCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_cObjCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_cObjCLSQL.WindowWidth.ToString + ",height=" + m_cObjCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
                Else
                    Response.Write(vbCrLf + "     window.open(" + Chr(34) + strUIPage + "&" + m_cObjCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken + ""&" + m_strCommonQueryString & Chr(34) + ", """", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_cObjCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_cObjCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_cObjCLSQL.WindowWidth.ToString + ",height=" + m_cObjCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
                End If
            End If
        End If
        Response.Write(vbCrLf + "}")
    End Sub

    Private Sub WriteClientsideScript_DeletionResult()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_DeletionResult
        ' Purpose               :	Write Clientside Script for Deletion Result
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 20, 2003
        ' Revisions             :
        '=====================================================================
        'Delete Message
        If Trim(m_cObjCLSQL.DeletionResult) <> "" Then
            Dim strResultMsgArray As String()
            Dim intIndex As Integer
            Dim strMsg As String = ""
            strResultMsgArray = Split(m_cObjCLSQL.DeletionResult, "<CR>")
            Dim intUBound As Integer = strResultMsgArray.GetUpperBound(0) - 1
            strMsg = strMsg + Chr(34)
            For intIndex = 0 To intUBound
                If intIndex = intUBound Then
                    strMsg = strMsg + Microsoft.VisualBasic.Strings.Replace(strResultMsgArray(intIndex), """", "\""")
                Else
                    strMsg = strMsg + Microsoft.VisualBasic.Strings.Replace(strResultMsgArray(intIndex), """", "\""") + "\r\n"
                End If
            Next
            strMsg = strMsg + Chr(34)
            Response.Write(vbCrLf + "<Script Laguage=javascript>" + vbCrLf)
            If strMsg.Trim <> "" Then Response.Write("alert (" & strMsg & ");")
            Response.Write(vbCrLf + "</Script>" + vbCrLf)
        End If
    End Sub

    Private Sub CreateHiddenParameters()
        '=====================================================================
        ' Procedure Name        :	CreateHiddenParameters
        ' Purpose               :	Create hidden Controls to hold the parameter 
        '                           values for which state needs to be persisted
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :   Modified By PrasannaP on 30th May 2005, Issue ID: 28888
        '=====================================================================
        'hidden Controls to hold the parameter values 
        Response.Write("<INPUT type=hidden id='MasterTagID' name='MasterTagID' value='" + m_objGlobal.TagID.ToString + "'>")
        Response.Write("<INPUT type=hidden id='ParentTagID' name='ParentTagID' value='" + m_objGlobal.ParentTagID.ToString + "'>")
        Response.Write("<INPUT type=hidden id='FromWhere' name='FromWhere' value='" + m_objGlobal.FromWhere.ToString + "'>")
        Response.Write("<INPUT type=hidden id='PagingAlphabet' name='PagingAlphabet' value='" + m_cObjCLSQL.PagingAlphabet.ToString + "'>")
        Response.Write("<INPUT type=hidden id='SortBy' name='SortBy' value='" + m_cObjCLSQL.SortBy.ToString + "'>")
        Response.Write("<INPUT type=hidden id='SortOrder' name='SortOrder' value='" + m_cObjCLSQL.SortOrder.ToString + "'>")
        Response.Write("<INPUT type=hidden id='AccessFirstTime' name='AccessFirstTime' value='0'>")
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("thisIsADummyControl", "thisIsADummyControl", , , , , , " display:none; ", , , , , "TabIndex=-1", True)) 'Added by Ninad on 15 Feb 2008, To plot dummy control for filter text box, to avoid submiting page
    End Sub

    Private Sub EndForm()
        '=====================================================================
        ' Procedure Name        :	EndForm
        ' Purpose               :	End Form and Page html tag
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write("</FORM></BODY></HTML>")
    End Sub

    Private Sub PlotPageLegends()
        '=====================================================================
        ' Procedure Name        :	PlotPageLegends
        ' Purpose               :	Plot the Page Legends
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjPageLegends = New WebPage.Templates.PageLegends
        'If No page Legends then add a <BR>
        Dim strLegend As String = m_cObjPageLegends.DrawPageLegendsWithEvents(m_objGlobal, , , True, m_cObjCLSQL.CLLegend)
        If strLegend.Trim = "" Then Response.Write("<BR>")
        Response.Write(strLegend)

        'Destroy the object
        m_cObjPageLegends = Nothing
    End Sub

    Private Sub PlotPageHeaderFooter(ByVal enmDisplayPosition As WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition, ByVal HeaderFooter As String)
        '=====================================================================
        ' Procedure Name        :	PlotPageHeaderFooter
        ' Purpose               :	Plot the Page Header / Footer
        ' Description           :	Same as above
        ' Parameters Passed     :	enmDisplayPosition - Display Position,
        '                           HeaderFooter - Header/Footer string 
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjHeaderFooter = New WebPage.Templates.HeaderFooter
        With m_cObjHeaderFooter
            .DisplayPosition = enmDisplayPosition
            .HeaderFooter = HeaderFooter
        End With
        Response.Write(m_cObjHeaderFooter.DrawHeaderFooter(m_objGlobal))
        'Destroy the object
        m_cObjHeaderFooter = Nothing
    End Sub

    Private Sub PlotPageCaption()
        '=====================================================================
        ' Procedure Name        :	PlotPageCaption
        ' Purpose               :	Plot the Page Caption
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :   By NinadP Argument Class is used
        '=====================================================================
        m_cObjPageCaption = New WebPage.Templates.PageCaption
        'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
        Dim Args As New WebPage.Templates.PageCaption.PageCaptionArgs
        Args.LeftPageCaption = m_cObjCLSQL.PageCaption
        Args.RightPageCaption = PlotMyViews()
        Args.MiddlePageCaption = ""
        Args.ShowCaptionWithNavigation = True
        Args.ReturnHTML = True
        Args.IsDesignMode = m_blnIsDesignMode
        Dim strPageCaption As String = m_cObjPageCaption.GetPageCaptionsWithEvents(m_objGlobal, Args) 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 30 May 2007
        If strPageCaption <> "" Then Response.Write(strPageCaption + "<BR>")
        'Destroy the object
        m_cObjPageCaption = Nothing
        Args = Nothing
        'End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
    End Sub
    Private Function PlotMyViews() As String
        '=====================================================================
        ' Procedure Name        :	PlotMyViews
        ' Purpose               :	Plot My Views link and dropdown
        ' Description           :	R. No. WAF3_PB_24
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	July 12, 2006 
        ' Revisions             :
        '=====================================================================
        If m_cObjCLSQL.EnableViews = False Then Return ""
        Dim strTagID As String = CStr(m_objGlobal.TagID)
        Dim strUserID As String = CStr(m_objGlobal.UserID)
        Dim strViewsKey As String = strUserID + "-" + CStr(m_objGlobal.LoginType) + "-VIEWS-" + strTagID
        Dim strMyViewID As String = UCase(CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(strViewsKey)))
        MyBase.InitializeResources("Resources.PB_Views", "Resources")
        PlotMyViews = "<A href=""javascript:MyViews('" + strTagID + Replace(m_strQuerystringDefaultParameters, "\""", """") + "')"">" + CommonFunctions.HTMLControls.DrawImage("../../Images/View.gif", "view", Tooltip:=MyBase.GetResourceString("VIEWS_TOOLTIP"), ReturnAsHTML:=True, Border:=0) + "</A>&nbsp;"  'RequestID : 272 UJ 13 Aug 2007
        PlotMyViews += CommonFunctions.HTMLControls.DrawComboBox("cboMyViews", "usp_Sel_tbl_UI_Views_ForCombo " + strTagID + "," + strUserID, 200, strMyViewID, "onchange='javascript:cboMyViews_OnChange()'", ReturnAsHTML:=True)

        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
    End Function
    '###################################################################################################
    '____________________________ADDED BY UMESHJ ON 3 NOV 2004....PLOT GRAPH AND RELATED DATA ON LIST
    '###################################################################################################
#Region "PLOT LIST SECTIONS"

    Private Sub PlotSections()
        '=====================================================================
        ' Procedure Name        :	PlotSections
        ' Purpose               :	This function is used to plot the Page Sections
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 29, 2003 
        ' Revisions             :   PrasannaP on 30th May 2005
        '                           Issue ID 28888
        '=====================================================================
        Dim sbClientsideScript As New System.Text.StringBuilder("")
        Dim sbExpandSections As New System.Text.StringBuilder(vbCrLf + " function " + FUNCTION_NAME_EXPAND_SECTION + "() { ")
        Dim intLength As Integer
        Dim intIndex As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        Dim intNoOfActiveSections As Integer = 0

        'Dim blnNumericPaging As Boolean'WAF3_PB_42 April 09, 2007 UmeshJ

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'Tag Sections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-1")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
            End If
        End If
        If objSection Is Nothing Then Return
        intLength = objSection.Length - 1
        Dim strcssDivClass As String = ""
        'm_cObjCLSQL.FreezeHeader
        If True Then
            'Commented Out:RajeshB
            'strcssDivClass = " class='clsScrollableDIV' onscroll='scrollME(this)'"
        End If
        'Commented Out:RajeshB  
        ' HttpContext.Current.Response.Write("<DIV Id=" + DIV_TAG + strcssDivClass + " Style=" & Chr(34) + "overflow:auto;height:400px;width:100%" + Chr(34) + ">")
        'Added By NileshD on 8 Feb 2006 For SuportRequestID :99

        'blnNumericPaging = NumericPagingEnabled()'WAF3_PB_42 April 09, 2007 UmeshJ

        If m_cObjCLSQL.AllowNumericPaging = False Then 'WAF3_PB_42 April 09, 2007 UmeshJ
            If CommonFunctions.General.IsClientBrowserIE = True Then
                HttpContext.Current.Response.Write("<DIV Id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:500px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            Else
                HttpContext.Current.Response.Write("<DIV Id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:450px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            End If
        End If
        'End of addition By NileshD on 8 Feb 2006 For SuportRequestID :99
        'Get the Number of active sections
        For intIndex = 0 To intLength
            '_________##### Number of active LIST page sections
            If objSection(intIndex).IsActiveCL = True And objSection(intIndex).DisplayPosition <> CommonFunctions.Constants.SECTION_DISPLAY_POSITION_UI.ToString Then intNoOfActiveSections += 1
        Next

        For intIndex = 0 To intLength
            If objSection(intIndex).IsActiveCL = True And IsCLSection(objSection(intIndex).SectionID) Then   '_________##### If it is a LIST page SECTION
                'If the Div Height is not specified in the div style then apply it from the
                'value specified in the Height property
                Dim lngDivHeight As Long
                Dim strDivStyle As String = "overflow:auto;width:99.9%;"
                Dim strSectionTag As String = "divSection" + objSection(intIndex).SectionID.ToString
                Dim strFunctionName As String = "showHide_" + strSectionTag

                Dim blnCancelSection As Boolean = False
                'Create object of the Section Structure
                Dim Section As EventHandlers.WAF_Section = PrepareSectionObject(objSection(intIndex).SectionID, objSection(intIndex).TagSectionID, objSection(intIndex).HeightCL, objSection(intIndex).OrderNumberCL, objSection(intIndex).IsActiveCL, objSection(intIndex).ShowSectionTitleCL, objSection(intIndex).SectionTitleCL, objSection(intIndex).SectionTitleAlignmentCL, strSectionTag, strFunctionName)
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "Before_PlotSection")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    ExtensionArgs.PrimaryKey = ""
                    ExtensionArgs.m_Section = Section
                    ExtensionArgs.Cancel = blnCancelSection
                    ExtensionArgs.m_global = m_objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "Before_PlotSection", ExtensionArgs)

                    blnCancelSection = ExtensionArgs.Cancel
                    Section = ExtensionArgs.m_Section
                    m_objGlobal = ExtensionArgs.m_global
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    'Call the Before plot section event...pass the section structure by ref
                    'Code Modified:RajeshB      19 Jan 2005
                    ' Purpose:Wrap the call into an overridable function

                    Call Before_PlotSection(blnCancelSection, Section, m_objGlobal, "")
                End If
                'addition ends.
                'If the only one section present then directly plot the grid
                If blnCancelSection = False And intNoOfActiveSections > 1 Then
                    sbExpandSections.Append(vbCrLf + Section.FunctionName + "(""none"");")
                    'For each Section - Plot Section Header
                    'Create object of the Section Structure for sectionTitle
                    Dim SectionTitle As EventHandlers.WAF_Section = PrepareSectionObject(Section.SectionID, Section.TagSectionID, Section.Height, Section.OrderNumber, Section.IsActive, Section.ShowSectionTitle, Section.SectionTitle, Section.SectionTitleAlignment, Section.DivSectionTag, Section.FunctionName)
                    Dim blnCancelSectionTitle As Boolean = False
                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised
                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSectionTitle")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.Cancel = blnCancelSectionTitle
                        ExtensionArgs.PrimaryKey = ""
                        ExtensionArgs.m_Section = SectionTitle
                        ExtensionArgs.m_global = m_objGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSectionTitle", ExtensionArgs)

                        blnCancelSectionTitle = ExtensionArgs.Cancel
                        SectionTitle = ExtensionArgs.m_Section
                        m_objGlobal = ExtensionArgs.m_global
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************
                        'Code Modified:RajeshB      19 Jan 2005
                        ' Purpose: Wrap the call into an overridable function
                        'Call the Before plot sectionTitle event...pass the sectionTitle structure by ref
                        Call Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, "")
                    End If
                    'addition ends.
                    If blnCancelSectionTitle = False Then
                        sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID))
                    End If
                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised

                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSectionTitle")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.PrimaryKey = ""
                        ExtensionArgs.m_Section = SectionTitle
                        ExtensionArgs.m_global = m_objGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSectionTitle", ExtensionArgs)

                        blnCancelSection = ExtensionArgs.Cancel
                        SectionTitle = ExtensionArgs.m_Section
                        m_objGlobal = ExtensionArgs.m_global
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************
                        'Code Modified:RajeshB      19 Jan 2005
                        ' Purpose: Wrap the call into overridable function
                        'Call after print event for Section Title
                        Call After_PlotSectionTitle(SectionTitle, m_objGlobal, "")
                    End If
                    'addition ends.
                    SectionTitle = Nothing
                End If

                'Show/Hide the section according to user preferences
                If blnCancelSection = False And GetSectionPreferences(Section.SectionID) = 1 Then

                    lngDivHeight = Section.Height
                    If lngDivHeight <> 0 Then
                        strDivStyle += "HEIGHT:" & lngDivHeight.ToString.Trim & "px; "
                    End If

                    'Show the Section
                    Select Case Section.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER

                            'Dim strcssDivClass As String = ""
                            'Dim strDivID As String = Section.DivSectionTag
                            ''m_cObjCLSQL.FreezeHeader
                            'If True Then
                            '    strDivID = "clsScrollableDIV"
                            '    strcssDivClass = " class='clsScrollableDIV'"
                            'End If
                            'HttpContext.Current.Response.Write("<DIV Id=" + strDivID + strcssDivClass + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")

                            Call PlotGrid()

                            '-------------------------------------------------------------------------------------------------------------
                            'Commented By - PushkarK On 15-May-2007 For Requirement ID - WAF3_PB_47
                            'Reason       - The DIV ending tag should be and will be plotted within the cPlotGrid's
                            '               PlotGrid method.
                            '-------------------------------------------------------------------------------------------------------------
                            'HttpContext.Current.Response.Write("</DIV>")
                            '-------------------------------------------------------------------------------------------------------------
                            'Comment Ends By - PushkarK On 15-May-2007 For Requirement ID - WAF3_PB_47
                            '-------------------------------------------------------------------------------------------------------------

                        Case CommonFunction.Constants.SECTION_GRAPH
                            ' **************************************************************************
                            ' Added Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
                            ' **************************************************************************
                            If lngDivHeight <> 0 Then
                                HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")
                            End If

                            'Plot graph section
                            Call PlotGraphs()
                            If lngDivHeight <> 0 Then
                                HttpContext.Current.Response.Write("</DIV>")
                            End If
                            ' **************************************************************************
                            ' End Addition Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
                            ' **************************************************************************
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            ' **************************************************************************
                            ' Added Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
                            ' **************************************************************************
                            If lngDivHeight <> 0 Then
                                HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")
                            End If

                            'Plot Related Data
                            Call PlotRelatedData()
                            If lngDivHeight <> 0 Then
                                HttpContext.Current.Response.Write("</DIV>")
                            End If
                            ' **************************************************************************
                            ' End Addition Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
                            ' **************************************************************************
                    End Select

                End If
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised

                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "After_PlotSection")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    ExtensionArgs.PrimaryKey = ""
                    ExtensionArgs.m_Section = Section
                    ExtensionArgs.m_global = m_objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "After_PlotSection", ExtensionArgs)

                    Section = ExtensionArgs.m_Section
                    m_objGlobal = ExtensionArgs.m_global
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    'Code Modified:RajeshB      19 Jan 2005
                    ' Wrap the call into an overridable function
                    'After plotting the section call the After Print Event
                    Call After_PlotSection(Section, m_objGlobal, "")
                End If
                'addition ends.
                Section = Nothing
            End If
        Next
        sbExpandSections.Append(vbCrLf + "}" + vbCrLf)
        HttpContext.Current.Response.Write("</DIV>")
        m_strSectionClientsideScript = sbExpandSections.ToString + sbClientsideScript.ToString
        sbClientsideScript = Nothing
        sbExpandSections = Nothing
        objSection = Nothing

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Public Overridable Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSection(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSectionTitle(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotSectionTitle(ByVal Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.After_PlotSectionTitle(Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotSection(ByVal Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.After_PlotSection(Args, WhizGlobal, "")
    End Sub
    Private Function PrepareSectionObject(ByVal SectionID As Long, ByVal TagSectionID As Long, ByVal Height As Long, ByVal OrderNumber As Long, ByVal IsActive As Boolean, ByVal ShowSectionTitle As Boolean, ByVal SectionTitle As String, ByVal SectionTitleAlignment As String, ByVal DivSectionTag As String, ByVal FunctionName As String) As EventHandlers.WAF_Section
        '=====================================================================
        ' Procedure Name        :	PrepareSectionObject
        ' Purpose               :	Prepare Section Object will be used for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	Section Object
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 09, 2004
        ' Revisions             :
        '=====================================================================
        Dim Section As EventHandlers.WAF_Section
        With Section
            .TagSectionID = TagSectionID
            .SectionID = SectionID
            .OrderNumber = OrderNumber
            .Height = Height
            .ShowSectionTitle = ShowSectionTitle
            .IsActive = IsActive
            If ShowSectionTitle = True Then
                .SectionTitle = SectionTitle
            Else
                .SectionTitle = ""
            End If
            .SectionTitleAlignment = SectionTitleAlignment
            .DivSectionTag = DivSectionTag
            .FunctionName = FunctionName
            .DisplayPosition = CommonFunctions.Constants.SECTION_DISPLAY_POSITION_LIST
        End With
        'Return the object 
        PrepareSectionObject = Section
    End Function

    Private Function PlotSectionTitle(ByVal strSectionTitle As String, ByVal divID_SectionTag As String, ByVal FunctionName As String, ByVal Alignment As String, ByVal SectionID As Long, Optional ByVal blnSaveUserPreferences As Boolean = True, Optional ByVal AllowHideShow As Boolean = True) As String
        '=====================================================================
        ' Procedure Name        :	PlotSectionTitle
        ' Purpose               :	Plot the Section Title
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Dim strLeftSectionTitle As String
        Dim strRightSectionTitle As String
        Dim strMiddleSectionTitle As String
        'According to the Section Title Alignment set the Section Title as LEFT/RIGHT/CENTER
        Select Case Alignment.ToUpper
            Case "LEFT" : strLeftSectionTitle = strSectionTitle
            Case "RIGHT" : strRightSectionTitle = strSectionTitle
            Case "CENTER" : strMiddleSectionTitle = strSectionTitle
            Case Else : strLeftSectionTitle = strSectionTitle
        End Select
        'Create object of the Section Title class from the Templates
        m_cObjSectionTitle = New WebPage.Templates.SectionTitle

        With m_cObjSectionTitle
            If blnSaveUserPreferences = False Then
                Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, , , , , , , AllowHideShow))
                PlotSectionTitle = .ClientsideScript
            Else
                If GetSectionPreferences(SectionID) = 1 Then
                    Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, , , , , , True))
                Else
                    Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, "../../Images/plus.gif", , , , , True))
                End If
                PlotSectionTitle = WriteClientsideScript_SectionShowHide(SectionID, FunctionName)
            End If
        End With
        'Destroy the object
        m_cObjSectionTitle = Nothing
    End Function

    Private Function GetSectionPreferences(ByVal lngSectionID As Long) As Byte
        '=====================================================================
        ' Procedure Name        :	GetSectionPreferences
        ' Purpose               :	Get Section Preferences
        ' Description           :	Same as above
        ' Parameters Passed     :	lngSectionID - section ID
        ' Parameters Affected   :	None.
        ' Returns               :	User Preferences for the section(0-hide,1-show)
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        GetSectionPreferences = 0
        Dim intIndex As Integer
        Dim intLength As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        'Master.............>TAG
        'Tag Sections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(m_objGlobal.TagID.ToString + CType(m_objGlobal.LCID, String) + "-1")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-1")
            End If
        End If
        If objSection Is Nothing Then Return 0
        intLength = objSection.Length - 1
        For intIndex = 0 To intLength
            If objSection(intIndex).SectionID = lngSectionID And objSection(intIndex).IsActiveCL = True Then
                'The section is active
                Select Case lngSectionID
                    Case CommonFunction.Constants.SECTION_HEADER
                        GetSectionPreferences = m_cObjCLSQL.SectionPreferences(0)
                        Exit For
                    Case CommonFunction.Constants.SECTION_GRAPH
                        GetSectionPreferences = m_cObjCLSQL.SectionPreferences(2)
                        Exit For
                    Case CommonFunction.Constants.SECTION_RELATED_DATA
                        GetSectionPreferences = m_cObjCLSQL.SectionPreferences(3)
                        Exit For
                End Select
            End If
        Next
        'Destroy the object
        objSection = Nothing
    End Function

    Private Function WriteClientsideScript_SectionShowHide(ByVal lngSectionID As Long, ByVal functionName As String) As String
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SectionShowHide
        ' Purpose               :	Write Clientside Script for section hide show
        ' Description           :	Same as above
        ' Parameters Passed     :	SectionID and functionName
        ' Parameters Affected   :	None.
        ' Returns               :	WriteClientsideScript for SectionShowHide
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 26, 2003
        ' Revisions             :
        '=====================================================================
        Dim bytValue As Byte = 0
        Dim sbSection As New System.Text.StringBuilder(vbCrLf + " function " + functionName + "() {")
        'Get the User Preference for the section
        bytValue = GetSectionPreferences(lngSectionID)
        'If the previous section preference is show then new section preference will be hide
        If bytValue = 1 Then
            bytValue = 0
        Else
            bytValue = 1
        End If
        'Prepare action accordingly
        If m_strCommonQueryString.Trim = "" Then
            sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strListPage & "?Operation=SHOW_HIDE&ListSectionID=" + lngSectionID.ToString + "&ListSectionIDValue=" + bytValue.ToString & Chr(34))
        Else
            sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strListPage & "?Operation=SHOW_HIDE&ListSectionID=" + lngSectionID.ToString + "&ListSectionIDValue=" + bytValue.ToString + "&" & m_strCommonQueryString & Chr(34))
        End If
        sbSection.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
        sbSection.Append(vbCrLf + "}")
        WriteClientsideScript_SectionShowHide = sbSection.ToString
        sbSection = Nothing
    End Function
#End Region
    '###################################################################################################
    '____________________________END OF ADDITION
    '###################################################################################################


    ' **************************************************************************
    ' Added Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11 & WAF2_PB_12
    ' **************************************************************************

    Private Sub PlotGraphs()
        '=====================================================================
        ' Procedure Name        :	PlotGraphs
        ' Purpose               :	Plot the section : Graphs
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Umesh Joshi/Rajanikant Khethawatt
        ' Created               :	November 05, 2004 
        ' Revisions             :   PrasannaP on 30th May IssueID 28888
        '=====================================================================
        'Create Hash Table object for Related Data
        Dim objGraphHashTable() As CommonEngines.HashTables.UIGraphs
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Same Culture ID as default
            objGraphHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIGraphObject(m_objGlobal.TagID)
        Else
            'Culture ID is different 
            objGraphHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIGraphObject(m_objGlobal.TagID + m_objGlobal.LCID)
            If objGraphHashTable Is Nothing Then
                'Culture not supported ...use default
                objGraphHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIGraphObject(m_objGlobal.TagID)
            End If
        End If

        If objGraphHashTable Is Nothing Then
            ' there are no items to show
            Call WriteNoItemsToShow(CommonFunction.Constants.SECTION_GRAPH)
            Return
        End If

        Dim intIndex As Integer
        Dim intLastIndex As Integer = objGraphHashTable.Length - 1
        Dim objGraph As Graph.Graph 'Modified By PushkarK On 03-Oct-2007
        Dim strVirtualImgPath As String = ""
        Dim strImageFileName As String = ""
        Dim intRowGraphCnt As Integer = 0
        'Modified by PrasannaP on 30th May 2005
        'Issue ID 28888
        'CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0>")
        CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0 width='99.9%'>")
        'Modification Ends
        CommonFunction.General.WriteHTML("<TR><TD")
        For intIndex = 0 To intLastIndex

            If objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_LIST.ToString Or objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_BOTH.ToString Then
                'Plot graph on same row or next row
                If (intRowGraphCnt Mod 2 = 0) Then
                    intRowGraphCnt = 1
                    If intIndex > 0 Then CommonFunction.General.WriteHTML("</TD></TR><TR><TD")

                    If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                        CommonFunction.General.WriteHTML(" colspan=2 ")
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                Else
                    If objGraphHashTable(intIndex - 1).WidthInPixel > 500 Then
                        'Next Line
                        CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                            intRowGraphCnt = 2
                        Else
                            intRowGraphCnt = 1
                        End If
                    Else
                        'Same line
                        CommonFunction.General.WriteHTML("</TD><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Then
                            CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                        End If
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                End If
                'End If
                'Modified By NileshD on 9 Jan 2006
                'Added more elements in the array.
                Dim arrType As String() = {objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type}
                'Image Path
                strImageFileName = CommonFunction.FileDirectory.GetUniqueFileName
                strVirtualImgPath = CommonFunction.Constants.CLCP_IMAGES_FOLDER_PATH + "/" + strImageFileName
                Dim ChartAreaGradientStyle As String
                Dim PieChartLabelStyle As String
                If objGraphHashTable(intIndex).Type.ToUpper = "PIE" Then
                    ChartAreaGradientStyle = "Center"
                    PieChartLabelStyle = objGraphHashTable(intIndex).PiChartLabelStyle
                Else
                    ChartAreaGradientStyle = "TopBottom"
                    PieChartLabelStyle = ""
                End If

                Dim blnCancelGraph As Boolean = False
                Dim oGraph As EventHandlers.WAF_Graph
                oGraph = PrepareGraphObject(arrType, ReplacePlaceHolders(objGraphHashTable(intIndex).StoredProcedure, "", m_objGlobal), strVirtualImgPath, _
                    Server.MapPath(strVirtualImgPath), m_strConnectionString, "white", objGraphHashTable(intIndex).BorderStyle, objGraphHashTable(intIndex).ChartAreaColor, _
                    objGraphHashTable(intIndex).ChartBackColor, objGraphHashTable(intIndex).Enable3D, "white", objGraphHashTable(intIndex).BorderColor, "white", "TopBottom", "TopBottom", _
                    ChartAreaGradientStyle, PieChartLabelStyle, objGraphHashTable(intIndex).Title, New System.Drawing.Font(objGraphHashTable(intIndex).GraphTitleFont, 9, System.Drawing.FontStyle.Bold), "black", _
                    CType(objGraphHashTable(intIndex).WidthInPixel, Integer), CType(objGraphHashTable(intIndex).HeightInPixel, Integer), objGraphHashTable(intIndex).LegendCaptionColor, _
                    New System.Drawing.Font(objGraphHashTable(intIndex).LegendFont, 9, System.Drawing.FontStyle.Bold), "excel", objGraphHashTable(intIndex).ShowExplodedPiChart, objGraphHashTable(intIndex).ShowLegends, objGraphHashTable(intIndex).DisplayPosition)

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                oGraph.ConditionClause = ReplacePlaceHolders(objGraphHashTable(intIndex).ConditionClause, "", m_objGlobal)
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************

                'Call Before plot graph event
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                Call Before_PlotGraph(blnCancelGraph, oGraph, m_objGlobal, "")

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                ' Check the condition to plot the graph.
                Dim dr As IDataReader
                Dim blnPlotGraph As Boolean = True

                If Trim(oGraph.ConditionClause & "") <> "" Then
                    '==========================================================================================================
                    'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                    dr = CommonFunctions.Data.GetDataReader(oGraph.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), oGraph.ConnectionString)
                    ' Addition End By : Ninad   Req Id : WAF3_PB_33
                    '==========================================================================================================

                    If dr.Read Then
                        blnPlotGraph = True
                    Else
                        blnPlotGraph = False
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If

                ' Plot the grpah only when there are some rows returned by executin of the condition clause sql
                If blnPlotGraph Then
                    ' ***************************************************************************************
                    ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                    ' ***************************************************************************************
                    objGraph = New Graph.Graph 'Added By PushkarK On 03-Oct-2007
                    With objGraph
                        'Main properties
                        .ChartType = oGraph.ChartType
                        .SQL = oGraph.SQL
                        .VirtualImagePath = oGraph.VirtualImagePath
                        .AbsoluteImagePath = oGraph.AbsoluteImagePath
                        .ConnectionString = oGraph.ConnectionString
                        .LegendBackColor = "white"
                        'Other Properties
                        .BorderColor = oGraph.BorderColor
                        .BorderStyle = oGraph.BorderStyle
                        .ChartAreaColor = oGraph.ChartAreaColor
                        .ChartBackColor = oGraph.ChartBackColor
                        .Enable3D = oGraph.Enable3D
                        .ChartAreaGradientColor = oGraph.ChartAreaGradientColor
                        .BorderGradientColor = oGraph.BorderGradientColor
                        .ChartBackGradientColor = oGraph.ChartBackGradientColor
                        .ChartBackGradientStyle = oGraph.ChartBackGradientStyle
                        .BorderGradientStyle = oGraph.BorderGradientStyle
                        .ChartAreaGradientStyle = oGraph.ChartAreaGradientStyle
                        .PieChartLabelStyle = oGraph.PieChartLabelStyle
                        'Title Properties
                        .GraphTitle = oGraph.GraphTitle
                        .TitleFont = oGraph.TitleFont
                        .GraphTitleColor = oGraph.GraphTitleColor
                        .Width = oGraph.Width
                        .Height = oGraph.Height
                        .LegendCaptionColor = oGraph.LegendCaptionColor
                        .LegendFont = oGraph.LegendFont
                        .PalleteStyle = oGraph.PalletStyle
                        .ShowExplodedPie = oGraph.ShowExplodedPie
                        .ShowLegends = oGraph.ShowLegends
                        .EnableSmartLabels = oGraph.EnableSmartLabels
                        .ShowCaptions = oGraph.ShowCaptions
                        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
                        .XAxisInterval = 1
                        If blnCancelGraph = False Then
                            If oGraph.ChartType(0).ToUpper = "STACKEDBAR" Or oGraph.ChartType(0).ToUpper = "STACKEDCOLUMN" Then
                                .GenerateStackedGraphImage()
                            Else
                                .GenerateImage()
                            End If
                        End If
                    End With
                    If blnCancelGraph = False Then CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawImage(strVirtualImgPath + ".png", , , , , , , True))
                    objGraph.Dispose() : objGraph = Nothing 'Added By PushkarK On 03-Oct-2007
                    ' ***************************************************************************************
                    ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                    ' ***************************************************************************************
                End If
                ' ***************************************************************************************
                ' End Adddition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                'Call After plot graph event
                Call After_PlotGraph(oGraph, m_objGlobal, "")
            End If
        Next

        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        'Destroy the object
        objGraph = Nothing
        objGraphHashTable = Nothing
    End Sub
    Protected Overridable Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Graph.Before_PlotGraph(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotGraph(ByVal Args As EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Graph.After_PlotGraph(Args, WhizGlobal, "")
    End Sub

    Private Sub PlotRelatedData()
        '=====================================================================
        ' Procedure Name        :	PlotRelatedData
        ' Purpose               :	Plot the section : Related Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ / Rajanikant Khethawatt
        ' Created               :	November 05, 2004
        ' Revisions             :   
        '=====================================================================
        'Create Hash Table object for Related Data
        Dim objDataHashTable() As CommonEngines.HashTables.UIRelatedData
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Same Culture ID as default
            objDataHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIRelatedDataObject(m_objGlobal.TagID)
        Else
            'Culture ID is different 
            objDataHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIRelatedDataObject(m_objGlobal.TagID + m_objGlobal.LCID)
            If objDataHashTable Is Nothing Then
                'Culture not supported ...use default
                objDataHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIRelatedDataObject(m_objGlobal.TagID)
            End If
        End If

        If objDataHashTable Is Nothing Then
            Return
        End If

        Dim intIndex As Integer
        Dim intLastIndex As Integer = objDataHashTable.Length - 1
        For intIndex = 0 To intLastIndex

            If objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_LIST.ToString Or objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_BOTH.ToString Then

                Dim RelatedDataDivID As String = "RelatedData_DivList" + intIndex.ToString

                'Data Header
                Dim objHeader As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
                Dim blnCancelHeader As Boolean = False
                objHeader = PrepareRelatedDataHeaderObject(objDataHashTable(intIndex).DataHeader.Trim, objDataHashTable(intIndex).DataHeaderAlignment.Trim, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).UniqueID)

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                ' set the condition clause of the object
                objHeader.ConditionClause = objDataHashTable(intIndex).ConditionClause
                'Added By UmeshJ Aug 03, 2007
                objHeader.ConditionClause = ReplacePlaceHolders(objHeader.ConditionClause, "", m_objGlobal)
                'End of Addition
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************
                'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                ExtensionArgs.Cancel = blnCancelHeader
                ExtensionArgs.m_RelatedDataHeader = objHeader
                ExtensionArgs.m_global = m_objGlobal
                ExtensionArgs.PrimaryKey = ""

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                        "Before_PlotRelatedDataHeader", ExtensionArgs)

                objHeader = ExtensionArgs.m_RelatedDataHeader
                blnCancelHeader = ExtensionArgs.Cancel
                m_objGlobal = ExtensionArgs.m_global
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                'Call the Before Print Event for Related Data Header
                'Code Modified:RajeshB      19 Jan 2005
                'Wrap the call into an overridable function
                Call Before_PlotRelatedDataHeader(blnCancelHeader, objHeader, m_objGlobal, "")
                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************

                ' Check the condition to plot the related data info.
                Dim dr As IDataReader
                Dim blnPlotHeader As Boolean = True

                If Trim(objHeader.ConditionClause & "") <> "" Then
                    '==========================================================================================================
                    'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                    dr = CommonFunctions.Data.GetDataReader(objHeader.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
                    ' Addition End By : Ninad   Req Id : WAF3_PB_33
                    '==========================================================================================================
                    If dr.Read Then
                        blnPlotHeader = True
                    Else
                        blnPlotHeader = False
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If

                ' Plot the header only when there are some rows returned by execution of the condition clause sql
                If blnPlotHeader Then
                    If blnCancelHeader = False Then Call RelatedData_Header(objHeader.DataHeader, objHeader.DataHeaderAlignment)
                End If
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                '***************************************************************************************
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************   


                ExtensionArgs.m_RelatedDataHeader = objHeader
                ExtensionArgs.m_global = m_objGlobal
                ExtensionArgs.PrimaryKey = ""

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                        "After_PlotRelatedDataHeader", ExtensionArgs)

                objHeader = ExtensionArgs.m_RelatedDataHeader
                m_objGlobal = ExtensionArgs.m_global
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                'Code Modified:RajeshB          19 Jan 2005
                ' Purpose:Wrap the event call into a function
                'Call the After Print Event for Related Data Header
                Call After_PlotRelatedDataHeader(objHeader, m_objGlobal, "")
                objHeader = Nothing

                'Related Data Grid
                ' ***************************************************************************************
                ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                ' Passing the condition clause to the routine to plot grid
                'Modified By UmeshJ Aug 03, 2007
                Call RelatedData_Grid(ReplacePlaceHolders(objDataHashTable(intIndex).DataGridSQL, "", m_objGlobal), RelatedDataDivID, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).UniqueID, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).ConditionClause, Not (objDataHashTable(intIndex).VerticalDisplay), objDataHashTable(intIndex).DisplayPosition)
                'End of Modification
                ' ***************************************************************************************
                ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                'Separator HTML Tag
                If intIndex < intLastIndex Then Response.Write(CommonFunction.General.CheckIsNothing(objDataHashTable(intIndex).SeperatorHTMLTag))
            End If
        Next
        'Destroy the object
        objDataHashTable = Nothing
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataHeader(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotRelatedDataHeader(ByVal Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataHeader(Args, WhizGlobal, "")
    End Sub
    Private Sub WriteNoItemsToShow(ByVal intSectionID As Integer)
        '=====================================================================
        ' Procedure Name        :	WriteNoItemsToShow
        ' Purpose               :	Write user friendly message as No Items To Show
        ' Description           :	Same as above
        ' Parameters Passed     :	lngSectionID - section ID
        ' Parameters Affected   :	None.
        ' Returns               :	none
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 08, 2003
        ' Revisions             :   Modified by PrasannaP on 30th May 2005 Issue ID 28888
        '=====================================================================
        Dim strUserMessage As String
        Select Case intSectionID
            Case CommonFunction.Constants.SECTION_SUBTAG
                'Message for Sub Tag
                strUserMessage = MyBase.GetResourceString("NO_RECORDS")
            Case CommonFunction.Constants.SECTION_GRAPH
                'Message for Graph
                strUserMessage = MyBase.GetResourceString("NO_RECORDS")
            Case CommonFunction.Constants.SECTION_RELATED_DATA
                'Message for Related Data
                strUserMessage = MyBase.GetResourceString("NO_RECORDS")
        End Select
        'Plot table to inform the user that there are no record
        'Modified by PrasannaP on 30th May 2005
        'Issue ID 28888
        'CommonFunction.General.WriteHTML("<Table class=clsTable width='100%' cellspacing=0 border=0>")
        CommonFunction.General.WriteHTML("<Table class=clsTable width='99.9%' cellspacing=0 border=0>")
        'End Modification
        CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=center>" + strUserMessage)
        CommonFunction.General.WriteHTML("</TD></TR></Table>")
    End Sub

    Private Function PrepareGraphObject(ByVal ChartType As String(), ByVal SQL As String, ByVal VirtualImagePath As String, ByVal AbsoluteImagePath As String, ByVal ConnectionString As String, ByVal BorderColor As String, ByVal BorderStyle As String, ByVal ChartAreaColor As String, ByVal ChartBackColor As String, ByVal Enable3D As Boolean, ByVal ChartAreaGradientColor As String, ByVal BorderGradientColor As String, ByVal ChartBackGradientColor As String, ByVal ChartBackGradientStyle As String, ByVal BorderGradientStyle As String, ByVal ChartAreaGradientStyle As String, ByVal PieChartLabelStyle As String, ByVal GraphTitle As String, ByVal TitleFont As System.Drawing.Font, ByVal GraphTitleColor As String, ByVal Width As Integer, ByVal Height As Integer, ByVal LegendCaptionColor As String, ByVal LegendFont As System.Drawing.Font, ByVal PalletStyle As String, ByVal ShowExplodedPie As Boolean, ByVal ShowLegends As Boolean, ByVal DisplayPosition As String) As EventHandlers.WAF_Graph
        '=====================================================================
        ' Procedure Name        :	PrepareGraphObject
        ' Purpose               :	Prepare Graph Object for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 10, 2004
        ' Revisions             :   Rajanikant Khethawatt - Added DisplayPosition 
        '                           param and set the property
        '=====================================================================
        Dim objGraph As EventHandlers.WAF_Graph
        With objGraph
            .AbsoluteImagePath = AbsoluteImagePath
            .BorderColor = BorderColor
            .BorderGradientColor = BorderGradientColor
            .BorderGradientStyle = BorderGradientStyle
            .BorderStyle = BorderStyle
            .ChartAreaColor = ChartAreaColor
            .ChartAreaGradientColor = ChartAreaGradientColor
            .ChartAreaGradientStyle = ChartAreaGradientStyle
            .ChartBackColor = ChartBackColor
            .ChartBackGradientColor = ChartBackGradientColor
            .ChartBackGradientStyle = ChartBackGradientStyle
            .ChartType = ChartType
            .ConnectionString = ConnectionString
            .Enable3D = Enable3D
            .GraphTitle = GraphTitle
            .GraphTitleColor = GraphTitleColor
            .Height = Height
            .LegendCaptionColor = LegendCaptionColor
            .LegendFont = LegendFont
            .PalletStyle = PalletStyle
            .PieChartLabelStyle = PieChartLabelStyle
            .ShowExplodedPie = ShowExplodedPie
            .ShowLegends = ShowLegends
            .SQL = SQL
            .TitleFont = TitleFont
            .VirtualImagePath = VirtualImagePath
            .Width = Width
            .EnableSmartLabels = True
            .ShowCaptions = True
            .DisplayPosition = DisplayPosition
        End With
        PrepareGraphObject = objGraph
    End Function

    Private Function ReplacePlaceHolders(ByVal strInput As String, ByVal strUniqueValue As String, ByVal WhizGlobal As WebPages.Template.IGlobal) As String
        '=====================================================================
        ' Procedure Name        :	ReplacePlaceHolders
        ' Purpose               :	Replace the Place Holders by actual values
        ' Description           :	Same as above
        ' Parameters Passed     :	strInput- input string, strUniqueValue - unique value
        ' Parameters Affected   :	None.
        ' Returns               :	String with actual values for the place holders
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Thursday, September 11, 2003 
        ' Revisions             :
        '=====================================================================
        If strInput = "" Then Return ""
        strInput = CommonFunction.General.ReplacePlaceHolders(strInput)
        'Replace By Unique Value
        strInput = Microsoft.VisualBasic.Replace(strInput, "<UNIQUE_ID>", strUniqueValue)

        'Replace by Server Date
        strInput = Microsoft.VisualBasic.Replace(strInput, "<SERVER_DATE>", CommonFunction.Dates.GetDate(Date.Now).ToString)
        If m_objGlobal.ParentTagID <> 0 Then
            strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", WhizGlobal.ParentTagID.ToString)
            strInput = Microsoft.VisualBasic.Replace(strInput, "<SUBTAG_ID>", WhizGlobal.TagID.ToString)
        Else
            strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", WhizGlobal.TagID.ToString)
        End If
        'Added By - NinadP On - 25 Feb 2008 Support Req. ID. - 19143
        'Query string place holders
        If InStr(strInput, "<#", CompareMethod.Text) <> 0 Then
            'For these place holders check the syntax <#PLACE_HOLDER>
            'Place holder exists e.g. usp_sel 4545,<#DataId>,<#Data2>
            Dim arrInput() As String = Split(strInput, "<")
            Dim intIndex As Integer
            Dim intLastIndex As Integer = arrInput.Length - 1
            For intIndex = 0 To intLastIndex
                'For each item in the array
                If Left(arrInput(intIndex), 1) = "#" Then
                    'if first character is # then it is a Query String Place holder
                    Dim arrPlaceHolder() As String = Split(arrInput(intIndex), ">")
                    If arrPlaceHolder.Length = 2 Then
                        'First item will be #PLACE_HOLDER and Second will be some string
                        arrPlaceHolder(0) = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request(Right(arrPlaceHolder(0), arrPlaceHolder(0).Length - 1)))
                        arrInput(intIndex) = Join(arrPlaceHolder, "")
                    Else
                        'Not a valid Place holder
                        If intIndex > 0 Then arrInput(intIndex) = "<" + Join(arrPlaceHolder, ">")
                    End If
                Else
                    If intIndex > 0 Then
                        'Not a valid Place holder
                        arrInput(intIndex) = "<" + arrInput(intIndex)
                    End If
                End If
            Next
            'Recreate the query
            strInput = Join(arrInput, "")
        End If
        'End Addition By - NinadP On - 25 Feb 2008 Support Req. ID. - 19143

        Return strInput
    End Function

    Private Function PrepareRelatedDataHeaderObject(ByVal DataHeader As String, ByVal DataHeaderAlignment As String, ByVal OrderNumber As Long, ByVal QRBQueryID As Long, ByVal UniqueID As Long) As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
        '=====================================================================
        ' Procedure Name        :	PrepareRelatedDataHeaderObject
        ' Purpose               :	Prepare Related Data Header Object for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim objDataHeader As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
        With objDataHeader
            .DataHeader = DataHeader
            .DataHeaderAlignment = DataHeaderAlignment
            .OrderNumber = OrderNumber
            .QRBQueryID = QRBQueryID
            .UniqueID = UniqueID
        End With
        PrepareRelatedDataHeaderObject = objDataHeader
    End Function

    Private Sub RelatedData_Header(ByVal DataHeader As String, ByVal Align As String)
        '=====================================================================
        ' Procedure Name        :	RelatedData_Header
        ' Purpose               :	Related Data Header
        ' Description           :	Same as above
        ' Parameters Passed     :	DataHeader, AlignMent
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003
        ' Revisions             :
        '=====================================================================
        If DataHeader.Trim = "" Then Return
        Dim cObjPageCaption As New WebPages.UI.cPageCaption
        Dim WhizGlobal As New WebPages.Template.WhizGlobal
        WhizGlobal.TagID = -1
        WhizGlobal.ParentTagID = -1
        With cObjPageCaption
            .clsTable = "clsTable"
            .clsTR = "clsTRPageCaption"
            .returnHTML = True
            .LeftPageCaption = "" : .RightPageCaption = "" : .MiddlePageCaption = ""
            Select Case CommonFunction.General.CheckIsNothing(Align.ToUpper)
                Case "LEFT"
                    'Plot Left Data Header
                    .LeftPageCaption = DataHeader
                Case "RIGHT"
                    'Plot Right Data Header
                    .RightPageCaption = DataHeader
                Case "CENTER"
                    'Plot Center Data Header
                    .MiddlePageCaption = DataHeader
                Case ""
                    'No caption
                Case Else
                    'Plot Left Data Header
                    .LeftPageCaption = DataHeader
            End Select
            Response.Write(.DrawPageCaption())
        End With
        Response.Write("<BR>")
        'Destroy the object
        WhizGlobal = Nothing
        cObjPageCaption = Nothing
    End Sub

    Private Sub RelatedData_Grid(ByVal GridSQL As String, ByVal RelatedDataDivID As String, ByVal OrderNumber As Long, ByVal UniqueID As Long, ByVal QRBQueryID As Long, ByVal ConditionClause As String, Optional ByVal VerticalDisplay As Boolean = True, Optional ByVal DisplayPosition As String = "0")
        '=====================================================================
        ' Procedure Name        :	RelatedData_Grid
        ' Purpose               :	Plot Related Data Grid
        ' Description           :	Same as above
        ' Parameters Passed     :	GridSQL - SQL to plot the grid
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003
        ' Revisions             :   Aug 30,2004 Rajanikant Khethawatt
        '                           Added param cond. clause WAF2_PB_43
        '=====================================================================
        'Get the plot Grid Query after replacing the place holders
        GridSQL = ReplacePlaceHolders(GridSQL, "", m_objGlobal)

        'Plot Grid
        Dim strGRID As String = ""
        Dim strSortBy As String = ""
        Dim strSortOrder As String = ""
        Dim intDataColumns As Integer
        'Arraylist columns
        Dim arrListUFName As New System.Collections.ArrayList
        Dim arrListActualName As New System.Collections.ArrayList
        Dim arrListCheckBox As New System.Collections.ArrayList
        Dim arrListTDStyle As New System.Collections.ArrayList
        'Get Grid Columns

        'Added By PushkarK On 14-Nov-2007 for SRID: 287 and IssueID: 16575
        'Used DataSet and DataTable instead of DataReader so that the grid-sql will be fired only once
        'The same data table will be used for both, to get columns and to pass to the Grid-component.
        Dim dsGrid As DataSet = CommonFunction.Data.GetDataSet(GridSQL, "_RelatedDataGrid", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
        Dim dtGrid As DataTable = dsGrid.Tables("_RelatedDataGrid")
        dsGrid.Dispose() : dsGrid = Nothing
        intDataColumns = dtGrid.Columns.Count()
        Dim intIndex As Integer
        Dim intLastIndex As Integer = intDataColumns - 1
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        For intIndex = 0 To intLastIndex
            'User Friendly Column Name
            arrListUFName.Add(dtGrid.Columns(intIndex).ColumnName)
            'Actual Column Name
            arrListActualName.Add(dtGrid.Columns(intIndex).ColumnName)
            'Check Box ...blank entry
            arrListCheckBox.Add("")
            'TD Style
            arrListTDStyle.Add(" align=" + RelatedData_GetAlignmentByType(dtGrid.Columns(intIndex).DataType.ToString()) + " ")
        Next
        'Addition Ends By PushkarK On 14-Nov-2007 for SRID: 287 and IssueID: 16575


        'Commented By PushkarK On 14-Nov-2007 for SRID: 287 and IssueID: 16575

        ''==========================================================================================================
        ''Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
        'Dim drGrid As IDataReader = CommonFunction.Data.GetDataReader(GridSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
        '' Addition End By : Ninad   Req Id : WAF3_PB_33
        ''==========================================================================================================

        'intDataColumns = drGrid.FieldCount()
        'Dim intIndex As Integer
        'Dim intLastIndex As Integer = intDataColumns - 1
        ''Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        'Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'For intIndex = 0 To intLastIndex
        '    'User Friendly Column Name
        '    arrListUFName.Add(drGrid.GetName(intIndex))
        '    'Actual Column Name
        '    arrListActualName.Add(drGrid.GetName(intIndex))
        '    'Check Box ...blank entry
        '    arrListCheckBox.Add("")
        '    'TD Style
        '    arrListTDStyle.Add(" align=" + RelatedData_GetAlignment(CType(drGrid.GetDataTypeName(intIndex), String)) + " ")
        'Next

        'Comment Ends By PushkarK On 14-Nov-2007 for SRID: 287 and IssueID: 16575

        'Convert ArrayList into String Array : User Friendly Column Names
        Dim arrUFName(arrListUFName.Count - 1) As String
        arrListUFName.ToArray.CopyTo(arrUFName, 0)

        'Actual Column Name
        Dim arrActualName(arrListActualName.Count - 1) As String
        arrListActualName.ToArray.CopyTo(arrActualName, 0)

        'Check Box
        Dim arrCheckBox(arrListCheckBox.Count - 1) As String
        arrListCheckBox.ToArray.CopyTo(arrCheckBox, 0)

        'TD Style
        Dim arrTDStyle(arrListTDStyle.Count - 1) As String
        arrListTDStyle.ToArray.CopyTo(arrTDStyle, 0)

        'Destroy the object
        'CommonFunction.Data.DisposeDataReader(drGrid) 'Commented By PushkarK On 14-Nov-2007 for SRID: 287 and IssueID: 16575

        arrListUFName = Nothing
        arrListActualName = Nothing
        arrListCheckBox = Nothing
        arrListTDStyle = Nothing

        'Call Before Print event for Grid
        Dim DataGrid As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid
        Dim blnCancelGrid As Boolean = False
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        DataGrid = PrepareRelatedDataGridObject(GridSQL, arrActualName, arrUFName, arrTDStyle, "cellspacing=0 cellpadding=0", OrderNumber, QRBQueryID, UniqueID, MyBase.GetResourceString("No"), MyBase.GetResourceString("Yes"), True, RelatedDataDivID, 300, "overflow:auto", MyBase.GetResourceString("NO_RECORDS"), intDataColumns, VerticalDisplay, DisplayPosition)
        ' ***************************************************************************************
        ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************
        ' replace the place-holders in the condition clause 
        DataGrid.ConditionClause = ReplacePlaceHolders(ConditionClause, "", m_objGlobal)
        ' ***************************************************************************************
        ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************

        MyBase.InitializeResources("Resources.CommonPage", "Resources")
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        ExtensionArgs.Cancel = blnCancelGrid
        ExtensionArgs.m_RelatedDataGrid = DataGrid
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.PrimaryKey = ""

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                "Before_PlotRelatedDataGrid", ExtensionArgs)

        DataGrid = ExtensionArgs.m_RelatedDataGrid
        blnCancelGrid = ExtensionArgs.Cancel
        m_objGlobal = ExtensionArgs.m_global

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Call the Before Print event for the Grid
        'Call the After Print Event for Related Data Header
        'Code Modified:RajeshB          19 Jan 2005
        ' Purpose:Wrap the event call into a function
        'Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataGrid(blnCancelGrid, DataGrid, m_objGlobal, "")
        Call Before_PlotRelatedDataGrid(blnCancelGrid, DataGrid, m_objGlobal, "")

        ' ***************************************************************************************
        ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************
        ' Check the condition to plot the related data info.
        Dim dr As IDataReader
        Dim blnPlotGrid As Boolean = True

        If Trim(DataGrid.ConditionClause & "") <> "" Then
            '==========================================================================================================
            'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
            dr = CommonFunctions.Data.GetDataReader(DataGrid.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            If dr.Read Then
                blnPlotGrid = True
            Else
                blnPlotGrid = False
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If

        ' Plot the grids only when there are some rows returned by executin of the condition clause sql
        If blnPlotGrid Then
            ' ***************************************************************************************
            ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
            ' ***************************************************************************************
            'Plot the grid
            m_objGrid = New WebPage.Templates.GenericGrid
            With m_objGrid
                '==========================================================================================================
                'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                .ConnectionString = m_strConnectionString
                ' Addition End By : Ninad   Req Id : WAF3_PB_33
                '==========================================================================================================
                .UserFriendlyColumnArray = DataGrid.UserFriendlyColumnArray
                .ActualColumnArray = DataGrid.ActualColumnArray
                .NoOfDataColumns = DataGrid.NoOfDataColumns
                .TDStyleArray = DataGrid.TDStyleArray
                .SQL = DataGrid.GridSQL
                .CheckBoxIDArray = arrCheckBox
                .DIVStyle = DataGrid.DIVStyle
                .DIVHeight = DataGrid.DIVHeight
                .DIVID = DataGrid.DivID
                .ColNameToolTipOnEachRow = DataGrid.ColNameToolTipOnEachRow
                .VerticalDisplay = DataGrid.VerticalDisplay
                .BooleanFalseHTML = DataGrid.BooleanFalseHTML  '|false | <img src='../../images/cross.gif'>
                .BooleanTrueHTML = DataGrid.BooleanTrueHTML  '|true | <img src='../../images/check.gif'>

                .PrinterFriendlyVersion = True
                .ColumnHeaderAlignment = "" 'Take alignment from the as of the row
                .SortOrder = strSortOrder
                .SortBy = strSortBy
                .ClientSideSortFunctionName = "" '"RelatedData_Sort_OnClick" ' without param. and brackets
                .returnHTML = True '| true
                .UseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                If GridSQL.ToUpper.Trim = DataGrid.GridSQL.ToUpper.Trim Then 'Added By Shrikant on 19 June 2008 IssueID 20608
                    .GridDataTable = dtGrid 'Added By PushkarK On 14-Nov-2007 for SRID: 287 and IssueID: 16575
                End If
                'Addition End By Shrikant On 19 June 2008 For Issue ID 20608

                If blnCancelGrid = False Then strGRID = m_objGrid.DrawGrid() ' Called from within the section below
            End With
            m_objGrid = Nothing
            CommonFunction.General.WriteHTML(strGRID)

            ' ***************************************************************************************
            ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
            ' ***************************************************************************************
        End If
        ' ***************************************************************************************
        ' End Adddition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************   

        'Code Added By NileshD on 13 Oct 2005 
        'ExtensionArgs object is not initialize again after setting to nothing.
        'So initializing again.
        ExtensionArgs = New CommonEngines.General.ExtensionArgs
        'End Of Addition By NileshD on 13 Oct 2005 

        ExtensionArgs.m_RelatedDataGrid = DataGrid
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.PrimaryKey = ""

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                "After_PlotRelatedDataGrid", ExtensionArgs)

        DataGrid = ExtensionArgs.m_RelatedDataGrid
        m_objGlobal = ExtensionArgs.m_global
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Call the Before Print event for the Grid
        'Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataGrid(DataGrid, m_objGlobal, "")
        Call After_PlotRelatedDataGrid(DataGrid, m_objGlobal, "")
        DataGrid = Nothing

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataGrid(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotRelatedDataGrid(ByVal Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataGrid(Args, WhizGlobal, "")
    End Sub

    Private Function PrepareRelatedDataGridObject(ByVal GridSQL As String, ByVal ActualColumnArray As String(), ByVal UserFriendlyColumnArray As String(), ByVal TDStyleArray As String(), ByVal TableStyle As String, ByVal OrderNumber As Long, ByVal QRBQueryID As Long, ByVal UniqueID As Long, ByVal BooleanFalseHTML As String, ByVal BooleanTrueHTML As String, ByVal ColNameToolTipOnEachRow As Boolean, ByVal DivID As String, ByVal DivHeight As Integer, ByVal DivStyle As String, ByVal NoDataComment As String, ByVal NoOfDataColumns As Integer, ByVal VerticalDisplay As Boolean, ByVal DisplayPosition As String) As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid
        '=====================================================================
        ' Procedure Name        :	PrepareRelatedDataGridObject
        ' Purpose               :	Prepare Related Data Grid Object for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 10, 2004
        ' Revisions             :   waf2_pb_12  Rajanikant Khethawatt Nov 05,2004
        '                           Added param/property DisplayPosition
        '=====================================================================
        Dim objDataGrid As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid
        With objDataGrid
            .GridSQL = GridSQL
            .ActualColumnArray = ActualColumnArray
            .UserFriendlyColumnArray = UserFriendlyColumnArray
            .TableStyle = TableStyle
            .TDStyleArray = TDStyleArray
            .NoOfDataColumns = NoOfDataColumns
            .BooleanFalseHTML = BooleanFalseHTML
            .BooleanTrueHTML = BooleanTrueHTML
            .ColNameToolTipOnEachRow = ColNameToolTipOnEachRow
            .DivID = DivID
            .DIVHeight = DivHeight
            .DIVStyle = DivStyle
            .OrderNumber = OrderNumber
            .QRBQueryID = QRBQueryID
            .UniqueID = UniqueID
            .NoDataComment = NoDataComment
            .VerticalDisplay = VerticalDisplay
            ' **************************************************************************
            ' Added Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
            ' **************************************************************************
            .DisplayPosition = DisplayPosition
            ' **************************************************************************
            ' End Addition Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11
            ' **************************************************************************
        End With
        PrepareRelatedDataGridObject = objDataGrid
    End Function

    Public Shared Function RelatedData_GetAlignmentByType(ByVal strDataType As String) As String
        '=====================================================================
        ' Procedure Name        :	RelatedData_GetAlignment
        ' Purpose               :	Determine the Column Alignment for the .Net Datatype
        ' Description           :	SRID: 287 and IssueID: 16575
        ' Parameters Passed     :	.Net DataType.
        ' Parameters Affected   :	None.
        ' Returns               :	Alignment
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	PushkarK
        ' Created               :	14-Nov-2007
        ' Revisions             :   
        '=====================================================================
        RelatedData_GetAlignmentByType = "Left"
        Select Case strDataType.Trim.ToUpper
            Case "SYSTEM.INT32", "SYSTEM.INT64", "SYSTEM.DOUBLE", "SYSTEM.INT16", "SYSTEM.DECIMAL", "SYSTEM.SINGLE", "SYSTEM.BYTE"
                'On For  "INT", "BIGINT", "FLOAT", "SMALLINT", ["DECIMAL" and  "NUMERIC" and "MONEY" and "SMALLMONEY"], "REAL", "TINYINT"
                'number are align right
                RelatedData_GetAlignmentByType = "Right"
            Case "SYSTEM.DATETIME", "SYSTEM.BOOLEAN", "SYSTEM.BYTE[]"
                'On for ["DATETIME" and "SMALLDATETIME"], "BIT", "TIMESTAMP"
                '"CHAR", "NCHAR" are not taken care of here.
                'date..bit..align center
                RelatedData_GetAlignmentByType = "Center"
            Case Else
                'Includes --> "SYSTEM.STRING"  "SYSTEM.BYTE[]" , "SYSTEM.GUID"
                'On for ["VARCHAR" and "NVARCHAR" and "TEXT" and "NTEXT"]  ,["IMAGE" and "VARBINARY" and "BINARY"] , "UNIQUEIDENTIFIER"
                '"SQL_VARIANT" and "SYSNAME" are not taken care of here.
                RelatedData_GetAlignmentByType = "Left"
        End Select
    End Function

    Private Function RelatedData_GetAlignment(ByVal strDataType As String) As String
        '=====================================================================
        ' Procedure Name        :	RelatedData_GetAlignment
        ' Purpose               :	Determine the Column Alignment for the Datatype
        ' Description           :	Same as above
        ' Parameters Passed     :	DataType.
        ' Parameters Affected   :	None.
        ' Returns               :	Alignment
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003 
        ' Revisions             :
        '=====================================================================
        RelatedData_GetAlignment = "Left"
        Select Case strDataType.Trim.ToUpper
            Case "FLOAT", "INT", "DECIMAL", "NUMERIC", "SMALLMONEY", "BIGINT", "REAL", "MONEY", "TINYINT", "SMALLINT"
                'number are align right
                RelatedData_GetAlignment = "Right"
            Case "DATETIME", "BIT", "CHAR", "NCHAR", "SMALLDATETIME", "TIMESTAMP"
                'date..bit..align center
                RelatedData_GetAlignment = "Center"
            Case Else
                'Includes --> "VARCHAR" ,"NVARCHAR"  ,"IMAGE" ,"TEXT" ,"UNIQUEIDENTIFIER" ,"SQL_VARIANT" ,"NTEXT" ,"VARBINARY" ,"BINARY"  ,"SYSNAME"
                RelatedData_GetAlignment = "Left"
        End Select
    End Function

    Private Function IsCLSection(ByVal SectionID As Long) As Boolean
        '=====================================================================
        ' Procedure Name        :	IsCLSection
        ' Purpose               :	Determine if the section belongs to the commonlist
        ' Description           :	Only Header, Graph & Related Data section apply
        ' Parameters Passed     :	Section ID
        ' Parameters Affected   :	None.
        ' Returns               :	true if section applies to CL else false
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Rajanikant Khethawatt
        ' Created               :	Nov 05,2004 
        ' Revisions             :
        '=====================================================================
        Select Case SectionID
            Case CommonFunctions.Constants.SECTION_HEADER, CommonFunctions.Constants.SECTION_GRAPH, CommonFunctions.Constants.SECTION_RELATED_DATA
                Return True
            Case Else
                Return False
        End Select
    End Function
    ' **************************************************************************
    ' End Addition Nov 05,2004 Rajanikant Khethawatt R.No. WAF2_PB_11 & WAF2_PB_12
    ' **************************************************************************
    Protected Overrides Sub Finalize()
        'Clean up the objects from the memory
        Call MemoryCleanUp()
    End Sub

    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
    End Sub
    Private Sub GetGlobalObject()
        '=====================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get Page Specific WhizGlobal Object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        ' Modified By           :	Ninad
        ' Modification Purpose  :	GetGlobalObject() method will be modified to give call to the WhizForm_Init() event.
        ' Modification Req Tag  :   WAF3_PB_33 
        ' Modified              :	10 Nov 2006 

        '=====================================================================
        'Apply Security
        MyBase.ApplySecurity(True, 2, True, True, True)
        'Create the WhizGlobal class object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        m_objGlobal = MyBase.GlobalObject
        m_blnIsDesignMode = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_objGlobal.TagID).IsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 28 May 2007
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                    "GetPageSpecificGlobalObject")
        If blnCheckEventCall = True Then
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Any Page specific changes......such as for Tag ID 27...get details for tag ID 32 (Project Information)
            Call CommonEngine.General.cPageSpecificBehavior.GetPageSpecificGlobalObject(m_objGlobal)
        End If
        GetPageSpecificGlobalClass(m_objGlobal)
        'addition ends.
        'added by ninad ' Requirement Tag :WAF3_PB_33 
        Call WhizForm_Init(m_objGlobal, m_intConnectionID)
        'addition end by ninad ' Requirement Tag :WAF3_PB_33 


    End Sub
    Protected Overridable Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        '=====================================================================
        ' Procedure Name        :	WebFormInit
        ' Purpose               :	This method will call the WhizForm_Init event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	Friday, Nov 11, 2003 
        ' Requirement Tag       :   WAF3_PB_33 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.WhizForm_Init(m_objGlobal, "LIST", m_intConnectionID)
        cobjEventHndlr = Nothing
    End Sub
    Private Sub GetConnection()
        '=====================================================================
        ' Procedure Name        :	GetConnection
        ' Purpose               :	This method will give call to the shared method GetConnectionID of cCLSQL class, 
        '                           if user has not set the value of m_intConnectionID. This method will return the ConnectionID, that will be set to the variable m_intConnectionID. 
        '                           If the value of this variable is not nothing then, connection string value will be retrieved from this connection id and will be assigned to the variable m_strConnectionString 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	Thursday, Nov 16, 2003 
        ' Requirement Tag       :   WAF3_PB_33 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        If m_intConnectionID = 0 Then
            'check weather it is a tag or subtag
            If m_objGlobal.ParentTagID = 0 Then
                m_intConnectionID = CommonEngines.CommonList.cCLSQL.GetConnectionID(CommonFunctions.General.CheckIsNothing(m_objGlobal.TagID))
            Else
                m_intConnectionID = CommonEngines.CommonList.cCLSQL.GetConnectionID(CommonFunctions.General.CheckIsNothing(m_objGlobal.ParentTagID))
            End If
        End If
        If m_intConnectionID <> 0 Then
            m_strConnectionString = CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableConnection(CommonFunctions.General.CheckIsNothing(m_intConnectionID)))
        End If
    End Sub
    Protected Overridable Sub GetPageSpecificGlobalClass(ByRef WhizGlobal As WebPages.Template.IGlobal)

    End Sub


#Region "EVENTS"

#Region "DYNAMIC MENU EVENTS"
    'Private  -> Protected Overridable
    Protected Overridable Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_Link_Print
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Link_Print(Cancel, Args, WhizGlobal)
    End Sub

    'Private -> Protected Overridable
    Protected Overridable Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_Link_Print
        Call CommonEngine.General.CLCP_Events_DynamicActions.After_Link_Print(Args, WhizGlobal)
    End Sub

    'Private -> Protected Overridable
    Protected Overridable Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_Paging_Print
        Call CommonEngine.General.CLCP_Events_DynamicActions.After_Paging_Print(Args, WhizGlobal)
    End Sub

    'Private -> Protected Overridable
    Protected Overridable Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging) Handles m_cObjMenu.Before_Paging_Link_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Paging_Link_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_PagingLink = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.DynamicMenuPaging = Paging

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Paging_Link_Print", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Paging = ExtensionArgs.DynamicMenuPaging
            Args = ExtensionArgs.m_PagingLink
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
        End If
        'addition ends.

    End Sub

    'Private -> Protected Overridable
    Protected Overridable Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_Paging_Print
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Paging_Print(Cancel, Args, WhizGlobal)
    End Sub

    'Private -> Protected Overridable
    Protected Overridable Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Initialize
        Call CommonEngine.General.CLCP_Events_DynamicActions.Initialize(Cancel, Args, WhizGlobal)
    End Sub

    'Private -> Protected Overridable
    Protected Overridable Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging) Handles m_cObjMenu.Initialize_Paging_Link_Print
        Call CommonEngine.General.CLCP_Events_DynamicActions.Initialize_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
    End Sub

#Region "Menu Print Event Sections"
    'Added by PrasannaP on 26th April 2005
    'This event is triggered before/after printing links
    Protected Overridable Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_Menu_Print
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Menu_Print")
        If blnCheckEventCall = True Then
            Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Menu_Print(Cancel, Args, WhizGlobal)
        End If
        'You can put the Display position of the link.
        'If you want to plot it on both the positions then don't set it.
        'Args.DisplayPosition = "LIST_HEAD"/"LIST_FOOT"
    End Sub

    Protected Overridable Sub After_Menu_Print(ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_Menu_Print
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_Menu_Print")
        If blnCheckEventCall = True Then
            Call CommonEngine.General.CLCP_Events_DynamicActions.After_Menu_Print(Args, WhizGlobal)
        End If
        'You can put the Display position of the link.
        'If you want to plot it on both the positions then don't set it.
        'Args.DisplayPosition = "LIST_HEAD"/"LIST_FOOT"
    End Sub
    'End Addition
#End Region

#End Region

#Region "PAGE LEGENDS EVENTS"
    'Private -> Protected Overridable
    Protected Overridable Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends) Handles m_cObjPageLegends.Initialize_Legend

        Call CommonEngine.General.CLCP_Events_PageLegends.Initialize_Legend(Cancel, Args, m_objGlobal, m_objGeneral)
    End Sub
    'Private -> Protected Overridable
    Protected Overridable Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends) Handles m_cObjPageLegends.Before_Legend_Print
        Call CommonEngine.General.CLCP_Events_PageLegends.Before_Legend_Print(Cancel, Args, m_objGlobal, m_objGeneral)
    End Sub
#End Region

#Region "PAGE HEADER FOOTER EVENTS"
    'Private -> Protected Overridable
    Protected Overridable Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter) Handles m_cObjHeaderFooter.Before_Header_Footer_Print
        Call CommonEngine.General.CLCP_Events_HeaderFooter.Before_Header_Footer_Print(Cancel, Args, m_objGlobal, m_objGeneral)
    End Sub
#End Region

#Region "PAGE CAPTION EVENTS"
    'Private -> Protected Overridable
    Protected Overridable Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption) Handles m_cObjPageCaption.Before_Page_Caption_Print
        Call CommonEngine.General.CLCP_Events_PageCaption.Before_Page_Caption_Print(Cancel, Args, m_objGlobal, m_objGeneral)
    End Sub
#End Region

    'Private -> Protected Overridable
    Protected Overridable Sub After_Getting_FilterClause(ByRef FilterClause As String)
        Call CommonEngine.General.CLCP_Events_DynamicFilters.After_Getting_FilterClause(m_objGlobal, FilterClause)
    End Sub

    'Private -> Protected Overridable
    Protected Overridable Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)
        Call CommonEngine.General.CLCP_Events_DynamicFilters.Before_Applying_Filter(m_objGlobal, ToBeInsertedInFunction)
    End Sub
#End Region

    Public Function NumericPagingEnabled() As Boolean
        '=====================================================================
        ' Procedure Name        :	NumericPagingEnabled
        ' Purpose               :	whether numeric paging is enabled or not.
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	True/ false
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NileshD
        ' Created               :	Mar 10, 2006 
        ' Revisions             :
        '=====================================================================
        Dim objUITagMaster As CommonEngines.HashTables.UITagMaster
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_objGlobal.TagID)
        Else
            'Culture ID is other than the default culture id Check if the Culture is supported by the system
            'Yes. Culture is supported. Retrieve the data specific to that Culture 
            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterCultureObject(m_objGlobal.TagID.ToString.Trim & m_objGlobal.LCID.ToString)
            If objUITagMaster Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defual culture 
                objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_objGlobal.TagID)
            End If
        End If

        If objUITagMaster.AllowNumericPaging = True Then
            NumericPagingEnabled = True
        Else
            NumericPagingEnabled = False
        End If

        objUITagMaster = Nothing
    End Function
    Private Sub WritePluginScriptBlock(ByVal bIsFromPageLoad As Boolean)
        '=====================================================================
        ' Procedure Name        :	WritePluginScriptBlock
        ' Purpose               :	To write the script block for each control for which the language support property is enabled
        '                           in control properties
        ' Description           :	same as above
        ' Parameters Passed     :	indicates whether the script block is to be written onto page or not 
        ' Parameters Affected   :	
        ' Returns               :	
        ' Assumptions           :	None
        ' Dependencies          :	None.
        ' Author                :	Shrikant B 
        ' Created               :	07 MAR 2011
        ' Revisions             :
        '=====================================================================
        WritePluginScriptBlock(bIsFromPageLoad, m_objGlobal.TagID, False)
    End Sub
    Private Sub WritePluginScriptBlock(ByVal bIsFromPageLoad As Boolean, ByVal TagID As Long, ByVal bIsSubTag As Boolean)
        '=====================================================================
        ' Procedure Name        :	WritePluginScriptBlock
        ' Purpose               :	To write the script block for each control for which the language support property is enabled
        '                           in control properties
        ' Description           :	Overload of method of same name, this overloaded method does the actual job of writing the 
        '                           script block
        ' Parameters Passed     :	indicates whether the script block is to be written onto page or not 
        '                           TagID-the tag/subtagid of the current page
        '                           bIsSubTag - indicates whether page is subtag.
        ' Parameters Affected   :	
        ' Returns               :	
        ' Assumptions           :	None
        ' Dependencies          :	None.
        ' Author                :	Shrikant B 
        ' Created               :	07 MAR 2011
        ' Revisions             :
        '=====================================================================

        Dim arrUICtrlTagMaster() As CommonEngines.HashTables.UIControlTagMaster
        Dim sbBlurFocusScriptBlock As New System.Text.StringBuilder
        Dim strFunctionNameToBeInserted(1) As String


        Const ONBLUR_LANGSUPPORT_FUNCTIONNAME As String = "plugin_close();"
        Const ONFOCUS_LANGSUPPORT_FUNCTIONNAME As String = "plugin_open();"

        arrUICtrlTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableControlTagMasterCPObject(CType(TagID, Long))

        sbBlurFocusScriptBlock.AppendLine("<script type=text/javascript>")


        If arrUICtrlTagMaster IsNot Nothing Then
            For Each objUICtrlTagMaster As CommonEngines.HashTables.UIControlTagMaster In arrUICtrlTagMaster
                If objUICtrlTagMaster.AllowFilteringOnField AndAlso objUICtrlTagMaster.LanguageSupportID = "1" Then '1 - IPlugin
                    m_bIsLangEnabled = True

                    If bIsFromPageLoad Then
                        Exit Sub
                    Else

                        Dim sbOnBlurCode As New System.Text.StringBuilder
                        Dim sbOnFocusCode As New System.Text.StringBuilder

                        sbBlurFocusScriptBlock.AppendLine(" var obj" + objUICtrlTagMaster.ControlName + " = document.getElementsByName('" + objUICtrlTagMaster.ControlName + "');")
                        sbBlurFocusScriptBlock.AppendLine(" for(var iCnt=0;iCnt<obj" + objUICtrlTagMaster.ControlName + ".length;iCnt++)")
                        sbBlurFocusScriptBlock.AppendLine(" {")

                        sbOnBlurCode.AppendLine("   if(obj" + objUICtrlTagMaster.ControlName + "[iCnt]!=null)")
                        sbOnBlurCode.AppendLine("   {")
                        sbOnBlurCode.AppendLine("       obj" + objUICtrlTagMaster.ControlName + "[iCnt].onblur=function(){ ")

                        sbOnBlurCode.AppendLine(ONBLUR_LANGSUPPORT_FUNCTIONNAME)
                        sbOnFocusCode.AppendLine("  if(obj" + objUICtrlTagMaster.ControlName + "[iCnt]!=null)")
                        sbOnFocusCode.AppendLine("   {")
                        sbOnFocusCode.AppendLine("      obj" + objUICtrlTagMaster.ControlName + "[iCnt].onfocus=function(){ ")
                        sbOnFocusCode.AppendLine(ONFOCUS_LANGSUPPORT_FUNCTIONNAME)

                        If TryParseFunctionCallForControl(CommonFunctions.General.CheckIsNothing(objUICtrlTagMaster.FunctionCall), strFunctionNameToBeInserted) Then
                            sbOnBlurCode.AppendLine(strFunctionNameToBeInserted(0))
                            sbOnFocusCode.AppendLine(strFunctionNameToBeInserted(1))
                        End If
                        sbOnBlurCode.AppendLine("       }") : sbOnFocusCode.AppendLine("        }")
                        sbOnBlurCode.AppendLine("   }") : sbOnFocusCode.AppendLine("    }")
                        sbBlurFocusScriptBlock.AppendLine(sbOnBlurCode.ToString)
                        sbBlurFocusScriptBlock.AppendLine(sbOnFocusCode.ToString)
                        sbBlurFocusScriptBlock.AppendLine("}")
                        sbBlurFocusScriptBlock.AppendLine("")

                        sbOnBlurCode = Nothing
                        sbOnFocusCode = Nothing
                    End If
                End If
            Next
        End If


        sbBlurFocusScriptBlock.AppendLine("</script>")

        If m_bIsLangEnabled AndAlso bIsFromPageLoad = False Then
            Response.Write(sbBlurFocusScriptBlock.ToString)
        End If

        sbBlurFocusScriptBlock = Nothing
        arrUICtrlTagMaster = Nothing
        strFunctionNameToBeInserted = Nothing

    End Sub
    Private Function TryParseFunctionCallForControl(ByVal strFunctionCall As String, ByRef result() As String) As Boolean
        '=====================================================================
        ' Procedure Name        :	TryParseFunctionCallForControl
        ' Purpose               :	To check if the function call in control properties contains usage of onblur/onfocus,
        '                           parse it, and return the appropriate handler code for those functions
        ' Description           :	same as above
        ' Parameters Passed     :	strFunctionCall contains the function call from ControlProperties 
        ' Parameters Affected   :	result paramter is passed ByRef and hence it will now contain the actual result of parsing of function call.
        ' Returns               :	result of parsing (ByRef) and true/false depending on parse result.
        ' Assumptions           :	None
        ' Dependencies          :	None.
        ' Author                :	Shrikant B 
        ' Created               :	07 MAR 2011
        ' Revisions             :
        '=====================================================================

        Dim bIsSuccess As Boolean = False

        Dim strFunctionCallLowerCase As String = strFunctionCall.ToLower

        If strFunctionCallLowerCase.Trim <> "" Then
            Dim arrEventAndHandler As String()
            Dim iCnt, iArrIdx As Integer
            'Dim iEqualOpPos() As Integer
            'Dim strTemp As String, strThatRemains As String
            Dim arrSeparators() As String = {"="}
            arrEventAndHandler = strFunctionCallLowerCase.Split(arrSeparators, StringSplitOptions.RemoveEmptyEntries)

            result(0) = ""
            result(1) = ""

            If strFunctionCallLowerCase.Contains("onblur") OrElse strFunctionCallLowerCase.Contains("onfocus") Then

                'Dim regExOnBlur As New Regex("(onblur=|onfocus=)", RegexOptions.ECMAScript)
                'Dim matchedCollection As MatchCollection
                If System.Text.RegularExpressions.Regex.IsMatch(strFunctionCallLowerCase, "(onblur|onfocus)") Then
                    'matchedCollection = Regex.Matches(strFunctionCallLowerCase, "[a-zA-Z0-9 ]+[=]+[\042\047]?[a-zA-Z0-9_ ]+[();]?[\047]?[a-zA-Z0-9_ ]*[\047]?[(); ]?[(); ]?[\042\047]?")
                    'matchedCollection = Regex.Matches(strFunctionCallLowerCase, "on(?!(blur|focus))[.,a-zA-Z0-9 =();\042\047_ ]*")

                    'The RegEx for replace is meant to replace any event=handler code in function call string with blank, if the event under consideration
                    'is not onblur/onfocus
                    strFunctionCall = System.Text.RegularExpressions.Regex.Replace(strFunctionCall, "on(?!(blur|focus))[.,a-zA-Z0-9 =();\042\047_ ]*", "")
                    arrEventAndHandler = System.Text.RegularExpressions.Regex.Split(strFunctionCall, "(onblur|onfocus)", System.Text.RegularExpressions.RegexOptions.IgnoreCase)
                End If

            Else
                Return bIsSuccess
            End If

            If arrEventAndHandler IsNot Nothing AndAlso arrEventAndHandler.Length <> 0 Then
                For iCnt = 1 To arrEventAndHandler.Length - 1 Step 2
                    Select Case arrEventAndHandler(iCnt).Trim.ToLower
                        Case "onblur"
                            result(0) = result(0) + vbCrLf + Replace(arrEventAndHandler(iCnt + 1).Trim.TrimStart(CChar("=")).Trim(CChar("'")), ControlChars.Quote, "")

                        Case "onfocus"
                            result(1) = result(1) + vbCrLf + Replace(arrEventAndHandler(iCnt + 1).Trim.TrimStart(CChar("=")).Trim(CChar("'")), ControlChars.Quote, "")
                    End Select
                Next

                If result(0).Trim <> "" OrElse result(1).Trim <> "" Then
                    If Not result(0).EndsWith(";") Then
                        result(0) = result(0) + ";"
                    End If

                    If Not result(1).EndsWith(";") Then
                        result(1) = result(1) + ";"
                    End If
                    bIsSuccess = True
                End If

            End If
        End If

        Return bIsSuccess
    End Function
End Class
