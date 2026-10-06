Public Class IB_ViewBuilder
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

#Region " Class Scope Variables"
    Dim WithEvents m_objViewListGrid As New WebPages.Template.GenericGrid

    Private m_strPageTitle As String
    Private m_strHelpId As String
    Protected m_strPageNumber As String
    Private m_lngProjectId As Long
    Private m_strLoginType As String
    Private m_lngUserId As Long
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_lngProjectViewId As Long
    Private m_strSortBy As String
    Private m_strSortOrder As String
    Private m_strPageAlphabets As String = ""

    ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
    Protected m_SetAsDefault As String
    Protected m_Mode As String
    Protected m_blnValidate As Boolean = "True"
    Protected m_strPKToken As String = ""
    ''Addition by Dhanashri S on 11 Aug 2016

    '****Code Added*******
    'By     :   DipaliS
    'Reason :   Apply Role Level Security to custom fields
    'Date   :   6 July 2004
    'Requirement No.:IB_PBN_ENT_05
    'Addition   :  Added declaration for RoleID
    Private m_intRoleID As Integer
    '*****End Addition*****
#End Region

#Region " Class Level Constants "
    Protected Const MODE_LIST As String = "List"
    Protected Const MODE_ADD As String = "Add"
    Protected Const MODE_EDIT As String = "Edit"
    Protected Const ACTION_ADDNEW As String = "Add New"
    Protected Const ACTION_DELETE As String = "Delete"
    Protected Const ACTION_SETASDEFAULT As String = "Set As Default"
    Protected Const ACTION_SAVE As String = "Save"
    Protected Const ACTION_APPLY As String = "Apply"
    Protected Const STR_SEPERATOR As String = "|~|"
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        m_strPageTitle = MyBase.GetResourceString("TITLE")
        m_strHelpId = "IB_VIEWS"
        If Not Page.IsPostBack Then
            m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber"))
        Else
            m_strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidPageNo_ViewBuilder"))
        End If
        If m_strPageNumber = "" Then m_strPageNumber = "-1"

        'commented by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list(IssueID:685)
        'm_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID"), "0"), Long) '312

        'Added by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list(IssueID:685)
        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("IssueProject"), "0"), Long)

        m_lngUserId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intUserID"), "0"), Long) '61
        m_strLoginType = CommonFunctions.General.CheckIsNothing(Session.Item("LoginType"), "") '"E"

        m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"))
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"))
        m_strSortOrder = CommonFunctions.General.UnBuildQueryString(m_strSortOrder)
        If m_strSortBy = "" Then m_strSortBy = "CreatedDate"
        If m_strSortOrder = "" Then m_strSortOrder = "DESC"

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security to custom fields
        'Date   :   6 July 2004
        'Requirement No.:IB_PBN_ENT_05
        'Addition   :  Added Code to set RoleID from Session

        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'm_intRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(m_lngUserId, String), MyBase.UseSQL), "0"), Integer)
        m_intRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(m_lngUserId, String), MyBase.UseSQL), "0"), Integer)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        If Not m_intRoleID > 0 Then
            m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intPostID")), Integer)
        End If
        '********End Addition

        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        If Not Request.QueryString("SetAsDefault") Is Nothing Then
            m_SetAsDefault = Request.QueryString("SetAsDefault").ToString
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_Mode = Request.QueryString("Mode").ToString
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016

        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        ''Added by Yogesh J on on 02-FEB-2016 to validate Token
        'If Request.QueryString("ProjectViewID") <> "" And Request.QueryString("PKToken") <> "" Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ProjectViewID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("View Builder", 0, 0, "ProjectViewID", CType(Request.QueryString("ProjectViewID"), String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        If (((Request.QueryString("ProjectViewID") <> "") And (m_Mode <> "")) Or ((Request.QueryString("ProjectViewID") <> "") And (m_SetAsDefault <> ""))) Then
            If (((Request.QueryString("ProjectViewID") <> "") And (m_Mode <> "")) Or ((Request.QueryString("ProjectViewID") <> "") And (m_SetAsDefault <> ""))) Then
                If ((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Then
                    m_blnValidate = "False"
                ElseIf (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ProjectViewID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                    m_blnValidate = "False"
                End If
            End If
        End If
        If (m_blnValidate = "False") Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016

        ''End of addition by Yogesh J on on 02-FEB-2016 to validate Token 

        m_strMode = "" & Request.QueryString("MODE")
        If m_strMode = "" Then
            m_strMode = MODE_LIST
        End If

        m_lngProjectViewId = CType("0" & Request.QueryString("ProjectViewID"), Long)
        m_strAction = MyBase.GetFormValue("txthidAction_ViewBuilder")
        If m_strMode = MODE_LIST Then
            If m_strAction = ACTION_DELETE Then
                DeleteProjectView()
            ElseIf m_strAction = ACTION_APPLY Then
                Session("intViewID") = m_lngProjectViewId
            End If
        End If
        If m_strMode <> MODE_LIST And m_strAction = ACTION_SAVE Then
            SaveViewDetails()
        End If
        If m_strMode = MODE_EDIT And m_strAction = ACTION_SETASDEFAULT Then
            SetAsDefault_View()
        End If
        'Added By VarunA on 13-July-2007 whizible 7.0 development & Release
        'Purpose : To set the values in SP for which Set as Default is set.
        If m_strMode = "List" Then
            If HttpContext.Current.Request.QueryString("SetAsDefault") = "1" Then
                SetAsDefault_View()
            End If
        End If
        'End By VarunA on 13-July-2007
        m_strPKToken = CommonFunctions.Security.Token.GetToken(CType(Session("intUserID"), String) + CType(m_lngProjectViewId, String) + "0" + "0")
    End Sub

#Region " Procedures / Functions Common to All Modes of the Page "
    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle, , , , "<script language='javascript' src='../QRB/QueryBuilder.js'></script>")
    End Sub

    Public Sub WritePage()
        If m_strMode = MODE_LIST Then
            WritePage_ViewList()
        Else
            WritePage_ViewDetails()
        End If

        'Hidden Fields
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction_ViewBuilder", "txthidAction_ViewBuilder", , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidPageNo_ViewBuilder", "txthidPageNo_ViewBuilder", , , , m_strPageNumber, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
    End Sub

    Private Function WritePageMenu() As String
        Dim intMenuCount As Integer
        If m_strMode = MODE_LIST Then
            intMenuCount = 6
        ElseIf m_strMode = MODE_ADD And m_lngProjectViewId = 0 Then
            intMenuCount = 4
        ElseIf m_strMode = MODE_EDIT And m_lngProjectViewId > 0 Then
            intMenuCount = 5
        End If
        Dim strMenu As String
        Dim intIndex As Integer = 0
        Dim arrMenuItem(intMenuCount - 1) As String
        Dim arrMenuTooltip(intMenuCount - 1) As String
        Dim arrClientSideFunctions(intMenuCount - 1) As String

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        If m_strMode = MODE_LIST Then
            arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_ADDNEW")
            arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP")
            arrClientSideFunctions(intIndex) = "AddNew_OnClick()"
            intIndex = intIndex + 1

            arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_DELETE")
            arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_DELETE_TOOLTIP")
            arrClientSideFunctions(intIndex) = "Delete_OnClick()"
            intIndex = intIndex + 1

            arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_SELECTALL")
            arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_SELECTALL_TOOLTIP")
            arrClientSideFunctions(intIndex) = "SelectAll_OnClick('frmViewBuilder','chkDelete')"
            intIndex = intIndex + 1

            arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_CLEARALL")
            arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")
            arrClientSideFunctions(intIndex) = "ClearAll_OnClick('frmViewBuilder','chkDelete')"
            intIndex = intIndex + 1
        Else
            arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_SAVE")
            arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
            arrClientSideFunctions(intIndex) = "Save_OnClick()"
            intIndex = intIndex + 1

            If m_strMode = MODE_EDIT Then
                arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_IB_SETASDEFAULT")
                arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_IB_SETASDEFAULT_TOOLTIP")
                arrClientSideFunctions(intIndex) = "SetAsDefault_OnClick()"
                intIndex = intIndex + 1
            End If

            arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_BACK")
            arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_BACK_TOOLTIP")
            arrClientSideFunctions(intIndex) = "Back_OnClick()"
            intIndex = intIndex + 1

        End If
        arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_CLOSE")
        arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        arrClientSideFunctions(intIndex) = "Close_OnClick()"
        intIndex = intIndex + 1

        arrMenuItem(intIndex) = MyBase.GetResourceString("MENU_HELP")
        arrMenuTooltip(intIndex) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunctions(intIndex) = "Help_OnClick('" & m_strHelpId & "')"
        intIndex = intIndex + 1

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True, m_strPageAlphabets)
        Return strMenu
    End Function

    Private Sub WritePageLegend()
        Dim intLegendCount As Integer
        If m_strMode = MODE_LIST Then
            intLegendCount = 1
        Else
            intLegendCount = 2
        End If
        Dim arrLegends(intLegendCount - 1) As String
        Dim arrLegendImg(intLegendCount - 1) As String

        If m_strMode = MODE_LIST Then
            arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("BLUECOLORINDICATESETTINGS")
            arrLegendImg(0) = ""
        Else
            arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("PREFIXINDICATES")
            arrLegendImg(0) = ""
            arrLegends(1) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
            arrLegendImg(1) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        End If
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_ViewBuilder", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_ViewBuilder: " & UserInput & " " & Cause
        Throw ex
    End Sub
#End Region

#Region " Procedures / Functions specific to List Mode of the Page "

    Public Sub WritePage_ViewList()
        Dim strMenu As String
        Dim strQuery As String
        'added by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(m_lngProjectId, String), True), String)
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(m_lngProjectId, String), True), String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        'End addition by SandipL
        'For Paging Alphbets
        strQuery = "Exec usp_Sel_tbl_IB_Project_Views_All " & m_lngProjectId & ", '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "'," & m_lngUserId.ToString() & ", '-1',null,null,1"
        'Added by PrashantD on 3 April 2007 for IssueId 11524
        If m_strPageNumber = "AND" Then
            m_strPageNumber = "&"
        ElseIf m_strPageNumber = "HASH" Then
            m_strPageNumber = "#"
        ElseIf m_strPageNumber = "''" Then
            m_strPageNumber = "'"
        End If
        'End of addition by PrashantD for IssueID 11524
        m_strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, "Select ", , "ViewName", True)

        If m_strPageAlphabets = "" Then m_strPageNumber = "-1"
        'Display Menu
        CommonFunctions.General.WriteHTML(WritePageMenu())
        m_strPageAlphabets = ""

        MyBase.InitializeResources("AppResources.IB_ViewBuilder", "AppResources")

        'Write Page Legends and Page Caption
        WritePageLegend()
        'Modified by SandipL on 8 Feb 2006 -- added rightCaption for Project
        CommonFunctions.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("VIEWLIST"), "Project: " + strProjectName, , True))
        'end Modification by SandipL on 8 Feb 2006
        CommonFunctions.General.WriteHTML("<br>")

        'Display List of Views
        WriteViewList()

        'Display Menu
        CommonFunctions.General.WriteHTML(WritePageMenu())
        MyBase.InitializeResources("AppResources.IB_ViewBuilder", "AppResources")
    End Sub

    Private Sub WriteViewList()
        Dim strQuery As String
        'Modified By VarunA
        'Dim intColumnsToShow As Integer = 8
        'Dim intDataColumns As Integer = 7
        Dim intColumnsToShow As Integer = 9
        Dim intDataColumns As Integer = 8
        'End By VarunA
        Dim intIndex As Integer = 0
        Dim arrDataColumn(intColumnsToShow - 1) As String
        Dim arrColumnHeader(intColumnsToShow - 1) As String
        Dim arrCheckBoxId(intColumnsToShow - 1) As String
        Dim arrColumnLink(intColumnsToShow - 1) As String
        Dim arrTDStyle(intColumnsToShow - 1) As String
        Dim arrGroup() As String = {"1"}

        arrDataColumn(intIndex) = "ViewType"
        arrColumnHeader(intIndex) = ""
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = ""
        arrTDStyle(intIndex) = "width=0%"
        intIndex = intIndex + 1

        arrDataColumn(intIndex) = "ProjectViewID"
        arrColumnHeader(intIndex) = MyBase.GetResourceString("VIEWID")
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = ""
        ''Commented And Added By Vaijat k ON 03/11/2015
        'arrTDStyle(intIndex) = "width=3% align=left valign=top"
        arrTDStyle(intIndex) = "width=11% align=left valign=top"
        intIndex = intIndex + 1

        arrDataColumn(intIndex) = "ViewName"
        arrColumnHeader(intIndex) = MyBase.GetResourceString("VIEWNAME")
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = "ViewName_OnClick(ProjectViewID)"
        ''Commented And Added By Vaijat k ON 03/11/2015
        'arrTDStyle(intIndex) = "width=10% align=left valign=top"
        arrTDStyle(intIndex) = "width=16% align=left valign=top"
        intIndex = intIndex + 1

        arrDataColumn(intIndex) = "CreatedDate"
        arrColumnHeader(intIndex) = MyBase.GetResourceString("CREATEDON")
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = ""
        ''Commented And Added By Vaijat k ON 03/11/2015
        'arrTDStyle(intIndex) = "width=10% align=left valign=top"
        arrTDStyle(intIndex) = "width=16% align=left valign=top"
        intIndex = intIndex + 1

        arrDataColumn(intIndex) = "Fields"
        arrColumnHeader(intIndex) = MyBase.GetResourceString("DISPLAYFIELDS")
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = ""
        arrTDStyle(intIndex) = "width=33% align=left valign=top"
        intIndex = intIndex + 1

        arrDataColumn(intIndex) = "SortBy"
        arrColumnHeader(intIndex) = MyBase.GetResourceString("SORTORDER")
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = ""
        arrTDStyle(intIndex) = "width=33% align=left valign=top"
        intIndex = intIndex + 1

        'Added By VarunA on 13-July-2007 Whizible 7.0 Development & Release
        'Purpose : To have the Set Default link in the list
        arrDataColumn(intIndex) = "DefaultViewID"
        arrColumnHeader(intIndex) = "Set As Default"
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = "SetDefault_List_OnClick(ProjectViewID)"
        arrTDStyle(intIndex) = "width=3% align=left valign=top"
        intIndex = intIndex + 1
        'End By VarunA on 13-July-2007

        arrDataColumn(intIndex) = "Applied"
        arrColumnHeader(intIndex) = MyBase.GetResourceString("APPLY")
        arrCheckBoxId(intIndex) = ""
        arrColumnLink(intIndex) = "Apply_OnClick(ProjectViewID)"
        arrTDStyle(intIndex) = "width=3% align=left valign=top"
        intIndex = intIndex + 1

        arrDataColumn(intIndex) = ""
        arrColumnHeader(intIndex) = MyBase.GetResourceString("DELETE")
        arrCheckBoxId(intIndex) = "chkDelete"
        arrColumnLink(intIndex) = ""
        arrTDStyle(intIndex) = "width=4% align=center valign=top"
        intIndex = intIndex + 1

        strQuery = "Exec usp_Sel_tbl_IB_Project_Views_All " & m_lngProjectId
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'," & m_lngUserId.ToString()

        m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
        m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
        m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")

        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "', NULL"
        If Not (m_strSortBy = "Fields" Or m_strSortBy = "SortBy") Then

            'Modified by PrajaktaR on May 09, 2005 for Default sorting on ViewType IssueID 18088
            ' strQuery &= ", 'ORDER BY " & m_strSortBy & " " & m_strSortOrder & "'"
            strQuery &= ", 'ORDER BY ViewType, " & m_strSortBy & " " & m_strSortOrder & "'"
            'End of Modification by PrajaktaR on May 09, 2005 for Default sorting on ViewType IssueID 18088

        End If
        'Set Grid Peroperties
        With m_objViewListGrid
            .UserFriendlyColumnArray = arrColumnHeader
            .ActualColumnArray = arrDataColumn
            .CheckBoxIDArray = arrCheckBoxId
            .TDStyleArray = arrTDStyle
            .RowLinkArray = arrColumnLink
            .NoOfDataColumns = intDataColumns
            .PrimaryKey = "ProjectViewID"
            .GroupOnColumn = arrGroup

            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"

            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .returnHTML = True
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width:100%;"
            .EmptyValueReplacement = "&nbsp;"
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        ' Store Number of Rows in Hidden Field
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidNoOfRows", "txthidNoOfRows", , , , m_objViewListGrid.NoOfRows.ToString(), , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
    End Sub

    Private Sub DeleteProjectView()
        Dim strQuery As String
        Dim strIds As String
        Dim arrIdsToDelete() As String
        Dim intCount As Integer

        strIds = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkDelete"))
        If strIds <> "" Then
            arrIdsToDelete = strIds.Split(CType(",", Char))
            If CommonFunctions.General.CheckIsNothing(arrIdsToDelete) <> "" Then
                For intCount = 0 To arrIdsToDelete.Length - 1
                    strQuery = "Exec usp_Del_tbl_IB_Project_Views " & arrIdsToDelete(intCount)
                    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                Next
            End If
        End If
    End Sub
