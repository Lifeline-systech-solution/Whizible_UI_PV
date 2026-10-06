'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise
' Module Name      :    Resource Allocation
' Purpose          :    Displays the List of requests to the Resource Allocator
' Description      :    <Description>
' Assumptions      :    <Assumptions>
' Dependencies     :    <Dependencies>
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    April 08, 2004case 11

' Revisions        :    
'******************************************************************

Public Class PM_ResourceAllocation
    Inherits WebPages.Template.WhizTemplate

#Region " Constants Used in the Class "
    Protected Const DASHBOARD_ID As Integer = 30
    Protected Const ITEM_ID As Integer = 23

    Private ALLOCATION_LEVEL_CORPORATE As String = "Corporate"
    Private ALLOCATION_LEVEL_BUSINESSGROUP As String = "Business Group"

    'Commented by MrugajaB
    Private ALLOCATION_LEVEL_ODC As String = "ODC"
    'Private ALLOCATION_LEVEL_ODC As String = "Organization Unit"

    Private Const STATUS_REQUESTED As String = "R"
    Private Const STATUS_ASSIGNED As String = "A"
    Private Const STATUS_CLOSED As String = "C"
    Private Const STATUS_REJECTED As String = "REJECT"
    Private Const STATUS_EXTENDED As String = "E"
    Private Const STATUS_ESCALATED As String = "ESCALATE"
    Private Const STATUS_PREPONED As String = "P"
    Private Const STATUS_DEFERRED As String = "D"
    Private Const STATUS_Opened As String = "O"
    Private Const STATUS_CHANGE As String = "CHANGE"
    Private Const TEAM_MANAGER As String = ",TM,"
    Private Const RESOURCE_MANAGER As String = ",RM,"
    Private Const OU_MANAGER As String = ",OUM,"
    Private Const BG_MANAGER As String = ",BGM,"
    Private Const GLOBAL_RESOURCE_MANAGER As String = ",GRM,"
    Private Const ADMIN As String = ",ADMIN,"
    'Added by TruptiK on 23-Jan-2008
    Private Const RESOURCEPOOL_MANAGER As String = ",RPM,"
    'End of addition by TrupitK

    Private Enum MenuIndex
        'REQUESTS_SUMMARY
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 1
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Protected m_lngTagId As Long = 0
    Protected m_lngUserID As Long = 0
    Public m_strStatus As String = ""
    Public m_project As String = ""
    Public m_RequestID As String = ""
    Private m_strFromDate As String = ""
    Private m_strToDate As String = ""
    Private m_strSortBy As String = ""
    Private m_strSortOrder As String = ""

    Protected tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
    Protected divGraphs As System.Web.UI.HtmlControls.HtmlControl
    Private cell As New HtmlTableCell
    Private row As New HtmlTableRow
    Protected m_strClientSideScript As String = ""
    ' Whether logged in user is Team manager / Resource Manager / Global Resource Manager
    Private m_strUserType As String = ""
    Protected m_intMessageID As Integer = 0
    'The Resource Allocation Level
    Private m_strResourceAllocationLevel As String = ""
#End Region

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

