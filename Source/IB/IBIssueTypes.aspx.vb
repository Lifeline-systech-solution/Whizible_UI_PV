Public Class IBIssueTypes
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
        ''Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token
        If Request.QueryString("ProjectTypeStatusID") IsNot Nothing And Request.QueryString("PKTokenStatusClick") IsNot Nothing Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ProjectTypeStatusID"), String) + CType(Request.QueryString("MasterTagId"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKTokenStatusClick")) = False) Then
                ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        If Request.QueryString("SubTypeID") IsNot Nothing And Request.QueryString("PkTokenSubType") IsNot Nothing Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("SubTypeID"), String) + CType(Request.QueryString("MasterTagId"), String) + CType(0, String) + CType(0, String), Request.QueryString("PkTokenSubType")) = False) Then
                ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        '  End of addition Yogesh Jalamkar  on 02 AUG 2016 to validate Token
    End Sub

#End Region

#Region " Constants to be used "
    'Page Help Id
    Protected Const HELP_ID As Integer = 538
    'Page Modes
    Protected Const MODE_LIST As String = "List"
    Protected Const MODE_STATUS As String = "Status"
    Protected Const MODE_SUBTYPE As String = "Subtype"
    Protected Const MODE_REVIEWTYPE As String = "Review Types"
    Protected Const MODE_ISSUETYPE As String = "Issue Type"
    Protected Const MODE_EDIT As String = "Edit"
    Protected Const MODE_ADD As String = "Add"
    'Actions on the Page
    Protected Const ACTION_SAVE As String = "Save"
    Protected Const ACTION_SETASDEFAULT As String = "Set As Default"
    Protected Const ACTION_DELETE As String = "Delete"
    Protected Const ACTION_APPLY_PROECT_TYPES As String = "Apply Project Types"
    Protected Const ACTION_CHANGE_CORPORATE_TYPE As String = "Change Corporate Type"
    Protected Const COLOR_DEFAULT_ISSUE_TYPE As String = "Blue"
    Protected Const ACTION_SUCCESSFUL As String = "Action Completed Successfully"

    Protected Const SEPERATOR As String = "|~|"
    Private Const MENU_SEPERATOR As String = "|"

    ''Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
    Protected Const ACTION_INHERIT_STATUS_FLOW As String = "Inherit Status Flow"
    ''End Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0

    'Added by Dhanashri Samudra ON 2nd April 2014
    'Purpose:To remove the default flag of issue type

    Protected Const ACTION_REMOVEDEFAULT As String = "Remove Default"

    'End of Addition by Dhanashri Samudra ON 2nd April 2014
    'Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality
    Protected Shared GblstrType As String = ""
    Protected Const ACTION_REMOVEDEFAULTSUBTYPE As String = "Remove Default Sub Type"
    'End Of Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality


    Private Enum MenuIndex
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   28 June 2004
        'Requirement Number :   IB_PBN_ENT_01
        'Addition Made  :   Added One more index for the Configure Type Security link
        CONFIG_TYPE
        ADD_NEW
        DELETE
        SELECTALL
        CONFIGURE_MAILS
        SAVE
        CLOSE
        SET_AS_DEFAULT
        'Added by Dhanashri Samudra ON 2nd April 2014
        'Purpose:Add the tab as RMOVE DEFAULT
        REMOVEDEFAULT
        'End of Addition by Dhanashri Samudra ON 2nd April 2014
        'SHOW_HISTORY
        BACK
        HELP
    End Enum
#End Region

#Region " Class Scope Variables "
    Private m_lngHelpId As Long
    Protected m_lngTagId As Long
    Private m_lngProjectId As Long
    Protected m_strAction As String
    Protected m_strMode As String
    Protected m_strPageNumber As String
    Private m_strSortBy As String
    Private m_strSortOrder As String

    Protected m_strOldType As String = ""
    Protected m_strIssueTypeId As String
    Private m_blnAuditTrailExists As Boolean
    Private m_SaveFunction As String = ""
    Private m_ConfigureMailFunction_StatusMode As String = ""

    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private m_blnAddAccessRight As Boolean = False
    Private m_blnEditAccessRight As Boolean = False
    Private m_blnDeleteAccessRight As Boolean = False
    Private m_blnViewAccessRight As Boolean = False

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    'Code Commented By Dhanashri Samudra ON 2nd April 2014

    'Code commented By DipaliS 28 June 2004 and added following
    'Private m_arrMenuItem(9) As String
    'Private m_arrMenuTooltip(9) As String
    'Private m_arrClientSideFunctions(9) As String

    'By     :   DipaliS
    'Reason :   Apply Role Level Security
    'Date   :   28 June 2004
    'Requirement Number :   IB_PBN_ENT_01
    'Addition Made  :   Changed the size of arrays as one more link is added for configure type
    'Private m_arrMenuItem(9) As String
    'Private m_arrMenuTooltip(9) As String
    'Private m_arrClientSideFunctions(9) As String
    '*******End Addition*********

    'End of Comment

    'Added by Dhanashri Samudra ON 2nd April 2014
    'Pupose: Change the size of arrays as one more link is added for configure type

    Private m_arrMenuItem(10) As String
    Private m_arrMenuTooltip(10) As String
    Private m_arrClientSideFunctions(10) As String

    'End of Addition by Dhanashri Samudra ON 2nd April 2014 

    Private m_blnNodeRight As Boolean
    Private m_blnSendMail As Boolean
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortField")) <> "" Then
            m_strSortBy = MyBase.FixString(MyBase.GetFormValue("txthidSortField"), 0, False, True)
            m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
            m_strSortOrder = MyBase.FixString(MyBase.GetFormValue("txthidSortOrder"), 0, False, True)
            m_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)
        Else
            m_strSortBy = "Type"
            m_strSortOrder = "ASC"
        End If
        m_lngHelpId = HELP_ID

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCustomerProjects")) <> "" Then
            m_lngProjectId = CType(MyBase.FixString(MyBase.GetFormValue("cboCustomerProjects"), 0, True, True), Integer)
            m_blnAddAccessRight = False
            m_blnEditAccessRight = False
            m_blnDeleteAccessRight = False
            m_blnViewAccessRight = False
        Else
            m_lngProjectId = m_objGlobal.ProjectID
            m_blnAddAccessRight = m_objAccessRights.Add
            m_blnEditAccessRight = m_objAccessRights.Edit
            m_blnDeleteAccessRight = m_objAccessRights.Delete
            m_blnViewAccessRight = m_objAccessRights.View
        End If
        m_lngTagId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagId")), Long)

        If Not Page.IsPostBack Then
            m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber")).ToString
            m_strIssueTypeId = CommonFunctions.General.CheckIsNothing(Request.QueryString("IssueTypeID"), "").ToString()
        Else
            m_strPageNumber = MyBase.FixString(MyBase.GetFormValue("txthidPageNumber"), 0, False, False)
            m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
            m_strIssueTypeId = MyBase.FixString(MyBase.GetFormValue("txthidIssueTypeId"), 0, False, False)
            m_strIssueTypeId = CommonFunctions.General.UnBuildQueryString(m_strIssueTypeId)
        End If

        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToString
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        m_strAction = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidAction_IssueTypes"))
        If (m_strAction = ACTION_APPLY_PROECT_TYPES) Then
            ApplyProjectTypes()
        End If
        If m_strMode = MODE_EDIT Or m_strMode = MODE_ADD Then
            If m_strAction = ACTION_SAVE Or m_strAction = ACTION_SETASDEFAULT Then
                SaveTypeDetails()
            End If
        End If

        'Added by Dhanashri Samudra ON 2nd April 2014
        'Purpose:To call the function on the action of REMOVE DEFAULT
        If m_strMode = MODE_EDIT Then

            If m_strAction = ACTION_REMOVEDEFAULT Then
                RemoveTypeDetails()
            End If
            'End of Addition by Dhanashri Samudra ON 2nd April 2014
        End If

        If m_strMode = MODE_LIST And m_strAction = ACTION_DELETE Then
            Delete_IssueType()
        End If

        'ACTION_INHERIT_STATUS_FLOW
        ''Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
        If m_strMode = MODE_LIST And m_strAction = ACTION_INHERIT_STATUS_FLOW Then
            Inherit_Status_Flow()
        End If
        ''END Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0

    End Sub

