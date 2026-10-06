Imports CommonFunctions

Public Class OTS_ResourceSelection
    Inherits WebPages.Template.WhizTemplate

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

    Private CONST_ADD As String = "ADD"
    Private CONST_EDIT As String = "EDIT"
    Protected CONST_ACTION_SAVE As String = "SAVE"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_strAlphabet As String
    Private m_strSQL As String
    Private m_strPagingSQL As String
    Private m_lngProjectID As Long
    Private m_strDepartment As String
    Private m_strLocation As String
    Private m_strDesignation As String
    Private m_strEmployeeName As String
    Private m_strEmailID As String
    Private m_strEmployeeID As String
    Private WithEvents objGrid As New WebPage.Templates.GenericGrid
    Private m_strTimesheetSchedulerID As String
    'Added by DipaliS

    'SchedulerChanges15-12-2004
    'Commented
    'Protected m_strSingleSelect As Integer
    'Added
    Protected m_strSingleSelect As String
    'End addition by DipaliS

    ' Added by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular
    Private m_blnOnDemand As Boolean
    ' End of Addition by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular

    Public Sub New()
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting        
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    'initialize the variables 
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        m_lngProjectID = 0
        m_strMode = Request.QueryString("Mode") + ""
        m_strAction = Request.QueryString("Action") + ""

        'Adde by DipaliS
        m_strSingleSelect = CommonFunction.General.CheckIsNothing(Request.QueryString("SingleSelect"), "") + ""
        'End addition by DipaliS

        If CommonFunction.General.CheckIsNothing(Session("intProjectID"), "") <> "" Then
            m_lngProjectID = CType(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"), Long)
        End If

        If CommonFunction.General.CheckIsNothing(Request.QueryString("TimesheetSchedulerID"), "") <> "" Then
            m_strTimesheetSchedulerID = Request.QueryString("TimesheetSchedulerID") + ""
        Else
            m_strTimesheetSchedulerID = MyBase.GetFormValue("TimesheetSchedulerID") + ""
        End If

        m_strDepartment = Request.QueryString("Department") + ""
        m_strLocation = Request.QueryString("Location") + ""
        m_strDesignation = Request.QueryString("Designation") + ""
        m_strEmployeeName = Request.QueryString("EmployeeName") + ""
        m_strEmailID = Request.QueryString("EMailID") + ""
        m_strEmployeeID = Request.QueryString("EmployeeID") + ""

        ' Added by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular
        m_blnOnDemand = False
        If CommonFunction.General.CheckIsNothing(Request.QueryString("OnDemand"), "") <> "" Then
            m_blnOnDemand = CType(Request.QueryString("OnDemand"), Boolean)
        Else
            m_blnOnDemand = CType(MyBase.GetFormValue("OnDemand"), Boolean)
        End If
        ' End of Addition by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular


    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML body tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	06 Dec 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strSQL As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String

        'get filter values
        If m_strDepartment = "" Then m_strDepartment = MyBase.GetFormValue("cboDepartment") + ""
        If m_strLocation = "" Then m_strLocation = MyBase.GetFormValue("cboLocation") + ""
        If m_strDesignation = "" Then m_strDesignation = MyBase.GetFormValue("cboDesignation") + ""
        If m_strEmployeeName = "" Then m_strEmployeeName = MyBase.GetFormValue("txtEmpName") + ""
        If m_strEmailID = "" Then m_strEmailID = MyBase.GetFormValue("txtEmailID1") + ""
        If m_strEmployeeID = "" Then m_strEmployeeID = MyBase.GetFormValue("txtEmployeeID") + ""
        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"


        If m_strAction = CONST_ACTION_SAVE Then
            UpdateData()
        End If

        m_strPagingSQL = "usp_Sel_tbl_PM_Employee_Scheduler_Paging " + m_lngProjectID.ToString
        m_strSQL = "usp_Sel_tbl_PM_Employee_Scheduler " + m_lngProjectID.ToString

        If m_strEmployeeID <> "" Then
            m_strSQL += "," + m_strEmployeeID
            m_strPagingSQL += "," + m_strEmployeeID
        Else
            m_strSQL += ",NULL"
            m_strPagingSQL += ",NULL"
        End If
        If m_strEmployeeName <> "" Then
            m_strSQL += ",'" + m_strEmployeeName + "'"
            m_strPagingSQL += ",'" + m_strEmployeeName + "'"
        Else
            m_strSQL += ",NULL"
            m_strPagingSQL += ",NULL"
        End If
        If m_strEmailID <> "" Then
            m_strSQL += ",'" + m_strEmailID + "'"
            m_strPagingSQL += ",'" + m_strEmailID + "'"
        Else
            m_strSQL += ",NULL"
            m_strPagingSQL += ",NULL"
        End If
        If m_strDepartment <> "" Then
            m_strSQL += "," + m_strDepartment
            m_strPagingSQL += "," + m_strDepartment
        Else
            m_strSQL += ",NULL"
            m_strPagingSQL += ",NULL"
        End If
        If m_strLocation <> "" Then
            m_strSQL += "," + m_strLocation
            m_strPagingSQL += "," + m_strLocation
        Else
            m_strSQL += ",NULL"
            m_strPagingSQL += ",NULL"
        End If
        If m_strDesignation <> "" Then
            m_strSQL += "," + m_strDesignation
            m_strPagingSQL += "," + m_strDesignation
        Else
            m_strSQL += ",NULL"
            m_strPagingSQL += ",NULL"
        End If
        If m_strAlphabet <> "" Then
            m_strSQL += ",'" + m_strAlphabet + "'"
            m_strPagingSQL += ",NULL"
        Else
            m_strSQL += ",NULL"
            m_strPagingSQL += ",NULL"
        End If

        'pass where clause to ignore those resources which are already added to timsheet scheduler
        If m_strTimesheetSchedulerID <> "" Then
            m_strSQL += ",' B.EmployeeID Not In (Select EmployeeID From tbl_PM_Timesheet_Scheduler_Details Where TimesheetSchedulerID=" + m_strTimesheetSchedulerID + " )'"
            m_strPagingSQL += ",' B.EmployeeID Not In (Select EmployeeID From tbl_PM_Timesheet_Scheduler_Details Where TimesheetSchedulerID=" + m_strTimesheetSchedulerID + " )'"
        End If

        'SchedulerChanges15-12-2004
        'Added by DipaliS 15 dec 2004
        'If called from On Demand Scheduler Show all the Resources
        ' Added by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular
        'If m_strTimesheetSchedulerID = "" Then
        If m_blnOnDemand = True Then
            ' End of Addition by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular
            m_strSQL += ",1"
            m_strPagingSQL += ",1"
        Else
            m_strSQL += ",0"
            m_strPagingSQL += ",0"
        End If
        'End addition by DipaliS
        'EndSchedulerChanges15-12-2004

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        ''''' Start DebadattaR 28-Sep-2005 for Cosmetic Changes

        arrMenu.Add("Show") : arrMenuToolTip.Add("Show") : arrClientSideFunctions.Add("Show_OnClick()")

        ''''' End DebadattaR 28-Sep-2005 for Cosmetic Changes

        arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
        ' Code Added by RajkumarM on 5th Oct to Add SelectAll link
        arrMenu.Add("Select All") : arrMenuToolTip.Add("Select All") : arrClientSideFunctions.Add("SelectAll_OnClick()")
        arrMenu.Add("Clear All") : arrMenuToolTip.Add("Clear All") : arrClientSideFunctions.Add("ClearAll_OnClick()")
        ' Code Added by RajkumarM on 5th Oct to Add SelectAll link
        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('EmpSelect')")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing

        'display the paging links on the menu bar
        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, m_strPagingSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "EmployeeName", True)
        objPaging = Nothing

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)

        'draw upper menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")
        'create lower menu without paging
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)


        'initialize the resource file for HR_EmployeeSelection page.
        MyBase.InitializeResources("AppResources.HR_EmployeeSelection", "AppResources")

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
        General.WriteHTML("<BR>")

        'plot the screen with data
        Call plotEmployeeList()

        'store data in hidden controls
        ''''Commented And Added By Vaijat K On 07/10/2015
        '''General.WriteHTML(HTMLControls.DrawTextBox("TimesheetSchedulerID", "TimesheetSchedulerID", , , , m_strTimesheetSchedulerID.Trim, , , , , , True, , True))
        General.WriteHTML(HTMLControls.DrawTextBox("TimesheetSchedulerID", "TimesheetSchedulerID", , , , m_strTimesheetSchedulerID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 07/10/2015
        ' Added by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular
        'General.WriteHTML(HTMLControls.DrawTextBox("OnDemand", "OnDemand", , , , m_blnOnDemand, , , , , , True, , True))
        ''''Commented And Added By Vaijat K On 07/10/2015
        '''General.WriteHTML(HTMLControls.DrawTextBox("OnDemand", "OnDemand", , , , m_blnOnDemand.ToString, , , , , , True, , True))
        General.WriteHTML(HTMLControls.DrawTextBox("OnDemand", "OnDemand", , , , m_blnOnDemand.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 07/10/2015
        ' End of Addition by RajkumarM on 14th Oct 2005 to show In Active Employees in On Demand Schedular

        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotEmployeeList
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls to show list of employies 
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	06 Dec 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotEmployeeList()
        Dim objdr As IDataReader
        Dim strSQL As String
        Dim objLink As WebPage.UI.cDynamicLink
        'Dim objGrid As WebPage.Templates.GenericGrid
        Dim arrlstColHeader As Collections.ArrayList
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstRowLink As Collections.ArrayList
        Dim arrlstChkBox As Collections.ArrayList
        Dim intColToShow As Integer

        'plot the filter textbox
        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTREven'>")
        'plot employee name control

        ''''' Start Commented By DebadattaR 28-Sep-2005 for Cosmetic Changes.

        ''''' General.WriteHTML("<TD align='right' nowrap >Employee Name&nbsp;</TD>")
        ''''' General.WriteHTML("<TD align='left' nowrap >")
        ''''' General.WriteHTML(HTMLControls.DrawTextBox("txtEmpName", "txtEmpName", , 100, , m_strEmployeeName.Trim, , , , , , , , True) + "</TD>")
        ''''' General.WriteHTML("<TD align='right' nowrap >Employee ID&nbsp;</TD>")
        ''''' General.WriteHTML("<TD align='left' nowrap >")
        ''''' General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeID", "txtEmployeeID", , 100, , m_strEmployeeID.Trim, , , , , , , , True) + "</TD>")
        ''''' General.WriteHTML("<TD align='right' nowrap >EMail ID&nbsp;</TD>")
        ''''' General.WriteHTML("<TD align='left' nowrap >")
        ''''' General.WriteHTML(HTMLControls.DrawTextBox("txtEmailID", "txtEmailID", , 100, , m_strEmailID.Trim, , , , , , , , True))

        ''''' End Commented By DebadattaR 28-Sep-2005 for Cosmetic Changes


        ''''' Start DebadattaR 28-Sep-2005 for Cosmetic Changes

        General.WriteHTML("<TD align='right' nowrap >Resource&nbsp;</TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        ''''Commented And Added By Vaijat K On 07/10/2015
        '''General.WriteHTML(HTMLControls.DrawTextBox("txtEmpName", "txtEmpName", , 100, , m_strEmployeeName.Trim, , , , , , , , True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextBox("txtEmpName", "txtEmpName", , 100, , m_strEmployeeName.Trim, , , , , , , , True, EnableHTMLEncode:=True) + "</TD>")
        ''''End Added By Vaijat K On 07/10/2015
        General.WriteHTML("<TD align='right' nowrap >Email ID&nbsp;</TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        ''''Commented And Added By Vaijat K On 07/10/2015
        '''General.WriteHTML(HTMLControls.DrawTextBox("txtEmailID1", "txtEmailID1", , 100, , m_strEmailID.Trim, , , , , , , , True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextBox("txtEmailID1", "txtEmailID1", , 100, , m_strEmailID.Trim, , , , , , , , True, EnableHTMLEncode:=True) + "</TD>")
        ''''End Added By Vaijat K On 07/10/2015
        General.WriteHTML("<TD align='right' nowrap >Employee ID&nbsp;</TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        ''''Commented And Added By Vaijat K On 07/10/2015
        '''General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeID", "txtEmployeeID", , 100, , m_strEmployeeID.Trim, , , , , , , , True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeID", "txtEmployeeID", , 100, , m_strEmployeeID.Trim, , , , , , , , True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 07/10/2015

        ''''' End DebadattaR 28-Sep-2005 for Cosmetic Changes

        ''''' Start Commented By DebadattaR 28-Sep-2005 for Cosmetic Changes.

        ''''''display links
        '''''objLink = New WebPage.UI.cDynamicLink
        '''''objLink.ReturnHTML = True
        '''''objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        '''''objLink.LinkName = MyBase.GetResourceString("LINK_SHOW") + ""
        '''''objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
        '''''objLink.FunctionName = "Show_OnClick()"
        '''''General.WriteHTML("| <B>" + objLink.GetDynamicLink() + "</B> |")
        '''''objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR") + ""
        '''''objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP") + ""
        '''''objLink.FunctionName = "Clear_OnClick()"
        '''''General.WriteHTML(" <B>" + objLink.GetDynamicLink() + "</B> |")

        ''''' End Commented By DebadattaR 28-Sep-2005 for Cosmetic Changes

        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        ''''' Start Commented By DebadattaR 28-Sep-2005 for Cosmetic Changes.

        ''''''diplay dpartment combo
        '''''General.WriteHTML("<TR class='clsTREven'>")
        '''''strSQL = "usp_Sel_PM_DepartmentList"
        '''''General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_DEPARTMENT") + "&nbsp;</TD>")
        '''''General.WriteHTML("<TD align='left' nowrap >")
        '''''General.WriteHTML(HTMLControls.DrawComboBox("cboDepartment", strSQL, 120, m_strDepartment.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        ''''''display location combo
        '''''strSQL = "usp_Sel_PM_LocationList"
        '''''General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_LOCATION") + "&nbsp;</TD>")
        '''''General.WriteHTML("<TD align='left' nowrap >")
        '''''General.WriteHTML(HTMLControls.DrawComboBox("cboLocation", strSQL, 120, m_strLocation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        ''''''display Designation combo
        '''''strSQL = "usp_Sel_tbl_PM_Role"
        '''''General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_DESIGNATION") + "&nbsp;</TD>")
        '''''General.WriteHTML("<TD align='left' nowrap >")
        '''''General.WriteHTML(HTMLControls.DrawComboBox("cboDesignation", strSQL, 150, m_strDesignation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        '''''General.WriteHTML("</TR>")

        ''''' End Commented By DebadattaR 28-Sep-2005 for Cosmetic Changes

        ''''' Start DebadattaR 28-Sep-2005 for Cosmetic Changes

        '######### Modified by AnugrahaL on 09 Jan 2006 to hide the Wipro specific filters #############
        General.WriteHTML("<TR class='clsTREven'>")

        'display location combo
        strSQL = "usp_Sel_PM_LocationList"
        General.WriteHTML("<TD align='right' nowrap ><!--" + MyBase.GetResourceString("CAP_LOCATION") + "&nbsp;--></TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        General.WriteHTML(HTMLControls.DrawComboBox("cboLocation", strSQL, 120, m_strLocation.Trim, , True, True, , , , True) + "</TD>")

        'display Designation combo
        strSQL = "usp_Sel_tbl_PM_Role"
        General.WriteHTML("<TD align='right' nowrap ><!--" + MyBase.GetResourceString("CAP_DESIGNATION") + "&nbsp;--></TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        General.WriteHTML(HTMLControls.DrawComboBox("cboDesignation", strSQL, 150, m_strDesignation.Trim, , True, True, , , , True) + "</TD>")

        'diplay SAPRole  combo
        strSQL = "usp_Sel_tbl_WPBN_PM_SAPRoles"
        General.WriteHTML("<TD align='right' nowrap ><!--SAP Role&nbsp;--></TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        General.WriteHTML(HTMLControls.DrawComboBox("cboDepartment", strSQL, 120, m_strDepartment.Trim, , True, True, , , , True) + "</TD>")

        ''''' End DebadattaR 28-Sep-2005 for Cosmetic Changes
        '########## End of modification by AnugrahaL on 09 Jan 2006 #####################################
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'initialize the grid columns
        arrlstColHeader = New Collections.ArrayList
        arrlstAN = New Collections.ArrayList
        arrlstRowLink = New Collections.ArrayList
        arrlstChkBox = New Collections.ArrayList

        '''''arrlstColHeader.Add("Employee Name") : arrlstColHeader.Add("Employee ID") : arrlstColHeader.Add("Email ID")
        '''''arrlstAN.Add("EmployeeName") : arrlstAN.Add("EmployeeID") : arrlstAN.Add("EMailID")
        '''''arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("")
        '''''arrlstChkBox.Add("") : arrlstChkBox.Add("") : arrlstChkBox.Add("")

        '''''arrlstColHeader.Add(MyBase.GetResourceString("COL_USER_NAME"))
        '''''arrlstAN.Add("UserName")
        '''''arrlstRowLink.Add("")
        '''''arrlstChkBox.Add("")

        '''''arrlstColHeader.Add(MyBase.GetResourceString("COL_DEPARTMENT")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_LOCATION")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_DESIGNATION"))
        '''''arrlstAN.Add("Department") : arrlstAN.Add("Location") : arrlstAN.Add("RoleDescription")
        '''''arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("")
        '''''arrlstChkBox.Add("") : arrlstChkBox.Add("") : arrlstChkBox.Add("")

        '''''arrlstColHeader.Add("Select")
        '''''arrlstAN.Add("")
        '''''arrlstRowLink.Add("")
        '''''arrlstChkBox.Add("chkSelect")


        ''''' Start DebadattaR 28-Sep-2005 for Cosmetic Changes

        arrlstColHeader.Add("Resource")
        arrlstAN.Add("EmployeeName")
        arrlstRowLink.Add("")
        arrlstChkBox.Add("")

        arrlstColHeader.Add("Email ID")
        arrlstAN.Add("EMailID")
        arrlstRowLink.Add("")
        arrlstChkBox.Add("")

        arrlstColHeader.Add("Status")
        arrlstAN.Add("ResourceStatus")
        arrlstRowLink.Add("")
        arrlstChkBox.Add("")

        arrlstColHeader.Add("Select")
        arrlstAN.Add("")
        arrlstRowLink.Add("")
        arrlstChkBox.Add("chkSelect")

        ''''' End DebadattaR 28-Sep-2005 for Cosmetic Changes

        ''''' Start Commented By DebadattaR 05-Oct-2005 For Cosmetic Changes

        '''''arrlstColHeader.Add(MyBase.GetResourceString("COL_LOCATION"))
        '''''arrlstAN.Add("Location")
        '''''arrlstRowLink.Add("")
        '''''arrlstChkBox.Add("")

        '''''arrlstColHeader.Add(MyBase.GetResourceString("COL_DESIGNATION"))
        '''''arrlstAN.Add("RoleDescription")
        '''''arrlstRowLink.Add("")
        '''''arrlstChkBox.Add("")

        '''''arrlstColHeader.Add("SAP Role")
        '''''arrlstAN.Add("SAPRoleDescription")
        '''''arrlstRowLink.Add("")
        '''''arrlstChkBox.Add("")

        ''''' End Commented By DebadattaR 05-Oct-2005 For Cosmetic Changes

        Dim arrColHeader(arrlstColHeader.Count - 1) As String
        Dim arrAN(arrlstAN.Count - 1) As String
        Dim arrRowLink(arrlstRowLink.Count - 1) As String
        Dim arrchkSelect(arrlstChkBox.Count - 1) As String
        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)
        arrlstChkBox.CopyTo(arrchkSelect)
        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing
        arrlstChkBox = Nothing


        ''''Added By Vaijat K On 07/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 07/10/2015

        'create Grid object and set the properties
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        objGrid.CheckBoxIDArray = arrchkSelect
        objGrid.PrimaryKey = "EmployeeID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 300
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 3
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = m_strSQL
        objGrid.UseSQL = MyBase.UseSQL

        ''''Added By Vaijat K On 07/10/2015
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        ''''End Added By Vaijat K On 07/10/2015
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing

        'General.WriteHTML(HTMLControls.DrawTextBox("txtSearchType", "txtSearchType", , , , m_strSearchType.Trim, , , , , , True, , True))
        'General.WriteHTML(HTMLControls.DrawTextBox("txtMasterTagID", "txtMasterTagID", , , , m_strMasterTagID.Trim, , , , , , True, , True))
    End Sub


    '=====================================================================
    ' Procedure Name		:	UpdateData
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data by inserting record in the timesheet defaulters table
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	07 Dec 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub UpdateData()
        Dim strSQL As String
        Dim strEmpIDList As String
        Dim arrEmpIDList() As String
        Dim strEmployeeID As String
        Dim blnDataUpdated As Boolean = False

        If m_strTimesheetSchedulerID <> "" Then
            strEmpIDList = MyBase.GetFormValue("chkSelect") + ""
            If strEmpIDList <> "" Then
                arrEmpIDList = strEmpIDList.Split(","c)

                For Each strEmployeeID In arrEmpIDList
                    If strEmployeeID <> "" Then
                        strSQL = "usp_Ins_WPBN_tbl_PM_Timesheet_Scheduler_Details " + m_strTimesheetSchedulerID + "," + strEmployeeID
                        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                        blnDataUpdated = True
                    End If
                Next
            End If

            If blnDataUpdated = True Then
                General.WriteHTML("<Script language=javascript>")
                'General.WriteHTML("opener.frmCommonPage.submit();")
                If m_blnOnDemand Then
                    HttpContext.Current.Response.Write(vbCrLf + "   refreshParent('frmCommonPage','OnDemand_CommonPage.aspx','OnDemand_CommonPage.aspx',true);")
                Else
                    HttpContext.Current.Response.Write(vbCrLf + "   refreshParent('frmCommonPage','Default_CommonPage.aspx','Default_CommonPage.aspx',true);")
                End If
                General.WriteHTML("</Script>")
            End If

        End If

    End Sub

    'This event is used to format the number for column employeeID
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.DataField = "EmployeeID" Then
            Args.ApplyDataTypeBasedFormatting = False
        End If
        'Added by DipaliS 
        If Args.DataField.ToUpper = "USERNAME" Then
            Args.StringToBeInserted = "<Input type=hidden name='txtUsername' id='txtUserName" + Args.DataReader("EmployeeID").ToString + "' value=""" + Args.DataReader("UserName").ToString + """>"
        ElseIf Args.DataField.ToUpper = "EMAILID" Then
            Args.StringToBeInserted = "<Input type=hidden name='txtEMailID' id='txtEmailID" + Args.DataReader("EmployeeID").ToString + "' value=""" + CommonFunction.Data.CheckIsDBNull(Args.DataReader("EMailID"), "").ToString + """>"
        End If
        'End addition by DipaliS
    End Sub
End Class
