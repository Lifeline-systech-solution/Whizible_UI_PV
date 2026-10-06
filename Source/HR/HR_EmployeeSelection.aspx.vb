Imports CommonFunctions

Public Class HR_EmployeeSelection
    Inherits WebPages.Template.WhizTemplate

    Protected m_strWindowTitle As String
    Protected m_strFromWhere As String
    Protected m_strAction As String
    Protected m_strAlphabet As String
    Private m_strSQL As String
    Private m_strProjectID As String
    Private m_strControlID As String
    Private m_strFilter As String
    Private m_strLocation As String
    Private m_strDesignation As String
    Private m_strDepartment As String
    Private m_strParentFormName As String
    'Private m_strSearchType As String
    'Protected m_strMasterTagID As String
    'Private m_blnShowEmployeeCode As Boolean
    'Private m_dblResourcePercentageMaxLimit As Double
    'Private m_dblTotalResourcePerInOtherProjects As Double
    'Private m_strWhereClause As String
    'Private m_strPayroll As String
    'Private m_strUnit As String
    ' Added By NitinVS on 20 July 2005 for WhizibleSEM SP4 
    ' To Display the Desgnation Filter 
    Private m_strDesignationName As String = ""
    ' End Addition By NitinVS on 20 july 2005 for WhizibleSEM SP4 

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")
    End Sub
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.HR_EmployeeSelection", "AppResources")
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
    ' Created				:	Feb 18 2004
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
        Dim strPagingSQL As String
        Dim strEmployeeCode As String


        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"
        m_strFilter = MyBase.GetFormValue("txtFilter", False) + ""

        'if page is calles first time(not posted back) then take the values from the querystring
        'else take the values from the hidden controls which are created first time.
        If Not IsPostBack Then
            m_strFromWhere = Request.QueryString("FromWhere") + ""
            m_strControlID = Request.QueryString("IDControl") + ""
            m_strProjectID = ""
            If m_strFromWhere <> "KM" Then
                m_strProjectID = Session("intProjectID").ToString + ""
            End If

            'm_strMasterTagID = Request.QueryString("MasterTagID") + ""
            'm_strSearchType = Session("SearchType").ToString + ""
        Else
            m_strFromWhere = MyBase.GetFormValue("txtFromWhere") + ""
            m_strControlID = MyBase.GetFormValue("txtControlID") + ""
            m_strProjectID = MyBase.GetFormValue("txtintProjectID") + ""
            'm_strMasterTagID = MyBase.GetFormValue("txtMasterTagID") + ""
            'm_strSearchType = MyBase.GetFormValue("txtSearchType") + ""
            'm_strPayroll = MyBase.GetFormValue("cboPayroll") + ""
            'm_strUnit = MyBase.GetFormValue("cboUnit") + ""
        End If

        'get filter from the combo box
        m_strDepartment = MyBase.GetFormValue("cboDepartment") + ""
        m_strLocation = MyBase.GetFormValue("cboLocation") + ""
        If Request.QueryString("RoleID") <> "" Then
            m_strDesignation = Request.QueryString("RoleID")
        Else
            m_strDesignation = MyBase.GetFormValue("cboDesignation") + ""
        End If
        'hidden control
        strEmployeeCode = MyBase.GetFormValue("txtEmployeeCode") + ""

        ' Added By NitinVS on 20 July 2005 For whizibleSEM SP4 
        m_strDesignationName = MyBase.GetFormValue("cboDesignationID") + ""
        ' End Addition By NitinVS on 20 July 2005 for WhizibleSEM SP4

        If m_strFromWhere = "KM" Then
            If m_strControlID = "txtAuthenticatorID" Then
                m_strSQL = "Exec usp_Sel_KM_Authenticators "
                strPagingSQL = "usp_Sel_KM_Authenticators_PagingAlphabet "
            Else
                m_strSQL = "usp_Sel_KM_Contributors "
                strPagingSQL = "usp_Sel_KM_Contributors_PagingAlphabet "
            End If
        Else
            m_strSQL = "usp_Sel_tbl_PM_Employee_Temp "
            strPagingSQL = "usp_Sel_tbl_PM_Employee_Temp_PagingAlphabet "
            m_strSQL += m_strProjectID.Trim + ","
            strPagingSQL += m_strProjectID.Trim + ","
        End If

        'apply the filters
        If m_strLocation <> "" Then
            m_strSQL += m_strLocation.Trim + ","
            strPagingSQL += m_strLocation.Trim + ","
        Else
            m_strSQL += "Null,"
            strPagingSQL += "Null,"
        End If
        If m_strDepartment <> "" Then
            m_strSQL += m_strDepartment + ","
            strPagingSQL += m_strDepartment + ","
        Else
            m_strSQL += "Null,"
            strPagingSQL += "Null,"
        End If
        If m_strDesignation <> "" Then
            m_strSQL += m_strDesignation.Trim + ","
            strPagingSQL += m_strDesignation.Trim + ","
        Else
            m_strSQL += "Null,"
            strPagingSQL += "Null,"
        End If

        ' Added By NitinVS on 20 july 2005 For WhizibleSEM SP4 
        ' Designation Filter is to be shown
        'Modified by SandipL on 7 Dec 2005 For WhizibleSEM SP5 -- Designation not required in case of knowledge module
        If m_strFromWhere <> "KM" Then
            If m_strDesignationName <> "" Then
                m_strSQL += m_strDesignationName.Trim + ","
                strPagingSQL += m_strDesignationName.Trim + ","
            Else
                m_strSQL += "Null,"
                strPagingSQL += "Null,"
            End If
        End If
        'End modification by SandipL
        ' End Addition By NitinVS on 20 July 2005 for WhizibleSEM SP4 

        '################################################################################
        'This case is specific to particular client(MPhasys) and not the part of core functionality
        'any references to this case are commented in here.

        'm_blnShowEmployeeCode = False
        'm_strWhereClause = "'"

        'If m_strMasterTagID = "20004" Then

        '    If m_strSearchType = "Outsource" Then
        '        m_blnShowEmployeeCode = True
        '        m_strWhereClause = ", 'EmployeeType = ''Outsource''"

        '        If strEmployeeCode <> "" Then
        '            m_strWhereClause += " AND EmployeeCode = ''" + General.BuildQueryString(strEmployeeCode) + "''"
        '        End If
        '        If m_strPayroll <> "" Then
        '            m_strWhereClause += " AND CurrentPayrollID = " + m_strPayroll + " "
        '        End If
        '        If m_strUnit <> "" Then
        '            m_strWhereClause += " AND UnitID = " + m_strUnit + " "
        '        End If
        '        m_strWhereClause += "'"
        '    End If

        'ElseIf m_strMasterTagID = "23" Then

        '    If m_strSearchType = "NonOutsource" Then
        '        m_blnShowEmployeeCode = True
        '        m_strWhereClause = ", 'EmployeeType <> ''Outsource''"

        '        If strEmployeeCode <> "" Then
        '            m_strWhereClause += " AND EmployeeCode = ''" + General.BuildQueryString(strEmployeeCode) + "''"
        '        End If
        '        If m_strPayroll <> "" Then
        '            m_strWhereClause += " AND CurrentPayrollID = " + m_strPayroll + " "
        '        End If
        '        If m_strUnit <> "" Then
        '            m_strWhereClause += " AND UnitID = " + m_strUnit + " "
        '        End If
        '        m_strWhereClause += "'"
        '    End If

        'End If
        '################################################################################

        'create pagin sql seperatly as it dont need the alphabetical filter
        strPagingSQL += "'-1'"

        '##### Added By AmitD for Scurity Filter BusinessGroup and Location(OU)
        '##### Based on High,Middle,low Role Level
        'If m_strFromWhere <> "KM" Then
        '    If CType(Session("intUserID"), String) <> "" Then
        '        strPagingSQL += "," + CType(Session("intUserID"), String)
        '    End If
        'End If
        '##### End Addition

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

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
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strPagingSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "EmployeeName", True)
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

        ''draw page description
        'objHeader = New WebPage.Templates.HeaderFooter
        'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC") + ""
        'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
        'General.WriteHTML("<BR>")
        'objHeader = Nothing

        'plot the screen with data
        Call plotEmployeeList()

        'write client side script to declare the variabel for controlID on the parent page.
        General.WriteHTML("<Script language=javascript>")
        General.WriteHTML("var strControlID = '" + m_strControlID.Trim + "';")
        General.WriteHTML("</Script>")

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
    ' Created				:	Feb 18 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotEmployeeList()
        Dim strSQL As String
        Dim objdr As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink
        Dim objGrid As WebPage.Templates.GenericGrid
        Dim arrlstColHeader As Collections.ArrayList
        Dim arrlstAN As Collections.ArrayList
        Dim arrlstRowLink As Collections.ArrayList
        Dim intColToShow As Integer

        'plot the filter textbox
        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        General.WriteHTML("<TR class='clsTREven'>")
        ' Modified By NitinVS on 20 July for WhizibleSEM SP 4 
        General.WriteHTML("<TD align='left' width=100% nowrap colspan=4 >" + MyBase.GetResourceString("CAP_SHOW_NAME") + "&nbsp;")
        ' End Modification By NitinVs on 20 July 2005 for WhizibleSEM SP4 
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtFilter", "txtFilter", , 50, , m_strFilter.Trim, , , , , , , , True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        'display links
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        objLink.LinkName = MyBase.GetResourceString("LINK_SHOW") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
        objLink.FunctionName = "Show_OnClick()"
        General.WriteHTML("| <B>" + objLink.GetDynamicLink() + "</B> |")
        objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP") + ""
        objLink.FunctionName = "Clear_OnClick()"
        General.WriteHTML(" <B>" + objLink.GetDynamicLink() + "</B> |")
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        ''diplay dpartment combo
        'General.WriteHTML("<TR class='clsTREven'>")
        'strSQL = "usp_Sel_PM_DepartmentList"
        'General.WriteHTML("<TD align='left' nowrap >" + MyBase.GetResourceString("CAP_DEPARTMENT") + "&nbsp;")
        'General.WriteHTML(HTMLControls.DrawComboBox("cboDepartment", strSQL, 120, m_strDepartment.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        ''display location combo
        'strSQL = "usp_Sel_PM_LocationList"
        'General.WriteHTML("<TD align='left' nowrap >" + MyBase.GetResourceString("CAP_LOCATION") + "&nbsp;")
        'General.WriteHTML(HTMLControls.DrawComboBox("cboLocation", strSQL, 120, m_strLocation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        ''display Designation combo
        'strSQL = "usp_Sel_tbl_PM_Role"
        'General.WriteHTML("<TD align='left' nowrap >" + MyBase.GetResourceString("CAP_DESIGNATION") + "&nbsp;")
        'General.WriteHTML(HTMLControls.DrawComboBox("cboDesignation", strSQL, 150, m_strDesignation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        'General.WriteHTML("</TR>")

        ' Modified By NitinVS on 20 July for WhizibleSEM SP 4 
        ' To Display Designation Filter 

        'diplay dpartment combo
        General.WriteHTML("<TR class='clsTREven'>")
        strSQL = "usp_Sel_PM_DepartmentList"
        General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_DEPARTMENT") + "&nbsp;" + "</TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        General.WriteHTML(HTMLControls.DrawComboBox("cboDepartment", strSQL, 150, m_strDepartment.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        'display location combo
        strSQL = "usp_Sel_PM_LocationList"
        General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_LOCATION") + "&nbsp;" + "</TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        General.WriteHTML(HTMLControls.DrawComboBox("cboLocation", strSQL, 150, m_strLocation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")


        'display Role combo
        strSQL = "usp_Sel_tbl_PM_Role"
        General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_ROLE") + "&nbsp;" + "</TD>")
        General.WriteHTML("<TD align='left' nowrap >")
        General.WriteHTML(HTMLControls.DrawComboBox("cboDesignation", strSQL, 150, m_strDesignation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        ' Display Designation Combo 
        If m_strFromWhere <> "KM" Then

            strSQL = "usp_Sel_tbl_PM_DesignationMaster"
            General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_DESIGNATION") + "&nbsp;" + "</TD>")
            General.WriteHTML("<TD align='left' nowrap >")
            General.WriteHTML(HTMLControls.DrawComboBox("cboDesignationID", strSQL, 150, m_strDesignationName.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        Else
            General.WriteHTML("<TD>&nbsp;</TD>")
        End If

        General.WriteHTML("</TR>")

        ' End Modification By NitinVs on 20 July 2005 for WhizibleSEM SP4 
        ' To show Designation Filter 

        '################################################################################
        'This code in been commented as purpose is not cleared, and specific to case
        'If m_blnShowEmployeeCode = True Then
        '    General.WriteHTML("<TR class='clsTREven'>")

        '    'display payroll combo box
        '    strSQL = "usp_Sel_tbl_PM_PayrollMaster"
        '    General.WriteHTML("<TD align='left' nowrap >" + MyBase.GetResourceString("CAP_PAYROLL") + "&nbsp;")
        '    General.WriteHTML(HTMLControls.DrawComboBox("cboPayroll", strSQL, 200, m_strPayroll.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        '    'display unit combo box
        '    strSQL = "usp_Sel_tbl_PM_UnitMaster"
        '    General.WriteHTML("<TD align='left' nowrap >" + MyBase.GetResourceString("CAP_UNIT") + "&nbsp;")
        '    General.WriteHTML(HTMLControls.DrawComboBox("cboUnit", strSQL, 200, m_strUnit.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        '    General.WriteHTML("<TD align='left'></TD>")
        '    General.WriteHTML("</TR>")
        'End If
        '################################################################################

        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'apply the alphabetical filters
        If m_strFilter <> "" Then
            m_strSQL += "'" + General.BuildQueryString(General.BuildQueryString(m_strFilter.Trim)) + "'"
        Else
            m_strSQL += "'" + General.BuildQueryString(General.BuildQueryString(m_strAlphabet.Trim)) + "'"
        End If
        'm_strSQL += "NULL"

        '##### Added By AmitD for Scurity Filter BusinessGroup and Location(OU)
        '##### Based on High,Middle,low Role Level
        'If m_strFromWhere <> "KM" Then
        '    If CType(Session("intUserID"), String) <> "" Then
        '        m_strSQL += "," + CType(Session("intUserID"), String)
        '    End If
        'End If
        '##### End Additon


        arrlstColHeader = New Collections.ArrayList
        arrlstAN = New Collections.ArrayList
        arrlstRowLink = New Collections.ArrayList

        arrlstColHeader.Add(MyBase.GetResourceString("COL_USER_NAME"))
        arrlstAN.Add("Employee Name")
        If m_strFromWhere <> "KM" Then
            'modified by harshk for resource date validation sp4 issueid 120,121 
            arrlstRowLink.Add("EmployeeName_OnClick(EmployeeID,Employee Name,TotalResourcePercentage,JoiningDate)")
            'End modified by harshk for resource date validation sp4 issueid 120,121 
        Else
            arrlstAN.Add("Employee Name")
            arrlstRowLink.Add("EmployeeName_OnClick(EmployeeID,Employee Name,EmployeeID)")
        End If

        'Added by MrugajaB on 7th March 2006 for Issue ID.1835
        'Purpose:-For displaying Employee Name on pop up page that opens from 'Ad New Resource' page
        If m_strFromWhere <> "KM" Then
            arrlstAN.Add("ResourceName") : arrlstColHeader.Add(MyBase.GetResourceString("Employee Name")) : arrlstRowLink.Add("")
        End If

        ' Modified By NitinVS on 20 July 2005 for WhizibleSEM SP4
        arrlstColHeader.Add(MyBase.GetResourceString("COL_DEPARTMENT")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_LOCATION")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_ROLE"))
        arrlstAN.Add("Department") : arrlstAN.Add("Location") : arrlstAN.Add("Designation")
        arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("")

        intColToShow = 4
        'If m_strFromWhere <> "KM" Then
        '    arrlstColHeader.Add(MyBase.GetResourceString("COL_RESOURCE"))
        '    arrlstAN.Add("TotalResourcePercentage")
        '    arrlstRowLink.Add("Percentage_OnClick(EmployeeID)")
        '    intColToShow = 5
        'End If

        ' Designation Column is to be shown
        If m_strFromWhere <> "KM" Then

            arrlstColHeader.Add(MyBase.GetResourceString("COL_DESIGNATION"))
            arrlstAN.Add("DesignationName")
            arrlstRowLink.Add("")

            arrlstColHeader.Add(MyBase.GetResourceString("COL_RESOURCE"))
            arrlstAN.Add("TotalResourcePercentage")
            arrlstRowLink.Add("Percentage_OnClick(EmployeeID)")
            'intColToShow = 5

            'Added by MrugajaB on 7th March 2006 for Issue ID.1835
            'Purpose:-For displaying Employee Name on pop up page that opens from 'Ad New Resource' page
            'intColToShow = 6
            intColToShow = 7
            'End Additino
        End If

        ' End Modification By NitinVS on 20 July 2005 for WhizibleSEM SP4

        'plot the grid for employee list.
        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String

        arrlstColHeader.CopyTo(arrColHeader)
        arrlstAN.CopyTo(arrAN)
        arrlstRowLink.CopyTo(arrRowLink)

        arrlstColHeader = Nothing
        arrlstAN = Nothing
        arrlstRowLink = Nothing

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        objGrid.PrimaryKey = "EmployeeID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 300
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = intColToShow
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = m_strSQL
        objGrid.UseSQL = MyBase.UseSQL

        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing

        'plot the hidden controls with values
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtFromWhere", "txtFromWhere", , , , m_strFromWhere.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtControlID", "txtControlID", , , , m_strControlID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        General.WriteHTML(HTMLControls.DrawTextBox("txtintProjectID", "txtintProjectID", , , , m_strProjectID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        'General.WriteHTML(HTMLControls.DrawTextBox("txtSearchType", "txtSearchType", , , , m_strSearchType.Trim, , , , , , True, , True))
        'General.WriteHTML(HTMLControls.DrawTextBox("txtMasterTagID", "txtMasterTagID", , , , m_strMasterTagID.Trim, , , , , , True, , True))
    End Sub
End Class