#Region " Page / Class Events "
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()

        'Get User type
        GetUserType()
        GetResourceAllocationLevel()

        If m_strUserType.IndexOf(TEAM_MANAGER) > -1 Then
            m_intMessageID = 428
        ElseIf m_strUserType.IndexOf(RESOURCE_MANAGER) > -1 Then
            m_intMessageID = 429
        ElseIf m_strUserType.IndexOf(OU_MANAGER) > -1 Then
            m_intMessageID = 431
        ElseIf m_strUserType.IndexOf(BG_MANAGER) > -1 Then
            m_intMessageID = 433
        End If

        'Added by TruptiK on 05-Nov-08
        'Purpose:-
        If m_strResourceAllocationLevel = "Business Group" Then
            m_intMessageID = 433
        ElseIf m_strResourceAllocationLevel = "ODC" Then
            m_intMessageID = 431
        End If
        'end of additiin by TruptiK
        m_lngTagId = m_objGlobal.TagID
        m_lngUserID = m_objGlobal.UserID
        m_strStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("Status"), "").Trim().ToUpper()

        'If m_strStatus = "" And m_strStatus = "" Then
        'Then m_strStatus = "R"


        If Not HttpContext.Current.Request.QueryString("Status") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Status") <> "" Then
            m_strStatus = HttpContext.Current.Request.QueryString("Status")
        ElseIf Not HttpContext.Current.Request.Form("cboRequest") Is Nothing AndAlso HttpContext.Current.Request.Form("cboRequest") <> "" Then
            m_strStatus = HttpContext.Current.Request.Form("cboRequest")
        End If
        If m_strStatus = "" Then m_strStatus = "R"

        If Not HttpContext.Current.Request.QueryString("Project") Is Nothing AndAlso HttpContext.Current.Request.QueryString("Project") <> "" Then
            m_project = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.QueryString("Project"))
        ElseIf Not HttpContext.Current.Request.Form("txtProject") Is Nothing AndAlso HttpContext.Current.Request.Form("txtProject") <> "" Then
            m_project = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form("txtProject"))
        End If



        If Not HttpContext.Current.Request.QueryString("RequestID") Is Nothing AndAlso HttpContext.Current.Request.QueryString("RequestID") <> "" Then
            m_RequestID = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.QueryString("RequestID"))
        ElseIf Not HttpContext.Current.Request.Form("txtRequestID") Is Nothing AndAlso HttpContext.Current.Request.Form("txtRequestID") <> "" Then
            m_RequestID = CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form("txtRequestID"))
        End If

        m_RequestID = m_RequestID.Trim()

        'm_project = CommonFunctions.General.CheckIsNothing(Request.QueryString("Project"), "").Trim().ToUpper()

        'm_RequestID = CommonFunctions.General.CheckIsNothing(Request.QueryString("RequestID"), "").Trim().ToUpper()

        If Not Page.IsPostBack Then
            m_strSortBy = CommonFunctions.General.CheckIsNothing(Request.QueryString("SortByField"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(Request.QueryString("ASCorDESC"), "")
            CommonFunction.Dates.GetFromAndToDates("10", m_strFromDate, m_strToDate, "")
            If m_strFromDate <> "" Then
                m_strFromDate = CommonFunctions.Dates.GetDate(CType(m_strFromDate, Date))
            End If
            If m_strToDate <> "" Then
                m_strToDate = CommonFunctions.Dates.GetDate(CType(m_strToDate, Date))
            End If
        Else
            m_strFromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFromDate"), "")
            m_strToDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtToDate"), "")
            m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
            m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        End If
        If m_strSortBy = "" Then m_strSortBy = "RequestDate"
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"

    End Sub
    ''Added By Shamkant S on 16 feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function Request_OnClick(RequestID As String) As String
        Try
            Dim m_PKToken_Request_Task As String
            m_PKToken_Request_Task = CommonFunctions.Security.Token.GetToken(CType(RequestID, String) + "0" + "0")

            Return m_PKToken_Request_Task
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''Ended By Shamkant s 16 Feb 2016
    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub
    'Commented By SuchitraP on 21 Feb 2008
    'Added by ArchanaN on 5 Nov 2007 for Opportinity Details tabs
    'Public Sub PlotHeader()
    '    CommonFunctions.General.WriteHTML("<TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width='100%'>")
    '    CommonFunctions.General.WriteHTML("<TR class=clsTRNavLinks valign=middle>")
    '    CommonFunctions.General.WriteHTML("<TD noWrap>")
    '    CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Opportunity Details' href='javascript:ItemTab_OnClick(""Opportunity"")'>Opportunity Details</a>")
    '    CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Resource Allocation' href='javascript:ItemTab_OnClick(""RA"")' >Resource Allocation</a>")
    '    CommonFunctions.General.WriteHTML("</TD> </TR>")
    '    CommonFunctions.General.WriteHTML("</TABLE>")
    'End Sub
    'End by ArchanaN
    'End by SuchitraP 
    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim objDynamicLink As WebPages.UI.cDynamicLink
        Dim ObjSectionTitle As WebPages.Template.SectionTitle
        'PlotHeader()
        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Filter Controls
        CommonFunctions.General.WriteHTML("<table class='clsTable' CellSpacing='0' cellpadding='0' width='99.9%'>")
        'Status Filters
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td> Request Type")
        'CommonFunctions.General.WriteHTML("&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("</td>")
        'Added by TruptiK on 28-May-09
        'Purpose:-UI changes.
        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboRequest", "usp_sel_Request_type " + m_objGlobal.UserID.ToString(), 150, m_strStatus, "onChange=comboChanged()", , False))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td> Project")
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtProject", "txtProject", , 150, 9, m_project, , , , , , , ToBeInserted:=" OnKeyPress=Projectenter(event)", EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'> Request ID")
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtRequestID", "txtRequestID", , 80, 9, m_RequestID, , , , , , , ToBeInserted:=" OnKeyPress=RequestIDenter(event)", EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("</tr>")
        'CommonFunctions.General.WriteHTML("<tr class='clsTREven' align=left>")
        'If (m_strUserType.IndexOf(ADMIN) > -1) Or _
        '   (m_strUserType.IndexOf(OU_MANAGER) > -1 And m_strResourceAllocationLevel = ALLOCATION_LEVEL_ODC) Or _
        '   (m_strUserType.IndexOf(BG_MANAGER) > -1 And m_strResourceAllocationLevel = ALLOCATION_LEVEL_BUSINESSGROUP) Or _
        '   (m_strUserType.IndexOf(RESOURCEPOOL_MANAGER) > -1) Or _
        '  (m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) > -1 And m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE) Then
        '    CommonFunctions.General.WriteHTML("<td align='left' style=nowrap>")
        '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , CType(m_strStatus = STATUS_EXTENDED, Boolean), STATUS_EXTENDED, , "OnClick=""Status_OnClick('" & STATUS_EXTENDED & "')"""))
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("EXTEND_BOOKING_REQUESTS"))
        '    CommonFunctions.General.WriteHTML("</td>")

        '    CommonFunctions.General.WriteHTML("<td align='left' style=nowrap>")
        '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , CType(m_strStatus = STATUS_PREPONED, Boolean), STATUS_PREPONED, , "OnClick=""Status_OnClick('" & STATUS_PREPONED & "')"""))
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PREPONE_BOOKING_REQUESTS"))
        '    CommonFunctions.General.WriteHTML("</td>")
        'Else
        '    CommonFunctions.General.WriteHTML("<td></td><td></td>")

        'End If
        'Trupti
        'If (m_strUserType.IndexOf(ADMIN) > -1) Or _
        '  (m_strUserType.IndexOf(OU_MANAGER) > -1 And m_strResourceAllocationLevel = ALLOCATION_LEVEL_ODC) Or _
        '  (m_strUserType.IndexOf(BG_MANAGER) > -1 And m_strResourceAllocationLevel = ALLOCATION_LEVEL_BUSINESSGROUP) Or _
        ' (m_strUserType.IndexOf(RESOURCEPOOL_MANAGER) > -1) Or _
        '  (m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) > -1 And m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE) Then
        '    CommonFunctions.General.WriteHTML("<td align='left' style=nowrap>")
        '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , CType(m_strStatus = STATUS_PREPONED, Boolean), STATUS_PREPONED, , "OnClick=""Status_OnClick('" & STATUS_PREPONED & "')"""))
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PREPONE_BOOKING_REQUESTS"))
        '    CommonFunctions.General.WriteHTML("</td>")
        'Else
        '    CommonFunctions.General.WriteHTML("<td></td><td></td>")

        'End If
        ' end



        'If m_strResourceAllocationLevel <> ALLOCATION_LEVEL_CORPORATE And m_strUserType.IndexOf(ADMIN) = -1 And _
        '    m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) = -1 Then
        '    CommonFunctions.General.WriteHTML("<td align='left' style=nowrap>")
        '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , CType(m_strStatus = STATUS_ESCALATED, Boolean), STATUS_ESCALATED, , "OnClick=""Status_OnClick('" & STATUS_ESCALATED & "')"""))
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ESCALATED_REQUESTS"))
        '    CommonFunctions.General.WriteHTML("</td>")
        '    'CommonFunctions.General.WriteHTML("<td colspan=4></td>")
        '    'Else
        '    'CommonFunctions.General.WriteHTML("<td></td><td></td>")
        '    'CommonFunctions.General.WriteHTML("<td colspan=6></td>")
        'End If
        ''Added by TrupitK on 27-Feb-2008
        'If m_strResourceAllocationLevel <> ALLOCATION_LEVEL_CORPORATE And m_strUserType.IndexOf(ADMIN) = -1 And _
        '  m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) = -1 Then
        '    CommonFunctions.General.WriteHTML("<td align='left' style=nowrap>")
        '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , CType(m_strStatus = STATUS_DEFERRED, Boolean), STATUS_DEFERRED, , "OnClick=""Status_OnClick('" & STATUS_DEFERRED & "')"""))
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DEFERRED_REQUESTS"))
        '    CommonFunctions.General.WriteHTML("</td>")
        '    CommonFunctions.General.WriteHTML("<td></td><td></td>")
        '    CommonFunctions.General.WriteHTML("<td colspan=2></td>")
        'Else
        '    CommonFunctions.General.WriteHTML("<td align='left' style=nowrap>")
        '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optStatus", "optStatus", , CType(m_strStatus = STATUS_DEFERRED, Boolean), STATUS_DEFERRED, , "OnClick=""Status_OnClick('" & STATUS_DEFERRED & "')"""))
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DEFERRED_REQUESTS"))
        '    CommonFunctions.General.WriteHTML("</td>")
        '    CommonFunctions.General.WriteHTML("<td></td><td></td>")
        '    CommonFunctions.General.WriteHTML("<td colspan=4></td>")
        'End If
        ''End of addition by TruptiK on 27-Feb-2008
        'CommonFunctions.General.WriteHTML("</tr>")
        ''Date Filters
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='Left' colspan=3>Request Date")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;From")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strFromDate, , "frmPM_ResourceAllocation", returnHTML:=True))
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;To")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strToDate, , "frmPM_ResourceAllocation", returnHTML:=True))
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = MyBase.GetResourceString("SHOW")
        objDynamicLink.Tooltip = MyBase.GetResourceString("SHOW_TOOLTIP")
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True
        CommonFunctions.General.WriteHTML(" | <B>" + objDynamicLink.GetDynamicLink() + "</B> | ")
        objDynamicLink = Nothing
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("<BR>")
        '''Commented And Added By Vaijat K ON 13/10/2015 to adjust height of div as per browser
        CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' style='overflow:auto;WIDTH:100%;height:300px'>")
        ''' commented by Nilesh g on 17/11/2015 for issue id 19996
        'CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' style='overflow:auto;WIDTH:100%;")
        'If Request.Browser.Browser = "InternetExplorer" Then
        '    CommonFunctions.General.WriteHTML("height:695px'>")
        'ElseIf Request.Browser.Browser = "Chrome" Then
        '    CommonFunctions.General.WriteHTML("height:689px'>")
        'ElseIf Request.Browser.Browser = "Firefox" Then
        '    CommonFunctions.General.WriteHTML("height:675px'>")
        'End If
        ''End Added By Vaijat K ON 13/10/2015 to adjust height of div as per browser
        'Display the List of requets.
        DisplayListof_Requests()
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Graph of Skillwise Resources 
        ObjSectionTitle = New WebPages.Template.SectionTitle
        With ObjSectionTitle
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("SKILLWISE_RESOURCES"), "divGraphSection", "ShowHide_divGraphSection", , , , , ))
            Response.Write(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
            Response.Write(.ClientsideScript())
            Response.Write(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
        End With
        ObjSectionTitle = Nothing
        CommonFunctions.General.WriteHTML("<DIV Id='divGraphSection' style='HEIGHT:150px;'>")
        DisplayNonNeedleGraphs()
        CommonFunctions.General.WriteHTML("</DIV>")

        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("</DIV>")
        'Display the Menu at Bottom
        CommonFunctions.General.WriteHTML(strMenu)
        'Hidden Controls
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

    End Sub

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_ResourceAllocation", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Common Functions or Procedures "
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_ResourceAllocation : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        '====================================================================
        ' Procedure Name        : InitPageMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Builds the arrays required to display the Menu.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 08, 2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        'm_arrMenuItem(MenuIndex.REQUESTS_SUMMARY) = MyBase.GetResourceString("MENU_PM_REQUESTS_SUMMARY")
        'm_arrMenuTooltip(MenuIndex.REQUESTS_SUMMARY) = MyBase.GetResourceString("MENU_PM_REQUESTS_SUMMARY_TOOLTIP")
        'm_arrClientSideFunctions(MenuIndex.REQUESTS_SUMMARY) = "Summary_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        'Modified By VarunA on 15-Mar-2008
        'm_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId.ToString() & ")"
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(2345)"
        'End By VarunA on 15-Mar-2008

        MyBase.InitializeResources("AppResources.PM_ResourceAllocation", "AppResources")
    End Sub

    Private Sub GetUserType()
        '====================================================================
        ' Procedure Name       : GetUserType
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Get the logged in users type whether it is Team Manager / Resource Manager /
        '                        Global Resource Manager / Others
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : July 03, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""

        strQuery = "DECLARE @strType VARCHAR(30)" & vbCrLf
        strQuery &= " Exec usp_Sel_GetUserType " & m_objGlobal.UserID.ToString() & ", @strType OUT" & vbCrLf
        strQuery &= " SELECT @strType"
        m_strUserType = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
    End Sub

    Private Sub GetResourceAllocationLevel()
        '====================================================================
        ' Procedure Name       : GetResourceAllocationLevel
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Get the Resource allocation level
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : Aug 24, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""

        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT ResourceAllocationLevel FROM tbl_Pm_CompanyInformation"
        strQuery = "usp_sel_tbl_PM_CompanyInformation_ResourceAllocationLevel"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_strResourceAllocationLevel = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
    End Sub
#End Region

    Private Sub DisplayListof_Requests()
        '====================================================================
        ' Procedure Name        : DisplayListof_Requests
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedures assigns values to the Grid object, which display the list of 
        '                         Requests.  
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 08, 2004
        ' Revisions             :
        '=====================================================================

        Dim strQuery As String = ""
        Dim strWhereClause As String = ""
        Dim intColumnsToShow As Integer = 14
        'Modified by TruptiK on 28-Feb-2008
        'Purpose:-Add two fields 1.Request Status 2.Project Status.
        'Modified by TrutpiK on 29-MAy-09
        'Purpose:-UI changes.
        Dim arrActualColumns() As String = {"Requesttype", "RequestID", "RequestDate", "Project", "Requestor", _
                                            "FromDate", "ToDate", "Type", "WorkHours", "NoOfResources", "TotalAssignedResources", "", _
                                            "RequestStatus", "ProjectStatus", MyBase.GetResourceString("DETAILS"), _
                                             "RequestID", "RequestID", MyBase.GetResourceString("REMINDER")}







        Dim arrUserFriendlyColumn() As String = {"Request Type", MyBase.GetResourceString("ID"), MyBase.GetResourceString("REQUEST_DATE"), _
                                                 MyBase.GetResourceString("PROJECT"), MyBase.GetResourceString("REQUESTOR"), _
                                                 MyBase.GetResourceString("FROM_DATE"), MyBase.GetResourceString("TO_DATE"), _
                                                 "Allocation Type", MyBase.GetResourceString("WORK_HOURS"), MyBase.GetResourceString("REQUESTED"), _
                                                MyBase.GetResourceString("ASSIGNED"), MyBase.GetResourceString("COMMENTS"), _
                                                MyBase.GetResourceString("REQUEST_STATUS"), MyBase.GetResourceString("PROJECT_STATUS"), MyBase.GetResourceString("VIEW_DETAILS"), _
                                                MyBase.GetResourceString("ESCALATE"), _
                                                MyBase.GetResourceString("VIEW_ESCALATION_COMMENTS"), MyBase.GetResourceString("REMINDER")}



        Dim arrRowLink() As String = {"", "Display_Details(RequestID,Requesttype)", "", "", "", "", "", "", "", "", _
                                    "", "ViewComments(RequestID,re)", "", "", "ExtendBooking(RequestID)", _
                                    "EscalateRequest_OnClick(RequestID)", _
                                     "EscalateRequest_OnClick(RequestID)", "Reminder_OnClick(RequestID)"}



        Dim arrGroupOnColumn() As String = {"1"}

        Dim arrstrTDStyle() As String = {"align='left' width=5", "align='left' width=20", "align='left' width=100 NoWrap", "align='left' width=90", _
                                       "align='left' width=80", "align='left' width=90 NoWrap", "align='left' width=90 NoWrap", "align='left' width=50", "align='right' width=30", _
                                       "align='right' width=30  NoWrap", "align='right' width=20  NoWrap", "align='right' width=20", _
                                       "align='left' width=50 NoWrap", "align='left' width=50 NoWrap", _
                                       "align='left' width=50", "align='left' width=50", "align='left width=50", "align='left' width=50"}




        'Apply filters of the From Date and To Date
        If (m_strFromDate <> "" Or m_strToDate <> "") And strWhereClause <> "" Then
            strWhereClause &= " AND"
        End If
        If m_strFromDate <> "" And m_strToDate <> "" Then
            strWhereClause &= " RequestDate between ''" & m_strFromDate & "'' AND ''" & m_strToDate & "'' "
        ElseIf m_strFromDate <> "" Then
            strWhereClause &= " RequestDate >= ''" & m_strFromDate & "'' "
        ElseIf m_strToDate <> "" Then
            strWhereClause &= " RequestDate <= ''" & m_strToDate & "'' "
        End If
        'Added by SanaS on 21-Aug-2009 for Change Allocation Request
        If m_strStatus = "P" Then
            strQuery = "Exec usp_Sel_tbl_PM_ResourceRequests_Prepone " & m_objGlobal.UserID.ToString()
            If strWhereClause <> "" Then
                strQuery &= ", '" & strWhereClause & "'"
            Else
                strQuery &= ","
            End If
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strStatus) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & " "
            strQuery &= CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
            'end of addition by TruptiK on 11-Jan-2008
            If m_project <> "" Then
                strQuery &= ", '" & m_project & "'"
            Else
                strQuery &= ", null"
            End If
            If m_RequestID <> "" Then
                strQuery &= "," & m_RequestID
            Else
                strQuery &= ", null"
            End If
            'Added by TruptiK on 28-Feb-2008
            'Purpose:-Added one more option button:Deferred Requests.
        ElseIf m_strStatus = "D" Then
            strQuery = "Exec usp_Sel_tbl_PM_ResourceRequests_Deferred " & m_objGlobal.UserID.ToString()
            If strWhereClause <> "" Then
                strQuery &= ", '" & strWhereClause & "'"
            Else
                strQuery &= ", null"
            End If
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strStatus) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & " "
            strQuery &= CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
            'End of addition by TrupitK 
            If m_project <> "" Then
                strQuery &= ", '" & m_project & "'"
            Else
                strQuery &= ", null"
            End If
            If m_RequestID <> "" Then
                strQuery &= "," & m_RequestID
            Else
                strQuery &= ", null"
            End If
        ElseIf m_strStatus = "O" Then
            strQuery = "Exec usp_Sel_tbl_PM_ResourceRequests_Open " & m_objGlobal.UserID.ToString()
            If strWhereClause <> "" Then
                strQuery &= ", '" & strWhereClause & "'"
            Else
                strQuery &= ", null"
            End If
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strStatus) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & " "
            strQuery &= CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
            'End of addition by TrupitK 
            If m_project <> "" Then
                strQuery &= ", '" & m_project & "'"
            Else
                strQuery &= ", null"
            End If
            If m_RequestID <> "" Then
                strQuery &= "," & m_RequestID
            Else
                strQuery &= ", null"
            End If
        ElseIf m_strStatus = "CHANGE" Then
            strQuery = "Exec usp_Sel_tbl_PM_ResourceRequests_ChangeAllocation " & m_objGlobal.UserID.ToString()
            If strWhereClause <> "" Then
                strQuery &= ", '" & strWhereClause & "'"
            Else
                strQuery &= ", null"
            End If

            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & " "
            strQuery &= CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
            'end of addition by TruptiK on 11-Jan-2008
            If m_project <> "" Then
                strQuery &= ", '" & m_project & "'"
            Else
                strQuery &= ", null"
            End If
            If m_RequestID <> "" Then
                strQuery &= "," & m_RequestID
            Else
                strQuery &= ", null"
            End If
        Else
            strQuery = "Exec usp_Sel_tbl_PM_ResourceRequests " & m_objGlobal.UserID.ToString()
            If strWhereClause <> "" Then
                strQuery &= ", '" & strWhereClause & "'"
            Else
                strQuery &= ", null"
            End If
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strStatus) & "'"
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & " "
            strQuery &= CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
            If m_project <> "" Then
                strQuery &= ", '" & m_project & "'"
            Else
                strQuery &= ", null"
            End If
            If m_RequestID <> "" Then
                strQuery &= "," & m_RequestID
            Else
                strQuery &= ", null"
            End If
        End If
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .GroupOnColumn = arrGroupOnColumn
            .RowLinkArray = arrRowLink
            .PrimaryKey = "RequestID"
            .EmptyValueReplacement = "&nbsp;"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = 14
            .ClientSideSortFunctionName = "Sort_OnClick"
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
        'End of modification by TruptiK on 29-MAy-09
    End Sub