#Region " Functions / Procedures Common to all Modes "
    Protected Sub WritePageHead()
        Dim strPageTitle As String = ""

        Select Case m_strMode
            Case MODE_LIST
                strPageTitle = MyBase.GetResourceString("ISSUETYPES")
            Case MODE_STATUS
                strPageTitle = MyBase.GetResourceString("STATUSDETAILS")
            Case MODE_SUBTYPE
                strPageTitle = MyBase.GetResourceString("SUBTYPEDETAILS")
            Case MODE_REVIEWTYPE
                strPageTitle = MyBase.GetResourceString("REVIEWTYPES")
            Case Else
                strPageTitle = MyBase.GetResourceString("ISSUETYPES")
        End Select
        CommonFunction.General.PlotPageHeadTag(strPageTitle)
    End Sub

    Protected Sub WritePage()
        If m_strMode = MODE_LIST Then
            WritePage_IssueTypeList()
        ElseIf m_strMode = MODE_STATUS Then
            WritePage_Status()
        ElseIf m_strMode = MODE_SUBTYPE Then
            WritePage_SubType()
        ElseIf m_strMode = MODE_REVIEWTYPE Then
            WritePage_ReviewType()
        Else
            WritePage_IssueTypeDetails()
        End If

        'Hidden Fields
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidIssueTypeId", "txthidIssueTypeId", , , , m_strIssueTypeId, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidPageNumber", "txthidPageNumber", , , , m_strPageNumber, , , , , , True, EnableHTMLEncode:=True)

        CommonFunctions.HTMLControls.DrawTextBox("txthidAction_IssueTypes", "txthidAction_IssueTypes", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortField", "txthidSortField", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
    End Sub

    Private Sub InitPageMenu()
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   28 June 2004
        'Requirement Number :   IB_PBN_ENT_01
        'Addition Made  :   Added the items to the array for menu links
        m_arrMenuItem(MenuIndex.CONFIG_TYPE) = MyBase.GetResourceString("MENU_CONFIGTYPE")
        m_arrMenuTooltip(MenuIndex.CONFIG_TYPE) = MyBase.GetResourceString("MENU_CONFIGTYPE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CONFIG_TYPE) = "ConfigType_OnClick()"
        '********End Addition**********

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.ADD_NEW) = MyBase.GetResourceString("MENU_ADDNEW")
        m_arrMenuTooltip(MenuIndex.ADD_NEW) = MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ADD_NEW) = "AddNew_OnClick()"

        m_arrMenuItem(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE")
        m_arrMenuTooltip(MenuIndex.DELETE) = MyBase.GetResourceString("MENU_DELETE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.DELETE) = "Delete_OnClick()"

        m_arrMenuItem(MenuIndex.SELECTALL) = MyBase.GetResourceString("MENU_SELECTALL")
        m_arrMenuTooltip(MenuIndex.SELECTALL) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SELECTALL) = "SelectAll_OnClick()"

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE) = ""

        m_arrMenuItem(MenuIndex.CONFIGURE_MAILS) = MyBase.GetResourceString("MENU_IB_CONFIGUREMAILS")
        m_arrMenuTooltip(MenuIndex.CONFIGURE_MAILS) = MyBase.GetResourceString("MENU_IB_CONFIGUREMAILS_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CONFIGURE_MAILS) = ""

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) = MyBase.GetResourceString("MENU_IB_SETASDEFAULT")
        m_arrMenuTooltip(MenuIndex.SET_AS_DEFAULT) = MyBase.GetResourceString("MENU_IB_SETASDEFAULT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SET_AS_DEFAULT) = "SetAsDefault_OnClick()"

        'Added by Dhanashri Samudra ON 2nd April 2014
        'Purpose:Add the menu of RMOVE DEFAULT
        m_arrMenuItem(MenuIndex.REMOVEDEFAULT) = "Remove Default"
        m_arrMenuTooltip(MenuIndex.REMOVEDEFAULT) = "Remove Default"
        'm_arrMenuItem(MenuIndex.REMOVEDEFAULT) = MyBase.GetResourceString("MENU_IB_REMOVEDEFAULT")
        'm_arrMenuTooltip(MenuIndex.REMOVEDEFAULT) = MyBase.GetResourceString("MENU_IB_REMOVEDEFAULT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.REMOVEDEFAULT) = "RemoveDefault_OnClick()"
        'End of Addition by Dhanashri Samudra ON 2nd April 2014


        'Modified By ShraddhaM on 18 Sep 2006 for SP7 Issue ID :
        'm_arrMenuItem(MenuIndex.SHOW_HISTORY) = MyBase.GetResourceString("MENU_IB_SHOWHISTORY")
        'm_arrMenuTooltip(MenuIndex.SHOW_HISTORY) = MyBase.GetResourceString("MENU_IB_SHOWHISTORY_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.SHOW_HISTORY) = ""

        m_arrMenuItem(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK")
        m_arrMenuTooltip(MenuIndex.BACK) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.BACK) = "Back_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('" & m_lngHelpId & "')"

        MyBase.InitializeResources("AppResources.IB_IssueTypes", "AppResources")
    End Sub

    Private Sub WritePageLegend()
        Dim intLegendCount As Integer = 0
        If m_strMode = MODE_LIST Then
            intLegendCount = 2
        Else        'If m_strMode = MODE_STATUS Then
            intLegendCount = 1
        End If
        Dim arrLegends(intLegendCount - 1) As String
        Dim arrLegendImg(intLegendCount - 1) As String

        If m_strMode = MODE_LIST Then
            arrLegends(0) = MyBase.GetResourceString("BLUECOLORINDICATESETTINGS")
            arrLegendImg(0) = ""
            arrLegends(1) = MyBase.GetResourceString("STATUSFORTASKCOMPLETE")
            arrLegendImg(1) = ""

        Else        'If m_strMode = MODE_STATUS Then
            arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
            arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        End If
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Private Sub ApplyProjectTypes()
        Dim strQuery As String = ""
        Dim intcboCustProject As Integer = 0

        intcboCustProject = CType(MyBase.FixString(MyBase.GetFormValue("cboCustomerProjects"), 0, True, True), Integer)
        strQuery = "Exec usp_Upd_IB_ImportProjectTypes " & m_objGlobal.ProjectID.ToString() & ", " & intcboCustProject.ToString
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        m_lngProjectId = m_objGlobal.ProjectID
        m_objAccessRights = Nothing
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_blnAddAccessRight = m_objAccessRights.Add
        m_blnEditAccessRight = m_objAccessRights.Edit
        m_blnDeleteAccessRight = m_objAccessRights.Delete
        m_blnViewAccessRight = m_objAccessRights.View
    End Sub
#End Region

#Region " Functions / Procedures Specific to List Mode "
    Private Sub WritePage_IssueTypeList()
        Dim strMenu As String = ""
        Dim strQuery As String = ""
        Dim strPageAlphabets As String = ""
        Dim drWork As IDataReader
        Dim lngCustomerId As Long = 0
        Dim objHref As New WebPages.UI.cDynamicLink
        Dim objHeader As New WebPages.Template.HeaderFooter

        strQuery = "Exec usp_Sel_IB_Project_Sub_Type_PagingAlphabets " & m_lngProjectId
        strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, "Select ", , "Type", True)
        If strPageAlphabets = "" Then m_strPageNumber = "-1"
        'Display Menu
        m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False, strPageAlphabets)

        'Write Page Legends and Page Caption
        WritePageLegend()
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ISSUETYPES"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeader.DrawHeaderFooter(m_objGlobal)
        objHeader = Nothing
        ''CommonFunctions.General.WriteHTML("<B>Inherit Status Flow:</B>Status at corporate level & Status at project level should be same,if any difference it will inherit only matching Status Flow.")
        CommonFunctions.General.WriteHTML("<table width=""100%"" class=""clsTable"" cellSpacing=""0"">")
        CommonFunctions.General.WriteHTML("<TBODY>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageHeader>")
        CommonFunctions.General.WriteHTML("<TD align=left>")
        Dim strNote As String
        strNote = "<B>Inherit Status Flow:</B>Status at corporate level & Status at project level should be same,if any differences in Status at corporate level & Status at project level ,it will inherit only matching Status Flow."
        CommonFunctions.General.WriteHTML(strNote)
        CommonFunctions.General.WriteHTML("</TD></TR></TBODY>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<br>")

        ' The customer projects will not be shown if there are any issues entered against the Task.
        lngCustomerId = 0
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        ' strQuery = "SELECT TOP 1 IssueID FROM tbl_IB_Issue WHERE ProjectID = " & m_objGlobal.ProjectID.ToString()
        strQuery = "usp_sel_tbl_IB_Issue_TopIssue " & m_objGlobal.ProjectID.ToString()
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) = "" Then
            strQuery = "Exec usp_Sel_tbl_PM_Project " & m_lngProjectId.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    lngCustomerId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("CustomerID"), "0"), Long)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        End If
        If lngCustomerId > 0 Then
            strQuery = "Exec usp_Sel_PM_CustomerProjects " & lngCustomerId & ", " & m_objGlobal.ProjectID.ToString()
            If CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL)) <> "" Then
                CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'><tr class='clsTREven'>")
                CommonFunctions.General.WriteHTML("<td nowrap align='left' valign='top'>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHOWTYPESOFPROJECT"))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCustomerProjects", strQuery, 200, m_lngProjectId.ToString, "OnChange=cboCustomerProjects_onchange()", True))
                CommonFunctions.General.WriteHTML("</td>")
                If m_lngProjectId <> m_objGlobal.ProjectID Then
                    CommonFunctions.General.WriteHTML("<td nowrap align='right' valign='top'>")
                    objHref.FunctionName = "ApplyProjectTypes_OnClick()"
                    objHref.LinkName = MyBase.GetResourceString("APPLYTYPESTOCURRENTPROJECT")
                    objHref.ReturnHTML = True
                    CommonFunctions.General.WriteHTML("|&nbsp;" & objHref.GetDynamicLink() & "&nbsp;|")
                    CommonFunctions.General.WriteHTML("</td>")
                End If
                CommonFunctions.General.WriteHTML("</tr></table>")
            End If
        End If
        CommonFunctions.General.WriteHTML("<br>")

        'Display List of Issue Types
        WriteList_IssueType()
        Dim objFooter As New WebPages.Template.HeaderFooter
        'Display footer
        objFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objFooter.DrawHeaderFooter(m_objGlobal)
        CommonFunctions.General.WriteHTML("<br>")

        'Display Menu at footer
        m_objMenu = Nothing
        m_objMenu = New WebPages.Template.StaticMenu
        m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False)

        'Destroy the Objects
        m_objMenu = Nothing
        objFooter = Nothing
    End Sub

    Private Sub WriteList_IssueType()
        Dim strTemp As String = ""
        Dim strImageName As String = ""
        Dim strColumnName As String = ""
        Dim strSortOrder As String = ""
        Dim objHref As New WebPages.UI.cDynamicLink

        CommonFunctions.General.WriteHTML("<div id='divList' style='overflow:auto;width:100%'>")
        CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'>")

        'Display Column Headers
        CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader'>")
        'Column -1
        strColumnName = "Type"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TYPE"))

        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td noWrap valign='top'>-&gt;</td>")

        'Column -2
        strColumnName = "CorporateType"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MAPEDCORPORATETYPE"))
        CommonFunctions.General.WriteHTML("</td>")

        'Column -3
        strColumnName = "Status"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("STATUS"))
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td noWrap valign='top'>-&gt;</td>")

        'Column -4
        strColumnName = "CorporateStatus"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CORPORATESTATUS"))
        CommonFunctions.General.WriteHTML("</td>")

        'Column -5
        strColumnName = "SubType"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SUBTYPE"))
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td noWrap valign='top'>-&gt;</td>")

        'Column -6
        strColumnName = "CorporateSubType"
        strSortOrder = "ASC"
        strTemp = ""
        If strColumnName = m_strSortBy And m_strSortOrder.ToUpper = "ASC" Then
            strSortOrder = "DESC"
        End If
        CommonFunctions.General.WriteHTML("<td nowrap valign='top'>")
        strImageName = GetImageToShow(strColumnName, strSortOrder)
        objHref.FunctionName = "Sort_OnClick('" & strColumnName & "','" & strSortOrder & "')"
        If strImageName <> "" Then
            strTemp = "<img border=0 SRC='" & strImageName & "'>"
        End If
        objHref.LinkName = strTemp
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CORPORATESUBTYPE"))
        CommonFunctions.General.WriteHTML("</td>")

        'Column -7
        'Added by GaneshD on 04 Jun 2009
        'CommonFunctions.General.WriteHTML("<td align='center'> </td>")
        'End of addition by GaneshD
        If m_blnDeleteAccessRight = True Then
            CommonFunctions.General.WriteHTML("<td align='center'  valign='top'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DELETE"))
            CommonFunctions.General.WriteHTML("</td>")
        End If
        CommonFunctions.General.WriteHTML("</tr>")

        'Display the data rows
        DisplayRow_IssueType()

        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
    End Sub

    Private Sub DisplayRow_IssueType()
        Dim strQuery As String = ""
        Dim drRow As IDataReader
        Dim strDefaulType As String = ""
        Dim strColor As String = ""
        Dim objHref As New WebPages.UI.cDynamicLink
        Dim blnDisabled As Boolean = False
        Dim intCheckboxCount As Integer = 0
        Dim intNoOfRows As Integer = 0
        'Data Fields
        Dim strType As String = ""
        Dim strCorporateType As String = ""
        Dim strUsed As String = ""

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'T', " & m_lngProjectId.ToString
        drRow = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drRow) <> "" Then
            If drRow.Read() Then
                strDefaulType = drRow.Item("Type").ToString()
                'Commented By JyotiG
                'Start
                'strDefaulType = CommonFunctions.General.UnBuildQueryString(strDefaulType)
                'End
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drRow)

        strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_lngProjectId & ", 'T', NULL, NULL, NULL, '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
        If UCase(m_strSortBy) = "TYPE" Or UCase(m_strSortBy) = "CORPORATETYPE" Then
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy)
            strQuery &= " " & CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
        End If
        drRow = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drRow) <> "" Then
            While (drRow.Read())
                intNoOfRows = intNoOfRows + 1
                strType = drRow.Item("Type").ToString
                'Commnented By JyotiG
                'Start
                'strType = CommonFunctions.General.UnBuildQueryString(strType)
                'End
                strCorporateType = drRow.Item("CorporateType").ToString
                'Commnented By JyotiG
                'Start
                'Issue Id: 7215
                'strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
                'End
                strUsed = drRow.Item("Used").ToString
                strUsed = CommonFunctions.General.UnBuildQueryString(strUsed)

                If strDefaulType.ToUpper = strType.ToUpper Then
                    strColor = COLOR_DEFAULT_ISSUE_TYPE
                Else
                    strColor = ""
                End If
                CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")

                CommonFunctions.General.WriteHTML("<td>")
                If m_blnEditAccessRight = True Then
                    objHref.FunctionName = "Type_OnClick('" & Replace(strType, "'", "\'") & "')"
                    objHref.LinkName = "<FONT color=" & strColor & ">" & Server.HtmlEncode(strType) & "</FONT>"
                    objHref.ReturnHTML = True
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                Else
                    CommonFunctions.General.WriteHTML("<FONT color=" & strColor & ">" & Server.HtmlEncode(strType) & "</FONT>")
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strColor & ">-&gt;</FONT></td>")

                CommonFunctions.General.WriteHTML("<td noWrap>")
                CommonFunctions.General.WriteHTML("<FONT color=" & strColor & ">" & Server.HtmlEncode(strCorporateType) & "</FONT></td>")

                CommonFunctions.General.WriteHTML("<td>")
                'Added By VarunA on 12-Aug-2008 RequestID-14439
                'Purpose : To have apply role level security
                If m_blnAddAccessRight = True Or m_blnEditAccessRight = True Then
                    'End By VarunA on 12-Aug-2008 RequestID-14439
                    objHref.FunctionName = "ConfigureMails_OnClick('" & Replace(strType, "'", "\'") & "')"
                    objHref.LinkName = "[" & MyBase.GetResourceString("CONFIGUREMAILS") & "]"
                    objHref.ReturnHTML = True
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                    'Added By VarunA on 12-Aug-2008 RequestID-14439
                    'Purpose : To have apply role level security
                Else
                    CommonFunctions.General.WriteHTML("[" & MyBase.GetResourceString("CONFIGUREMAILS") & "]")
                End If
                CommonFunctions.General.WriteHTML("</td>")
                'End By VarunA on 12-Aug-2008 RequestID-14439

                'Added by GaneshD on 04 Jun 2009 for Issue types->StatusFlow configuration
                Dim DrStatusFlow As IDataReader
                Dim IsStatusFlowConfigured As Boolean
                Dim StringForStatusFlow As String = ""
                ''Commented And Added By Usha Pandit On 12.06.2020 For escaping quotes in string
                'DrStatusFlow = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_IB_IsStatusFlowCofigured '" & strType & "', " & m_lngProjectId & "", True)
                DrStatusFlow = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_IB_IsStatusFlowCofigured '" & strType.Replace("'", "''").Replace("\r\n", "\n").Replace("\r", "\n").Replace("\n", "\r\n") & "', " & m_lngProjectId & "", True)
                ''End Of Added By Usha Pandit On 12.06.2020 For escaping quotes in string
                CommonFunctions.General.WriteHTML("<td  colspan=5>")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
                ''objHref.FunctionName = "StatusFlow_OnClick('" & Replace(strType, "'", "\'") & "','" & Replace(strCorporateType, "'", "\'") & "'," & m_lngProjectId & ")"
                ''MODIFIED BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
                ''Added BY AMIT MAHADIK ON 12 August 2011, WHIZIBLESEM 10.0
                ''**************************************************
                objHref.FunctionName = "StatusFlowAtProjectLevel_OnClick('" & Replace(strType, "'", "\'") & "','" & Replace(strCorporateType, "'", "\'") & "'," & m_lngProjectId & ")"
                If DrStatusFlow.Read Then
                    StringForStatusFlow = "<FONT color='red'>[Define Status Flow]</Font>"
                    objHref.LinkName = "<FONT color='red'>[Define Status Flow]</Font>"
                Else
                    StringForStatusFlow = "[Define Status Flow]"
                    objHref.LinkName = "[Define Status Flow]"
                End If
                objHref.ReturnHTML = True
                If m_blnAddAccessRight = True Or m_blnEditAccessRight = True Then
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                Else
                    CommonFunctions.General.WriteHTML(StringForStatusFlow)
                End If
                ''**************************************************
                ''END Added BY AMIT MAHADIK ON 12 August 2011, WHIZIBLESEM 10.0
                objHref.FunctionName = "StatusFlow_OnClick('" & Replace(strType, "'", "\'") & "','" & Replace(strCorporateType, "'", "\'") & "'," & m_lngProjectId & ")"

                If DrStatusFlow.Read Then
                    StringForStatusFlow = "|<FONT color='red'>[Inherit Status Flow]</Font>"
                    objHref.LinkName = "|<FONT color='red'>[Inherit Status Flow]</Font>"
                Else
                    StringForStatusFlow = "|[Inherit Status Flow]"
                    objHref.LinkName = "|[Inherit Status Flow]"
                End If
                ''END MODIFIED BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
                CommonFunction.Data.DisposeDataReader(DrStatusFlow)
                objHref.ReturnHTML = True
                'Added and modified by GaneshD on 14 Sep 2009 based on the acces rights. IssueID-33338
                If m_blnAddAccessRight = True Or m_blnEditAccessRight = True Then
                    CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                Else
                    CommonFunctions.General.WriteHTML(StringForStatusFlow)
                End If
                ' end of addition and modification by GaneshD on 14 Sep 2009
                CommonFunctions.General.WriteHTML("</td>")
                'End of addition by GaneshD

                If m_blnDeleteAccessRight = True Then
                    CommonFunctions.General.WriteHTML("<td align='center'>")
                    If strUsed = "1" Then
                        blnDisabled = True
                    Else
                        blnDisabled = False
                    End If
                    CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , strType, blnDisabled)

                    'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                    CommonFunctions.HTMLControls.DrawTextBox("txthidTypeUsed", "txthidTypeUsed", , , , strUsed, , , , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:07/10/15
                    CommonFunctions.General.WriteHTML("</td>")
                    intCheckboxCount = intCheckboxCount + 1
                End If
                CommonFunctions.General.WriteHTML("</tr>")

                ' Display Details of Sub Type and Sub Status
                DisplaySubDetails_IssueType(strType)
                CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='10'><hr style='color:#99CCFF' size='1pt'></td></tr>")
            End While
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCheckboxCount", "txthidCheckboxCount", , , , intCheckboxCount.ToString, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
        End If
        If intNoOfRows = 0 Then
            'Added by PrashantD on 23 April 2007 for IssueID 12750
            If Not MyBase.GetFormValue("txthidPageNumber") Is Nothing Then
                If MyBase.GetFormValue("txthidPageNumber") <> "-1" Or MyBase.GetFormValue("txthidPageNumber") = "" Then
                    Response.Redirect("../IB/IBIssueTypes.aspx?FromWhere=PM&MasterTagId=538")
                End If
            End If
            'End of addition by PrashantD on 23 April 2007

            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='center' colspan='10'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOITEMSTOSHOW"))
            CommonFunctions.General.WriteHTML("</td></tr>")
        End If
        CommonFunctions.Data.DisposeDataReader(drRow)
    End Sub

    Private Sub DisplaySubDetails_IssueType(ByVal strType As String)
        Dim strTemp As String = ""
        Dim objHref As New WebPages.UI.cDynamicLink
        Dim strQuery As String = ""
        Dim drSubType As IDataReader
        Dim drStatus As IDataReader
        Dim strDefaultSubtype As String = ""
        Dim strDefaultStatus As String = ""
        Dim strStatusColor As String = ""
        Dim strSubTypeColor As String = ""
        'Data Fields
        Dim strStatus As String = ""
        Dim intProjectTypeStatusId As Integer = 0
        Dim blnSetTaskCompleteStatus As Boolean = False
        Dim strCorporateStatus As String = ""
        Dim strSubType As String = ""
        Dim strCorporateSubType As String = ""
        Dim intSubTypeId As Integer = 0
        Dim blnStatusRead As Boolean = True
        Dim blnSubTypeRead As Boolean = True

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST', " & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        drStatus = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drStatus) <> "" Then
            If drStatus.Read() Then
                strDefaultStatus = drStatus.Item("Status").ToString()
                'Commented By jyotiG
                'Start
                'strDefaultStatus = CommonFunctions.General.UnBuildQueryString(strDefaultStatus)
                'End
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drStatus)

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'S', " & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        drSubType = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drSubType) <> "" Then
            If drSubType.Read() Then
                strDefaultSubtype = drSubType.Item("SubType").ToString()
                'Commented By JyotiG
                'Start
                'strDefaultSubtype = CommonFunctions.General.UnBuildQueryString(strDefaultSubtype)
                'End
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drSubType)

        strQuery = "Exec usp_Sel_tbl_IB_Project_Type_Status " & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        If UCase(m_strSortBy) = "STATUS" Or UCase(m_strSortBy) = "CORPORATESTATUS" Then
            strQuery &= ", NULL, '" & CommonFunctions.General.BuildQueryString(m_strSortBy)
            strQuery &= " " & CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
        End If
        drStatus = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_lngProjectId & ", 'S', '"
        strQuery &= CommonFunctions.General.BuildQueryString(strType) & "'"
        If UCase(m_strSortBy) = "SUBTYPE" Or UCase(m_strSortBy) = "CORPORATESUBTYPE" Then
            strQuery &= ", NULL, NULL, NULL, '" & CommonFunctions.General.BuildQueryString(m_strSortBy)
            strQuery &= " " & CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
        End If
        drSubType = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If CommonFunctions.General.CheckIsNothing(drStatus) <> "" And CommonFunctions.General.CheckIsNothing(drSubType) <> "" Then
            If Not drStatus.Read() Then blnStatusRead = False
            If Not drSubType.Read() Then blnSubTypeRead = False
            While (blnStatusRead Or blnSubTypeRead)
                If blnStatusRead Then
                    strStatus = drStatus.Item("Status").ToString
                    'Commented By JyotiG
                    'Start
                    'strStatus = CommonFunctions.General.UnBuildQueryString(strStatus)
                    'End
                    intProjectTypeStatusId = CType(CommonFunctions.Data.CheckIsDBNull(drStatus.Item("ProjectTypeStatusID"), "0"), Integer)
                    blnSetTaskCompleteStatus = CType(CommonFunctions.Data.CheckIsDBNull(drStatus.Item("SetTaskCompleteStatus"), "False"), Boolean)
                    strCorporateStatus = drStatus.Item("CorporateStatus").ToString
                    'Commented By JyotiG
                    'Start
                    'strCorporateStatus = CommonFunctions.General.UnBuildQueryString(strCorporateStatus)
                    'End
                End If
                If blnSubTypeRead Then
                    intSubTypeId = CType(CommonFunctions.Data.CheckIsDBNull(drSubType.Item("SubTypeID"), "0"), Integer)
                    strSubType = drSubType.Item("SubType").ToString()
                    'Commented By JyotiG
                    'Start
                    'strSubType = CommonFunctions.General.UnBuildQueryString(strSubType)
                    'End
                    strCorporateSubType = drSubType.Item("CorporateSubType").ToString
                    strCorporateSubType = CommonFunctions.General.UnBuildQueryString(strCorporateSubType)
                End If
                strStatusColor = ""
                If strDefaultStatus.ToUpper() = strStatus.ToUpper() Then
                    strStatusColor = COLOR_DEFAULT_ISSUE_TYPE
                End If
                strSubTypeColor = ""
                If strDefaultSubtype.ToUpper() = strSubType.ToUpper() Then
                    strSubTypeColor = COLOR_DEFAULT_ISSUE_TYPE
                End If
                CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='3'></td><td>")
                If blnStatusRead Then
                    'Status Details
                    strTemp = "<FONT color=" & strStatusColor & ">" & Server.HtmlEncode(strStatus)
                    If blnSetTaskCompleteStatus = True Then strTemp &= " @"
                    strTemp &= "</FONT>"
                    If m_blnEditAccessRight = True Then
                        objHref.FunctionName = "Status_OnClick(" & intProjectTypeStatusId.ToString & ")"
                        objHref.LinkName = strTemp
                        objHref.ReturnHTML = True
                        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                    Else
                        CommonFunctions.General.WriteHTML(strTemp)
                    End If
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td noWrap>")
                If blnStatusRead Then
                    CommonFunctions.General.WriteHTML("<FONT color=" & strStatusColor & ">-&gt;</FONT>")
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td noWrap>")
                If blnStatusRead Then
                    CommonFunctions.General.WriteHTML("<FONT color=" & strStatusColor & ">" & Server.HtmlEncode(strCorporateStatus) & "</FONT>")
                End If
                CommonFunctions.General.WriteHTML("</td>")

                'Sub Type Details
                CommonFunctions.General.WriteHTML("<td>")
                If blnSubTypeRead Then
                    strTemp = "<FONT color=" & strSubTypeColor & ">" & Server.HtmlEncode(strSubType) & "</FONT>"
                    If m_blnEditAccessRight = True Then
                        objHref.FunctionName = "SubType_OnClick(" & intSubTypeId.ToString & ")"
                        objHref.LinkName = strTemp
                        objHref.ReturnHTML = True
                        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
                    Else
                        CommonFunctions.General.WriteHTML(strTemp)
                    End If
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td noWrap>")
                If blnSubTypeRead Then
                    CommonFunctions.General.WriteHTML("<FONT color=" & strSubTypeColor & ">-&gt;</FONT>")
                End If
                CommonFunctions.General.WriteHTML("</td>")

                CommonFunctions.General.WriteHTML("<td noWrap>")
                If blnSubTypeRead Then
                    CommonFunctions.General.WriteHTML("<FONT color=" & strSubTypeColor & ">" & Server.HtmlEncode(strCorporateSubType) & "</FONT>")
                End If
                CommonFunctions.General.WriteHTML("</td>")

                If m_blnDeleteAccessRight = True Then
                    CommonFunctions.General.WriteHTML("<td align='center'>&nbsp;</td>")
                End If
                CommonFunctions.General.WriteHTML("</tr>")

                If Not drStatus.Read() Then blnStatusRead = False
                If Not drSubType.Read() Then blnSubTypeRead = False
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drStatus)
        CommonFunctions.Data.DisposeDataReader(drSubType)
    End Sub

    Private Function GetImageToShow(ByVal strColumn As String, ByVal strSortOrder As String) As String
        Dim strImageName As String = ""
        If strColumn = m_strSortBy Then
            If strSortOrder.ToUpper = "ASC" Then
                strImageName = "../../images/sort_down.gif"
            Else
                strImageName = "../../images/sort_up.gif"
            End If
        Else
            strImageName = "../../images/sortby.gif"
        End If
        Return strImageName
    End Function

    Private Sub Delete_IssueType()
        Dim strQuery As String = ""
        Dim strDeleteIds As String = ""
        Dim arrId() As String
        Dim intCnt As Integer = 0

        strDeleteIds = MyBase.FixString(MyBase.GetFormValue("chkDelete"), 0, False, False)
        strDeleteIds = CommonFunctions.General.UnBuildQueryString(strDeleteIds)
        If strDeleteIds.Length > 0 Then
            arrId = strDeleteIds.Split(CType(",", Char))
            For intCnt = 0 To arrId.Length - 1
                strQuery = "Exec usp_Del_tbl_IB_Project_Type_SubType_Status 'T'," & m_lngProjectId.ToString & ", '" & CommonFunctions.General.BuildQueryString(arrId(intCnt)) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Next
        End If
    End Sub

    ''Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
    Private Sub Inherit_Status_Flow()
        ''Added BY AMIT MAHADIK ON 26 JULY 2011, WHIZIBLESEM 10.0
        'update table here...
        Dim strQueryIns As String = ""
        Dim IssueTypeStatusFlow As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("IssueTypeStatusFlow"), "")
        Dim strCorporateType As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("strCorporateType"), "")

        'usp_Ins_tbl_IB_StatusFlow_Inherit_Status_Flow 'type-I','type11',90  

        strQueryIns = "Exec usp_Ins_tbl_IB_StatusFlow_Inherit_Status_Flow '" & strCorporateType & "','" + IssueTypeStatusFlow + "'," & m_lngProjectId.ToString()
        CommonFunctions.Data.InsertOrUpdateData(strQueryIns, MyBase.UseSQL)
        ''End Added BY AMIT MAHADIK ON 26 JULY 2011, WHIZIBLESEM 10.0
    End Sub

    ''END Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