#End Region

#Region " Procedures / Functions specific to Add/Edit Mode of the Page "
    Private Sub WritePage_ViewDetails()
        Dim strMenu As String
        Dim strTemp As String
        Dim strTempViewName As String = ""
        Dim strQuery As String
        Dim objHref As New WebPages.UI.cDynamicLink

        'Field Details
        Dim strViewName As String
        Dim strSortBy As String
        Dim strFields As String
        Dim drDetails As IDataReader

        'Get View Details From table
        If m_lngProjectViewId > 0 Then
            strQuery = "Exec usp_Sel_tbl_IB_Project_Views NULL, NULL, NULL, " & m_lngProjectViewId
            drDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drDetails) <> "" Then
                drDetails.Read()
                strViewName = CommonFunctions.Data.CheckIsDBNull(drDetails.Item("ViewName")).ToString()
                strViewName = CommonFunctions.General.UnBuildQueryString(strViewName)
                strFields = CommonFunctions.Data.CheckIsDBNull(drDetails.Item("Fields")).ToString()
                strFields = CommonFunctions.General.UnBuildQueryString(strFields)
                strSortBy = CommonFunctions.Data.CheckIsDBNull(drDetails.Item("SortBy")).ToString()
                strSortBy = CommonFunctions.General.UnBuildQueryString(strSortBy)
            End If
            CommonFunctions.Data.DisposeDataReader(drDetails)
        End If

        'Display Menu
        strMenu = WritePageMenu()
        CommonFunctions.General.WriteHTML(strMenu)

        MyBase.InitializeResources("AppResources.IB_ViewBuilder", "AppResources")

        'Display Legends
        WritePageLegend()

        'Display Page Caption
        If m_lngProjectViewId > 0 And m_strMode = MODE_EDIT Then
            strTemp = MyBase.GetResourceString("VIEWID") & " : [" & m_lngProjectViewId & "]"
        Else
            strTemp = MyBase.GetResourceString("VIEWID") & " : [" & MyBase.GetResourceString("NOTASSIGNED") & "]"
        End If
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("VIEWDETAILS"), strTemp, , True))
        CommonFunctions.General.WriteHTML("<br><br>")

        CommonFunctions.General.WriteHTML("<div id='divList' style='OVERFLOW: auto; WIDTH: 100%'>")

        'Display View Name
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table cellspacing='0' class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'> <td valign='top' align='right' width='100'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("VIEWNAME"))
        CommonFunctions.General.WriteHTML("</td><td valign='top' noWrap>")
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtViewName", "txtViewName", , 480, 100, Server.HtmlEncode(strViewName), , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML("<br>")

        'Show Display Fields
        CommonFunctions.General.WriteHTML("<table cellspacing='0' class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='4'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DISPLAYFIELDS"))
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='2'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LISTOFFIELDS"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td colspan='2' width='150px' align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECTEDFIELDS"))
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td style='width:30%' rowspan='4'>")
        'modified by HarshK for sp4 issueid 539
        strQuery = "Exec usp_Sel_tbl_IB_ProjectViews_GetFieldList " & m_lngProjectId & ", " & m_lngProjectViewId & ", 'D',0, '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security to custom fields
        'Date   :   6 July 2004
        'Requirement No.:IB_PBN_ENT_05
        'Addition   :  Added One More Parameter RoleID to the Sp
        strQuery &= "," + m_intRoleID.ToString + "," + m_lngUserId.ToString
        'End modified by HarshK for sp4 issueid 539
        '****End Addition*****

        strTemp = "OnDblClick = 'lstView_FieldList_OnDblClick_Custom()' Onfocus= 'lstView_FieldList_onfocus()'"
        CommonFunctions.HTMLControls.DrawListBox("lstView_FieldList", strQuery, 180, 150, , strTemp)
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='middle' style='width:20%'>")

        objHref.FunctionName = "btnView_AddAll_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/allright.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td style='width:30%' rowspan='4'>")
        'modified by HarshK for sp4 issueid 539
        strQuery = "Exec usp_Sel_tbl_IB_ProjectViews_GetFieldList " & m_lngProjectId & ", " & m_lngProjectViewId & ", 'D',1, '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security to custom fields
        'Date   :   6 July 2004
        'Requirement No.:IB_PBN_ENT_05
        'Addition   :  Added One More Parameter RoleID to the Sp
        strQuery &= "," + m_intRoleID.ToString + "," + m_lngUserId.ToString
        'End modified by HarshK for sp4 issueid 539
        '****End Addition*****
        strTemp = "OnDblClick = 'lstView_SelectedFields_OnDblClick_Custom()' Onfocus= 'lstView_SelectedFields_onfocus()'"
        CommonFunctions.HTMLControls.DrawListBox("lstView_SelectedFields", strQuery, 180, 150, , strTemp)
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidSelectedViewFields", "txthidSelectedViewFields", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        objHref.FunctionName = "btnView_MoveToTop_OnClick()"
        objHref.LinkName = "<img src='../../images/topmost.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='middle'>")
        objHref.FunctionName = "btnView_AddSelected_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/right.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td><td>")
        objHref.FunctionName = "btnView_MoveUpBy1_OnClick()"
        objHref.LinkName = "<img src='../../images/up.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='middle'>")
        objHref.FunctionName = "btnView_RemoveSelected_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/left.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td><td>")
        objHref.FunctionName = "btnView_MoveDownBy1_OnClick()"
        objHref.LinkName = "<img src='../../images/down.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='middle'>")
        objHref.FunctionName = "btnView_RemoveAll_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/allleft.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td><td>")
        objHref.FunctionName = "btnView_MoveToBottom_OnClick()"
        objHref.LinkName = "<img src='../../images/bottommost.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<br>")

        'Display Sort Fields
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunctions.General.WriteHTML("<table cellspacing='0' class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='4'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SORTFIELDS"))
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td colspan='2'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LISTOFFIELDS"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td colspan='2' width='150px' align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECTEDFIELDS"))
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td style='width:30%' rowspan='4'>")
        'modified by HarshK for sp4 issueid 539
        strQuery = "Exec usp_Sel_tbl_IB_ProjectViews_GetFieldList " & m_lngProjectId & ", " & m_lngProjectViewId & ", 'S',0, '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security to custom fields
        'Date   :   6 July 2004
        'Requirement No.:IB_PBN_ENT_05
        'Addition   :  Added One More Parameter RoleID to the Sp
        strQuery &= "," + m_intRoleID.ToString + "," + m_lngUserId.ToString
        'End modified by HarshK for sp4 issueid 539
        '****End Addition*****
        strTemp = "OnDblClick = 'lstSort_FieldList_OnDblClick_Custom()' Onfocus= 'lstSort_FieldList_onfocus()'"
        CommonFunctions.HTMLControls.DrawListBox("lstSort_FieldList", strQuery, 180, 150, , strTemp)
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='middle' style='width:20%'>")
        objHref.FunctionName = "btnSort_AddAll_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/allright.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td style='width:30%' rowspan='4'>")
        'modified by HarshK for sp4 issueid 539
        strQuery = "Exec usp_Sel_tbl_IB_ProjectViews_GetFieldList " & m_lngProjectId & ", " & m_lngProjectViewId & ", 'S',1, '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security to custom fields
        'Date   :   6 July 2004
        'Requirement No.:IB_PBN_ENT_05
        'Addition   :  Added One More Parameter RoleID to the Sp
        strQuery &= "," + m_intRoleID.ToString + "," + m_lngUserId.ToString
        'End modified by HarshK for sp4 issueid 539
        '****End Addition*****
        strTemp = "OnDblClick = 'lstSort_SelectedFields_OnDblClick()' Onfocus= 'lstSort_SelectedFields_onfocus()'"
        CommonFunctions.HTMLControls.DrawListBox("lstSort_SelectedFields", strQuery, 180, 150, , strTemp)
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidSelectedSortFields", "txthidSelectedSortFields", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td style='width:20%'>")
        objHref.FunctionName = "btnSort_MoveToTop_OnClick()"
        objHref.LinkName = "<img src='../../images/topmost.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='middle'>")
        objHref.FunctionName = "btnSort_AddSelected_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/right.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td><td>")
        objHref.FunctionName = "btnSort_MoveUpBy1_OnClick()"
        objHref.LinkName = "<img src='../../images/up.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='middle'>")
        objHref.FunctionName = "btnSort_RemoveSelected_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/left.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td><td>")
        objHref.FunctionName = "btnSort_MoveDownBy1_OnClick()"
        objHref.LinkName = "<img src='../../images/down.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='middle'>")
        objHref.FunctionName = "btnSort_RemoveAll_OnClick_Custom()"
        objHref.LinkName = "<img src='../../images/allleft.gif' border='0' height='14' width='18'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td><td>")
        objHref.FunctionName = "btnSort_MoveToBottom_OnClick()"
        objHref.LinkName = "<img src='../../images/bottommost.gif' border='0' height='18' width='14'>"
        objHref.ReturnHTML = True
        CommonFunctions.General.WriteHTML(objHref.GetDynamicLink())
        CommonFunctions.General.WriteHTML("</td></tr>")

        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td>&nbsp;</td><td>&nbsp;</td><td align='right' width='150px'>")
        CommonFunctions.General.WriteHTML("(" & MyBase.GetResourceString("DOUBLECLICKTOCHANGESORTORDER") & ")")
        CommonFunctions.General.WriteHTML("</td><td>&nbsp;</td>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML("</div>")

        ' Store the already exists views and the old name of selected view
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidOldViewName", "txthidOldViewName", , , , strViewName, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15

        strQuery = "Exec usp_Sel_tbl_IB_Project_Views " & m_lngProjectId & ", '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "', " & m_lngUserId
        drDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        strTemp = ""
        If CommonFunctions.General.CheckIsNothing(drDetails) <> "" Then
            strTemp = STR_SEPERATOR
            While drDetails.Read()
                strTempViewName = CommonFunctions.Data.CheckIsDBNull(drDetails.Item("ViewName")).ToString()
                strTempViewName = CommonFunctions.General.UnBuildQueryString(strTempViewName)
                strTemp &= strTempViewName & STR_SEPERATOR
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drDetails)
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidAllViewNames", "txthidAllViewNames", , , , strTemp, , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        'Display Menu at footer
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub SaveViewDetails()
        Dim strQuery As String
        Dim strViewName As String
        Dim strViewFields As String
        Dim strSortFields As String

        strViewName = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtViewName"), "").ToString().Trim()
        strViewName = CommonFunctions.General.UnBuildQueryString(strViewName)
        strViewFields = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("lstView_SelectedFields"), "").ToString().Trim()
        strViewFields = CommonFunctions.General.UnBuildQueryString(strViewFields)
        strSortFields = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("lstSort_SelectedFields"), "").ToString().Trim()
        strSortFields = CommonFunctions.General.UnBuildQueryString(strSortFields)

        strQuery = "Exec usp_Ins_tbl_IB_Project_Views "
        If m_lngProjectViewId > 0 Then
            strQuery &= m_lngProjectViewId.ToString() & ", "
        Else
            strQuery &= "NULL, "
        End If
        strQuery &= m_lngProjectId.ToString & ", " & CommonFunctions.General.BuildQueryString(m_strLoginType) & ", " & m_lngUserId.ToString & ", "
        If strViewName = "" Then
            strQuery &= "NULL, "
        Else
            strQuery &= "'" & CommonFunctions.General.BuildQueryString(strViewName) & "', "
        End If
        If strViewFields = "" Then
            strQuery &= "NULL, "
        Else
            strQuery &= "'" & CommonFunctions.General.BuildQueryString(strViewFields) & "', "
        End If
        If strSortFields = "" Then
            strQuery &= "NULL"
        Else
            strQuery &= "'" & CommonFunctions.General.BuildQueryString(strSortFields) & "'"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        Response.Redirect("IB_ViewBuilder.aspx?Mode=" & MODE_LIST)
    End Sub

    Private Sub SetAsDefault_View()
        Dim strQuery As String

        strQuery = "Exec usp_Upd_IB_SetDefaultView " & m_lngProjectId & ", '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "', " & m_lngUserId & ", "
        If m_lngProjectViewId > 0 Then
            strQuery &= m_lngProjectViewId.ToString()
        Else
            strQuery &= " NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
    End Sub