#Region " Graph Related functions and Procedures "
    Private Sub DisplayNonNeedleGraphs()
        '=====================================================================
        ' Procedure Name        : DisplayNoNeedleGraphs()
        ' Purpose               : To display the skills graph for the dashboard
        ' Description           : The procedure displays the skills graph for the
        '                         dashboard
        ' Parameters Passed     : Dashboard ID, User ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Graph.dll
        ' Author                : JayavantK
        ' Created               : 13-April-2004
        ' Revisions             :
        '=====================================================================
        Dim objQRB As QueryBuilder.cQuery
        Dim drGraphs As IDataReader
        Dim dr As IDataReader
        Dim drDetails As IDataReader
        Dim intRowCount As Integer
        Dim blnShowDrillDowns As Boolean
        Dim blnOracleDB As Boolean = False
        Dim strSQL As String
        Dim strGraphSQL As String
        Dim myGraph As Graph.Graph
        Dim strLeftSectionTitle As String = ""
        Dim strSectionTag As String = ""
        Dim strFunctionName As String = ""
        Dim blnPrinted As Boolean = False
        Dim intNoOfGraphElements As Integer = 5
        Dim lngConnectionID As Long
        Dim strConnectionString As String = ""
        Dim strImagePath As String

        Response.Write("<BR>")
        strSQL = "usp_CDB_Get_UserSettings " + DASHBOARD_ID.ToString() + ","
        strSQL &= m_objGlobal.UserID.ToString + ",2,0,'" & m_objGlobal.LoginType & "'"
        drGraphs = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraphs.Read Then
            'Added By Usha Pandit On 28.04.2021 For checking if Data Reader has data to read
            Dim blnItemIDExists As Boolean = False
            If CLng(drGraphs("ItemId")) = ITEM_ID Then
                blnItemIDExists = True
            End If
            'End Of Added By Usha Pandit On 28.04.2021 For checking if Data Reader has data to read
            Do
                If CLng(drGraphs("ItemId")) = ITEM_ID Then Exit Do
            Loop While drGraphs.Read

            If Not blnPrinted Then
                m_strClientSideScript += "<script language=javascript>" + vbCrLf
                m_strClientSideScript += "ShowOtherGraphs=0;" + vbCrLf + "" + vbCrLf
                m_strClientSideScript += "</script>" + vbCrLf
                divGraphs.Attributes.Add("style", "overflow:auto;" + vbCrLf)
                'Destroy the object
                blnPrinted = True
            End If
            'Added By Usha Pandit On 28.04.2021 For checking if Data Reader has data to read
            If blnItemIDExists = True Then
                'End Of Added By Usha Pandit On 28.04.2021 For checking if Data Reader has data to read
                If CInt(drGraphs.Item("GraphTypeID")) <> 1 Then
                    With tblGraphs
                        If intRowCount = 0 Then
                            row = New HtmlTableRow
                            .Rows.Add(row)
                        End If
                        intRowCount += 1
                        ' add row cells
                        cell = New HtmlTableCell
                        cell.Attributes.Add("width", "100%")
                        cell.Attributes.Add("align", "center")
                        cell.Attributes.Add("Valign", "middle")

                        objQRB = New QueryBuilder.cQuery(Session("strUserName").ToString, CType(Session("intPostID"), Long), CType(Session("intUserID"), Long), Session("LoginType").ToString, CType(Session("intRoleLevel"), Integer), CType(Session("IsCreatedByCustomer"), Boolean))
                        objQRB.QueryID = CLng(drGraphs("QueryID"))
                        objQRB.UseSQL = MyBase.UseSQL
                        strGraphSQL = objQRB.BuildQuery()

                        If Not IsDBNull(drGraphs("NoOfGraphElements")) Then
                            intNoOfGraphElements = CType(drGraphs("NoOfGraphElements"), Integer)
                        Else
                            intNoOfGraphElements = 5
                        End If

                        drDetails = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID_ForQuery	" & CLng(drGraphs("QueryID")), MyBase.UseSQL)
                        If drDetails.Read Then
                            If IsDBNull(drDetails("ConnectionID")) Then
                                lngConnectionID = 0
                            Else
                                lngConnectionID = CType(drDetails("ConnectionID"), Long)
                            End If
                        Else
                            lngConnectionID = 0
                        End If
                        CommonFunctions.Data.DisposeDataReader(drDetails)
                        CommonFunctions.General.GetConnectionString()
                        If Trim(strConnectionString & "") = "" Then strConnectionString = "" & CommonFunctions.Application.ConnectionString

                        If blnOracleDB Then
                            strGraphSQL = "SELECT " & Right(Trim(strGraphSQL & ""), Len(Trim(strGraphSQL & "")) - 6)
                            strGraphSQL = "SELECT * From (" & strGraphSQL & ") Where RowNum < " & (intNoOfGraphElements + 1)
                        Else
                            strGraphSQL = "SELECT TOP " & intNoOfGraphElements & "  " & Right(Trim(strGraphSQL & ""), Len(Trim(strGraphSQL & "")) - 6)
                        End If

                        blnShowDrillDowns = CBool(drGraphs.Item("ShowDrillDowns"))
                        If blnShowDrillDowns Then
                            strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Details  " & m_objGlobal.UserID.ToString() & "," & CType(drGraphs.Item("ItemID"), Long) & ",'" & m_objGlobal.LoginType & "'"
                            dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                            If dr.Read Then
                                blnShowDrillDowns = True
                            Else
                                blnShowDrillDowns = False
                            End If
                            CommonFunction.Data.DisposeDataReader(dr)
                        End If

                        ' in case there is an error in the graph item dont add it
                        Try
                            cell.Controls.Add(CreateGraph(CType(drGraphs.Item("ItemID"), Long), strGraphSQL, 400, 700, blnShowDrillDowns, strConnectionString))
                        Catch exc As Exception
                            cell.Attributes.Add("class", "clsTDOdd")
                            cell.Attributes.Add("border", "1")
                            cell.Attributes.Add("bordercolor", "black")
                            cell.InnerHtml = "<B>The graph was not generated</B>"
                        End Try
                        row.Cells.Add(cell)
                        If intRowCount > 1 Then
                            intRowCount = 0
                        End If
                    End With
                End If
                'Added By Usha Pandit On 28.04.2021 For checking if Data Reader has data to read
            End If
            'End Of Added By Usha Pandit On 28.04.2021 For checking if Data Reader has data to read
        End If

        ' rendering the control at the position
        tblGraphs.Attributes.Add("Style", "")
        Dim SB As New System.Text.StringBuilder
        Dim SW As New System.IO.StringWriter(SB)
        Dim htmlTW As New HtmlTextWriter(SW)
        divGraphs.RenderControl(htmlTW)
        Dim HTML As String = SB.ToString()

        Response.Write(Replace(HTML, "divGraphs", "divOtherGraph", , , Microsoft.VisualBasic.CompareMethod.Binary))

        ' hiding the rendered controls
        tblGraphs.Attributes.Add("style", "Display:None")
        divGraphs.Attributes.Add("style", "Display:None")
        CommonFunction.Data.DisposeDataReader(drGraphs)
    End Sub

    Private Function CreateGraph(ByVal ItemID As Long, ByVal SQL As String, ByVal Height As Integer, ByVal Width As Integer, ByVal ShowDrillDowns As Boolean, ByVal ConnectionString As String, Optional ByRef ImagePath As String = "") As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : Graph Control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : JayavantK
        ' Created               : 13-April-2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strBorderStyle As String = ""
        Dim strBorderColor As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim intUCL As Integer = 0
        Dim intLCL As Integer = 0
        Dim strUCLColor As String = ""
        Dim strLCLColor As String = ""
        Dim strPieLabelStyle As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim intGraphID As Integer
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim strTitleColor As String = ""

        Dim intXAxisMax As Long = 0
        Dim intXAxisMin As Long = 0
        Dim intXAxisInterval As Long = 0

        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
        Dim blnShowHover As Boolean = True
        'check the application settings for hover on graphs
        objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject("EnableHoverForCDBMain")
        If Not objFrameworkSetting Is Nothing Then
            If UCase(Trim(objFrameworkSetting.Status & "")) = "Y" Then
                blnShowHover = True
            Else
                blnShowHover = False
            End If
        End If
        objFrameworkSetting = Nothing

        ' get the item details
        strSQL = "EXEC usp_CDB_GetQueryDetails_ForItem " & DASHBOARD_ID.ToString() & ", " & ItemID & "," & m_objGlobal.UserID.ToString() & ",'" & m_objGlobal.LoginType & "'"

        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If dr.Read Then
            strItemName = dr("ItemName").ToString : strBorderStyle = dr("BorderStyle").ToString
            strBorderColor = dr("BorderColor").ToString : strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString : strCaptionColor = dr("CaptionColor").ToString
            strTitleColor = dr("TitleColor").ToString
            If Not IsDBNull(dr("UCL")) Then
                intUCL = CType(dr("UCL"), Integer)
            End If
            strUCLColor = dr("UCLColor").ToString
            If Not IsDBNull(dr("LCL")) Then
                intLCL = CType(dr("LCL"), Integer)
            End If
            strLCLColor = dr("LCLColor").ToString
            If Not IsDBNull(dr("ShowLegends")) Then
                blnShowLegends = CType(dr("ShowLegends"), Boolean)
            End If
            If Not IsDBNull(dr("ShowExplodedPie")) Then
                blnShowExplodedPie = CType(dr("ShowExplodedPie"), Boolean)
            End If
            intGraphID = CType(dr("GraphTypeID"), Integer)

            If Not IsDBNull(dr("Enable3D")) Then
                blnEnable3D = CType(dr("Enable3D"), Boolean)
            End If
            lngEntityID = CType(dr("EntityID"), Long)
            strNomenclature = dr("Nomenclature").ToString
            strPieLabelStyle = dr("PieLabelStyle").ToString

            If Not IsDBNull(dr("XAxisMin")) Then
                intXAxisMin = CType(dr("XAxisMin"), Long)
            End If
            If Not IsDBNull(dr("XAxisMax")) Then
                intXAxisMax = CType(dr("XAxisMax"), Long)
            End If
            If Not IsDBNull(dr("XAxisInterval")) Then
                intXAxisInterval = CType(dr("XAxisInterval"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        ' default title color
        If Trim(strTitleColor & "") = "" Then strTitleColor = "white"

        ' create the grpah for the item values
        objGraph = New Graph.Graph
        objGraph.ConnectionString = ConnectionString
        objGraph.VirtualImagePath = "../../Images/" : objGraph.Enable3D = blnEnable3D
        objGraph.ChartType = GetChartType(ItemID, SQL, intGraphID, MyBase.UseSQL)
        objGraph.BorderStyle = strBorderStyle
        objGraph.GraphTitle = strItemName : objGraph.TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
        objGraph.GraphTitleColor = strTitleColor
        objGraph.SQL = SQL : objGraph.Width = Width : objGraph.Height = Height
        objGraph.ShowExplodedPie = blnShowExplodedPie : objGraph.ChartBackColor = strChartBackColor
        objGraph.ChartAreaColor = strChartAreaColor : objGraph.PalleteStyle = "EARTHTONES"

        objGraph.LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
        objGraph.LegendCaptionColor = strCaptionColor : objGraph.LegendBorderColor = strCaptionColor
        objGraph.BorderColor = strBorderColor : objGraph.ShowLegends = blnShowLegends
        objGraph.BorderGradientColor = "WHITE"
        objGraph.BorderGradientStyle = "TOPBOTTOM"
        objGraph.ChartBackGradientColor = "WHITE"
        objGraph.ChartBackGradientStyle = "TOPBOTTOM"
        objGraph.ChartAreaGradientColor = "WHITE"
        If objGraph.ChartType(0) = "PIE" Or objGraph.ChartType(0) = "DOUGHNUT" Then
            objGraph.ChartAreaGradientStyle = "CENTER"
        Else
            objGraph.ChartAreaGradientStyle = "TOPBOTTOM"
        End If
        objGraph.PieChartLabelStyle = strPieLabelStyle


        'if drill downs are present?
        If ShowDrillDowns Then
            objGraph.DrillDownClientSideFunctionName = "DrillDown_OnClick(" + ItemID.ToString + ","
        End If
        objGraph.EntityID = lngEntityID : objGraph.Nomenclature = strNomenclature
        If intGraphID <> 5 Then
            objGraph.LCL = intLCL : objGraph.LCLColor = strLCLColor
            objGraph.UCL = intUCL : objGraph.UCLColor = strUCLColor
        End If

        objGraph.YAxisMin = intXAxisMin
        If intXAxisMax <> 0 Then
            objGraph.YAxisMax = intXAxisMax
        End If
        If intXAxisInterval <> 0 Then
            objGraph.YAxisInterval = intXAxisInterval
        End If

        ' return the graph control
        Return objGraph.GenerateChartControl()

    End Function

    Private Function GetChartType(ByVal ItemID As Long, ByVal strSQL As String, ByVal intGraphID As Integer, ByVal UseSQL As Boolean) As String()
        '=====================================================================
        ' Procedure Name        : GetChartType
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : JayavantK
        ' Created               : 13-April-2004
        ' Revisions             :
        '=====================================================================
        Dim ds As DataSet
        Dim intUBound As Integer
        Dim intX As Integer

        Dim dr As IDataReader
        Dim arr() As String = {}
        Dim intCount As Integer = 1
        Dim arrGraph() As String = {}

        ds = CommonFunctions.Data.GetDataSet(strSQL, "default", , , UseSQL)
        intUBound = ds.Tables(0).Columns.Count()
        ds.Dispose() : ds = Nothing

        strSQL = "usp_sel_tbl_CDB_Item_Series_Detail " + ItemID.ToString + "," + m_objGlobal.UserID.ToString + ",'" + m_objGlobal.LoginType + "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While dr.Read
            ReDim Preserve arrGraph(intCount)
            arrGraph(intCount) = dr("GraphID").ToString
            intCount += 1
        Loop
        CommonFunctions.Data.DisposeDataReader(dr)

        Select Case intGraphID
            Case 2 'pie
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "PIE"
                Next
                Return arr
            Case 3 ' column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                                arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                            Else
                                arr(intX) = "COLUMN"
                            End If
                        Else
                            arr(intX) = "COLUMN"
                        End If
                    Else
                        arr(intX) = "COLUMN"
                    End If
                Next
                Return arr
            Case 4 ' line
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "LINE"
                        End If
                    Else
                        arr(intX) = "LINE"
                    End If
                Next
                Return arr
            Case 5 ' bar
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "BAR"
                Next
                Return arr
            Case 6 ' step
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STEPLINE"
                        End If
                    Else
                        arr(intX) = "STEPLINE"
                    End If
                Next
                Return arr
            Case 7 ' doughnut
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "DOUGHNUT"
                Next
                Return arr

            Case 8 ' CandleStick
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "CANDLESTICK"
                        End If
                    Else
                        arr(intX) = "CANDLESTICK"
                    End If
                Next
                Return arr

            Case 9 ' Spline
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINE"
                        End If
                    Else
                        arr(intX) = "SPLINE"
                    End If
                Next
                Return arr
            Case 10 ' Splin area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINEAREA"
                        End If
                    Else
                        arr(intX) = "SPLINEAREA"
                    End If
                Next
                Return arr

            Case 11 ' Area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "AREA"
                        End If
                    Else
                        arr(intX) = "AREA"
                    End If
                Next
                Return arr
            Case 12 ' stacked column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "RADAR"
                Next
                Return arr
            Case Else
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "COLUMN"
                Next
                Return arr
        End Select
    End Function

    Private Function GetChartName(ByVal intGraphID As Integer) As String
        '=====================================================================
        ' Procedure Name        : GetChartName
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : JayavantK
        ' Created               : 13-April-2004
        ' Revisions             :
        '=====================================================================

        Select Case intGraphID
            Case 2 : Return "PIE"
            Case 3 : Return "COLUMN"
            Case 4 : Return "LINE"
            Case 5 : Return "BAR"
            Case 6 : Return "STEPLINE"
            Case 7 : Return "DOUGHNUT"
            Case 8 : Return "CANDLESTICK"
            Case 9 : Return "SPLINE"
            Case 10 : Return "SPLINEAREA"
            Case 11 : Return "AREA"
            Case 12 : Return "STACKEDCOLUMN"
            Case Else : Return "COLUMN"
        End Select
    End Function
#End Region

#Region " Grid and Menu Event Handlers "
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim intRequestedNoOfResources As Integer = 0
        Dim intAssignedNoOfResources As Integer = 0
        Dim strTemp As String = ""
        Dim strQuery As String = ""
        'Added by TruptiK on 22-Jan-2008
        Dim intWorkhours As Integer = 0
        'End of addition by TruptiK

        Select Case Args.ColumnName.ToUpper
            Case "REQUEST TYPE" '0
                If m_strStatus <> STATUS_Opened Then
                    Cancel = True
                End If

            Case "ID" '1  'Request ID 
                Dim TotalHours As Double
                Dim type As String
                Dim workhours As Double

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strQuery = "select type from tbl_pm_resourcerequest where requestid=" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RequestID"), "0").ToString()
                strQuery = "usp_sel_tbl_pm_resourcerequest_type " & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RequestID"), "0").ToString()
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                type = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), String)

                If Not (m_strStatus = STATUS_ASSIGNED Or m_strStatus = STATUS_REQUESTED Or m_strStatus = STATUS_EXTENDED Or m_strStatus = STATUS_PREPONED Or m_strStatus = STATUS_Opened Or m_strStatus = STATUS_CHANGE) Then
                    Args.EnableLink = False
                ElseIf m_objAccessRights.Add = False Then
                    Args.EnableLink = False
                End If

                If type = "TH" Then
                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    'strQuery = "select sum(workhours) from tbl_pm_assignedresources where requestid=" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RequestID"), "0").ToString()
                    strQuery = "usp_tbl_pm_assignedresources_workhours " & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RequestID"), "0").ToString()
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    TotalHours = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Double)
                End If
                If type = "TH" Then
                    workhours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("workhours"), "0"), Double)
                    If workhours <= TotalHours Then
                        Args.EnableLink = False
                    End If
                End If
                'Added by TruptiK on 27-Feb-2008
            Case "REQUESTOR" '4 'Requestor
                If m_strStatus = STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 7
            Case "FROM DATE" '5
                If m_strStatus = STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 8
            Case "TO DATE" '6
                If m_strStatus = STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 11
            Case "REQUEST STATUS" '11
                If m_strStatus <> STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 12
            Case "PROJECT STATUS" '12
                If m_strStatus <> STATUS_DEFERRED Then
                    Cancel = True
                End If

                'End of addition by TruptiK
                'Case 4  'View Comments 
            Case "COMMENTS" '10
                If m_strStatus = STATUS_CLOSED Or m_strStatus = STATUS_REJECTED Then


                    Args.EnableLink = False
                    strTemp = "<A href='javascript:ViewComments("
                    strTemp &= CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RequestID"), "0").ToString() & ")'>"
                    strTemp &= MyBase.GetResourceString("VIEW_COMMENTS") & "</A>"
                    Args.DataFieldValue = strTemp
                    Args.ApplyDataTypeBasedFormatting = False
                    Args.ApplyHTMLEncode = False
                Else
                    Cancel = True
                End If

                'Case 5  'Requested Number of resources.
            Case "REQUESTED" '8
                'Modified by TruptiK on 11-Jan-2007
                '  If m_strStatus = STATUS_EXTENDED
                If m_strStatus = STATUS_EXTENDED Or m_strStatus = STATUS_PREPONED Or m_strStatus = STATUS_CHANGE Then
                    'End of modification by TruptiK on 11-Jan-2007
                    Cancel = True
                ElseIf m_strStatus = STATUS_CLOSED Then
                    Args.EnableLink = False
                    strTemp = Args.DataFieldValue.ToString()
                    strTemp &= "<BR><A href='javascript:ViewRequestDetails("
                    strTemp &= CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("RequestID"), "0").ToString() & ")'>"
                    strTemp &= MyBase.GetResourceString("VIEW_DETAILS") & "</A>"
                    Args.DataFieldValue = strTemp
                    Args.ApplyDataTypeBasedFormatting = False
                    Args.ApplyHTMLEncode = False
                Else
                    Args.ApplyDataTypeBasedFormatting = True
                End If
                'Modified Code for IssueID - 14903
                ' Case 6  'Assigned Number of resources.
            Case "ASSIGNED" '9
                If m_strStatus <> STATUS_EXTENDED And m_strStatus <> STATUS_PREPONED And m_strStatus <> STATUS_CHANGE Then
                    Args.ApplyDataTypeBasedFormatting = True

                Else
                    intAssignedNoOfResources = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalAssignedResources"), "0"), Integer)
                    If intAssignedNoOfResources = 1 Then
                        strTemp = "Yes"
                    Else
                        strTemp = "No"
                    End If

                    Args.DataFieldValue = strTemp
                    Args.ApplyDataTypeBasedFormatting = False
                    Args.ApplyHTMLEncode = False

                End If
                'Added by TruptiK on 11-Jna-2007
                'Case 9
            Case "WORK HOURS" '7
                If m_strStatus = STATUS_PREPONED Or m_strStatus = STATUS_DEFERRED Or m_strStatus = STATUS_CHANGE Then
                    Cancel = True
                End If
                If m_strStatus = STATUS_REJECTED Or m_strStatus = STATUS_Opened Then
                    intWorkhours = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("WorkHours"), "0"), Integer)
                    If intWorkhours < 0 Then
                        Args.DataFieldValue = "N/A"
                        Args.ApplyDataTypeBasedFormatting = False
                        Args.ApplyHTMLEncode = False
                    End If
                End If
                'Case 10
                '    If m_strStatus = STATUS_PREPONED Or m_strStatus = STATUS_DEFERRED Then
                '        Cancel = True
                '    End If

                'End of addition by TruptiK on 11-Jna-2007
                'Case 11  'View Details (Only for Extend booking)
                'Case 13
            Case "VIEW DETAILS" '13
                'If Not m_strStatus = STATUS_EXTENDED Then
                '    Cancel = True
                Cancel = True

                'Modified by TruptiK on 29-Feb-2008
                'Case 12  'Escalate the Request
                'Case 14
            Case "ALLOCATION TYPE"
                Cancel = True
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Type"), ""), String) = "TH" Then

                    Args.StringToBeInserted = "<TD align='left' width=30>Total Hours</td>"
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Type"), ""), String) = "HPD" Then

                    Args.StringToBeInserted = "<TD align='left' width=30> Per Day</td>"
                Else

                    Args.StringToBeInserted = "<TD align='left' width=30>% of Day </td>"
                End If
            Case "ESCALATE" '14
                'End of modification by TruptiK on 29-Feb-2008
                Dim strsql As String
                Dim m_Manager As String
                Dim level As String
                Dim BusinessGroup As String
                Dim drManager As IDataReader
                strsql = "exec usp_sel_approvers " & CType(Args.DataReader.Item("RequestID"), String) & ",'" & m_strResourceAllocationLevel & "'"
                drManager = CommonFunctions.Data.GetDataReader(strsql, MyBase.UseSQL)
                If drManager.Read Then
                    m_Manager = CType(CommonFunctions.Data.CheckIsDBNull(drManager("Employeename"), ""), String)
                    level = CType(CommonFunctions.Data.CheckIsDBNull(drManager("Level"), ""), String)
                    BusinessGroup = CType(CommonFunctions.Data.CheckIsDBNull(drManager("BusinessGroup"), ""), String)
                End If

                CommonFunction.Data.DisposeDataReader(drManager)

                If m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE Then
                    Cancel = True
                End If
                If m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) = -1 And m_strUserType.IndexOf(ADMIN) = -1 Then
                    If Not m_strStatus = STATUS_REQUESTED Then
                        Cancel = True
                    Else
                        If m_strResourceAllocationLevel = ALLOCATION_LEVEL_ODC Then
                            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsEscalatedFromOUPool"), "False"), Boolean) = False Then
                                'Args.StringToBeInserted = "<TD align='left' width=50><A href='JavaScript:EscalateRequest_OUM_OnClick(" & Args.DataFieldValue.ToString() & "','" + m_Manager + "')"">"
                                Args.StringToBeInserted = "<TD align='left' width=50><A href=""JavaScript:EscalateRequest_OUM_OnClick('" + CType(Args.DataReader("RequestID"), String) + "','" + m_Manager + "','" + level + "','" + BusinessGroup + "')"">"
                                Args.StringToBeInserted &= MyBase.GetResourceString("ESCALATE") & "</A></td>"
                                Cancel = True
                            ElseIf m_strUserType.IndexOf(BG_MANAGER) > -1 And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsEscalatedFromBGPool"), "False"), Boolean) = False Then
                                'Args.StringToBeInserted = "<TD align='left' width=50><A href='JavaScript:EscalateRequest_BGM_OnClick(" & Args.DataFieldValue.ToString() & "','" + m_Manager + "')"">"
                                Args.StringToBeInserted = "<TD align='left' width=50><A href=""JavaScript:EscalateRequest_BGM_OnClick('" + CType(Args.DataReader("RequestID"), String) + "','" + m_Manager + "','" + level + "')"">"
                                Args.StringToBeInserted &= MyBase.GetResourceString("ESCALATE") & "</A></td>"
                                Cancel = True
                            End If
                        ElseIf m_strResourceAllocationLevel = ALLOCATION_LEVEL_BUSINESSGROUP Then
                            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsEscalatedFromBGPool"), "False"), Boolean) = False Then
                                'Args.StringToBeInserted = "<TD align='left' width=50><A href='JavaScript:EscalateRequest_BGM_OnClick(" & Args.DataFieldValue.ToString() & "','" + m_Manager + "')"">"
                                Args.StringToBeInserted = "<TD align='left' width=50><A href=""JavaScript:EscalateRequest_BGM_OnClick('" + CType(Args.DataReader("RequestID"), String) + "','" + m_Manager + "','" + level + "')"">"

                                Args.StringToBeInserted &= MyBase.GetResourceString("ESCALATE") & "</A></td>"
                                Cancel = True
                            End If
                        End If
                    End If
                Else
                    Cancel = True
                End If
                'Modified by TruptiK on 29-Feb-2008

                'Case 13     'View Escalation Comments
                'Case 15
            Case "VIEW ESCALATION COMMENTS" '15
                'End of modification by TruptiK on 29-Feb-2008
                If m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) = -1 And m_strUserType.IndexOf(ADMIN) = -1 Then
                    If Not m_strStatus = STATUS_ESCALATED Then
                        Cancel = True
                    Else
                        If m_strResourceAllocationLevel = ALLOCATION_LEVEL_ODC Then
                            If m_strUserType.IndexOf(OU_MANAGER) = -1 And CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsEscalatedFromBGPool"), "False"), Boolean) = True Then
                                Args.StringToBeInserted = "<TD align='left' width=50><A href='JavaScript:EscalateRequest_BGM_OnClick(" & Args.DataFieldValue.ToString() & ")'>"


                                Args.StringToBeInserted &= MyBase.GetResourceString("VIEW_ESCALATION_COMMENTS") & "</A></td>"
                                Cancel = True
                            ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsEscalatedFromOUPool"), "False"), Boolean) = True Then
                                Args.StringToBeInserted = "<TD align='left' width=50><A href='JavaScript:EscalateRequest_OUM_OnClick(" & Args.DataFieldValue.ToString() & ")'>"
                                Args.StringToBeInserted &= MyBase.GetResourceString("VIEW_ESCALATION_COMMENTS") & "</A></td>"
                                Cancel = True
                            End If
                        ElseIf m_strResourceAllocationLevel = ALLOCATION_LEVEL_BUSINESSGROUP Then
                            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsEscalatedFromBGPool"), "False"), Boolean) = True Then
                                Args.StringToBeInserted = "<TD align='left' width=50><A href='JavaScript:EscalateRequest_BGM_OnClick(" & Args.DataFieldValue.ToString() & ")'>"
                                Args.StringToBeInserted &= MyBase.GetResourceString("VIEW_ESCALATION_COMMENTS") & "</A></td>"
                                Cancel = True
                            End If
                        End If
                    End If
                Else
                    Cancel = True
                End If

                'Modified by TruptiK on 29-Feb-2008
                'CASE 14
                'Case 16     'Reminder
            Case "REMINDER" '16
                'end of modification by TruptiK on 29-Feb-2008
                If m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) = -1 And m_strUserType.IndexOf(ADMIN) = -1 Then
                    If Not m_strStatus = STATUS_ESCALATED Then
                        Cancel = True
                    Else

                        intRequestedNoOfResources = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("NoOfResources"), "0"), Integer)
                        intAssignedNoOfResources = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalAssignedResources"), "0"), Integer)
                        If intRequestedNoOfResources = intAssignedNoOfResources Then
                            Args.StringToBeInserted = "<td></td>"
                            Cancel = True
                        End If
                    End If
                Else
                    Cancel = True
                End If
        End Select
        'Added by TruptiK on 05-Nov-08
        'Purpose:-to give alert if approvers are not set
        'If Args.ColumnName.ToUpper = "ESCALATE" Then
        '    Cancel = True
        '    Dim strsql As String
        '    Dim m_Manager As String
        '    strsql = "exec usp_sel_approvers " & CType(Args.DataReader.Item("RequestID"), String) & ",'" & m_strResourceAllocationLevel & "'"
        '    m_Manager = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strsql, MyBase.UseSQL))
        '    Args.StringToBeInserted = "<TD align=center Title='Escalate'>"
        '    Args.StringToBeInserted += "<A href=""JavaScript:EscalateRequest_OnClick('" + CType(Args.DataReader("RequestID"), String) + "','" + m_Manager + "')"">"
        '    Args.StringToBeInserted += MyBase.GetResourceString("ESCALATE") + "</A>"
        '    Args.StringToBeInserted += "</TD>"
        'End If
        'End of Addition by TruptiK on 05-Nov-08
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case Args.ColumnName.ToUpper
            'Modified by TruptiK on 29-May-09
            'Case 4  'View Comments 
            'Case 9'View Comments 
            'Added by TrutpiK on 29-MAy-09
            'Purpose:-UI changes.
            Case "REQUEST TYPE"
                If m_strStatus <> STATUS_Opened Then
                    Cancel = True
                End If

            Case "COMMENTS" 'View Comments 
                If Not (m_strStatus = STATUS_CLOSED Or m_strStatus = STATUS_REJECTED) Then
                    Cancel = True
                Else
                    Args.ApplySorting = False
                End If

                'Case 5  'Requested Number of resources.
                'Case 7 'Requested Number of resources.
            Case "REQUESTED" 'Requested Number of resources.
                If m_strStatus = STATUS_EXTENDED Or m_strStatus = STATUS_PREPONED Or m_strStatus = STATUS_CHANGE Then
                    Cancel = True
                End If

                'Case 11  'View Details (Only for Extend booking)
                'Case 13
                'Case 12
            Case "VIEW DETAILS"
                'If Not m_strStatus = STATUS_EXTENDED Then
                '    Cancel = True
                'End If

                Cancel = True

                'trupti
                'Case 9
                'Case 6
            Case "WORK HOURS" '7
                If m_strStatus = STATUS_PREPONED Or m_strStatus = STATUS_DEFERRED Or m_strStatus = STATUS_CHANGE Then
                    Cancel = True
                End If
                'Case 10
                '    If m_strStatus = STATUS_PREPONED Or m_strStatus = STATUS_DEFERRED Then
                '        Cancel = True
                '    End If
                'End by trupti
                'Added by TruptiK on 27-Feb-2008
                'Case 3 'Requestor
            Case "REQUESTOR" 'Requestor
                If m_strStatus = STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 7
                'Case 4
            Case "FROM DATE" '5
                If m_strStatus = STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 8
            Case "TO DATE" '6
                If m_strStatus = STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 11
            Case "REQUEST STATUS" '11
                If m_strStatus <> STATUS_DEFERRED Then
                    Cancel = True
                End If
                'Case 12
            Case "PROJECT STATUS" '12
                If m_strStatus <> STATUS_DEFERRED Then
                    Cancel = True
                End If
                'End of addition by TruptiK
                'Modified by TruptiK on 29-Feb-2007
                'Case 12  'Escalate the Request
                'Case 14
            Case "ESCALATE" '14
                'End of modification by TruptiK
                If m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE Then
                    Cancel = True
                End If
                If m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) = -1 And m_strUserType.IndexOf(ADMIN) = -1 Then
                    If Not m_strStatus = STATUS_REQUESTED Then Cancel = True
                Else
                    Cancel = True
                End If
                'Modified by TruptiK on 29-Feb-2007
                'Case 13, 14 'View Escalation Comments, Reminder
                'Case 15, 16
            Case "VIEW ESCALATION COMMENTS", "REMINDER" '15 16

                'End of modification by TruptiK
                If m_strUserType.IndexOf(GLOBAL_RESOURCE_MANAGER) = -1 And m_strUserType.IndexOf(ADMIN) = -1 Then
                    If Not m_strStatus = STATUS_ESCALATED Then Cancel = True
                Else
                    Cancel = True
                End If
        End Select
    End Sub
#End Region
End Class