#End Region

#Region " Functions / Procedures Specific to Status Mode "
    Private Sub WritePage_Status()
        Dim strMenu As String
        Dim strQuery As String = ""
        Dim drStatusDetails As IDataReader
        'Data Fields 
        Dim intProjectTypeStatusId As Integer = 0
        Dim strType As String = ""
        Dim strStatus As String = ""
        Dim strCorporateStatus As String = ""
        Dim blnUsed As Boolean = False
        Dim blnTaskCompleteStatus As Boolean = False
        'Added by GaneshD on 14 Aug 2009 For Whiziblesem 9.0 Issue ID-32509
        Dim UsedInStatusFlow As Integer = 0
        ' End of addition by GaneshD

        intProjectTypeStatusId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectTypeStatusID"), "0"), Integer)
        If m_strAction = ACTION_SAVE Then
            SaveStatus(intProjectTypeStatusId)
        End If
        'Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality
        If m_strAction = ACTION_REMOVEDEFAULT Then
            RemoveDefaultStatusDetails()
        End If

        If m_strAction = ACTION_REMOVEDEFAULTSUBTYPE Then
            RemoveDefaultSubTypeDetails()
        End If
        'End Of Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality
        If m_strAction <> ACTION_SUCCESSFUL Then
            'Get Status Details
            strQuery = "Exec usp_Sel_tbl_IB_Project_Type_Status " & m_lngProjectId.ToString() & ", NULL, " & intProjectTypeStatusId
            drStatusDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drStatusDetails) <> "" Then
                If drStatusDetails.Read() Then
                    strStatus = drStatusDetails.Item("Status").ToString()
                    'Commented By JyotiG
                    'Start
                    'strStatus = CommonFunctions.General.UnBuildQueryString(strStatus)
                    'End
                    strCorporateStatus = drStatusDetails.Item("CorporateStatus").ToString()
                    'Commented By JyotiG
                    'Start
                    'strCorporateStatus = CommonFunctions.General.UnBuildQueryString(strCorporateStatus)
                    'End
                    strType = drStatusDetails.Item("Type").ToString()
                    'Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality
                    GblstrType = strType
                    'End Of Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality
                    'Commented By JyotiG
                    'Start
                    'strType = CommonFunctions.General.UnBuildQueryString(strType)
                    'End
                    blnUsed = CType(CommonFunctions.Data.CheckIsDBNull(drStatusDetails.Item("Used"), "False"), Boolean)
                    m_blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drStatusDetails.Item("SendMail"), "False"), Boolean)
                    blnTaskCompleteStatus = CType(CommonFunctions.Data.CheckIsDBNull(drStatusDetails.Item("SetTaskCompleteStatus"), "False"), Boolean)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drStatusDetails)
            ' Added by GaneshD on 14 Aug 2009 for Whiziblesem 9.0 Issue ID-32509
            strStatus = CommonFunction.General.BuildQueryString(strStatus)
            UsedInStatusFlow = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_CheckStatusUsedIn_StatusFlow " & m_lngProjectId.ToString() & ",'" + strType + "','" + strStatus + "'", MyBase.UseSQL), "0"), Integer)
            'End of addition by GaneshD on 14 Aug
            'Build Function Names   
            m_ConfigureMailFunction_StatusMode = "ConfigureMails_OnClick('" & Replace(strType, "'", "\'") & "','" & Replace(strStatus, "'", "\'") & "')"
            m_SaveFunction = "Save_OnClick(" & intProjectTypeStatusId & ")"

            'Display Page Menu at top
            strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
            m_objMenu = Nothing
            CommonFunctions.General.WriteHTML(strMenu)

            'Display Legends
            WritePageLegend()

            'Display Page Caption
            CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("STATUSDETAILS"), , , True))
            CommonFunctions.General.WriteHTML("<br>")

            'Display Staus Details
            CommonFunctions.General.WriteHTML("<div id='divList' style='OVERFLOW: auto; WIDTH: 100%'>")
            CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'>")
            'Status Row
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align='right' style='width:50%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("STATUS") & "&nbsp;")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td nowrap>")
            'Added by GaneshD on 14 Aug 2009 For Whiziblesem 9.0 IssueId-32509
            If UsedInStatusFlow > 0 Then
                blnUsed = True
            End If
            ' End of addition by GaneshD on 14 Aug 2009

            If blnUsed Then
                'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                CommonFunctions.HTMLControls.DrawTextBox("txtStatus", "txtStatus", "clsTextBoxReadOnly", 200, 50, strStatus, , , , blnUsed, "", , , , True, EnableHTMLEncode:=True)
            Else
                CommonFunctions.HTMLControls.DrawTextBox("txtStatus", "txtStatus", , 200, 50, strStatus, , , , blnUsed, , , , , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:07/10/15
            End If
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            'Corporate Status Row
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align='right' style='width:50%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CORPORATESTATUS") & "&nbsp;")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td nowrap>")
            'Modified by PrashantD on 20 April 2007 for IssueID 12453
            'Purpose: Status combo should be displayed values those are displayed by clicking issue type.
            'strQuery = "Exec usp_Sel_tbl_IB_Status"

            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            'Dim strCorporateType As String = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT top 1 CorporateType FROM TBL_IB_PROJECT_SUB_TYPE WHERE Type = '" + CommonFunction.General.BuildQueryString(strType) + "' AND CorporateType IS NOT NULL AND ProjectID = " + m_lngProjectId.ToString, MyBase.UseSQL), ""), String)
            Dim strCorporateType As String = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_Corporate_TBL_IB_PROJECT_SUB_TYPE '" + CommonFunction.General.BuildQueryString(strType) + "'," + m_lngProjectId.ToString, MyBase.UseSQL), ""), String)
            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

            strQuery = "Exec usp_Sel_tbl_IB_Status_ForMapping " + Session("intProjectID").ToString + ", '" + CommonFunction.General.BuildQueryString(strType) + "','" + CommonFunction.General.BuildQueryString(strCorporateType) + "'"
            'End of modification by PrashantD on 20 April 2007
            CommonFunctions.HTMLControls.DrawComboBox("cboCorporateStatus", strQuery, 200, strCorporateStatus, , True, , , True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            'Set Task Complete Status Row
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align='right' style='width:50%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TASKCOMPLETESTATUS") & "&nbsp;")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td nowrap>")
            CommonFunctions.HTMLControls.DrawCheckBox("chkTaskCompleteStatus", "chkTaskCompleteStatus", , blnTaskCompleteStatus, "1")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
            'Hidden Fields
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidType", "txthidType", , , , strType, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.General.WriteHTML("</div>")

            CommonFunctions.General.WriteHTML("<br>")

            'Display Page Menu at Bottom
            CommonFunctions.General.WriteHTML(strMenu)
        End If
    End Sub

    Private Sub SaveStatus(ByVal intProjectTypeStatusId As Integer)
        Dim strQuery As String = ""
        Dim strType As String = ""
        Dim strStatus As String = ""
        Dim strTaskCompleteStatus As String = ""
        Dim strCorporateStatus As String = ""
        Dim strUserName As String = ""

        strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName, "").ToString()
        strTaskCompleteStatus = MyBase.FixString(MyBase.GetFormValue("chkTaskCompleteStatus"), 0, True, False)
        strType = MyBase.FixString(MyBase.GetFormValue("txthidType"), 50, False, True)
        strType = CommonFunctions.General.UnBuildQueryString(strType)
        strStatus = MyBase.FixString(MyBase.GetFormValue("txtStatus"), 50, False, True)
        strStatus = CommonFunctions.General.UnBuildQueryString(strStatus)
        strCorporateStatus = MyBase.FixString(MyBase.GetFormValue("cboCorporateStatus"), 0, False, True)
        strCorporateStatus = CommonFunctions.General.UnBuildQueryString(strCorporateStatus)

        strQuery = "Exec usp_Ins_tbl_IB_Project_Type_Status " & intProjectTypeStatusId
        strQuery &= ", " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strStatus) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateStatus) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strTaskCompleteStatus) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        m_strAction = ACTION_SUCCESSFUL
    End Sub

