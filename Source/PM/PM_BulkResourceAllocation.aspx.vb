Public Class PM_BulkResourceAllocation
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

    'Variable Declaration
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
    ' To Display the Desgnation Filter 
    Private m_strDesignationName As String = ""
    Private m_strReportingTo As String

    Protected intRowCount As Long = 0
    Protected ProjectStartDate As String
    Protected ProjectEndDate As String
    Protected m_Count As Integer



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


        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''ProjectStartDate = CType(CommonFunctions.Data.GetDataScalar("SELECT Replace(Convert(CHAR(20),ExpectedStartDate,106),' ','-') FROM tbl_PM_Project WHERE ProjectID=" & Session("intProjectID").ToString, True), String)
        ProjectStartDate = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectIDWiseExpectedStartDate " & Session("intProjectID").ToString, True), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''ProjectEndDate = CType(CommonFunctions.Data.GetDataScalar("SELECT Replace(Convert(CHAR(20),ExpectedEndDate,106),' ','-') FROM tbl_PM_Project WHERE ProjectID=" & Session("intProjectID").ToString, True), String)
        ProjectEndDate = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectIDWiseExpectedEndDate " & Session("intProjectID").ToString, True), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

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
            'm_strSQL = "usp_Sel_tbl_PM_Employee_Temp "
            m_strSQL = "usp_Sel_tbl_PM_Employee_TempForBulkResourceAllocation "
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
        If m_strDesignationName <> "" Then
            m_strSQL += m_strDesignationName.Trim + ","
            strPagingSQL += m_strDesignationName.Trim + ","
        Else
            m_strSQL += "Null,"
            strPagingSQL += "Null,"
        End If

        'Added by SonalD
        If Not Request.Form("cboReportingTo") Is Nothing OrElse Request.Form("cboReportingTo") <> "" Then
            m_strReportingTo = Request.Form("cboReportingTo")
        Else
            m_strReportingTo = ""
        End If

        'End
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

        arrMenu.Add("Assign To Project") : arrMenuToolTip.Add("Assign To Project") : arrClientSideFunctions.Add("Assign_To_Project_OnClick()")
        arrMenu.Add("Select All") : arrMenuToolTip.Add("Select All") : arrClientSideFunctions.Add("SelectAll_OnClick()")
        arrMenu.Add("Clear All") : arrMenuToolTip.Add("Select All") : arrClientSideFunctions.Add("ClearAll_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('EmployeeSelect')")

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

        'If Request.QueryString("MODE") = "ASSIGN" Then
        '    Call Save_EmployeeData()
        'End If

        'display the paging links on the menu bar
        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strPagingSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "EmployeeName", True)
        objPaging = Nothing

        'strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        'draw upper menu
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'create lower menu without paging
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

        'initialize the resource file for HR_EmployeeSelection page.
        MyBase.InitializeResources("AppResources.HR_EmployeeSelection", "AppResources")

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, "Bulk Resource Allocation")
        CommonFunctions.General.WriteHTML("<BR>")

        ''draw page description
        'objHeader = New WebPage.Templates.HeaderFooter
        'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC") + ""
        'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
        'General.WriteHTML("<BR>")
        'objHeader = Nothing

        'plot the screen with data
        Call plotEmployeeList()

        'write client side script to declare the variabel for controlID on the parent page.
        CommonFunctions.General.WriteHTML("<Script language=javascript>")
        CommonFunctions.General.WriteHTML("var strControlID = '" + m_strControlID.Trim + "';")
        CommonFunctions.General.WriteHTML("</Script>")

        'plot the lower menu
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
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
        CommonFunctions.General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align='left' width=100% nowrap colspan=4 >" + MyBase.GetResourceString("CAP_SHOW_NAME") + "&nbsp;")
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtFilter", "txtFilter", , 50, , m_strFilter.Trim, , , , , , , , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'display links
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        objLink.LinkName = MyBase.GetResourceString("LINK_SHOW") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
        objLink.FunctionName = "Show_OnClick()"
        CommonFunctions.General.WriteHTML("| <B>" + objLink.GetDynamicLink() + "</B> |")
        objLink.LinkName = MyBase.GetResourceString("LINK_CLEAR") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_CLEAR_TOOLTIP") + ""
        objLink.FunctionName = "Clear_OnClick()"
        CommonFunctions.General.WriteHTML(" <B>" + objLink.GetDynamicLink() + "</B> |")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        ' Modified By NitinVS on 20 July for WhizibleSEM SP 4 
        ' To Display Designation Filter 

        'diplay dpartment combo
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        strSQL = "usp_Sel_PM_DepartmentList"
        CommonFunctions.General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_DEPARTMENT") + "&nbsp;" + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align='left' nowrap >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", strSQL, 150, m_strDepartment.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        'display location combo
        strSQL = "usp_Sel_PM_LocationList"
        CommonFunctions.General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_LOCATION") + "&nbsp;" + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align='left' nowrap >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboLocation", strSQL, 150, m_strLocation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")


        'display Role combo
        strSQL = "usp_Sel_tbl_PM_Role"
        CommonFunctions.General.WriteHTML("<TD align='right' nowrap >" + "Employee Role" + "&nbsp;" + "</TD>")
        CommonFunctions.General.WriteHTML("<TD align='left' nowrap >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", strSQL, 150, m_strDesignation.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")

        ' Display Designation Combo 
        If m_strFromWhere <> "KM" Then

            strSQL = "usp_Sel_tbl_PM_DesignationMaster"
            CommonFunctions.General.WriteHTML("<TD align='right' nowrap >" + MyBase.GetResourceString("CAP_DESIGNATION") + "&nbsp;" + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align='left' nowrap >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboDesignationID", strSQL, 150, m_strDesignationName.Trim, " onchange='javascript:Filter_OnChange()'", True, True) + "</TD>")
        Else
            CommonFunctions.General.WriteHTML("<TD>&nbsp;</TD>")
        End If

        CommonFunctions.General.WriteHTML("</TR>")

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

        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("<BR>")

        'apply the alphabetical filters
        If m_strFilter <> "" Then
            m_strSQL += "'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(m_strFilter.Trim)) + "'"
        Else
            m_strSQL += "'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(m_strAlphabet.Trim)) + "'"
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
            arrlstRowLink.Add("EmployeeName_OnClick(EmployeeID,Employee Name,TotalResourcePercentage)")
        Else
            arrlstRowLink.Add("EmployeeName_OnClick(EmployeeID,Employee Name,EmployeeID)")
        End If

        arrlstColHeader.Add(MyBase.GetResourceString("COL_DEPARTMENT")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_LOCATION")) : arrlstColHeader.Add(MyBase.GetResourceString("COL_ROLE"))
        arrlstAN.Add("Department") : arrlstAN.Add("Location") : arrlstAN.Add("Designation")
        arrlstRowLink.Add("") : arrlstRowLink.Add("") : arrlstRowLink.Add("")

        intColToShow = 4
        ' Modified By NitinVS on 20 July 2005 for WhizibleSEM SP4 
        ' Designation Column is to be shown
        If m_strFromWhere <> "KM" Then

            arrlstColHeader.Add(MyBase.GetResourceString("COL_DESIGNATION"))
            arrlstAN.Add("DesignationName")
            arrlstRowLink.Add("")

            arrlstColHeader.Add(MyBase.GetResourceString("COL_RESOURCE"))
            arrlstAN.Add("TotalResourcePercentage")
            arrlstRowLink.Add("Percentage_OnClick(EmployeeID)")
            'intColToShow = 5
            intColToShow = 6
        End If

        ' End Modification By NitinVS on 20 July 2005 for WhizibleSEM SP4

        'plot the grid for employee list.
        Dim arrColHeader(arrlstColHeader.Count) As String
        Dim arrAN(arrlstAN.Count) As String
        Dim arrRowLink(arrlstRowLink.Count) As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

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
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        'objGrid.DrawGrid()
        objGrid = Nothing
        If Request.QueryString("MODE") = "ASSIGN" Then
            Call Save_EmployeeData()
        End If
        Call drawEmployeeGrid(m_strSQL)

        If Request.QueryString("MODE") = "ASSIGN" Then
            CommonFunctions.General.WriteHTML("<Script language=javascript>")
            CommonFunctions.General.WriteHTML("window.opener.location.href=window.opener.location.href;")
            CommonFunctions.General.WriteHTML("window.close();")
            CommonFunctions.General.WriteHTML("refreshParent(""frmCommonList"",""CommonList.aspx"",""../General/CommonList.aspx?MasterTagId=1019"");")
            CommonFunctions.General.WriteHTML("</Script>")
        End If

        'plot the hidden controls with values
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtFromWhere", "txtFromWhere", , , , m_strFromWhere.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtControlID", "txtControlID", , , , m_strControlID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txtintProjectID", "txtintProjectID", , , , m_strProjectID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'General.WriteHTML(HTMLControls.DrawTextBox("txtSearchType", "txtSearchType", , , , m_strSearchType.Trim, , , , , , True, , True))
        'General.WriteHTML(HTMLControls.DrawTextBox("txtMasterTagID", "txtMasterTagID", , , , m_strMasterTagID.Trim, , , , , , True, , True))
    End Sub
    Private Sub drawEmployeeGrid(ByVal strSQL As String)


        Dim strTrClass As String
        Dim strEmployeeID As String
        Dim strEmployeeName As String
        Dim strUserName As String
        Dim strDepartment As String
        Dim strLocation As String
        Dim strDesignationName As String
        Dim drEmployee As IDataReader
        Dim strEndDate As String

        strEndDate = CType(CommonFunctions.Data.GetDataScalar("SELECT Replace(Convert(CHAR(20),ExpectedEndDate,106),' ','-') FROM tbl_PM_Project Where ProjectID=" & Session("intProjectID").ToString, True), String)

        drEmployee = CommonFunctions.Data.GetDataReader(strSQL, True)

        CommonFunction.General.WriteHTML("<DIV ID='DIVLIST' STYLE='OVERFLOW:auto;WIDTH:100%;HEIGHT=385px'>")

        CommonFunction.General.WriteHTML("<TABLE name=EmployeeListTable id=EmployeeListTable CellSpacing=0 Class=clsTable Width='99.9%' >")


        ' Plot the Header Row 

        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>")

        'Added by SonalD on 5th Sept 2008
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Employee Name")

        CommonFunction.General.WriteHTML("</TD>")
        'End of addition By SonalD on 5th Sept 2008

        ' User Name 
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("User Name")

        CommonFunction.General.WriteHTML("</TD>")

        ' Departement 
        'CommonFunction.General.WriteHTML("<TD align ='Left'>")

        'CommonFunction.General.WriteHTML("Departement")

        'CommonFunction.General.WriteHTML("</TD>")


        'Organization Unit
        'CommonFunction.General.WriteHTML("<TD align ='Left'>")

        'CommonFunction.General.WriteHTML("Organization Unit")

        'CommonFunction.General.WriteHTML("</TD>")




        ' Designation
        'designation name commented by sonald 

        'CommonFunction.General.WriteHTML("<TD align ='Left'>")

        'CommonFunction.General.WriteHTML("Designation")

        'CommonFunction.General.WriteHTML("</TD>")

        ' Start Date
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Start Date")

        CommonFunction.General.WriteHTML("</TD>")

        'End Date
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("End Date")

        CommonFunction.General.WriteHTML("</TD>")



        'Work(Hrs)
        CommonFunction.General.WriteHTML("<TD align ='Right'>")

        CommonFunction.General.WriteHTML("Work(Hrs)")

        CommonFunction.General.WriteHTML("</TD>")

        'Role
        CommonFunction.General.WriteHTML("<TD align ='Center'>")

        CommonFunction.General.WriteHTML("Role")

        CommonFunction.General.WriteHTML("</TD>")

        'Reporting To
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Reporting To")

        CommonFunction.General.WriteHTML("</TD>")

        'Added by SonalD on 5th sept 2008
        'Status
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Status")

        CommonFunction.General.WriteHTML("</TD>")

        'End of addition by sonalD on 5th Sept 2008

        'Select
        CommonFunction.General.WriteHTML("<TD align ='Left'>")

        CommonFunction.General.WriteHTML("Select")

        CommonFunction.General.WriteHTML("</TD>")

        CommonFunction.General.WriteHTML("</TR>")

        'intRowCount = 1

        While drEmployee.Read

            If intRowCount Mod 2 = 0 Then
                strTrClass = "clsTROdd"
            Else
                strTrClass = "clsTREven"
            End If



            strEmployeeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drEmployee("EmployeeID"), ""), "")
            strEmployeeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drEmployee("Employee Name"), ""), "")
            'Added by sonalD on 5th Sept 2008
            strUserName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drEmployee("User Name"), ""), "")
            'End of addition by SonalD on 5th sept 2008
            strDepartment = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drEmployee("Department"), ""), "")
            strLocation = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drEmployee("Location"), ""), "")
            strDesignationName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drEmployee("DesignationName"), ""), "")

            'Added By SonalD on 5th Sept 2008
            'grouping combo cboReportingTo
            Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
            GroupingColName.DropdownGroupingColumn = "IsExternal"
            GroupingColName.WidthInPixel = 150
            GroupingColName.IsMandatory = True
            GroupingColName.InsertBlankRow = True
            GroupingColName.ReturnHTML = False
            GroupingColName.MatchFieldID = CommonFunction.General.CheckIsNothing(m_strReportingTo, "0")
            'End of addition by sonalD on 5th Sept 2008

            CommonFunction.General.WriteHTML("<TR class='" + strTrClass + "'>")

            ' Employee Name
            CommonFunction.General.WriteHTML("<TD align ='Left'>")
            'commented by SonalD
            ' CommonFunction.HTMLControls.DrawTextBox("txtEmployeeName" + intRowCount.ToString, "txtEmployeeName" + intRowCount.ToString,  , 100, 205, strEmployeeName)
            'added by SonalD
            CommonFunction.General.WriteHTML(strEmployeeName)
            'End of addition by Sonald
            CommonFunction.General.WriteHTML("</TD>")

            'added by sonalD on 5th sept 2008
            CommonFunction.General.WriteHTML("<TD align ='Left'>")
            CommonFunction.General.WriteHTML(strUserName)
            CommonFunction.General.WriteHTML("</TD>")
            'end of addition by SonalD on 5th sept 2008

            ' Department
            'CommonFunction.General.WriteHTML("<TD align ='Left'>")

            'CommonFunction.HTMLControls.DrawTextBox("txtDepartmentName", "txtDepartmentName", , 100, 205, strDepartment)

            'CommonFunction.General.WriteHTML("</TD>")

            ' Orgnization Unit
            'CommonFunction.General.WriteHTML("<TD align ='Left'>")

            'CommonFunction.HTMLControls.DrawTextBox("txtLocation", "txtLocation", , 100, 205, strLocation)

            'CommonFunction.General.WriteHTML("</TD>")

            ' Designation Name
            'designation name commented by sonald 
            'CommonFunction.General.WriteHTML("<TD align ='Left'>")

            'CommonFunction.HTMLControls.DrawTextBox("txtDesignationName" + intRowCount.ToString, "txtDesignationName" + intRowCount.ToString, , 100, 205, strDesignationName)

            'CommonFunction.General.WriteHTML("</TD>")

            ' Start Date
            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            CommonFunction.HTMLControls.DrawDateControl("txtStartDate" + intRowCount.ToString, "txtStartDate" + intRowCount.ToString, , , CommonFunction.Dates.GetDate(Now()), "callcalendar", "frmPM_BulkResourceAllocation", "..\..\images\Calendar.gif", "Click here for calendar...", , , , , , True, "../../images/Star.gif")

            CommonFunction.General.WriteHTML("</TD>")

            ' End Date
            CommonFunction.General.WriteHTML("<TD align ='Left' >")

            'CommonFunction.HTMLControls.DrawDateControl("txtEndDate", "txtEndDate", , , , "callcalendar", "frmPM_BulkResourceAllocation", "..\..\images\Calendar.gif", "Click here for calendar...", , , , , , True, "../../images/Star.gif")
            CommonFunction.HTMLControls.DrawDateControl("txtEndDate" + intRowCount.ToString, "txtEndDate" + intRowCount.ToString, , , strEndDate, , "frmPM_BulkResourceAllocation", IsMandatory:=True)

            CommonFunction.General.WriteHTML("</TD>")

            ' Work hrs 
            CommonFunction.General.WriteHTML("<TD align ='Right' >")

            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtWorkhrs" + intRowCount.ToString, "txtWorkhrs" + intRowCount.ToString, , 70, 8, , "Right", EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            CommonFunction.General.WriteHTML("</TD>")


            ' Employee Role 
            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            CommonFunction.HTMLControls.DrawComboBox("cboEmployeeRole" + intRowCount.ToString, "EXEC usp_Sel_tbl_PM_Role_PopulateCombo ", 100, , , True, , , True)

            CommonFunction.General.WriteHTML("</TD>")

            ' Reporting To
            CommonFunction.General.WriteHTML("<TD align ='Left'>")
            'sp changed by sonald on 5th sept 2008
            'CommonFunction.HTMLControls.DrawComboBox("cboReportingTo" + intRowCount.ToString, "Exec usp_sel_tbl_PM_RowWiseApprovers " & Session("intProjectID").ToString(), 100, , , True, , , True)
            'CommonFunction.HTMLControls.DrawComboBox("cboReportingTo" + intRowCount.ToString, "Exec usp_sel_tbl_PM_RowWiseExternalApprovers " & Session("intProjectID").ToString(), 100, , , True, , , True)
            CommonFunction.HTMLControls.DrawComboBox("cboReportingTo" + intRowCount.ToString, "usp_sel_tbl_PM_RowWiseExternalApprovers " + Session("intProjectID").ToString(), GroupingColName)

            CommonFunction.General.WriteHTML("</TD>")

            'added by sonalD on 5th sept 2008
            'Status
            CommonFunction.General.WriteHTML("<TD align ='Left'>")

            CommonFunction.HTMLControls.DrawComboBox("cboStatus" + intRowCount.ToString, "Exec usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable ", 100, , , True, , , True)

            CommonFunction.General.WriteHTML("</TD>")
            'end of addition by sonalD on 5th sept 2008


            ' Select 
            CommonFunction.General.WriteHTML("<TD align ='Center'>")

            CommonFunction.HTMLControls.DrawCheckBox("chkSelect" + intRowCount.ToString, "chkSelect" + intRowCount.ToString, , , intRowCount.ToString)

            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("</TR>")


            'Plot Hidden Control
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.HTMLControls.DrawTextBox("txtEmployeeID" + intRowCount.ToString, "txtEmployeeID" + intRowCount.ToString, , , , strEmployeeID, DisplayNone:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            intRowCount += 1
        End While
        m_Count = intRowCount

        If intRowCount = 0 Then
            CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunction.General.WriteHTML("<TD align=middle valign=top colspan='8'>")
            CommonFunction.General.WriteHTML("There is no items in this view.")
            CommonFunction.General.WriteHTML("</TD></TR>")
        End If

        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")
        CommonFunction.Data.DisposeDataReader(drEmployee)
    End Sub
    Private Sub Save_EmployeeData()
        ' Get the Record numbers selected by the user 
        Dim strSelectedEmployee As String
        Dim intRowCount As Integer
        Dim intCnt As Integer
        Dim strEmployeeID As String
        Dim strStartDate As String
        Dim strEndDate As String
        Dim strWorkhrs As String
        Dim strEmployeeRole As String
        Dim strReportingTo As String
        Dim strSQLEmpList As String
        'Added by sonalD on 5th sept 2008
        Dim strStatus As String
        'End of addition by sonald
        'Dim drEmployeeList As IDataReader

        strSelectedEmployee = HttpContext.Current.Request.QueryString("SelectedEmployee")
        intRowCount = CType(HttpContext.Current.Request.QueryString("RowCount"), Integer)

        For intCnt = 0 To intRowCount - 1

            strEmployeeID = CommonFunctions.General.CheckIsNothing(Request.Form("txtEmployeeID" + intCnt.ToString))
            strStartDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtStartDate" + intCnt.ToString))
            strEndDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtEndDate" + intCnt.ToString))
            strWorkhrs = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtWorkhrs" + intCnt.ToString))
            strEmployeeRole = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboEmployeeRole" + intCnt.ToString))
            strReportingTo = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboReportingTo" + intCnt.ToString))
            'Added by sonalD on 5th sept 2008
            strStatus = CommonFunctions.General.CheckIsNothing(Request.Form("cboStatus" + intCnt.ToString))
            'End of addition by sonald

            'Modified by SavitaS on 09 Jan 2006 to solve the page crash problem.
            If ("," + strSelectedEmployee + ",").IndexOf("," + intCnt.ToString + ",") >= 0 Then
                'End Modification by SavitaS
                strSQLEmpList = "usp_Ins_EmployeeOnProject "
                strSQLEmpList &= Session("intProjectID").ToString & ","
                strSQLEmpList &= strEmployeeID & ","
                strSQLEmpList &= strEmployeeRole & ","
                If strWorkhrs <> "" Then
                    strSQLEmpList &= strWorkhrs & ","
                Else
                    strSQLEmpList &= "NULL,"
                End If
                strSQLEmpList &= "'" & strStartDate & "',"
                strSQLEmpList &= "'" & strEndDate & "',"
                strSQLEmpList &= strReportingTo & ","
                'Added by sonald
                strSQLEmpList &= "'" & strStatus & "'"
                'End of addition by sonalD
                CommonFunctions.Data.InsertOrUpdateData(strSQLEmpList, True)
            End If
            strSQLEmpList = ""
        Next
    End Sub
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

End Class