#End Region

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objViewListGrid = Nothing
    End Sub

    Private Sub m_objViewListGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objViewListGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
            Args.ApplySorting = False
            'Modified By VarunA on 13-July-2007 Whizible 7.0 Development & Release
            'Purpose : Not to have sorting on set default
            'ElseIf Args.ColIndex = 6 Then
        ElseIf Args.ColIndex = 6 Or Args.ColIndex = 7 Then
            'End By VarunA on 13-July-2007 
            Args.ApplySorting = False
        End If
    End Sub

    Private Sub m_objViewListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objViewListGrid.DataRowTD_BeforePrint
        Select Case Args.ColIndex
            Case 4
                Args.StringToBeInserted = "<TD width=35% align=left valign=top>"
                Args.StringToBeInserted &= Replace("" & Args.DataReader.Item("Fields").ToString(), ",", ", ")
                Args.StringToBeInserted &= "</TD>"
                Cancel = True

            Case 5
                Args.StringToBeInserted = "<TD width=35% align=left valign=top>"
                Args.StringToBeInserted &= Replace("" & Args.DataReader.Item("SortBy").ToString(), ",", ", ")
                Args.StringToBeInserted &= "</TD>"
                Cancel = True
        End Select
        'Addition by Harshada d for PCFC ISSUE ID 19229 to show default view in blue colour
        Dim m_viewID As String
        Dim strSQL As String
        Dim str_projectViewID As String
        Dim drDefaultView As IDataReader
        'Modified by SandipL on 20 Feb 2006 for IssueID 2164
        '        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID"), "0"), Long) '312
        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("IssueProject"), "0"), Long) '312
        'End Modification by SandipL on 20 Feb 2006
        m_lngUserId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intUserID"), "0"), Long) '61
        m_strLoginType = CommonFunctions.General.CheckIsNothing(Session.Item("LoginType"), "") '"E"
        m_viewID = Args.DataReader.Item("projectViewID").ToString()
        'take default View ID from table

        'Modified and Commented By VarunA on 13-July-2007 Whizible 7.0 Development & Release
        'strSQL = "Exec usp_Sel_tbl_IB_DefaultView " + m_lngUserId.ToString + ", " + m_lngProjectId.ToString + ", '" & m_strLoginType.ToString + "'"
        'drDefaultView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If drDefaultView.Read Then
        '    str_projectViewID = (CommonFunctions.Data.CheckIsDBNull(drDefaultView.Item("projectViewID")).ToString)
        'End If
        str_projectViewID = CType(Args.DataReader("DefaultViewID").ToString, String)
        'End By VarunA on 13-July-2007

        'Destroy DataReader
        CommonFunctions.Data.DisposeDataReader(drDefaultView)
        ' End If
        'if default view id and view id which is being printed (view ID which is taken from arg.datareader)is same then ..print that row in blue
        If str_projectViewID <> "" Then
            If str_projectViewID.ToString() = m_viewID.ToString() Then
                Select Case Args.ColIndex
                    Case 1
                        Args.StringToBeInserted = "<TD width=3% align=left valign=top style = 'color:Blue'>"
                        Args.StringToBeInserted &= Replace("" & Args.DataReader.Item("ProjectViewID").ToString(), ",", ", ")
                        Args.StringToBeInserted &= "</TD>"
                        Cancel = True
                    Case 2
                        Args.StringToBeInserted += " <td style='width:3%'align=left valign=top> <A link= blue href='Javascript:ViewName_OnClick(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("projectViewID"), "0"), String) + " )'><Font color='Blue'>" + CType(Args.DataReader.Item("ViewName").ToString(), String) + "</A></td>"
                        Cancel = True
                    Case 3
                        Args.TDStyle = "style = 'color:Blue'"
                    Case 4
                        Args.StringToBeInserted = "<TD width=39% align=left valign=top style = 'color:Blue'>"
                        Args.StringToBeInserted &= Replace("" & Args.DataReader.Item("Fields").ToString(), ",", ", ")
                        Args.StringToBeInserted &= "</TD>"
                        Cancel = True
                    Case 5
                        Args.StringToBeInserted = "<TD width=39% align=left valign=top style = 'color:Blue'>"
                        Args.StringToBeInserted &= Replace("" & Args.DataReader.Item("SortBy").ToString(), ",", ", ")
                        Args.StringToBeInserted &= "</TD>"
                        Cancel = True
                    Case 7
                        Args.StringToBeInserted = "<TD width=3% align=left valign=top  style = 'color:Blue'>"
                        Args.StringToBeInserted &= "<A href='Javascript:Apply_OnClick(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("projectViewID"), "0"), String) + " )'><Font color='Blue'>Apply</A></td>"
                        Cancel = True
                    Case 8
                        Args.StringToBeInserted = "<td style='width:4%'align=center valign=top ><Input type=checkbox name='chkDelete' id='chkDelete' class='clsCheckBox' disabled ></td>"
                        Cancel = True
                End Select
                'end of addition by harshada d
            End If
        End If
        'Added By VarunA on 12-July-2007 Whizible Development & Release
        'Purpose : Not to have link for Other Views in the View List
        If Args.DataReader("ViewType").ToString.ToUpper = "OTHER VIEWS" Then
            Select Case Args.ColIndex
                Case 2
                    If str_projectViewID <> "" Then
                        If str_projectViewID.ToString() = m_viewID.ToString() Then
                            Args.StringToBeInserted = " <td style='width:3%;color:Blue' align=left valign=top> " + CType(Args.DataReader.Item("ViewName").ToString(), String) + "</td>"
                        Else
                            Args.StringToBeInserted = " <td style='width:3%' align=left valign=top> " + CType(Args.DataReader.Item("ViewName").ToString(), String) + "</td>"

                        End If
                    Else
                        Args.StringToBeInserted = " <td style='width:3%' align=left valign=top> " + CType(Args.DataReader.Item("ViewName").ToString(), String) + "</td>"

                    End If
                    Cancel = True
                Case 8
                    Args.StringToBeInserted = "<td style='width:4%'align=center valign=top ><Input type=checkbox name='chkDelete' id='chkDelete' class='clsCheckBox' disabled ></td>"
                    Cancel = True
            End Select
        End If
        'End By VarunA on 12-July-2007

        'Added By VarunA on 13-July-2007 Whizible Development & Release
        'Purpose : To have Set Default link in the list
        Select Case Args.ColIndex
            Case 6
                If str_projectViewID <> "" Then
                    If str_projectViewID.ToString() = m_viewID.ToString() Then
                        Args.StringToBeInserted = "<TD width=4% align=left valign=top  style = 'color:Blue'>"
                        Args.StringToBeInserted &= "<A href='Javascript:SetDefault_List_OnClick(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("projectViewID"), "0"), String) + " )'><Font color='Blue'>Set As Default</A></td>"
                    Else
                        Args.StringToBeInserted = " <td style='width:4%' align=left valign=top><A href='Javascript:SetDefault_List_OnClick(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("projectViewID"), "0"), String) + " )'>Set As Default</A></td>"
                    End If
                Else
                    Args.StringToBeInserted = " <td style='width:4%' align=left valign=top><A href='Javascript:SetDefault_List_OnClick(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("projectViewID"), "0"), String) + " )'>Set As Default</A></td>"
                End If
                Cancel = True
        End Select
        'End By VarunA on 13-July-2007
    End Sub
    ''Added by Yogesh J on 02-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ViewName_OnClick(ProjectViewID As String, EmployeeID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(ProjectViewID, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    ''End of addition by Yogesh J on 02-Feb-2016
End Class