#End Region

#Region " Functions / Procedures Specific to SubType Mode "
    Private Sub WritePage_SubType()
        Dim strMenu As String
        Dim strQuery As String = ""
        Dim drSubTypeDetails As IDataReader
        'Data Fields 
        Dim intSubTypeId As Integer = 0
        Dim strType As String = ""
        Dim strSubType As String = ""
        Dim strCorporateSubType As String = ""
        Dim strCorporateType As String = ""
        Dim blnUsed As Boolean = False

        intSubTypeId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("SubTypeID"), "0"), Integer)
        If m_strAction = ACTION_SAVE Then
            SaveSubType(intSubTypeId)
        End If

        If m_strAction <> ACTION_SUCCESSFUL Then
            'Get Status Details
            strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_lngProjectId & ", 'S', NULL, NULL, " & intSubTypeId
            drSubTypeDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drSubTypeDetails) <> "" Then
                If drSubTypeDetails.Read() Then
                    strSubType = drSubTypeDetails.Item("SubType").ToString()
                    strSubType = CommonFunctions.General.UnBuildQueryString(strSubType)
                    strCorporateSubType = drSubTypeDetails.Item("CorporateSubType").ToString()
                    strCorporateSubType = CommonFunctions.General.UnBuildQueryString(strCorporateSubType)
                    strType = drSubTypeDetails.Item("Type").ToString()
                    strType = CommonFunctions.General.UnBuildQueryString(strType)
                    strCorporateType = drSubTypeDetails.Item("CorporateType").ToString()
                    strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
                    blnUsed = CType(CommonFunctions.Data.CheckIsDBNull(drSubTypeDetails.Item("Used"), "False"), Boolean)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drSubTypeDetails)
            'Build Function Names
            m_SaveFunction = "Save_OnClick(" & intSubTypeId & ")"

            'Display Page Menu at top
            strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
            m_objMenu = Nothing
            CommonFunctions.General.WriteHTML(strMenu)

            'Display Legends
            WritePageLegend()

            'Display Page Caption
            CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SUBTYPEDETAILS"), , , True))
            CommonFunctions.General.WriteHTML("<br>")

            'Display sub type Details
            CommonFunctions.General.WriteHTML("<div id='divList' style='OVERFLOW: auto; WIDTH: 100%'>")
            CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'>")
            'sub type Row
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align='right' style='width:50%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SUBTYPE") & "&nbsp;")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td nowrap>")
            If blnUsed Then

                'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                CommonFunctions.HTMLControls.DrawTextBox("txtSubType", "txtSubType", "clsTextBoxReadOnly", 200, 50, strSubType, , , , blnUsed, EnableHTMLEncode:=True)
            Else
                CommonFunctions.HTMLControls.DrawTextBox("txtSubType", "txtSubType", , 200, 50, strSubType, , , , blnUsed, , , , , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:07/10/15
            End If
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            'Corporate sub type Row
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align='right' style='width:50%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CORPORATESUBTYPE") & "&nbsp;")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td nowrap>")
            'Modified by PrashantD on 20 April 2007 for IssueID 12453
            'Purpose: Sub Type combo should be displayed values those are displayed by clicking issue type.
            strQuery = "Exec usp_Sel_tbl_IB_Sub_Type_ForMapping " + Session("intProjectID").ToString + ",'" + CommonFunction.General.BuildQueryString(strType) + "','" + CommonFunction.General.BuildQueryString(strCorporateType) + "'"
            'strQuery = "Exec usp_Sel_tbl_IB_Sub_Type"
            CommonFunctions.HTMLControls.DrawComboBox("cboCorporateSubType", strQuery, 200, strCorporateSubType, , True, , , True)
            'End of modification
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")

            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
            'Hidden Fields

            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidType", "txthidType", , , , strType, , , , , , True, EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txthidCorporateType", "txthidCorporateType", , , , strCorporateType, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.General.WriteHTML("</div>")

            CommonFunctions.General.WriteHTML("<br>")

            'Display Page Menu at Bottom
            CommonFunctions.General.WriteHTML(strMenu)
        End If
    End Sub

    Private Sub SaveSubType(ByVal intSubTypeId As Integer)
        Dim strQuery As String = ""
        Dim strType As String = ""
        Dim strCorporateType As String = ""
        Dim strSubType As String = ""
        Dim strCorporateSubType As String = ""
        Dim strUserName As String = ""

        strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName, "").ToString()
        strType = MyBase.FixString(MyBase.GetFormValue("txthidType"), 50, False, True)
        strType = CommonFunctions.General.UnBuildQueryString(strType)
        strCorporateType = MyBase.FixString(MyBase.GetFormValue("txthidCorporateType"), 0, False, True)
        strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
        strSubType = MyBase.FixString(MyBase.GetFormValue("txtSubType"), 50, False, True)
        strSubType = CommonFunctions.General.UnBuildQueryString(strSubType)
        strCorporateSubType = MyBase.FixString(MyBase.GetFormValue("cboCorporateSubType"), 0, False, True)
        strCorporateSubType = CommonFunctions.General.UnBuildQueryString(strCorporateSubType)

        strQuery = "Exec usp_Ins_tbl_IB_Project_Sub_Type " & intSubTypeId
        strQuery &= ", " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strSubType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateSubType) & "'"
        'Code Modified by PrashantD on 20 April 2007 for IssueID 12455
        'Purpose:--Issue Type gets duplicated from SP (not physically) 
        '   If SubType Then 's corporate is changed from SubType link of Project Setting->Issue Types page
        'strQuery &= ", NULL, NULL, 0, 0, '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"
        strQuery &= ", NULL, NULL, NULL, NULL, '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"
        'End of modification by PrashantD on 20 April 2007

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        m_strAction = ACTION_SUCCESSFUL
    End Sub

