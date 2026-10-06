#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
#End Region

Public Class HR_ResourceSchedule
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.ID = "frmHR_ResourceSchedule"

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    WithEvents objGrid As New WebPages.Template.AdvancedGrid
    Public strProjectID As String = "0"
    Protected m_strSelectedProject As String
    Public strDashBoardViewDate As String
    'Protected m_strHeaderTables As New System.Text.StringBuilder
    Private m_strPlotPage As New System.Text.StringBuilder("")
    Private m_strPlotFiletrs As New System.Text.StringBuilder("")



    Protected m_strBG As String = ""
    Protected m_strOU As String = ""
    Protected m_strDepartment As String = ""
    Protected m_strRole As String = ""
    Protected m_strReportingTo As String = ""
    Protected m_strEmployeeName As String = ""
    Private m_strEmployeeID As String

    Dim objLink As WebPage.UI.cDynamicLink
    'needs to be deleted'
    Protected m_strPM As String = ""
    Protected m_strPN As String = ""
    Protected m_strOptional As String = ""
    Protected m_strView As String = ""
    Protected m_strTimeline As String = ""
    '''''''
    '''Added By RathinP for Numeric Paging
    Private m_blnUseSQL As Boolean
    Protected m_lngEntityID As Long = 0
    Protected m_lngQueryID As Long = 0
    Protected m_strSortOrder As String = ""
    Protected m_strSortBy As String = ""
    Protected m_strWhereClause As String = ""
    Protected m_lngCurrentPage As Long = 1
    Dim intNoOfRows As Integer = 0
    Dim strPaging As String = ""
    Protected m_lngConnectionID As Long = 0
    Private Const MAX_QUERY_PAGESIZE As Long = 20
    'Instead of comparing the strings each time (m_strAction and "PRINTER_FRIENDLY_VERSION") use boolean variable.
    Private m_blnNotPrinterFriendly As Boolean = True
    Protected m_strBodyClass As String = "class='clsBody'"
    Dim m_strMode As String
    Protected strFromWhere As String

    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
    '-------------------------------------------------------------------------------------------------------------
    'End of Addition By RathinP 

#End Region

#Region "Constants"
    Private Const intQuartersToDisplay As Integer = 8
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub DrawMenu()
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
        ' Author                :  NitinVS
        ' Created               :  4 th December 2006
        ' Revisions             :  
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList

        If Request.QueryString("FromWhere") <> "DB" Then
            arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
            arrMenuToolTip.Add("Close")
            arrClientSideFunctions.Add("Close_Click()")
        End If
        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;" + MyBase.GetResourceString("MENU_HELP"))
        arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        arrClientSideFunctions.Add("OpenHelpPage('2193-SCHEDULE')")


        m_objMenu = New WebPages.Template.StaticMenu
        Dim strmenu As String = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)
        CommonFunctions.General.WriteHTML(strmenu)


        m_objMenu = Nothing
    End Sub
    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        Response.Write("<BR>")
    End Sub
    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing
    End Sub
    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing
    End Sub
    Public Sub DrawFilters()
        '====================================================================
        ' Procedure Name        : DrawFilters
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To plot the page filters
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SwatiC
        ' Created               : 16 May 2007
        ' Revisions             :
        '=====================================================================



        strFromWhere = Request.QueryString("FromWhere")

        If strFromWhere = "DB" Then
            Call DrawFiltersForDB()
        ElseIf strFromWhere = "RCV" Then
            Call DrawFiltersForRCV()
        End If

        'For Option Buttons
        m_strPlotFiletrs.Append("<table class='clsTable' cellpadding=0 cellspacing=0 width=99.99%>")
        m_strPlotFiletrs.Append("<tr class='clsTRSectionHeader'>")

        ''''''''''''''''View Option Button
        If m_strView = "1" Or m_strView = "" Then
            m_strPlotFiletrs.Append("<td width=112px align=right> 1 Month </td><td align=left>" + CommonFunctions.HTMLControls.DrawOptionButton("optView", "optView", , True, "1", , "OnClick='JavaScript:View_OnChange(this.value)'", True) + " </td>")
        Else
            m_strPlotFiletrs.Append("<td width=112px align=right> 1 Month </td><td align=left>" + CommonFunctions.HTMLControls.DrawOptionButton("optView", "optView", , , "1", , "OnClick='JavaScript:View_OnChange(this.value)'", True) + " </td>")
        End If
        If m_strView = "2" Then
            m_strPlotFiletrs.Append("<td  width=90px align=right> 3 Month </td><td width=43px align=left>" + CommonFunctions.HTMLControls.DrawOptionButton("optView", "optView", , True, "2", , "OnClick='JavaScript:View_OnChange(this.value)'", True) + " </td>")
        Else
            m_strPlotFiletrs.Append("<td  width=90px align=right> 3 Month </td><td width=43px align=left>" + CommonFunctions.HTMLControls.DrawOptionButton("optView", "optView", , , "2", , "OnClick='JavaScript:View_OnChange(this.value)'", True) + " </td>")
        End If
        If m_strView = "3" Then
            m_strPlotFiletrs.Append("<td width=98px align=right> 1 Year </td><td align=left>" + CommonFunctions.HTMLControls.DrawOptionButton("optView", "optView", , True, "3", , "OnClick='JavaScript:View_OnChange(this.value)'", True) + " </td>")
        Else
            m_strPlotFiletrs.Append("<td width=98px align=right> 1 Year </td><td align=left>" + CommonFunctions.HTMLControls.DrawOptionButton("optView", "optView", , , "3", , "OnClick='JavaScript:View_OnChange(this.value)'", True) + " </td>")
        End If
        m_strPlotFiletrs.Append("<td align=right> </td><td align=left></td>")

        m_strPlotFiletrs.Append("<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        m_strPlotFiletrs.Append("<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        objLink.LinkName = "SHOW"
        objLink.Tooltip = "Click to Apply Filters"
        objLink.FunctionName = "Show_OnClick()"
        m_strPlotFiletrs.Append("<td align=right><B>" + objLink.GetDynamicLink() + "</td></B>")

        m_strPlotFiletrs.Append("<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        m_strPlotFiletrs.Append("<td align=right>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        m_strPlotFiletrs.Append("</TR>")
        m_strPlotFiletrs.Append("</table>")

        CommonFunctions.General.WriteHTML(m_strPlotFiletrs.ToString)
        m_strPlotFiletrs = Nothing
    End Sub
    Public Sub DrawFiltersForDB()
        Dim strSQL As String

        m_strPlotFiletrs.Append(" <table id='tbl1' class='clsGridTable' cellpadding='0' cellspacing='0' width='100%'>")
        m_strPlotFiletrs.Append("<tr id='tr' class='clsTREven'><td> e-Dashboard ")

        '<!--class='clsTRPageCaption'-->
        If Trim(Session("intPostID").ToString) <> "" Then
            m_strPlotFiletrs.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString & "," & Session("intPostID").ToString, , "../HR/HR_ResourceSchedule.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))
        Else
            m_strPlotFiletrs.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString, , "../HR/HR_ResourceSchedule.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))
        End If
        m_strPlotFiletrs.Append("</td></tr></table>")

        'End Of Comment
        m_strPlotFiletrs.Append("<table class='clsTable' cellpadding=0 cellspacing=0 width=99.99%>")
        m_strPlotFiletrs.Append("<tr class='clsTRSectionHeader'>")
        m_strPlotFiletrs.Append("<td align=right> Business Group </td><td align=left>" + CommonFunctions.HTMLControls.DrawComboBox("cboBG", "USP_SEL_PROJECTSCHEDULE_BUSINESSGROUP", 150, m_strBG, "onchange=javascript:cboBG_Onchange()", True, True) + " </td>")
        m_strPlotFiletrs.Append("<td align=right> Organization Unit </td><td align=left>" + CommonFunctions.HTMLControls.DrawComboBox("cboOU", "USP_SEL_PROJECTSCHEDULE_ORGANIZATIONUNIT", 150, m_strOU, "onchange=javascript:cboOU_Onchange()", True, True) + " </td>")  '</TR>
        m_strPlotFiletrs.Append("<td align=right> Department </td><td align=left>" + CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_PM_DepartmentList", 150, m_strDepartment, "Onchange='JavaScript:cboDepartment_OnChange(this.value)'", True, True) + " </td>")

        m_strPlotFiletrs.Append("</tr>")

        m_strPlotFiletrs.Append("<tr class='clsTRSectionHeader'>")

        '''''''''''''''''''' Operational Combo
        strSQL = "Select 2,'Operational'"
        m_strPlotFiletrs.Append("<td align=right> Role </td><td align=left>" + CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_Sel_tbl_PM_Role", 150, m_strRole, "Onchange='JavaScript:cboRole_OnChange(this.value)'", True, True) + " </td>")

        '''''''''''''''''''' ReportingTo Combo
        'strSQL = "Select 2,'FIRM'"
        'strSQL = strSQL + "UNION Select 3,'SWAG'"

        m_strPlotFiletrs.Append("<td align=right> Reporting To </td><td align=left>" + CommonFunctions.HTMLControls.DrawComboBox("cboReportingTo", "usp_Sel_tbl_PM_EmployeeName_High_Medium", 150, m_strReportingTo, "Onchange='JavaScript:cboReportingTo_OnChange(this.value)'", True, True) + " </td>")

        '''''''''''Employee Name Text Box
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        m_strPlotFiletrs.Append("<td align=right> Employee Name </td><td align=left>" + CommonFunctions.HTMLControls.DrawTextBox("txtProjectName", "txtProjectName", , 150, , m_strEmployeeName, , , , , , , , True, EnableHTMLEncode:=True) + " </td></tr>")
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        m_strPlotFiletrs.Append("</table>")

    End Sub
    Public Sub DrawFiltersForRCV()
        '====================================================================
        ' Procedure Name        : DrawFilters
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To plot the page filters
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SwatiC
        ' Created               : 16 May 2007
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim dr As IDataReader
        Dim BusinessGroup As String
        Dim Location As String
        Dim Department As String
        Dim Role As String
        Dim ReportingTo As String
        Dim EmployeeName As String


        strFromWhere = Request.QueryString("FromWhere")

        strSQL = "usp_Sel_EmployeeInformation_RCV " + m_strEmployeeID

        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        While dr.Read
            BusinessGroup = CType(dr("BusinessGroup"), String)
            Location = CType(dr("Location"), String)
            Department = CType(dr("Department"), String)
            Role = CType(dr("RoleDescription"), String)
            ReportingTo = CType(dr("ReportingTo"), String)
            EmployeeName = CType(dr("EmployeeName"), String)

        End While
        CommonFunction.Data.DisposeDataReader(dr)
        ''If page opens from dashboard then only display e-Dashboard combo otherwise display close link.
        Call DrawMenu()
        m_strPlotFiletrs.Append("<BR>")
        ''m_strPlotFiletrs.Append(" <table id='tbl1' class='clsGridTable' cellpadding='0' cellspacing='0' width='100%'>")
        ''m_strPlotFiletrs.Append("<tr id='tr' class='clsTREven'><td align=right> <a style='TEXT-DECORATION:None' title='Close' href=javascript:Close_OnClick()>")
        ''m_strPlotFiletrs.Append("<Font Size=1 face=Arial;verdana color=Black>" + "|&nbsp;Close</font></a> |&nbsp;")

        ''m_strPlotFiletrs.Append("<a style='TEXT-DECORATION:None' title='Help' href=javascript:Help_OnClick('ResourceCalendar')>")
        ''m_strPlotFiletrs.Append("<Font Size=1 face=Arial;verdana color=Black>" + "?&nbsp;|</font>")
        ''m_strPlotFiletrs.Append("</a>")
        ''m_strPlotFiletrs.Append("</td></tr></table>")


        m_strPlotFiletrs.Append("<table class='clsTable' cellpadding=0 cellspacing=0 width=99.99%>")
        m_strPlotFiletrs.Append("<tr class='clsTRSectionHeader'>")
        m_strPlotFiletrs.Append("<td align=left colspan=9 > <B>Resource Name - " + EmployeeName + "</B></td></tr>")
        m_strPlotFiletrs.Append("<tr class='clsTRSectionHeader'>")
        m_strPlotFiletrs.Append("<td align=left> Business Group </td><td>:</td><td align=left>" + BusinessGroup + " </td>")
        m_strPlotFiletrs.Append("<td align=left> Organization Unit </td><td>:</td><td align=left>" + Location + " </td>")  '</TR>
        m_strPlotFiletrs.Append("<td align=left> Department </td><td>:</td><td align=left>" + Department + " </td></tr>")

        m_strPlotFiletrs.Append("<tr class='clsTRSectionHeader'>")
        strSQL = "Select 2,'Operational'"
        m_strPlotFiletrs.Append("<td align=left> Role </td><td>:</td><td align=left>" + Role + " </td>")
        m_strPlotFiletrs.Append("<td align=left> Reporting To </td><td>:</td><td align=left>" + ReportingTo + "</td>")
        m_strPlotFiletrs.Append("<td></td><td></td><td></td>")
        '''''''''''Employee Name Text Box
        'm_strPlotFiletrs.Append("<td align=right> Employee Name </td><td align=left>" + CommonFunctions.HTMLControls.DrawTextBox("txtProjectName", "txtProjectName", , 150, , m_strEmployeeName, , , , , , , , True) + " </td></tr>")

        m_strPlotFiletrs.Append("</tr></table><BR>")

        'm_strPlotFiletrs.Append("<table class='clsTable' cellpadding=0 cellspacing=0 width=99.99%>")
        'm_strPlotFiletrs.Append("<tr class='clsTRSectionHeader'>")
        'CommonFunctions.General.WriteHTML(m_strPlotFiletrs.ToString)
        'm_strPlotFiletrs = Nothing

    End Sub
    'Public Sub PageMenu()

    '    If strFromWhere = "DB" Then
    '        m_strPlotFiletrs.Append(" <table id='tbl1' class='clsGridTable' cellpadding='0' cellspacing='0' width='100%'>")
    '        m_strPlotFiletrs.Append("<tr id='tr' class='clsTREven'><td> e-Dashboard ")

    '        '<!--class='clsTRPageCaption'-->
    '        If Trim(Session("intPostID").ToString) <> "" Then
    '            m_strPlotFiletrs.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString & "," & Session("intPostID").ToString, , "../HR/HR_ResourceSchedule.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))
    '        Else
    '            m_strPlotFiletrs.Append(CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo  " & Session("intUserID").ToString, , "../HR/HR_ResourceSchedule.aspx|0", "OnChange='JavaScript:cboDashboard_OnChange()'", , True))
    '        End If
    '        m_strPlotFiletrs.Append("</td></tr></table>")

    '    ElseIf strFromWhere = "RCV" Then

    '        m_strPlotFiletrs.Append(" <table id='tbl1' class='clsGridTable' cellpadding='0' cellspacing='0' width='100%'>")
    '        m_strPlotFiletrs.Append("<tr id='tr' class='clsTREven'><td align=right> <a style='TEXT-DECORATION:None' href=javascript:Close_OnClick()>")
    '        m_strPlotFiletrs.Append("<Font Size=1 face=Arial;verdana color=Black>" + "|&nbsp;Close</font></a> |&nbsp;")

    '        m_strPlotFiletrs.Append("<a style='TEXT-DECORATION:None' href=javascript:Help_OnClick('ResourceCalendar')>")
    '        m_strPlotFiletrs.Append("<Font Size=1 face=Arial;verdana color=Black>" + "?&nbsp;|</font>")
    '        m_strPlotFiletrs.Append("</a>")

    '        m_strPlotFiletrs.Append("</td></tr></table>")

    '    End If
    'End Sub
    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        'This will initialize all the global objects.


        Initialize()
        'If m_strPG <> "" Then strPG = m_strPG

        GetGlobalObject()

        DrawHeader()

        DrawFilters()

        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;HEIGHT:200;WIDTH:100%'>")
        '---- End Comment.

        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;WIDTH: 100%'>")
        If Request.QueryString.Item("Project") Is Nothing Then
            m_strSelectedProject = ""
        Else
            m_strSelectedProject = Request.QueryString.Item("Project").ToString
        End If

        If Request.QueryString.Item("DivScroll") Is Nothing Then
            CommonFunctions.General.WriteHTML("<input type='hidden' id='DivVert' name='DivVert' value='0'/>")
        Else
            CommonFunctions.General.WriteHTML("<input type='hidden' id='DivVert' name='DivVert' value='" + Request.QueryString.Item("DivScroll") + "'/>")
        End If

        If m_strView = "" Or m_strView = "1" Then
            Response.Write(GenerateResourceSchedule_Monthly())
        ElseIf m_strView = "2" Then
            Response.Write(GenerateResourceSchedule_ThreeMonth())
        ElseIf m_strView = "3" Then
            Response.Write(GenerateResourceSchedule_1Year())
        End If

        m_strPlotPage = Nothing

        'CommonFunctions.General.WriteHTML("<HR>")
        'CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' cellpadding=0 cellspacing=1 width='99.90%'><TR class=clsTRPageCaption><TD align=Left>Details</TD></TR></TABLE>")
        'DisplayScheduleDetails(CType(IIf(m_strSelectedProject = "", 0, m_strSelectedProject), Integer))
        'DisplayScheduleCostDetails(CType(IIf(m_strSelectedProject = "", 0, m_strSelectedProject), Integer))

        'CommonFunctions.General.WriteHTML("</DIV>")
        'Call PageMenu()

        DisposeObjects()
        'CommonFunctions.General.WriteHTML(m_strHeaderTables.ToString)
        CommonFunctions.General.WriteHTML("</td></table></DIV>")

        Call DrawMenu()

    End Sub
    Private Sub Initialize()
        '====================================================================
        ' Procedure Name        : GenerateProjectSchedule
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To Initialize varables
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RathinP
        ' Created               : 16 May 2007
        ' Revisions             :
        '=====================================================================
        If HttpContext.Current.Request.QueryString("Mode") <> "" Then
            m_strMode = HttpContext.Current.Request.QueryString("Mode").ToUpper
        End If
        If m_strMode = "SHOW" Then
            Dim strBG As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboBG"), ""))
            Dim strOU As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboOU"), ""))

            Dim strDept As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboDepartment"), ""))
            Dim strRole As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboRole"), ""))
            Dim strReportingTo As String = CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboReportingTo"), ""))
            Dim strView As String


            Dim strPN As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtProjectName"), "")
            Dim strEN As String = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtProjectName"), "")


            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("View"), "") = "" Then
                strView = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("optView"), "")
            Else
                strView = HttpContext.Current.Request.QueryString("View")
            End If

            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BG"), "") <> "" Then
                m_strBG = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BG"), "")
            End If
            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OU"), "") <> "" Then
                m_strOU = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OU"), "")
            End If

            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EN"), "") <> "" Then
                m_strEmployeeName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EN"), "")
            End If
            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Department"), "") <> "" Then
                m_strDepartment = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Department"), "")
            End If
            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Role"), "") <> "" Then
                m_strRole = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Role"), "")
            End If
            If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReportingTo"), "") <> "" Then
                m_strReportingTo = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ReportingTo"), "")
            End If


            If strBG <> "" Then m_strBG = strBG
            If strOU <> "" Then m_strOU = strOU
            If strDept <> "" Then m_strDepartment = strDept
            If strRole <> "" Then m_strRole = strRole
            If strReportingTo <> "" Then m_strReportingTo = strReportingTo
            If strEN <> "" Then m_strEmployeeName = strEN

            m_strView = strView
        End If
        ''Added By RathinP for Numeric Paging
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        If m_blnNotPrinterFriendly Then

            Dim strNavigationDirection, strPageNumber As String
            strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PagingNumber"))
            If strPageNumber <> "" Then
                m_lngCurrentPage = CLng(strPageNumber)
            Else
                strNavigationDirection = UCase(CommonFunctions.General.CheckIsNothing(Request.QueryString("PagingNavigation")))
                If strNavigationDirection <> "" Then
                    strPageNumber = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtPageNumber"))
                    If strPageNumber <> "" Then
                        m_lngCurrentPage = CLng(strPageNumber)
                    End If
                    Select Case strNavigationDirection
                        Case "NEXT"
                            m_lngCurrentPage += 1
                        Case "PREV"
                            m_lngCurrentPage -= 1
                        Case "CURR"
                            m_lngCurrentPage = m_lngCurrentPage
                        Case Else
                            m_lngCurrentPage = 1
                    End Select
                Else
                    m_lngCurrentPage = 1
                End If
            End If

        End If
        '-------------------

        'Added By ShraddhaM
        'm_strEmployeeID
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "") <> "" Then
            m_strEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID")
        Else
            m_strEmployeeID = HttpContext.Current.Request.Form("hidEmployeeID")
        End If

        CommonFunctions.General.WriteHTML("<input type=hidden name='hidEmployeeID' value=" + m_strEmployeeID + ">")


        'End of addition by ShraddhaM


        'Modification Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
        '-------------------------------------------------------------------------------------------------------------
        ''End of Addition by RathinP
    End Sub
    Private Function GenerateResourceSchedule_1Year() As String
        '====================================================================
        ' Procedure Name        : GenerateProjectSchedule_1Year
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To plot the 1 year View
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RathinP
        ' Created               : 16 May 2007
        ' Revisions             :
        '=====================================================================
        'Added By RathinP for Numeric Paging
        Dim blnOracle As Boolean
        Dim ds1 As DataSet
        Dim dtGridTable As DataTable 'Added By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        'End of Addition By RathinP
        Dim strHTML As String
        Dim intloopCounter As Integer = 0
        Dim intMonthCount, intQuarterCount As Integer
        Dim strMonthName, strQuarterName As String
        Dim moment As New System.DateTime
        Dim strTRClass As String
        Dim dsColHeadings As DataSet
        Dim drColHeadings As DataRow
        Dim blnNoItems As Boolean = False
        'for Navigation'
        Dim nRecCount As Integer ' Number of records found
        Dim nPageCount As Integer ' Number of pages of records we have
        Dim nPage As Integer ' Current page number
        Dim nStart As Integer ' Starting Record
        Dim nEnd As Integer ' End Record
        Dim nPageEnd As Integer ' End Page for Alternative Navigation
        'Dim m_strMode As String
        'ends

        'If HttpContext.Current.Request.QueryString("Mode") <> "" Then
        'm_strMode = HttpContext.Current.Request.QueryString("Mode").ToUpper
        'End If


        Dim strSQL As String
        strSQL = "usp_sel_ResourceSchedule_1Year  "
        'If HttpContext.Current.Request.QueryString("Mode") <> "Show" Then
        If m_strMode <> "SHOW" Then
            strSQL = ""
        Else

            If m_strBG <> "" Then
                strSQL = strSQL + "" + m_strBG
            Else
                strSQL = strSQL + "NULL"
            End If

            If m_strOU <> "" Then
                strSQL = strSQL + "," + m_strOU
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strDepartment <> "" Then
                strSQL = strSQL + ",'" + m_strDepartment + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strRole <> "" Then
                strSQL = strSQL + ",'" + m_strRole + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strReportingTo <> "" Then
                strSQL = strSQL + ",'" + m_strReportingTo + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strEmployeeName <> "" Then
                strSQL = strSQL + ",'" + Replace(m_strEmployeeName, "'", "''") + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If
            'Added ShraddhaM
            If m_strEmployeeID <> "" Then
                strSQL = strSQL + "," + m_strEmployeeID
            Else
                strSQL = strSQL + ",NULL"
            End If

            strSQL = strSQL + ",'RCV'"
            'End of addition by ShraddhaM
            'drProjectSchedule = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            ds1 = CommonFunctions.Data.GetDataSet(strSQL, "Default", , , MyBase.UseSQL)
            ' the rows
            dtGridTable = ds1.Tables("Default")
            intNoOfRows = dtGridTable.Rows.Count
            ds1.Dispose() : ds1 = Nothing
            If dtGridTable.Rows.Count > 0 Then
                blnNoItems = True
            End If
        End If


        'Added By RathinP on 07/06/2007
        'To set the Starting date of Current Week'
        strDashBoardViewDate = CType(CommonFunctions.Data.GetDataScalar("Select dbo.udf_ResourceDashboard_1Year(GetDate())", True), String)
        'End of Addition by RathinP



        ' Added By RathinP for Numeric Paging
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
        'Reason   - For showing numeric paging similar to paging on CommonList.
        '-------------------------------------------------------------------------------------------------------------
        Dim lngPageSize, lngTotalPages As Long
        'lngPageSize = CommonFunction.Application.MaxQueryPageSize
        lngPageSize = 15
        If lngPageSize <= 0 Then
            lngPageSize = MAX_QUERY_PAGESIZE
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        'Reason      - Get the DataTable which will be used as a datasource to the Grid.
        '              This code was within the if condition -> "If Not blnOracle Then", moved it into here
        '              for getting the data table in anycase (Oracle or Not).
        '-------------------------------------------------------------------------------------------------------------

        'ds1 = CommonFunctions.Data.GetDataSet(strSQL, "Default", , , MyBase.UseSQL)
        '' the rows
        'dtGridTable = ds1.Tables("Default")
        'intNoOfRows = dtGridTable.Rows.Count
        'ds1.Dispose() : ds1 = Nothing

        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        '-------------------------------------------------------------------------------------------------------------


        If Not blnOracle Then
            If m_blnNotPrinterFriendly Then

                ' total pages
                If CType(intNoOfRows / lngPageSize, Double) > CType(intNoOfRows / lngPageSize, Long) Then
                    lngTotalPages = CType(intNoOfRows / lngPageSize, Long) + 1
                Else
                    lngTotalPages = CType(intNoOfRows / lngPageSize, Long)
                End If

                'If there are more than one pages, then only plot numeric paging.
                If lngTotalPages > 1 Then

                    Dim sbPage As New System.Text.StringBuilder
                    sbPage.Append("../HR/HR_ResourceSchedule.aspx?mode=Show") ': sbPage.Append(m_lngQueryID.ToString())

                    MyBase.InitializeResources("Resources.StandardMessages", "Resources")
                    Dim objWAF_NumericPage As New CommonFunctions.HTMLControls.WAF_NumericPagingControl
                    With objWAF_NumericPage
                        .WidthInPixel = 50
                        .value = m_lngCurrentPage.ToString
                        .ReturnHTML = True
                        .CurrentPageNumber = m_lngCurrentPage
                        .MaxPageSize = lngTotalPages
                        .FormName = "frmHR_ResourceSchedule"
                        .PagePath = sbPage.ToString()
                        .MaxRangeMsg = MyBase.GetResourceString("MAX_RANGE") + lngTotalPages.ToString()
                        .MinRangeMsg = MyBase.GetResourceString("MIN_RANGE")
                        .PositiveValueMsg = MyBase.GetResourceString("POSITIVE_VALUE")
                        .FirstRecordMsg = MyBase.GetResourceString("FIRST_PAGE")
                        .LastRecordMsg = MyBase.GetResourceString("LAST_PAGE")
                    End With
                    MyBase.InitializeResources("Resources.QRB_QueryResult", "Resources")


                    strPaging = CommonFunctions.HTMLControls.DrawNumericPagingControl("txtPageNumber", "txtPageNumber", objWAF_NumericPage)

                    objWAF_NumericPage = Nothing
                    sbPage = Nothing


                    ' write the paging info
                    With Response
                        If Trim(strPaging & "") <> "" Then
                            m_strPlotPage.Append("<Table class=clsTable cellpadding=0 cellspacing=0 width='100%'><TR class=clsTRMenu><Td align=right>" + vbCrLf)
                            m_strPlotPage.Append(strPaging)
                            m_strPlotPage.Append("</td></TR></Table>" + vbCrLf)
                            'Add a hidden,blank text box to prevent the submition of form when enter key is hit in Numeric paging text box (txtPageNumber).
                            m_strPlotPage.Append("<input type='Textbox' style='display:none'>")
                            'm_strPlotPage.Append("<BR>" + vbCrLf)
                        End If
                    End With

                End If 'lngTotalPages > 1

            End If 'm_blnNotPrinterFriendly

            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
            '-------------------------------------------------------------------------------------------------------------

        End If 'Not blnOracle 
        ' End Addition May 04,2004
        'End of Addition by RathinP


        If blnNoItems <> False Or m_strMode = "SHOW" Then
            'Added to Display The Total No of Records
            With Response
                ' no of rows on the page
                m_strPlotPage.Append("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><tr class=clsTRSectionHeader><td>")
                'm_strPlotPage.Append(MyBase.GetResourceString("TOTAL_RECORDS") & intNoOfRows)
                If strFromWhere = "DB" Then
                    m_strPlotPage.Append("Total Record(s) : " & intNoOfRows)
                    m_strPlotPage.Append("</td></tr></Table>")
                    'ElseIf strFromWhere = "RCV" Then
                    '    m_strPlotPage.Append("<B>Resource : " + dtGridTable.Rows(0).Item("EmployeeName").ToString + "</B></td></tr></Table>")
                End If
                '.Write("<BR>")
            End With
            'End of Addition
        End If

        'Plotting Header of the Resource Schedule table
        m_strPlotPage.Append(" <table id='tbl1' class='clsGridTable' cellpadding='0' cellspacing='1' width='100%'>")
        m_strPlotPage.Append(" <tr id='trHeader1' align='center' class= 'clsTRColumnHeader'>")

        If strFromWhere = "DB" Then
            m_strPlotPage.Append(" <td id='thh1' class='DivSub1Tag'  rowspan='2'> <B>" + "Resource" + "</B></td>")
        End If

        'moment = Now()
        Dim temp_Moment As Date
        temp_Moment = CType(CommonFunctions.Data.GetDataScalar("Select GetDate()", MyBase.UseSQL), Date)
        moment = temp_Moment

        Dim intYear As Integer = moment.Year()
        Dim dtNewDate As Date = moment.AddMonths(12)
        Dim intYearNew As Integer = dtNewDate.Year()
        Dim intYear1Month As Integer
        Dim intYear2Month As Integer
        Dim intcolspan As Integer = 1

        'moment = Now()
        moment = temp_Moment
        If intYear <> intYearNew Then
            intYear1Month = moment.Month()
            intYear2Month = dtNewDate.Month()
            intYear1Month = (12 - intYear2Month) + 1
            intYear2Month = 12 - intYear1Month
        End If

        If intYear <> intYearNew Then
            If moment.Month() <> 1 Then
                m_strPlotPage.Append("<TD  class='DivSub1Tag' colspan=" + intYear1Month.ToString + "><B>" + intYear.ToString + "</TD>")
                m_strPlotPage.Append("<TD  class='DivSub1Tag' colspan=" + intYear2Month.ToString + "><B>" + intYearNew.ToString + "</TD>")
            Else
                m_strPlotPage.Append("<TD  class='DivSub1Tag' colspan=12><B>" + intYear.ToString + "</TD>")
            End If
        Else
            m_strPlotPage.Append("<TD  class='DivSub1Tag' colspan=12><B>" + intYear.ToString + "</TD>")
        End If
        m_strPlotPage.Append(" </tr>")

        m_strPlotPage.Append(" <tr id='trHeader1' align='center' class= 'clsTRColumnHeader'>")

        For intMonthCount = 1 To 12
            Select Case moment.Month
                Case 1
                    strMonthName = "Jan"
                Case 2
                    strMonthName = "Feb"
                Case 3
                    strMonthName = "Mar"
                Case 4
                    strMonthName = "Apr"
                Case 5
                    strMonthName = "May"
                Case 6
                    strMonthName = "Jun"
                Case 7
                    strMonthName = "Jul"
                Case 8
                    strMonthName = "Aug"
                Case 9
                    strMonthName = "Sep"
                Case 10
                    strMonthName = "Oct"
                Case 11
                    strMonthName = "Nov"
                Case 12
                    strMonthName = "Dec"
            End Select
            m_strPlotPage.Append("<TD  class='DivSub1Tag' id='th1" + intMonthCount.ToString + "' ><B>" + strMonthName + "</B></td>")
            moment = moment.AddMonths(1)
        Next
        m_strPlotPage.Append(" </tr>")

        If blnNoItems = False Or m_strMode <> "SHOW" Then
            m_strPlotPage.Append(" <tr  align='center' class='clsTROdd'><TD Colspan = 32>There are no items to show in this view.</TD></TR>")
        End If
        'Added by RathinP
        'Set The Starting Point and the Ending Point.
        'End of Addition by RathinP
        nStart = CInt(lngPageSize * (m_lngCurrentPage - 1))
        nEnd = CInt(nStart + lngPageSize - 1)
        If nEnd > intNoOfRows - 1 Then
            nEnd = intNoOfRows - 1
        End If

        ' Let's output our records				
        If m_strMode = "SHOW" Then
            Dim j As Integer
            For j = nStart To nEnd
                intloopCounter = 0
                intloopCounter += 1
                If intloopCounter Mod 2 = 0 Then
                    strTRClass = "clsTREven"
                Else
                    strTRClass = "clsTROdd"
                End If
                ' All we do here is just show the records
                m_strPlotPage.Append(" <tr id='tr" + intloopCounter.ToString + "' class='" + strTRClass + "' style='PADDING-RIGHT: 0pt; PADDING-LEFT: 0pt; PADDING-BOTTOM: 0pt; PADDING-TOP: 0pt'>")

                If strFromWhere = "DB" Then
                    m_strPlotPage.Append("<td style='CURSOR: hand' id='linkTD" + dtGridTable.Rows(j).Item("EmployeeID").ToString + "' onclick='SelectRow_OnClick(" + dtGridTable.Rows(j).Item("EmployeeID").ToString + ")'nowrap >" + dtGridTable.Rows(j).Item("EmployeeName").ToString + "</td>")
                End If


                For intMonthCount = 2 To 13
                    If dtGridTable.Rows(j).Item(intMonthCount).ToString = "1" Then
                        m_strPlotPage.Append("  <td id='td" + intloopCounter.ToString + intMonthCount.ToString + "' valign='middle'>")
                        m_strPlotPage.Append(" <table width='100%' height='100%'  cellpadding='0' cellspacing='0'>")
                        m_strPlotPage.Append(" <tr><td></td></tr><tr>")
                        m_strPlotPage.Append(" <td bgcolor='DodgerBlue'></td>")
                        m_strPlotPage.Append(" </tr><tr><td></td></tr>")
                        m_strPlotPage.Append(" </table>")
                        m_strPlotPage.Append(" </td>")
                    Else
                        m_strPlotPage.Append(" <td id='td" + intloopCounter.ToString + intMonthCount.ToString + "'> &nbsp; </td>")
                    End If

                Next
                m_strPlotPage.Append(" </tr>")
            Next
        End If
        m_strPlotPage.Append("</table>")

        Return m_strPlotPage.ToString
    End Function
    Private Function GenerateResourceSchedule_Monthly() As String
        '====================================================================
        ' Procedure Name        : GenerateResourceSchedule_Monthly
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To plot the 1 month View
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RathinP
        ' Created               : 25 May 2007
        ' Revisions             :
        '=====================================================================
        'Added By RathinP for Numeric Paging

        Dim blnOracle As Boolean
        Dim strConnectionString As String
        Dim ds1 As DataSet
        Dim dtGridTable As DataTable 'Added By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        'End of Addition By RathinP
        Dim strHTML As String
        Dim intloopCounter As Integer = 0
        Dim intMonthCount, intQuarterCount As Integer
        Dim strMonthName, strQuarterName As String
        Dim moment As New System.DateTime
        Dim strTRClass As String
        Dim dsColHeadings As DataSet
        Dim drColHeadings As DataRow
        Dim blnNoItems As Boolean = False
        'for Navigation'
        Dim nRecCount As Integer ' Number of records found
        Dim nPageCount As Integer ' Number of pages of records we have
        Dim nPage As Integer ' Current page number
        Dim nStart As Integer ' Starting Record
        Dim nEnd As Integer ' End Record
        Dim nPageEnd As Integer ' End Page for Alternative Navigation
        'Dim m_strMode As String
        'ends

        'If HttpContext.Current.Request.QueryString("Mode") <> "" Then
        '    m_strMode = HttpContext.Current.Request.QueryString("Mode").ToUpper
        'End If


        Dim strSQL As String
        strSQL = "usp_sel_ResourceSchedule_Monthly  "
        If m_strMode <> "SHOW" Then
            strSQL = ""
        Else

            If m_strBG <> "" Then
                strSQL = strSQL + "" + m_strBG
            Else
                strSQL = strSQL + "NULL"
            End If

            If m_strOU <> "" Then
                strSQL = strSQL + "," + m_strOU
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strDepartment <> "" Then
                strSQL = strSQL + ",'" + m_strDepartment + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strRole <> "" Then
                strSQL = strSQL + ",'" + m_strRole + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strReportingTo <> "" Then
                strSQL = strSQL + ",'" + m_strReportingTo + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strEmployeeName <> "" Then
                strSQL = strSQL + ",'" + Replace(m_strEmployeeName, "'", "''") + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            'Added ShraddhaM
            If m_strEmployeeID <> "" Then
                strSQL = strSQL + "," + m_strEmployeeID
            Else
                strSQL = strSQL + ",NULL"
            End If

            strSQL = strSQL + ",'RCV'"
            'End of addition by ShraddhaM

            ds1 = CommonFunctions.Data.GetDataSet(strSQL, "Default", , , MyBase.UseSQL)
            ' the rows
            dtGridTable = ds1.Tables("Default")
            intNoOfRows = dtGridTable.Rows.Count
            ds1.Dispose() : ds1 = Nothing
            If dtGridTable.Rows.Count > 0 Then
                blnNoItems = True
            End If
        End If

        'Added By RathinP for Numeric Paging
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
        'Reason   - For showing numeric paging similar to paging on CommonList.
        '-------------------------------------------------------------------------------------------------------------
        Dim lngPageSize, lngTotalPages As Long
        'lngPageSize = CommonFunction.Application.MaxQueryPageSize
        lngPageSize = 15
        If lngPageSize <= 0 Then
            lngPageSize = MAX_QUERY_PAGESIZE
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        'Reason      - Get the DataTable which will be used as a datasource to the Grid.
        '              This code was within the if condition -> "If Not blnOracle Then", moved it into here
        '              for getting the data table in anycase (Oracle or Not).
        '-------------------------------------------------------------------------------------------------------------


        If Not blnOracle Then
            If m_blnNotPrinterFriendly Then

                ' total pages
                If CType(intNoOfRows / lngPageSize, Double) > CType(intNoOfRows / lngPageSize, Long) Then
                    lngTotalPages = CType(intNoOfRows / lngPageSize, Long) + 1
                Else
                    lngTotalPages = CType(intNoOfRows / lngPageSize, Long)
                End If

                'If there are more than one pages, then only plot numeric paging.
                If lngTotalPages > 1 Then

                    Dim sbPage As New System.Text.StringBuilder
                    sbPage.Append("../HR/HR_ResourceSchedule.aspx?mode=Show")
                    MyBase.InitializeResources("Resources.StandardMessages", "Resources")
                    Dim objWAF_NumericPage As New CommonFunctions.HTMLControls.WAF_NumericPagingControl
                    With objWAF_NumericPage
                        .WidthInPixel = 50
                        .value = m_lngCurrentPage.ToString
                        .ReturnHTML = True
                        .CurrentPageNumber = m_lngCurrentPage
                        .MaxPageSize = lngTotalPages
                        .FormName = "frmHR_ResourceSchedule"
                        .PagePath = sbPage.ToString()
                        .MaxRangeMsg = MyBase.GetResourceString("MAX_RANGE") + lngTotalPages.ToString()
                        .MinRangeMsg = MyBase.GetResourceString("MIN_RANGE")
                        .PositiveValueMsg = MyBase.GetResourceString("POSITIVE_VALUE")
                        .FirstRecordMsg = MyBase.GetResourceString("FIRST_PAGE")
                        .LastRecordMsg = MyBase.GetResourceString("LAST_PAGE")
                    End With
                    MyBase.InitializeResources("Resources.QRB_QueryResult", "Resources")

                    strPaging = CommonFunctions.HTMLControls.DrawNumericPagingControl("txtPageNumber", "txtPageNumber", objWAF_NumericPage)

                    objWAF_NumericPage = Nothing
                    sbPage = Nothing

                    ' write the paging info
                    With Response
                        If Trim(strPaging & "") <> "" Then
                            m_strPlotPage.Append("<Table class=clsTable cellpadding=0 cellspacing=0 width='100%'><TR class=clsTRMenu><Td align=right>" + vbCrLf)
                            m_strPlotPage.Append(strPaging)
                            m_strPlotPage.Append("</td></TR></Table>" + vbCrLf)
                            'Add a hidden,blank text box to prevent the submition of form when enter key is hit in Numeric paging text box (txtPageNumber).
                            m_strPlotPage.Append("<input type='Textbox' style='display:none'>")
                            'm_strPlotPage.Append("<BR>" + vbCrLf)
                        End If
                    End With

                End If 'lngTotalPages > 1

            End If 'm_blnNotPrinterFriendly

            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
            '-------------------------------------------------------------------------------------------------------------

        End If 'Not blnOracle 
        ' End Addition May 04,2004
        'End of Addition by RathinP


        If blnNoItems <> False Or m_strMode = "SHOW" Then
            'Added to Display The Total No of Records
            With Response
                ' no of rows on the page
                m_strPlotPage.Append("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><tr class=clsTRSectionHeader><td>")
                'm_strPlotPage.Append(MyBase.GetResourceString("TOTAL_RECORDS") & intNoOfRows)
                If strFromWhere = "DB" Then
                    m_strPlotPage.Append("Total Record(s) : " & intNoOfRows)
                    m_strPlotPage.Append("</td></tr></Table>")
                    'ElseIf strFromWhere = "RCV" Then
                    '    m_strPlotPage.Append("<B>Resource :" + dtGridTable.Rows(0).Item("EmployeeName").ToString)
                    '    m_strPlotPage.Append("</B></td></tr></Table>")
                End If

                '.Write("<BR>")
            End With
            'End of Addition
        End If

        'Added By RathinP on 07/06/2007
        'To set the Current Date'
        strDashBoardViewDate = CType(CommonFunctions.Data.GetDataScalar("Select GetDate()", True), String)
        'End of Addition by RathinP


        'Plotting Header of the Resource Schedule table
        m_strPlotPage.Append(" <table id='tbl1' class='clsGridTable' cellpadding='0' cellspacing='1' width='100%'>")
        'm_strPlotPage.Append(" <Tr bgcolor='white'></Tr> ")
        m_strPlotPage.Append(" <Tr id='trHeader1'  align='center' class='clsTRColumnHeader'>")
        If strFromWhere = "DB" Then
            m_strPlotPage.Append(" <TD  id='thh1' class='DivSub1Tag' rowspan=3><B>" + "Resource" + "</B></TD>")
        End If


        dsColHeadings = CommonFunctions.Data.GetDataSet(" usp_Sel_ProjectSchedule_ColumnHeadings 0", "Headings", , , MyBase.UseSQL)
        Dim strcolspan As String
        If dsColHeadings.Tables(0).Rows.Count > 0 Then
            For Each drColHeadings In dsColHeadings.Tables(0).Rows
                m_strPlotPage.Append("<TD  class='DivSub1Tag' colspan=" + CType(drColHeadings("NoOfDays"), String) + " ><B>" + CType(drColHeadings("years"), String) + "</B></TD>")
            Next
            m_strPlotPage.Append(" </TR>")
        End If

        If dsColHeadings.Tables(1).Rows.Count > 0 Then
            m_strPlotPage.Append(" <TR id='trHeader1'  align='center' class='clsTRColumnHeader'>")
            For Each drColHeadings In dsColHeadings.Tables(1).Rows
                strcolspan = CType(drColHeadings("NoOfDays"), String)
                m_strPlotPage.Append("<TD  class='DivSub1Tag' colspan=" + strcolspan + "><B>" + CType(drColHeadings("Months"), String) + "</B></TD>")
            Next
            m_strPlotPage.Append("</TR>")
        End If


        If dsColHeadings.Tables(2).Rows.Count > 0 Then
            m_strPlotPage.Append(" <TR id='trHeader1'  align='center' class='clsTRColumnHeader'>")
            For Each drColHeadings In dsColHeadings.Tables(2).Rows
                m_strPlotPage.Append("<TD  class='DivSub1Tag'><B>" + CType(drColHeadings("Days"), String) + "</B></TD>")
            Next
            m_strPlotPage.Append("</TR>")
        End If


        If blnNoItems = False Or m_strMode <> "SHOW" Then
            m_strPlotPage.Append(" <tr  align='center' class='clsTROdd'><TD Colspan = 32>There are no items to show in this view.</TD></TR>")
        End If

        nStart = CInt(lngPageSize * (m_lngCurrentPage - 1))
        nEnd = CInt(nStart + lngPageSize - 1)
        If nEnd > intNoOfRows - 1 Then
            nEnd = intNoOfRows - 1
        End If

        ' Let's output our records				
        If m_strMode = "SHOW" Then
            Dim j As Integer
            For j = nStart To nEnd
                intloopCounter = 0
                intloopCounter += 1
                If intloopCounter Mod 2 = 0 Then
                    strTRClass = "clsTREven"
                Else
                    strTRClass = "clsTROdd"
                End If
                ' All we do here is just show the records
                m_strPlotPage.Append(" <tr id='tr" + intloopCounter.ToString + "' class='" + strTRClass + "' style='PADDING-RIGHT: 0pt; PADDING-LEFT: 0pt; PADDING-BOTTOM: 0pt; PADDING-TOP: 0pt'>")
                If strFromWhere = "DB" Then
                    m_strPlotPage.Append("<td style='CURSOR: hand' id='linkTD" + dtGridTable.Rows(j).Item("EmployeeID").ToString + "' onclick='SelectRow_OnClick(" + dtGridTable.Rows(j).Item("EmployeeID").ToString + ")'nowrap >" + dtGridTable.Rows(j).Item("EmployeeName").ToString + "</td>")
                End If



                For intMonthCount = 2 To 31
                    If dtGridTable.Rows(j).Item(intMonthCount).ToString = "1" Then
                        m_strPlotPage.Append("  <td id='td" + intloopCounter.ToString + intMonthCount.ToString + "' valign='middle'>")
                        m_strPlotPage.Append(" <table width='100%' height='100%'  cellpadding='0' cellspacing='0'>")
                        m_strPlotPage.Append(" <tr><td></td></tr><tr>")
                        m_strPlotPage.Append(" <td bgcolor='DodgerBlue'></td>")
                        m_strPlotPage.Append(" </tr><tr><td></td></tr>")
                        m_strPlotPage.Append(" </table>")
                        m_strPlotPage.Append(" </td>")
                    Else
                        m_strPlotPage.Append(" <td id='td" + intloopCounter.ToString + intMonthCount.ToString + "'> &nbsp; </td>")
                    End If

                Next
                m_strPlotPage.Append(" </tr>")
            Next

        End If
        m_strPlotPage.Append("</table>")
        Return m_strPlotPage.ToString

    End Function
    Private Function GenerateResourceSchedule_ThreeMonth() As String
        '====================================================================
        ' Procedure Name        : GenerateResourceSchedule_ThreeMonth
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To plot the 3 month View
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RathinP
        ' Created               : 16 May 2007
        ' Revisions             :
        '=====================================================================
        'Added By RathinP for Numeric Paging
        Dim blnOracle As Boolean
        Dim strConnectionString As String
        Dim ds1 As DataSet
        Dim dtGridTable As DataTable 'Added By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        'End of Addition By RathinP
        Dim strHTML As String
        Dim drProjectSchedule As IDataReader
        Dim intloopCounter As Integer = 0
        Dim intMonthCount, intQuarterCount As Integer
        Dim strMonthName, strQuarterName As String
        Dim moment As New System.DateTime
        Dim strTRClass As String
        Dim dsColHeadings As DataSet
        Dim drColHeadings As DataRow
        Dim blnNoItems As Boolean = False
        'for Navigation'
        Dim nRecCount As Integer ' Number of records found
        Dim nPageCount As Integer ' Number of pages of records we have
        Dim nPage As Integer ' Current page number
        Dim nStart As Integer ' Starting Record
        Dim nEnd As Integer ' End Record
        Dim nPageEnd As Integer ' End Page for Alternative Navigation
        'Dim m_strMode As String
        'ends

        'If HttpContext.Current.Request.QueryString("Mode") <> "" Then
        '    m_strMode = HttpContext.Current.Request.QueryString("Mode").ToUpper
        'End If

        Dim strSQL As String
        strSQL = "usp_sel_ResourceSchedule_3Month  "
        If m_strMode <> "SHOW" Then
            strSQL = ""
        Else

            If m_strBG <> "" Then
                strSQL = strSQL + "" + m_strBG
            Else
                strSQL = strSQL + "NULL"
            End If

            If m_strOU <> "" Then
                strSQL = strSQL + "," + m_strOU
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strDepartment <> "" Then
                strSQL = strSQL + ",'" + m_strDepartment + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strRole <> "" Then
                strSQL = strSQL + ",'" + m_strRole + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strReportingTo <> "" Then
                strSQL = strSQL + ",'" + m_strReportingTo + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If

            If m_strEmployeeName <> "" Then
                strSQL = strSQL + ",'" + Replace(m_strEmployeeName, "'", "''") + "'"
            Else
                strSQL = strSQL + ",NULL"
            End If


            'Added ShraddhaM
            If m_strEmployeeID <> "" Then
                strSQL = strSQL + "," + m_strEmployeeID
            Else
                strSQL = strSQL + ",NULL"
            End If

            strSQL = strSQL + ",'RCV'"
            'End of addition by ShraddhaM


            ds1 = CommonFunctions.Data.GetDataSet(strSQL, "Default", , , MyBase.UseSQL)
            ' the rows
            dtGridTable = ds1.Tables("Default")
            intNoOfRows = dtGridTable.Rows.Count
            ds1.Dispose() : ds1 = Nothing
            If dtGridTable.Rows.Count > 0 Then
                blnNoItems = True
            End If

        End If
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        '-------------------------------------------------------------------------------------------------------------

        'Added By RathinP for Numeric Paging
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
        'Reason   - For showing numeric paging similar to paging on CommonList.
        '-------------------------------------------------------------------------------------------------------------
        Dim lngPageSize, lngTotalPages As Long
        'lngPageSize = CommonFunction.Application.MaxQueryPageSize
        lngPageSize = 15
        If lngPageSize <= 0 Then
            lngPageSize = MAX_QUERY_PAGESIZE
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On Wednesday, February 28, 2007 For WAF3_QRB_14: Use DataSet instead of DataReader. (Dependency: WAF3_GEN_11)
        'Reason      - Get the DataTable which will be used as a datasource to the Grid.
        '              This code was within the if condition -> "If Not blnOracle Then", moved it into here
        '              for getting the data table in anycase (Oracle or Not).
        '-------------------------------------------------------------------------------------------------------------
        If Not blnOracle Then
            If m_blnNotPrinterFriendly Then

                ' total pages
                If CType(intNoOfRows / lngPageSize, Double) > CType(intNoOfRows / lngPageSize, Long) Then
                    lngTotalPages = CType(intNoOfRows / lngPageSize, Long) + 1
                Else
                    lngTotalPages = CType(intNoOfRows / lngPageSize, Long)
                End If

                'If there are more than one pages, then only plot numeric paging.
                If lngTotalPages > 1 Then

                    Dim sbPage As New System.Text.StringBuilder
                    sbPage.Append("../HR/HR_ResourceSchedule.aspx?mode=Show")
                    MyBase.InitializeResources("Resources.StandardMessages", "Resources")
                    Dim objWAF_NumericPage As New CommonFunctions.HTMLControls.WAF_NumericPagingControl
                    With objWAF_NumericPage
                        .WidthInPixel = 50
                        .value = m_lngCurrentPage.ToString
                        .ReturnHTML = True
                        .CurrentPageNumber = m_lngCurrentPage
                        .MaxPageSize = lngTotalPages
                        .FormName = "frmHR_ResourceSchedule"
                        .PagePath = sbPage.ToString()
                        .MaxRangeMsg = MyBase.GetResourceString("MAX_RANGE") + lngTotalPages.ToString()
                        .MinRangeMsg = MyBase.GetResourceString("MIN_RANGE")
                        .PositiveValueMsg = MyBase.GetResourceString("POSITIVE_VALUE")
                        .FirstRecordMsg = MyBase.GetResourceString("FIRST_PAGE")
                        .LastRecordMsg = MyBase.GetResourceString("LAST_PAGE")
                    End With
                    MyBase.InitializeResources("Resources.QRB_QueryResult", "Resources")

                    strPaging = CommonFunctions.HTMLControls.DrawNumericPagingControl("txtPageNumber", "txtPageNumber", objWAF_NumericPage)

                    objWAF_NumericPage = Nothing
                    sbPage = Nothing

                    ' write the paging info
                    With Response
                        If Trim(strPaging & "") <> "" Then
                            m_strPlotPage.Append("<Table class=clsTable cellpadding=0 cellspacing=0 width='100%'><TR class=clsTRMenu><Td align=right>" + vbCrLf)
                            m_strPlotPage.Append(strPaging)
                            m_strPlotPage.Append("</td></TR></Table>" + vbCrLf)
                            'Add a hidden,blank text box to prevent the submition of form when enter key is hit in Numeric paging text box (txtPageNumber).
                            m_strPlotPage.Append("<input type='Textbox' style='display:none'>")
                            'm_strPlotPage.Append("<BR>" + vbCrLf)
                        End If
                    End With

                End If 'lngTotalPages > 1

            End If 'm_blnNotPrinterFriendly

            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On - Friday, January 05, 2006 For Hotfix ID. - 2.0.16-SP5-WAF
            '-------------------------------------------------------------------------------------------------------------

        End If 'Not blnOracle 
        'End of Addition by RathinP


        If blnNoItems <> False Or m_strMode = "SHOW" Then
            'Added to Display The Total No of Records
            With Response
                ' no of rows on the page
                m_strPlotPage.Append("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><tr class=clsTRSectionHeader><td>")
                'm_strPlotPage.Append(MyBase.GetResourceString("TOTAL_RECORDS") & intNoOfRows)
                If strFromWhere = "DB" Then
                    m_strPlotPage.Append("Total Record(s) : " & intNoOfRows)
                    m_strPlotPage.Append("</td></tr></Table>")
                    'ElseIf strFromWhere = "RCV" Then
                    '    m_strPlotPage.Append("<B>Resource :" + dtGridTable.Rows(0).Item("EmployeeName").ToString)
                    '    m_strPlotPage.Append("</B></td></tr></Table>")
                End If

                '.Write("<BR>")
            End With
            'End of Addition
        End If

        'Added By RathinP on 07/06/2007
        'To set the Starting date of Current Week'
        strDashBoardViewDate = CType(CommonFunctions.Data.GetDataScalar("Select dbo.udf_getCurrentWeek_For_SpecifiedDate(GETDATE())", True), String)
        'End of Addition by RathinP


        'Plotting Header of the Resource Schedule table
        m_strPlotPage.Append(" <table id='tbl1' class='clsGridTable' cellpadding='0' cellspacing='1' width='100%'>")
        m_strPlotPage.Append(" <Tr id='trHeader1'  align='center' class='clsTRColumnHeader'>")
        If strFromWhere = "DB" Then
            m_strPlotPage.Append(" <TD  id='thh1' class='DivSub1Tag'   rowspan=3><B>" + "Resource" + "</B></TD>")
        End If


        dsColHeadings = CommonFunctions.Data.GetDataSet(" usp_Sel_ProjectSchedule_ColumnHeadings 1", "Headings", , , MyBase.UseSQL)
        Dim strcolspan As String
        If dsColHeadings.Tables(2).Rows.Count > 0 Then
            For Each drColHeadings In dsColHeadings.Tables(2).Rows
                m_strPlotPage.Append("<TD align='center' class='DivSub1Tag' colspan=" + CType(drColHeadings("NoOfMnth"), String) + " ><b>" + CType(drColHeadings("Years"), String) + "</b></TD>")
            Next
        End If
        m_strPlotPage.Append("</TR>")

        m_strPlotPage.Append(" <TR class='clsTRColumnHeader'>")
        If dsColHeadings.Tables(1).Rows.Count > 0 Then
            For Each drColHeadings In dsColHeadings.Tables(1).Rows
                m_strPlotPage.Append("<TD align='center' class='DivSub1Tag' colspan=" + CType(drColHeadings("NoofWeeks"), String) + " ><b>" + CType(drColHeadings("MonthYear"), String) + "</b></TD>")
            Next
        End If
        Dim dtmWeekStartDate As Date

        m_strPlotPage.Append("</TR>")
        m_strPlotPage.Append(" <TR class='clsTRColumnHeader'>")
        If dsColHeadings.Tables(0).Rows.Count > 0 Then
            For Each drColHeadings In dsColHeadings.Tables(0).Rows
                dtmWeekStartDate = CType(drColHeadings("WeekStartDate"), Date)
                m_strPlotPage.Append("<TD align='center' class='DivSub1Tag' width=50px nowrap title='" + CType(drColHeadings("WeekStartDate"), String) + " - " + CType(drColHeadings("WeekEndDate"), String) + "'><b>" + (dtmWeekStartDate.Day).ToString + "</b></TD>")
            Next
            m_strPlotPage.Append("</TR>")
        End If

        If blnNoItems = False Or m_strMode <> "SHOW" Then
            m_strPlotPage.Append(" <tr  align='center' class='clsTROdd'><TD Colspan = 32>There are no items to show in this view.</TD></TR>")
        End If

        'For Getting the Start and End of the Records from Dataset
        nStart = CInt(lngPageSize * (m_lngCurrentPage - 1))
        nEnd = CInt(nStart + lngPageSize - 1)
        If nEnd > intNoOfRows - 1 Then
            nEnd = intNoOfRows - 1
        End If
        'Ends

        ' Let's output our records				
        If m_strMode = "SHOW" Then
            Dim j As Integer
            For j = nStart To nEnd
                intloopCounter = 0
                intloopCounter += 1
                If intloopCounter Mod 2 = 0 Then
                    strTRClass = "clsTREven"
                Else
                    strTRClass = "clsTROdd"
                End If

                ' All we do here is just show the records
                m_strPlotPage.Append(" <tr id='tr" + intloopCounter.ToString + "' class='" + strTRClass + "' style='PADDING-RIGHT: 0pt; PADDING-LEFT: 0pt; PADDING-BOTTOM: 0pt; PADDING-TOP: 0pt'>")
                'm_strPlotPage.Append("<td> </TD>")
                ' m_strPlotPage.Append("<td style='CURSOR: hand' id='linkTD" + dtGridTable.Rows(i).Item("EmployeeID").ToString + "' onclick='SelectRow_OnClick(" + dtGridTable.Rows(i).Item("EmployeeID").ToString + ")'nowrap >" + dtGridTable.Rows(i).Item("EmployeeName").ToString + "</td>")
                If strFromWhere = "DB" Then
                    m_strPlotPage.Append("<td style='CURSOR: hand' id='linkTD" + dtGridTable.Rows(j).Item("EmployeeID").ToString + "' onclick='SelectRow_OnClick(" + dtGridTable.Rows(j).Item("EmployeeID").ToString + ")'nowrap >" + dtGridTable.Rows(j).Item("EmployeeName").ToString + "</td>")
                End If


                For intMonthCount = 2 To 13
                    If dtGridTable.Rows(j).Item(intMonthCount).ToString = "1" Then
                        m_strPlotPage.Append("  <td id='td" + intloopCounter.ToString + intMonthCount.ToString + "' valign='middle'>")
                        m_strPlotPage.Append(" <table width='100%' height='100%'  cellpadding='0' cellspacing='0'>")
                        m_strPlotPage.Append(" <tr><td></td></tr><tr>")
                        m_strPlotPage.Append(" <td bgcolor='DodgerBlue'></td>")
                        m_strPlotPage.Append(" </tr><tr><td></td></tr>")
                        m_strPlotPage.Append(" </table>")
                        m_strPlotPage.Append(" </td>")
                    Else
                        m_strPlotPage.Append(" <td id='td" + intloopCounter.ToString + intMonthCount.ToString + "'> &nbsp; </td>")
                    End If

                Next
                m_strPlotPage.Append(" </tr>")

            Next

        End If
        m_strPlotPage.Append("</table>")
        Return m_strPlotPage.ToString
    End Function
#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'MyBase.InitializeResources("AppResourcePPM.DM_InitiativeSchedule", "AppResourcePPM")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

End Class