#End Region

#Region " Functions / Procedures Specific to Review Types Mode "
    Private Sub WritePage_ReviewType()
        Dim drReviewTypes As IDataReader
        Dim strQuery As String = ""
        Dim intPreviewTypeId As Integer = 0
        Dim strPreviewType As String = ""
        Dim intCount As Integer = 0

        If m_strAction = ACTION_SAVE Then
            SaveReviewTypes()
        End If
        If m_strAction <> ACTION_SUCCESSFUL Then
            CommonFunctions.General.WriteHTML("<div id='divList' style='OVERFLOW: auto; WIDTH: 100%'>")
            CommonFunctions.General.WriteHTML("<table class=clsTable width=99.9% cellspacing=1>")
            CommonFunctions.General.WriteHTML("<tr class=clsTRColumnHeader>")
            CommonFunctions.General.WriteHTML("<td align=center>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ADD"))
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td align=center>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("REVIEWTYPE"))
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td align=center>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CORPORATESUBTYPE"))
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")

            strQuery = "Exec usp_Sel_tbl_PM_ProjectReviewTypes " & m_lngProjectId & ", NULL, 1"
            drReviewTypes = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drReviewTypes) <> "" Then
                While drReviewTypes.Read()
                    intPreviewTypeId = CType(CommonFunctions.Data.CheckIsDBNull(drReviewTypes.Item("PReviewTypeID"), "0"), Integer)
                    strPreviewType = drReviewTypes.Item("PReviewType").ToString()
                    strPreviewType = CommonFunctions.General.UnBuildQueryString(strPreviewType)

                    CommonFunctions.General.WriteHTML("<tr class=clsTDEven>")
                    CommonFunctions.General.WriteHTML("<td align=center>")
                    CommonFunctions.HTMLControls.DrawCheckBox("chkPreviewTypeId", "chkPreviewTypeId", , True, intPreviewTypeId.ToString())
                    CommonFunctions.General.WriteHTML("</td>")
                    CommonFunctions.General.WriteHTML("<td align=center>")
                    'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                    CommonFunctions.HTMLControls.DrawTextBox("txthidPreviewType", "txthidPreviewType", , , , strPreviewType, , , , , , True, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:07/10/15
                    CommonFunctions.General.WriteHTML(Server.HtmlEncode(strPreviewType))
                    CommonFunctions.General.WriteHTML("</td>")
                    CommonFunctions.General.WriteHTML("<td align=center>")
                    strQuery = "Exec usp_Sel_tbl_IB_Sub_Type"
                    CommonFunctions.HTMLControls.DrawComboBox("cboCorporateSubType", strQuery, 200, , , True, , , True)
                    CommonFunctions.General.WriteHTML("</td>")
                    CommonFunctions.General.WriteHTML("</tr>")
                    intCount = intCount + 1
                End While
            Else
                CommonFunctions.General.WriteHTML("<tr class=clsTDEven>")
                CommonFunctions.General.WriteHTML("<td align=center colspan='3'>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOITEMSTOSHOW"))
                CommonFunctions.General.WriteHTML("</td></tr>")
            End If
            CommonFunctions.General.WriteHTML("</table></div>")
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCheckboxCount", "txthidCheckboxCount", , , , intCount.ToString(), , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.Data.DisposeDataReader(drReviewTypes)
        End If
    End Sub

    Private Sub SaveReviewTypes()
        Dim strQuery As String = ""
        Dim drWork As IDataReader
        Dim strType As String = ""
        Dim strCorporateType As String = ""
        Dim blnIsReviewType As Boolean = False
        Dim intCnt As Integer = 0
        Dim intCheckboxCount As Integer = 0
        Dim strCheckboxValues As String = ""
        Dim arrCheckboxValue() As String
        Dim strComboValues As String = ""
        Dim arrComboValue() As String
        Dim strUserName As String = ""

        strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_lngProjectId & ", 'T', '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId) & "'"
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                strType = drWork.Item("Type").ToString()
                strType = CommonFunctions.General.UnBuildQueryString(strType)
                strCorporateType = drWork.Item("CorporateType").ToString()
                strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
                blnIsReviewType = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("IsReviewType"), "0"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        intCheckboxCount = CType(MyBase.FixString(MyBase.GetFormValue("txthidCheckboxCount"), 0, True, True), Integer)
        If intCheckboxCount > 0 Then
            strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName, "").ToString()
            strCheckboxValues = MyBase.FixString(MyBase.GetFormValue("txthidPreviewType"), 0, False, False)
            strCheckboxValues = CommonFunctions.General.UnBuildQueryString(strCheckboxValues)
            strComboValues = MyBase.FixString(MyBase.GetFormValue("cboCorporateSubType"), 0, False, False)
            strComboValues = CommonFunctions.General.UnBuildQueryString(strComboValues)
            If strCheckboxValues <> "" Then
                arrCheckboxValue = strCheckboxValues.Split(CType(",", Char))
                arrComboValue = strComboValues.Split(CType(",", Char))
                For intCnt = 0 To arrCheckboxValue.Length
                    strQuery = "Exec usp_Ins_tbl_IB_Project_Sub_Type NULL, " & m_lngProjectId
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'"
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(arrCheckboxValue(intCnt)) & "'"
                    strQuery &= ", '" & CommonFunctions.General.BuildQueryString(arrComboValue(intCnt)) & "'"
                    strQuery &= ", 1, 1, '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                Next
            End If
        End If
        m_strAction = ACTION_SUCCESSFUL
    End Sub
#End Region

#Region " Functions / Procedures Specific to Edit / Add Mode "
    Private Sub WritePage_IssueTypeDetails()
        Dim strMenu As String
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        AuditTrailExists()

        m_SaveFunction = "Save_OnClick()"

        'Display Page Menu at top
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        m_objMenu = Nothing
        CommonFunctions.General.WriteHTML(strMenu)

        'Display Legends
        WritePageLegend()

        'Page Caption
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ISSUETYPE_STEP1"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display Header
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<br>")

        CommonFunctions.General.WriteHTML("<DIV id='divList' style='overflow:auto; width:100%'>")
        'Display Issue Type Details
        Write_IssueDetails()
        CommonFunctions.General.WriteHTML("</div>")

        objHeaderFooter = New WebPages.Template.HeaderFooter
        'Display footer
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<br>")

        'Display Menu at footer
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub Write_IssueDetails()
        Dim drWork As IDataReader
        Dim strQuery As String
        Dim blnTypeBasedLayouts As Boolean
        Dim strTemp As String
        Dim strDefaultStatus As String = ""
        Dim strDefaultSubType As String = ""

        'Fields
        Dim strType As String = ""
        Dim strCorporateType As String = ""
        Dim strPrevCorporateType As String = ""
        Dim blnIsReviewType As Boolean = False
        Dim blnTypeUsed As Boolean = False
        Dim intLayoutId As Integer = 0
        Dim dblDefaultWork As Double = 0
        'Added by GaneshD on 18 Aug for Type name not to change
        Dim UsedInStatusFlow As Integer
        ' End of addition by GaneshD

        blnTypeBasedLayouts = False
        strQuery = "Exec usp_Sel_tbl_PM_Project " & m_lngProjectId
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                If drWork.Item("IssueLayoutType").ToString() = "T" Then
                    blnTypeBasedLayouts = True
                End If
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        If m_strMode = MODE_EDIT Then
            strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_lngProjectId & ", 'T', '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId.Trim()) & "'"
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    strType = drWork.Item("Type").ToString()
                    strType = CommonFunctions.General.UnBuildQueryString(strType)
                    m_strOldType = strType
                    strCorporateType = drWork.Item("CorporateType").ToString()
                    'Commented By JyotiG
                    'Issue Id: 7215
                    'Start
                    'strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
                    strCorporateType = strCorporateType
                    'End
                    strPrevCorporateType = strCorporateType
                    blnIsReviewType = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("IsReviewType"), "False"), Boolean)
                    blnTypeUsed = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("Used"), "False"), Boolean)
                    intLayoutId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("LayoutID"), "0"), Integer)
                    If intLayoutId = 0 Then
                        intLayoutId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("CorporateLayoutID"), "0"), Integer)
                    End If
                    dblDefaultWork = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("DefaultWork"), "0"), Double)
                    FormatNumber(dblDefaultWork, 2, , , TriState.False)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        End If

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'ST', " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId.Trim()) & "'"
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                strDefaultStatus = drWork.Item("Status").ToString()
                'Commented By JyotiG
                'Start
                'strDefaultStatus = CommonFunctions.General.UnBuildQueryString(strDefaultStatus)
                'End
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        strQuery = "Exec usp_Sel_IB_GetDefault_Type_Status_SubType 'S', " & m_lngProjectId.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId.Trim()) & "'"
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                strDefaultSubType = drWork.Item("SubType").ToString()
                strDefaultSubType = CommonFunctions.General.UnBuildQueryString(strDefaultSubType)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        If m_strAction = ACTION_CHANGE_CORPORATE_TYPE Then
            strType = MyBase.FixString(MyBase.GetFormValue("txtType"), 50, False, True)
            strType = CommonFunctions.General.UnBuildQueryString(strType)
            strCorporateType = MyBase.FixString(MyBase.GetFormValue("cboCorporateType"), 0, False, True)
            strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
            strDefaultStatus = ""
            strDefaultSubType = ""

            If Not strCorporateType = "" Then 'AddedBy Dipali V On 30th Jun 2020 For Page Crash Issue
                ' Added by RajaniR on Tuesday, December 03, 2002 12:06.
                'strQuery = "Exec usp_Sel_tbl_IB_Type 'Type = ''" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'''"
                ' Modified by Archanan on 20-sep-2010 for whiziblesem9 SP2-Single quote handling
                'strQuery = "Exec usp_Sel_tbl_IB_Type '''" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'''"
                strQuery = "Exec usp_Sel_tbl_IB_Type '" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'"
                ' End of Modified by Archanan on 20-sep-2010

                'Commented And Added By Usha Pandit On 29.06.2020 For not passign blank value to SP 

                'drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                'If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                '    If drWork.Read() Then
                '        intLayoutId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("LayoutID"), "0"), Integer)
                '        dblDefaultWork = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("DefaultWork"), "0"), Double)
                '    End If
                'End If
            End If 'AddedBy Dipali V On 30th Jun 2020 For Page Crash Issue

            If Not strCorporateType = "" Then

                drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                    If drWork.Read() Then
                        intLayoutId = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("LayoutID"), "0"), Integer)
                        dblDefaultWork = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("DefaultWork"), "0"), Double)
                    End If
                End If
            End If

            'End Of Added By Usha Pandit On 29.06.2020 For not passing blank value to SP 

            CommonFunctions.Data.DisposeDataReader(drWork)
        End If
        CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'>")
        'type Row
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='width:40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TYPE") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td nowrap>")
        ' Added by GaneshD on 18 Aug 2009 For not to change the Type name if statusflow is configured
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'UsedInStatusFlow = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select Count(StatusFlowID) from tbl_IB_StatusFlow where ProjectID= " & m_lngProjectId.ToString() & " And IssueType='" + strType + "'", MyBase.UseSQL), "0"), Integer)
        UsedInStatusFlow = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_IB_StatusFlow_StatusFlow " & m_lngProjectId.ToString() & ",'" + strType + "'", MyBase.UseSQL), "0"), Integer)


        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        If UsedInStatusFlow > 0 Then
            blnTypeUsed = True
        End If
        'End of addition by GAneshD on 18 Aug 2009
        If blnTypeUsed = True Then
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtType", "txtType", "clsTextBoxReadOnly", 200, 50, strType, , , , blnTypeUsed, "", , , , True, EnableHTMLEncode:=True)
        Else
            CommonFunctions.HTMLControls.DrawTextBox("txtType", "txtType", , 200, 50, strType, , , , blnTypeUsed, , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
        End If
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        'Corporate type Row
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='width:40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CORPORATETYPE") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td nowrap>")
        'Integrated by SuchitraP on 20-May-2009 for IssueID : 27875
        'Modified by TruptiK on 28-Jan-09
        'strQuery = "Exec usp_Sel_tbl_IB_Type_ForMapping " & m_lngProjectId 
        ' Modified by Archanan on 20-sep-2010 for whiziblesem9 SP2-Single quote handling
        'strQuery = "Exec usp_Sel_tbl_IB_Type_ForMapping " & m_lngProjectId & ",'" & strCorporateType & "'"
        strQuery = "Exec usp_Sel_tbl_IB_Type_ForMapping " & m_lngProjectId & ",'" & CommonFunction.General.BuildQueryString(strCorporateType) & "'"
        ' Modified by Archanan on 20-sep-2010



        'end of modification by TruptiK
        'End of integration by SuchitraP
        CommonFunctions.HTMLControls.DrawComboBox("cboCorporateType", strQuery, 200, strCorporateType, "OnChange=cboCorporateType_OnChange()", True, , , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        If blnTypeBasedLayouts Then
            'Issue base Layout Row
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align='right' style='width:40%'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ISSUEBASELAYOUT") & "&nbsp;")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td nowrap>")
            strQuery = "Exec usp_Sel_tbl_IB_IssueEntry_Layout_Master"
            CommonFunctions.HTMLControls.DrawComboBox("cboLayoutID", strQuery, 200, intLayoutId.ToString(), , True, , , True)
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
        End If
        'Default Work Row
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='width:40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DEFAULTWORK") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td nowrap>")
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtDefaultWork", "txtDefaultWork", , 50, 4, dblDefaultWork.ToString(), "Right", , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        'Is Review Type Row
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' valign='top' style='width:40%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ISREVIEWTYPE") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.HTMLControls.DrawCheckBox("chkIsReviewType", "chkIsReviewType", , blnIsReviewType, "1")
        CommonFunctions.General.WriteHTML("<br>[<I>" & MyBase.GetResourceString("REVIEWTYPECOMMENT") & "</I>]")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")

        strQuery = "Exec usp_Sel_tbl_IB_Project_Sub_Type " & m_lngProjectId & ", 'T'"
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            strTemp = SEPERATOR
            While drWork.Read()
                strTemp &= CommonFunctions.General.UnBuildQueryString(drWork.Item("Type").ToString()) & SEPERATOR
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidProjectTypes", "txthidProjectTypes", , , , strTemp, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("<br>")

        'Display Sub Details
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ISSUETYPE_STEP2"), , , True))
        Write_SubDetails(strCorporateType, strPrevCorporateType, strDefaultStatus, strDefaultSubType)
        CommonFunctions.General.WriteHTML("<br>")
    End Sub

    Private Sub Write_SubDetails(ByVal strCorporateType As String, ByVal strPrevCorporateType As String,
                                 ByVal strDefaultStatus As String, ByVal strDefaultSubType As String)
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        'Added by GaneshD on 18 Aug 09 Not to delete the status and not to change the Type
        Dim strAllConfiguredStatus As String = ""
        Dim strSqlForStatus As String = ""
        'End of addition by GaneshD

        CommonFunctions.General.WriteHTML("<table class='clsTable' width='99.9%' cellspacing='0'>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left' valign='top'>")
        CommonFunctions.General.WriteHTML("<label id='lblDefaultStatus' style='width:200'></label>")
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidDefaultStatus", "txthidDefaultStatus", , , , strDefaultStatus, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' valign='top'>")
        CommonFunctions.General.WriteHTML("<label id='lblDefaultSubType' style='width:200'></label>")
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidDefaultSubType", "txthidDefaultSubType", , , , strDefaultSubType, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left' valign='top'>")
        CommonFunctions.General.WriteHTML("<label id='lblSelectedStatus' name='lblSelectedStatus' style='width:200'></label></td>")
        CommonFunctions.General.WriteHTML("<td align='left' valign='top'>")
        CommonFunctions.General.WriteHTML("<label id='lblSelectedSubType' name='lblSelectedSubType' style='width:200'></label></td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left' style='width:70%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("STATUS") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' style='width:30%'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SUBTYPE") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left'>")

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtStatus", "txtStatus", , 200, 50, , , , , , , , , , True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtSubType", "txtSubType", , 200, 50, , , , , , , , , , True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MAPTOCORPORATESTATUS") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MAPTOCORPORATESUBTYPE") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_tbl_IB_Status_ForMapping " & m_lngProjectId
        If m_strIssueTypeId <> "" And strCorporateType = strPrevCorporateType Then
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId) & "'"
        Else
            strQuery &= ", NULL"
        End If
        If strCorporateType <> "" Then
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'"
        End If
        CommonFunctions.HTMLControls.DrawComboBox("cboCorporateStatus", strQuery, 200, , , True, , , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_tbl_IB_Sub_Type_ForMapping " & m_lngProjectId
        If m_strIssueTypeId <> "" And strCorporateType = strPrevCorporateType Then
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId) & "'"
        Else
            strQuery &= ", NULL"
        End If
        If strCorporateType <> "" Then
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'"
        End If
        CommonFunctions.HTMLControls.DrawComboBox("cboCorporateSubType", strQuery, 200, , , True, , , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'Insert / Update / Delete Row
        DisplayMenuRow()

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left' valign='top'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("STATUSLIST") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' valign='top'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SUBTYPELIST") & "&nbsp;")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'Populate the combo
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        'For Status
        CommonFunctions.General.WriteHTML("<td align='left'>")

        If m_strAction = ACTION_CHANGE_CORPORATE_TYPE Or m_strIssueTypeId = "" Then
            strQuery = "Exec usp_Sel_tbl_IB_Status_ComboValues " & m_lngProjectId
            strQuery &= ", NULL"
            If strCorporateType <> "" Then
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'"
            Else
                strQuery &= ",''"
            End If
            strTemp = strQuery
            CommonFunctions.HTMLControls.DrawListBox("lstOldStatus", strTemp & ", 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
            CommonFunctions.HTMLControls.DrawListBox("lstStatus", strTemp & ",NULL, 1", 200, 150, , "ondblclick='ListboxOption_OnDblClick(1)'", False, , , True)
            CommonFunctions.HTMLControls.DrawListBox("lstCorporateStatus", strTemp & ", NULL, NULL, 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
        Else
            strQuery = "Exec usp_Sel_tbl_IB_Status_ComboValues " & m_lngProjectId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId) & "', NULL"
            strTemp = strQuery
            CommonFunctions.HTMLControls.DrawListBox("lstOldStatus", strTemp & ", 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
            CommonFunctions.HTMLControls.DrawListBox("lstStatus", strTemp & ",NULL, 1", 200, 150, , "ondblclick='ListboxOption_OnDblClick(1)'", False, , , True)
            CommonFunctions.HTMLControls.DrawListBox("lstCorporateStatus", strTemp & ", NULL, NULL, 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
        End If

        CommonFunctions.General.WriteHTML("</td>")

        'For SubType
        CommonFunctions.General.WriteHTML("<td align='left'>")

        If m_strAction = ACTION_CHANGE_CORPORATE_TYPE Or m_strIssueTypeId = "" Then
            strQuery = "Exec usp_Sel_tbl_IB_SubType_ComboValues " & m_lngProjectId
            strQuery &= ", NULL"
            If strCorporateType <> "" Then
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strCorporateType) & "'"
            Else
                strQuery &= ", ''"
            End If
            strTemp = strQuery
            CommonFunctions.HTMLControls.DrawListBox("lstOldSubType", strTemp & ", 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
            CommonFunctions.HTMLControls.DrawListBox("lstSubType", strTemp & ", NULL, 1", 200, 150, , "ondblclick='ListboxOption_OnDblClick(2)'", False, , , True)
            CommonFunctions.HTMLControls.DrawListBox("lstCorporateSubType", strTemp & ", NULL, NULL, 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
        Else
            strQuery = "Exec usp_Sel_tbl_IB_SubType_ComboValues " & m_lngProjectId.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strIssueTypeId) & "', NULL "
            strTemp = strQuery
            CommonFunctions.HTMLControls.DrawListBox("lstOldSubType", strTemp & ", 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
            CommonFunctions.HTMLControls.DrawListBox("lstSubType", strTemp & ", NULL, 1", 200, 150, , "ondblclick='ListboxOption_OnDblClick(2)'", False, , , True)
            CommonFunctions.HTMLControls.DrawListBox("lstCorporateSubType", strTemp & ", NULL, NULL, 1", , , , " size='2' multiple style='height:120;width:200;display:none'", False)
        End If
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left' valign='top'>")
        CommonFunctions.General.WriteHTML("(" & MyBase.GetResourceString("EDITSTATUS") & ")")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        CommonFunctions.General.WriteHTML("(" & MyBase.GetResourceString("EDITSUBTYPE") & ")")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        ' Added by GaneshD on 18 Aug Not to delete the status and not to change the Type
        CommonFunctions.General.WriteHTML("<tr>")
        strSqlForStatus = "USP_Sel_IB_StatusFlowFromAndToStatusList " & m_lngProjectId.ToString() & ",'" & m_strIssueTypeId & "'"
        strAllConfiguredStatus = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSqlForStatus, MyBase.UseSQL), "0"), String)
        CommonFunctions.General.WriteHTML("<td>")
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtHidTypeName", "txtHidTypeName", , , , m_strIssueTypeId, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td>")
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtConfiguredStatus", "txtConfiguredStatus", , , , strAllConfiguredStatus, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<tr>")
        'End of addition by GaneshD
        CommonFunctions.General.WriteHTML("</table>")

        'Disable the Corporate Type if Listbox are non blank
        If Trim(m_strIssueTypeId & "") <> "" And strCorporateType = strPrevCorporateType Then
            CommonFunctions.General.WriteHTML("<script language='javascript'>")
            CommonFunctions.General.WriteHTML("var objlstStatus,  objlstSubType, objcboCorporateType;")
            CommonFunctions.General.WriteHTML("objlstStatus= GetObjectReference('frmIssueTypes','lstStatus');")
            CommonFunctions.General.WriteHTML("objlstSubType= GetObjectReference('frmIssueTypes','lstSubType');")
            CommonFunctions.General.WriteHTML("if((objlstStatus.length > 0) || (objlstSubType.length > 0)){")
            CommonFunctions.General.WriteHTML("objcboCorporateType = GetObjectReference('frmIssueTypes','cboCorporateType');")
            CommonFunctions.General.WriteHTML("objcboCorporateType.disabled = true;")
            CommonFunctions.General.WriteHTML("}")
            CommonFunctions.General.WriteHTML("</script>")
        End If
    End Sub

    Private Sub DisplayMenuRow()
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        'For Status     
        CommonFunctions.General.WriteHTML("<td align='Left'><label style='width:200;text-align:center'>")
        If m_blnAddAccessRight = True Or m_blnEditAccessRight = True Or m_blnDeleteAccessRight = True Then
            CommonFunctions.General.WriteHTML("|&nbsp;")
        End If
        If m_blnAddAccessRight = True Then
            CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION: none' HREF='javascript:Insert_OnClick(1)'>")
            CommonFunctions.General.WriteHTML("<font size='1' face='verdana' color='black'>")
            CommonFunctions.General.WriteHTML("<b>" + MyBase.GetResourceString("INSERT") + "</b>")
            CommonFunctions.General.WriteHTML("</font></a>&nbsp;|&nbsp;&nbsp;")
        End If
        If m_blnEditAccessRight = True Then
            CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION: none' HREF='javascript:Update_OnClick(1)'>")
            CommonFunctions.General.WriteHTML("<font size='1' face='verdana' color='black'>")
            CommonFunctions.General.WriteHTML("<b>" + MyBase.GetResourceString("UPDATE") + "</b>")
            CommonFunctions.General.WriteHTML("</font></a>&nbsp;|&nbsp;&nbsp;")
        End If
        If m_blnDeleteAccessRight = True Then
            CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION: none' HREF='javascript:Delete_OnClick(1)'>")
            CommonFunctions.General.WriteHTML("<font size='1' face='verdana' color='black'>")
            CommonFunctions.General.WriteHTML("<b>" + MyBase.GetResourceString("DELETE") + "</b>")
            CommonFunctions.General.WriteHTML("</font></a>&nbsp;|&nbsp;&nbsp;")
        End If
        CommonFunctions.General.WriteHTML("</label></td>")
        'For Sub Type
        CommonFunctions.General.WriteHTML("<td align='Left'><label style='width:200;text-align:center'>")
        If m_blnAddAccessRight = True Or m_blnEditAccessRight = True Or m_blnDeleteAccessRight = True Then
            CommonFunctions.General.WriteHTML("|&nbsp;")
        End If
        If m_blnAddAccessRight = True Then
            CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION: none' HREF='javascript:Insert_OnClick(2)'>")
            CommonFunctions.General.WriteHTML("<font size='1' face='verdana' color='black'>")
            CommonFunctions.General.WriteHTML("<b>" + MyBase.GetResourceString("INSERT") + "</b>")
            CommonFunctions.General.WriteHTML("</font></a>&nbsp;|&nbsp;&nbsp;")
        End If
        If m_blnEditAccessRight = True Then
            CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION: none' HREF='javascript:Update_OnClick(2)'>")
            CommonFunctions.General.WriteHTML("<font size='1' face='verdana' color='black'>")
            CommonFunctions.General.WriteHTML("<b>" + MyBase.GetResourceString("UPDATE") + "</b>")
            CommonFunctions.General.WriteHTML("</font></a>&nbsp;|&nbsp;&nbsp;")
        End If
        If m_blnDeleteAccessRight = True Then
            CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION: none' HREF='javascript:Delete_OnClick(2)'>")
            CommonFunctions.General.WriteHTML("<font size='1' face='verdana' color='black'>")
            CommonFunctions.General.WriteHTML("<b>" + MyBase.GetResourceString("DELETE") + "</b>")
            CommonFunctions.General.WriteHTML("</font></a>&nbsp;|&nbsp;&nbsp;")
        End If
        CommonFunctions.General.WriteHTML("</label></td>")
        CommonFunctions.General.WriteHTML("</tr>")
    End Sub

    Private Sub AuditTrailExists()
        Dim drValues As IDataReader
        Dim strQuery As String

        m_blnAuditTrailExists = False
        strQuery = "Exec usp_Sel_tbl_PM_AuditTrail " & m_lngHelpId & ", " & m_lngProjectId
        drValues = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drValues) <> "" Then
            If drValues.Read() Then m_blnAuditTrailExists = True
        End If
        CommonFunctions.Data.DisposeDataReader(drValues)
    End Sub

    Private Sub SaveTypeDetails()
        Dim strQuery As String
        Dim intCtr As Integer
        Dim strStatusList As String
        Dim strSubTypeList As String
        Dim strDefaultStatus As String
        Dim strDefaultSubType As String

        'Fields
        Dim strType As String
        Dim strCorporateType As String
        Dim strUserName As String
        Dim lngLayoutId As Long
        Dim dblDefaultWork As Double
        Dim blnIsReviewType As Boolean

        ' Sub Status Fields
        Dim strOldStatus As String
        Dim arrOldStatus() As String
        Dim strStatus As String
        Dim arrStatus() As String
        Dim strCorporateStatus As String
        Dim arrCorporateStatus() As String
        ' Sub Type Fields
        Dim strOldSubType As String
        Dim arrOldSubType() As String
        Dim strSubType As String
        Dim arrSubType() As String
        Dim strCorporateSubType As String
        Dim arrCorporateSubType() As String

        ' STEP 1 : Update the type and corporate type.	
        strType = MyBase.FixString(MyBase.GetFormValue("txtType"), 50, False, True)
        strType = CommonFunctions.General.UnBuildQueryString(strType)
        strCorporateType = MyBase.FixString(MyBase.GetFormValue("cboCorporateType"), 0, False, True)
        strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
        strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName)

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboLayoutID")) = "" Then
            lngLayoutId = 0
        Else
            lngLayoutId = CType(MyBase.FixString(MyBase.GetFormValue("cboLayoutID"), 0, True, True), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDefaultWork")) = "" Then
            dblDefaultWork = 0
        Else
            dblDefaultWork = CType(MyBase.FixString(MyBase.GetFormValue("txtDefaultWork"), 0, True, True), Double)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType")) = "" Then
            blnIsReviewType = False
        Else
            blnIsReviewType = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType"), "False"), Boolean)
        End If
        strDefaultStatus = MyBase.FixString(MyBase.GetFormValue("txthidDefaultStatus"), 0, False, False)
        strDefaultStatus = CommonFunctions.General.UnBuildQueryString(strDefaultStatus)
        strDefaultSubType = MyBase.FixString(MyBase.GetFormValue("txthidDefaultSubType"), 0, False, False)
        strDefaultSubType = CommonFunctions.General.UnBuildQueryString(strDefaultSubType)

        strQuery = "Exec usp_Upd_tbl_IB_Project_Type_SubType_Status 'T', " & m_lngProjectId & ", NULL, '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strIssueTypeId)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strType)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strCorporateType)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"
        If lngLayoutId <> 0 Then
            strQuery &= ", " & lngLayoutId.ToString()
        Else
            strQuery &= ", NULL "
        End If
        If dblDefaultWork <> 0 Then
            strQuery &= ", " & FormatNumber(dblDefaultWork, , , , TriState.False)
        Else
            strQuery &= ", NULL"
        End If
        If blnIsReviewType <> False Then
            strQuery &= ", 1"
        Else
            strQuery &= ", 0"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        ' STEP 2 : Update the status & sub types.		
        ' First update all the records to be updated.
        strOldStatus = MyBase.FixString(MyBase.GetFormValue("lstOldStatus"), 0, False, False)
        strOldStatus = CommonFunctions.General.UnBuildQueryString(strOldStatus)
        arrOldStatus = strOldStatus.Split(CType(",", Char))
        strStatus = MyBase.FixString(MyBase.GetFormValue("lstStatus"), 0, False, True)
        strStatus = CommonFunctions.General.UnBuildQueryString(strStatus)
        arrStatus = strStatus.Split(CType(",", Char))
        strCorporateStatus = MyBase.FixString(MyBase.GetFormValue("lstCorporateStatus"), 0, False, False)
        strCorporateStatus = CommonFunctions.General.UnBuildQueryString(strCorporateStatus)
        arrCorporateStatus = strCorporateStatus.Split(CType(",", Char))

        For intCtr = 0 To arrStatus.Length - 1
            If arrOldStatus(intCtr) <> "" Then
                strQuery = "Exec usp_Upd_tbl_IB_Project_Type_SubType_Status 'ST', " & m_lngProjectId
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(arrOldStatus(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(arrStatus(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(arrCorporateStatus(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

                ' Execute the update query.
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        Next

        strOldSubType = MyBase.FixString(MyBase.GetFormValue("lstOldSubType"), 0, False, False)
        strOldSubType = CommonFunctions.General.UnBuildQueryString(strOldSubType)
        arrOldSubType = strOldSubType.Split(CType(",", Char))
        strSubType = MyBase.FixString(MyBase.GetFormValue("lstSubType"), 0, False, True)
        strSubType = CommonFunctions.General.UnBuildQueryString(strSubType)
        arrSubType = strSubType.Split(CType(",", Char))
        strCorporateSubType = MyBase.FixString(MyBase.GetFormValue("lstCorporateSubType"), 0, False, False)
        strCorporateSubType = CommonFunctions.General.UnBuildQueryString(strCorporateSubType)
        arrCorporateSubType = strCorporateSubType.Split(CType(",", Char))

        For intCtr = 0 To arrSubType.Length - 1
            If arrOldSubType(intCtr) <> "" Then
                strQuery = "Exec usp_Upd_tbl_IB_Project_Type_SubType_Status 'S', " & m_lngProjectId
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(arrOldSubType(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(arrSubType(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(arrCorporateSubType(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

                ' Execute the update query.
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        Next

        ' STEP 3 : Insert the new status & sub types.		
        ' Then insert the new records.
        For intCtr = 0 To arrStatus.Length - 1
            If arrOldStatus(intCtr) = "" Then
                strQuery = "Exec usp_Ins_tbl_IB_Project_Type_Status NULL, " & m_lngProjectId
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(arrStatus(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(arrCorporateStatus(intCtr))
                strQuery &= "', NULL, '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

                ' Execute the update query.
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        Next

        For intCtr = 0 To arrSubType.Length - 1
            If arrOldSubType(intCtr) = "" Then
                strQuery = "Exec usp_Ins_tbl_IB_Project_Sub_Type NULL, " & m_lngProjectId
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType)
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strCorporateType)
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(arrSubType(intCtr))
                strQuery &= "', '" & CommonFunctions.General.BuildQueryString(arrCorporateSubType(intCtr)) & "'"

                If lngLayoutId <> 0 Then
                    strQuery &= ", " & lngLayoutId.ToString()
                Else
                    strQuery &= ", NULL"
                End If

                If dblDefaultWork <> 0 Then
                    strQuery &= ", " & FormatNumber(dblDefaultWork, , , , TriState.False)
                Else
                    strQuery &= ", NULL"
                End If

                If blnIsReviewType <> False Then
                    strQuery &= ", 1"
                Else
                    strQuery &= ", 0"
                End If

                strQuery &= ", 0, '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

                ' Execute the update query.
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If
        Next

        ' STEP 4 : Delete the extra status & sub types.		
        ' Then delete the other records.
        If arrStatus.Length <> 0 Then
            strStatusList = ""
            For intCtr = 0 To arrStatus.Length - 1
                strStatusList &= """" & Replace(CommonFunctions.General.BuildQueryString(arrStatus(intCtr)), """", """""") & ""","
            Next

            ' Remove the last comma in the list.
            strStatusList = Left(strStatusList, Len(strStatusList) - 1)

            strQuery = "Exec usp_Del_tbl_IB_Project_Type_SubType_Status 'ST', " & m_lngProjectId
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
            strQuery &= ", '" & strStatusList & "'"

            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If

        If arrSubType.Length > 0 Then
            strSubTypeList = ""
            For intCtr = 0 To arrSubType.Length - 1
                strSubTypeList = strSubTypeList & """" & Replace(CommonFunctions.General.BuildQueryString(arrSubType(intCtr)), """", """""") & ""","
            Next

            ' Remove the last comma in the list.
            strSubTypeList = Left(strSubTypeList, Len(strSubTypeList) - 1)

            strQuery = "Exec usp_Del_tbl_IB_Project_Type_SubType_Status 'S', " & m_lngProjectId
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
            strQuery &= ", '" & strSubTypeList & "'"

            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If

        ' STEP 5 : Set the default.	
        ' 	SET THE DEFAULT STATUS.
        strQuery = "Exec usp_Upd_tbl_IB_Project_SetAsDefault_Type_SubType_Status 'ST', " & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strDefaultStatus)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

        ' Execute the update query.
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        ' 	SET THE DEFAULT SUB-TYPE.
        strQuery = "Exec usp_Upd_tbl_IB_Project_SetAsDefault_Type_SubType_Status 'S', " & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strDefaultSubType)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

        ' Execute the update query.
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        If m_strAction = ACTION_SETASDEFAULT Then
            ' SET THE DEFAULT TYPE.
            strQuery = "Exec usp_Upd_tbl_IB_Project_SetAsDefault_Type_SubType_Status 'T', " & m_lngProjectId
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType)
            strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

            ' Execute the update query.
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
        Response.Redirect("IBIssueTypes.aspx?Mode=" & MODE_LIST & "&MasterTagId=" & m_lngTagId)
    End Sub

    'Added by Dhanashri Samudra ON 2nd April 2014
    'Purpose:To remove the defaut tupe of selected issue type

    Private Sub RemoveTypeDetails()
        Dim strQuery As String
        Dim intCtr As Integer
        Dim strStatusList As String
        Dim strSubTypeList As String
        Dim strDefaultStatus As String
        Dim strDefaultSubType As String

        'Fields
        Dim strType As String
        Dim strCorporateType As String
        Dim strUserName As String
        Dim lngLayoutId As Long
        Dim dblDefaultWork As Double
        Dim blnIsReviewType As Boolean

        ' Sub Status Fields
        Dim strOldStatus As String
        Dim arrOldStatus() As String
        Dim strStatus As String
        Dim arrStatus() As String
        Dim strCorporateStatus As String
        Dim arrCorporateStatus() As String
        ' Sub Type Fields
        Dim strOldSubType As String
        Dim arrOldSubType() As String
        Dim strSubType As String
        Dim arrSubType() As String
        Dim strCorporateSubType As String
        Dim arrCorporateSubType() As String

        ' STEP 1 : Update the type and corporate type.	
        strType = MyBase.FixString(MyBase.GetFormValue("txtType"), 50, False, True)
        strType = CommonFunctions.General.UnBuildQueryString(strType)
        strCorporateType = MyBase.FixString(MyBase.GetFormValue("cboCorporateType"), 0, False, True)
        strCorporateType = CommonFunctions.General.UnBuildQueryString(strCorporateType)
        strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName)

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboLayoutID")) = "" Then
            lngLayoutId = 0
        Else
            lngLayoutId = CType(MyBase.FixString(MyBase.GetFormValue("cboLayoutID"), 0, True, True), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDefaultWork")) = "" Then
            dblDefaultWork = 0
        Else
            dblDefaultWork = CType(MyBase.FixString(MyBase.GetFormValue("txtDefaultWork"), 0, True, True), Double)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType")) = "" Then
            blnIsReviewType = False
        Else
            blnIsReviewType = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType"), "False"), Boolean)
        End If
        strDefaultStatus = MyBase.FixString(MyBase.GetFormValue("txthidDefaultStatus"), 0, False, False)
        strDefaultStatus = CommonFunctions.General.UnBuildQueryString(strDefaultStatus)
        strDefaultSubType = MyBase.FixString(MyBase.GetFormValue("txthidDefaultSubType"), 0, False, False)
        strDefaultSubType = CommonFunctions.General.UnBuildQueryString(strDefaultSubType)



        ' SET THE DEFAULT TYPE.
        strQuery = "Exec usp_tbl_IB_Project_RemoveDefault_Type 'T', " & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

        ' Execute the update query.
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        Response.Redirect("IBIssueTypes.aspx?Mode=" & MODE_LIST & "&MasterTagId=" & m_lngTagId)
    End Sub
    'End of Addition by Dhanashri Samudra ON 2nd April 2014
    'Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality
    Private Sub RemoveDefaultStatusDetails()
        Dim strQuery As String

        'Fields
        Dim strType As String
        Dim strUserName As String
        Dim lngLayoutId As Long
        Dim dblDefaultWork As Double
        Dim blnIsReviewType As Boolean

        ' Sub Status Fields
        Dim strStatus As String
        Dim strCorporateStatus As String


        ' STEP 1 : Update the type and corporate type.	
        strType = GblstrType
        strType = CommonFunctions.General.UnBuildQueryString(strType)
        'strType = "Change Request"
        strStatus = MyBase.FixString(MyBase.GetFormValue("txtStatus"), 50, False, True)
        strStatus = CommonFunctions.General.UnBuildQueryString(strStatus)
        strCorporateStatus = MyBase.FixString(MyBase.GetFormValue("cboCorporateStatus"), 0, False, True)
        strCorporateStatus = CommonFunctions.General.UnBuildQueryString(strCorporateStatus)
        strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName)

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboLayoutID")) = "" Then
            lngLayoutId = 0
        Else
            lngLayoutId = CType(MyBase.FixString(MyBase.GetFormValue("cboLayoutID"), 0, True, True), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDefaultWork")) = "" Then
            dblDefaultWork = 0
        Else
            dblDefaultWork = CType(MyBase.FixString(MyBase.GetFormValue("txtDefaultWork"), 0, True, True), Double)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType")) = "" Then
            blnIsReviewType = False
        Else
            blnIsReviewType = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType"), "False"), Boolean)
        End If

        ' SET THE DEFAULT TYPE.
        strQuery = "Exec usp_Whizible2_upd_tbl_IB_Project_Type_Status 'T'," & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strStatus)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

        ' Execute the update query.
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        m_strAction = ACTION_SUCCESSFUL

        ' Response.Redirect("IBIssueTypes_New.aspx?Mode=" & MODE_LIST & "&MasterTagId=" & m_lngTagId)
    End Sub
    Private Sub RemoveDefaultSubTypeDetails()
        Dim strQuery As String

        'Fields
        Dim strType As String
        Dim strUserName As String
        Dim lngLayoutId As Long
        Dim dblDefaultWork As Double
        Dim blnIsReviewType As Boolean

        ' Sub Status Fields
        Dim strSubType As String
        Dim strCorporateSubType As String


        ' STEP 1 : Update the type and corporate type.	
        strType = GblstrType
        strType = CommonFunctions.General.UnBuildQueryString(strType)
        'strType = "Change Request"
        strSubType = MyBase.FixString(MyBase.GetFormValue("txtSubType"), 50, False, True)
        strSubType = CommonFunctions.General.UnBuildQueryString(strSubType)
        strCorporateSubType = MyBase.FixString(MyBase.GetFormValue("cboCorporateSubType"), 0, False, True)
        strCorporateSubType = CommonFunctions.General.UnBuildQueryString(strCorporateSubType)
        strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName)

        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboLayoutID")) = "" Then
            lngLayoutId = 0
        Else
            lngLayoutId = CType(MyBase.FixString(MyBase.GetFormValue("cboLayoutID"), 0, True, True), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDefaultWork")) = "" Then
            dblDefaultWork = 0
        Else
            dblDefaultWork = CType(MyBase.FixString(MyBase.GetFormValue("txtDefaultWork"), 0, True, True), Double)
        End If
        If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType")) = "" Then
            blnIsReviewType = False
        Else
            blnIsReviewType = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkIsReviewType"), "False"), Boolean)
        End If

        ' SET THE DEFAULT TYPE.
        strQuery = "Exec usp_Whizible2_upd_tbl_IB_Project_Type_Status ''," & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strType) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strSubType)
        strQuery &= "', '" & CommonFunctions.General.BuildQueryString(strUserName) & "'"

        ' Execute the update query.
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        m_strAction = ACTION_SUCCESSFUL
        'Response.Redirect("IBIssueTypes_New.aspx?Mode=" & MODE_LIST & "&MasterTagId=" & m_lngTagId)
    End Sub
    'End Of Added by Usha Pandit On 22.05.2020 For Remove Default Status functionality
#End Region

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_IssueTypes", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_IssueTypes : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_strMode = MODE_LIST Then

            'If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_MAILS) Or _
            '   Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE) Or _
            '   Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
            '   Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Or _
            '   Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Or _
            '   Args.LinkName = m_arrMenuItem(MenuIndex.BACK) Then
            '    Cancel = True
            '    Return
            'End If
            'Code commented and added by PrashantD on 16 March 2007 for IssueID 11895
            'If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_MAILS) Or _
            '                Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE) Or _
            '                Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
            '                Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Or _
            '                Args.LinkName = m_arrMenuItem(MenuIndex.BACK) Then
            '    Cancel = True
            '    Return
            'End If

            'Modified by Dhanashri S ON 13 Aug 2014 
            'Purpose:Whizible Remove Default issue type functionality
            If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_MAILS) Or _
                            Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Or _
                            Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Or _
                             Args.LinkName = m_arrMenuItem(MenuIndex.REMOVEDEFAULT) Or _
                            Args.LinkName = m_arrMenuItem(MenuIndex.BACK) Then
                Cancel = True
                Return
            End If
            'End of modification by Dhanashri S  ON 13 Aug 2014
            'End of comment by PrashantD on 16 March 2007



            If m_blnAddAccessRight = False Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.ADD_NEW) Then Cancel = True
            End If
            If m_blnDeleteAccessRight = False Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.DELETE) Or Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Then
                    Cancel = True
                    Return
                End If
            End If
        ElseIf (m_strMode = MODE_STATUS) Or (m_strMode = MODE_SUBTYPE) Then

            'If Args.LinkName = m_arrMenuItem(MenuIndex.ADD_NEW) Or _
            '    Args.LinkName = m_arrMenuItem(MenuIndex.DELETE) Or _
            '    Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Or _
            '    Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Or _
            '    Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Or _
            '    Args.LinkName = m_arrMenuItem(MenuIndex.BACK) Or _
            '    Args.LinkName = m_arrMenuItem(MenuIndex.CONFIG_TYPE) Then
            '    '*****Added above condition BY DipaliS 3 July 2004**********
            '    Cancel = True
            '    Return
            'End If
            If Args.LinkName = m_arrMenuItem(MenuIndex.ADD_NEW) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.DELETE) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.SET_AS_DEFAULT) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.BACK) Or _
               Args.LinkName = m_arrMenuItem(MenuIndex.CONFIG_TYPE) Then
                '*****Added above condition BY DipaliS 3 July 2004**********
                Cancel = True
                Return
            End If


            If m_blnSendMail = False Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_MAILS) Then Cancel = True
            End If
        ElseIf (m_strMode = MODE_EDIT Or m_strMode = MODE_ADD) Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.ADD_NEW) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.DELETE) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.SELECTALL) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_MAILS) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.CLOSE) Or _
                Args.LinkName = m_arrMenuItem(MenuIndex.CONFIG_TYPE) Then
                '*****Added above condition BY DipaliS 3 July 2004**********
                Cancel = True
                Return
            End If

            If m_blnEditAccessRight = False Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = True
            End If
            'Added by PrashantD on 17 March 2007 for IssueID 11623
            If m_blnAddAccessRight = True And m_strMode = MODE_ADD Then
                If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = False
            End If
            'End of addition by PrashantD on 17 March 2007
            If m_strIssueTypeId <> "" Then
                If m_blnAuditTrailExists = False Then
                    ' If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Then Cancel = True
                End If
            End If
        End If

        If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then
            Args.FunctionName = m_SaveFunction
        End If
        If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIGURE_MAILS) Then
            Args.FunctionName = m_ConfigureMailFunction_StatusMode
        End If
        'If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Then
        '    'm_lngProjectId = 1237

        '    Args.FunctionName = "ShowHistory_OnClick(" & m_lngHelpId & ",0," & m_lngProjectId & ")"
        'End If
        'Added by VarunA on 12-Aug-2008 RequestID-14439
        'Purpose : To have apply role level security.
        If m_blnAddAccessRight = False And m_blnEditAccessRight = False Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.CONFIG_TYPE) Then Cancel = True
        End If
        'End By VarunA on 12-Aug-2008 RequestID-14439
    End Sub
    ''Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token	
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_StatusOnclick(EmployeeID As String, ProjectTypeStatusID As String, MasterTagId As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(ProjectTypeStatusID, String) + CType(MasterTagId, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_SubTypeOnclick(EmployeeID As String, SubTypeID As String, MasterTagId As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(SubTypeID, String) + CType(MasterTagId, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    ''End of addition by Yogesh J on 02 AUG 2016
End Class
