Option Strict Off
Public Class HR_ShowFreeResources
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Private m_sbHTML As System.Text.StringBuilder
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_strAllocationPercent As String
    Private m_strFromDate As String
    Private m_strRoleID As String
    Private m_strPrimarySkillID As String
    Private m_strOtherSkillID1 As String
    Private m_strOtherSkillID2 As String
    Private m_strSortBy As String
    Private m_strSortOrder As String
    Private m_strPagingChar As String
    Private m_strAllocationPercent_ForControl As String
    Private m_strFromDate_ForControl As String
    Private m_strRoleID_ForControl As String
    Private m_strPrimarySkillID_ForControl As String
    Private m_strOtherSkillID1_ForControl As String
    Private m_strOtherSkillID2_ForControl As String
    Protected m_strpaging As String
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Private m_strOldEmpName As String
    Private m_strNewEmpName As String


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        Call InitializeVariables()

        Call GenerateMenu(True)
        m_sbHTML.Append("<BR>" + vbCrLf)
        Call GenerateFilterMenu()
        m_sbHTML.Append("<BR>" + vbCrLf)
        Call DrawNumericPaging()

        m_sbHTML.Append("<BR>" + vbCrLf)
        Call DrawPage()
        m_sbHTML.Append("<BR>" + vbCrLf)
        Call GenerateMenu(False)

        Response.Write(m_sbHTML.ToString())
    End Sub
    Private Sub InitializeVariables()
        '=====================================================================
        ' Page Name             : InitializeVariables
        ' Purpose               : To Initializa variables comes from query string 
        ' Description           : To Initializa variables comes from query string 
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js 
        ' Author                : ShraddhaM
        ' Created               : 20,Feb 2008
        ' Revisions             : 
        '=====================================================================
        m_sbHTML = New System.Text.StringBuilder
        m_strpaging = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Paging"), "-1").ToUpper

        m_strAllocationPercent = Request.Form("txtAllocationPercent")
        If m_strAllocationPercent Is Nothing OrElse m_strAllocationPercent = "" Then
            m_strAllocationPercent = "NULL"
            m_strAllocationPercent_ForControl = ""
        Else
            m_strAllocationPercent_ForControl = m_strAllocationPercent
        End If


        m_strFromDate = Request.Form("dtFromDate")


        If m_strFromDate Is Nothing OrElse m_strFromDate = "" Then
            m_strFromDate = "NULL"
            m_strFromDate_ForControl = ""
        Else
            m_strFromDate = m_strFromDate.Replace("'", "")
            m_strFromDate = "'" + m_strFromDate + "'"

            m_strFromDate_ForControl = m_strFromDate
        End If


        m_strRoleID = Request.Form("cboRole")
        If m_strRoleID Is Nothing OrElse m_strRoleID = "" Then
            m_strRoleID = "NULL"
            m_strRoleID_ForControl = ""
        Else
            m_strRoleID_ForControl = m_strRoleID
        End If

        m_strPrimarySkillID = Request.Form("cboPrimarySkill")
        If m_strPrimarySkillID Is Nothing OrElse m_strPrimarySkillID = "" Then
            m_strPrimarySkillID = "NULL"
            m_strPrimarySkillID_ForControl = ""
        Else
            m_strPrimarySkillID_ForControl = m_strPrimarySkillID
        End If

        m_strOtherSkillID1 = Request.Form("cboOtherSkill1")
        If m_strOtherSkillID1 Is Nothing OrElse m_strOtherSkillID1 = "" Then
            m_strOtherSkillID1 = "NULL"
            m_strOtherSkillID1_ForControl = ""
        Else
            m_strOtherSkillID1_ForControl = m_strOtherSkillID1
        End If

        m_strOtherSkillID2 = Request.Form("cboOtherSkill2")
        If m_strOtherSkillID2 Is Nothing OrElse m_strOtherSkillID2 = "" Then
            m_strOtherSkillID2 = "NULL"
            m_strOtherSkillID2_ForControl = ""
        Else
            m_strOtherSkillID2_ForControl = m_strOtherSkillID2
        End If

        m_strSortBy = Request.QueryString("SortBy")
        If m_strSortBy Is Nothing OrElse m_strSortBy = "" Then
            m_strSortBy = Request.Form("txthidSortBy")
        End If

        m_strSortOrder = Request.QueryString("SortOrder")
        If m_strSortOrder Is Nothing OrElse m_strSortOrder = "" Then
            m_strSortOrder = Request.Form("txthidSortOrder")
        End If

        m_strPagingChar = Request.QueryString("Paging")
        If m_strPagingChar Is Nothing OrElse m_strPagingChar = "" Then
            m_strPagingChar = Request.Form("txthidPagingChar")
        End If

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidPagingChar", "txthidPagingChar", , , , m_strPagingChar, , , , , , True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
    End Sub
    Private Sub DrawPage1()
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strEmployeeName As String
        Dim strProjectName As String
        Dim strProjectRole As String
        Dim strPlannedStartDate As String
        Dim strPlannedEndDate As String
        Dim strResourceStatus As String
        Dim strReportingTo As String
        Dim strClass As String = "clsTREven"

        strQuery = "usp_sel_FreeResources " + m_strAllocationPercent + "," + m_strFromDate + "," + m_strRoleID + "," + m_strPrimarySkillID + "," + m_strOtherSkillID1 + "," + m_strOtherSkillID2
        strQuery = strQuery + ",'" + m_strSortBy + "','" + m_strSortOrder + "','-1'" + ",'" + m_intPageNumber + "'"


        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        m_sbHTML.Append("<BR>")

        m_sbHTML.Append("<DIV Id=DivMain Style='HEIGHT:400px;OVERFLOW:auto; WIDTH:100%'>" + vbCrLf)
        '<A Href="JavaScript:SortBy('EmployeeName','ASC')"><IMG Border=0  SRC='../../Images/Sort_up.gif'></A>
        m_sbHTML.Append("<TABLE id='tblHeader' cellspacing=1 cellpadding=0 Width='99.9%' class=clsGridTable >" + vbCrLf)
        m_sbHTML.Append("<THead class='clsTRColumnHeader' >" + vbCrLf)
        m_sbHTML.Append("<TH align=left id='thEmpName'><A Href=JavaScript:SortBy('EmployeeName','ASC')><IMG Border=0 id='imgEmployeeName' SRC='../../Images/Sort_up.gif'></A>&nbsp;&nbsp;Resource Name </TH>" + vbCrLf)
        m_sbHTML.Append("<TH align=left id='thProjectName'><A Href=JavaScript:SortBy('ProjectName','')><IMG Border=0 id='imgProjectName' SRC='../../Images/SortBy.gif'></A>&nbsp;&nbsp;Project Name </TH>" + vbCrLf)
        m_sbHTML.Append("<TH align=left id='thProjectRole'><A Href=JavaScript:SortBy('ProjectRole','')><IMG Border=0 id='imgProjectRole' SRC='../../Images/SortBy.gif'></A>&nbsp;&nbsp;Project Role </TH>" + vbCrLf)
        m_sbHTML.Append("<TH align=left id='thStartDate'><A Href=JavaScript:SortBy('ExpectedStartDate','')><IMG Border=0 id='imgExpectedStartDate' SRC='../../Images/SortBy.gif'></A>&nbsp;&nbsp;Planned Start Date </TH>" + vbCrLf)
        m_sbHTML.Append("<TH align=left id='thEndDate'><A Href=JavaScript:SortBy('ExpectedEndDate','')><IMG Border=0 id='imgExpectedEndDate' SRC='../../Images/SortBy.gif'></A>&nbsp;&nbsp;Planned End Date </TH>" + vbCrLf)
        m_sbHTML.Append("<TH align=left id='thResStatus'><A Href=JavaScript:SortBy('ResourceStatus','')><IMG Border=0 id='imgResourceStatus' SRC='../../Images/SortBy.gif'></A>&nbsp;&nbsp;Resource Status </TH>" + vbCrLf)
        m_sbHTML.Append("<TH align=left id='thReportingTo'><A Href=JavaScript:SortBy('ReportingTo','')><IMG Border=0 id='imgReportingTo' SRC='../../Images/SortBy.gif'></A>&nbsp;&nbsp;Reporting To </TH>" + vbCrLf)
        m_sbHTML.Append("</THead>" + vbCrLf)

        While dr.Read()

            strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeName"), ""), String)
            strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectName"), "-"), String)
            strProjectRole = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectRole"), "-"), String)

            If IsDBNull(dr("ExpectedStartDate")) Then
                strPlannedStartDate = CType(CommonFunctions.Data.CheckIsDBNull(dr("ExpectedStartDate"), "-"), String)
            Else
                strPlannedStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(dr("ExpectedStartDate"), ""), String)))
            End If

            If IsDBNull(dr("ExpectedEndDate")) Then
                strPlannedEndDate = CType(CommonFunctions.Data.CheckIsDBNull(dr("ExpectedEndDate"), "-"), String)
            Else
                strPlannedEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(CType(CommonFunctions.Data.CheckIsDBNull(dr("ExpectedEndDate"), "-"), String)))
            End If

            strResourceStatus = CType(CommonFunctions.Data.CheckIsDBNull(dr("ResourceStatus"), "-"), String)
            strReportingTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("ReportingToName"), ""), String)


            'CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(objDr("UpdatedDate"), "").ToString))

            m_sbHTML.Append("<TR class=" + strClass + ">" + vbCrLf)
            m_sbHTML.Append("<TD>" + strEmployeeName + "</TD>" + vbCrLf)
            m_sbHTML.Append("<TD>" + strProjectName + "</TD>" + vbCrLf)
            m_sbHTML.Append("<TD>" + strProjectRole + "</TD>" + vbCrLf)
            m_sbHTML.Append("<TD>" + strPlannedStartDate + "</TD>" + vbCrLf)
            m_sbHTML.Append("<TD>" + strPlannedEndDate + "</TD>" + vbCrLf)
            m_sbHTML.Append("<TD>" + strResourceStatus + "</TD>" + vbCrLf)
            m_sbHTML.Append("<TD>" + strReportingTo + "</TD>" + vbCrLf)
            m_sbHTML.Append("</TR>" + vbCrLf)

            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If


        End While

        CommonFunction.Data.DisposeDataReader(dr)
        m_sbHTML.Append("</TABLE>" + vbCrLf)
        m_sbHTML.Append("</DIV>" + vbCrLf)

        m_sbHTML.Append("<BR>")
    End Sub


    Private Sub GenerateMenu(ByVal isUp As Boolean)
        '====================================================================
        ' Procedure Name        :  GenerateMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To getnerate Menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  ShraddhaM
        ' Created               :  21,Feb 2008
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList = New System.Collections.ArrayList
        Dim strImage As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String
        Dim strSQL As String
        Dim strmenu As String

        'display the paging links on the menu bar
        strSQL = "usp_sel_FreeResources_Paging " + m_strAllocationPercent + "," + m_strFromDate + "," + m_strRoleID + "," + m_strPrimarySkillID + "," + m_strOtherSkillID1 + "," + m_strOtherSkillID2 _
                             + ",'" + CommonFunctions.General.BuildQueryString(m_strSortBy) + "','" + m_strSortOrder + "','-1'"

        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(m_strPagingChar, strSQL, "Select", "Page_OnClick", "EmployeeName", True)
        'm_sbHTML.Append(strPagingHTML)


        'If isUp Then
        '    strImage = "<img id='imgFilterUp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'>&nbsp;Filters"
        'Else
        '    strImage = "<img id='imgFilterDown' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'>&nbsp;Filters"
        'End If

        'arrMenu.Add(strImage)
        'arrMenuToolTip.Add("Filers")
        'arrClientSideFunctions.Add("Filters_OnClick('1')")

        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/close.gif'>&nbsp;Close")
        arrMenuToolTip.Add("Close")
        arrClientSideFunctions.Add("Close_Click()")

        arrMenu.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;Help")
        arrMenuToolTip.Add("Help")
        arrClientSideFunctions.Add("Help_OnClick()")

        m_objMenu = New WebPages.Template.StaticMenu
        If isUp = True Then
            strmenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True, strPagingHTML)
        Else
            strmenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenu), GetArray(arrClientSideFunctions), GetArray(arrMenuToolTip), True)
        End If

        m_sbHTML.Append(strmenu)

        m_objMenu = Nothing
        objPaging = Nothing

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()

        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Private Sub GenerateFilterMenu()

        'Filter Table 

        m_sbHTML.Append("<TABLE id='tblFilter' style='width:99.99%;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")

        m_sbHTML.Append("<TR width=99.9%  class=clsTRPageCaption align='Right' >")
        m_sbHTML.Append("<td style='width:25%;text-align:left' align=left>Show Free Resources From")
        m_sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("dtFromDate", "dtFromDate", , , m_strFromDate_ForControl, , "frmFreeResources", , , , , , , True, True))
        m_sbHTML.Append("&nbsp;&nbsp;With Available %")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        m_sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtAllocationPercent", "txtAllocationPercent", , 60, 6, m_strAllocationPercent_ForControl, "right", , , , , , , True, True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        m_sbHTML.Append("</TD></TR>")

        m_sbHTML.Append("<TR width=99.9%  class=clsTRPageCaption align='left' >")
        m_sbHTML.Append("<td style='width:25%;text-align:left' align=left>With Role")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''m_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription From tbl_PM_Role Where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, m_strRoleID_ForControl, , True, True, , True, ))
        m_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_Department_tbl_pm_Departmentmaster", 200, m_strRoleID_ForControl, , True, True, , True, ))
        'm_sbHTML.Append("<td style='width:25%;text-align:right' align=right>Having Primary Skill")
        m_sbHTML.Append("&nbsp;&nbsp;Having Primary Skill")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' m_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPrimarySkill", "select ToolID,[Description] from tbl_PM_Tools  WHERE ISSkill = 1 ORDER BY [Description]", 200, m_strPrimarySkillID_ForControl, , True, True))
        m_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPrimarySkill", "usp_sel_tbl_PM_Tools_ToolID_Description", 200, m_strPrimarySkillID_ForControl, , True, True))
        m_sbHTML.Append("</td></TR>")

        m_sbHTML.Append("<TR width=99.9% class=clsTRPageCaption align='left'  >")
        m_sbHTML.Append("<td style='width:25%;text-align:left' align=left>And Other Desired Skill")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        'm_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOtherSkill1", "select ToolID,[Description] from tbl_PM_Tools  WHERE ISSkill = 1 ORDER BY [Description]", 200, m_strOtherSkillID1_ForControl, , True, True))
        'm_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOtherSkill2", "select ToolID,[Description] from tbl_PM_Tools  WHERE ISSkill = 1 ORDER BY [Description]", 200, m_strOtherSkillID2_ForControl, , True, True))
        m_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOtherSkill1", "usp_sel_tbl_PM_Tools_ToolID_Description", 200, m_strOtherSkillID1_ForControl, , True, True))
        m_sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOtherSkill2", "usp_sel_tbl_PM_Tools_ToolID_Description", 200, m_strOtherSkillID2_ForControl, , True, True))
        ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        m_sbHTML.Append("</td></tr>")

        'Apply and close buttons
        m_sbHTML.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        m_sbHTML.Append("<input type=button id=btnApply onclick='Apply_OnClick()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        m_sbHTML.Append("<input type=button id=btnClose onclick='Clear_OnClick()' value=""Clear""></TD>")

        m_sbHTML.Append("</TR>")
        m_sbHTML.Append("</Table>")


    End Sub
    Private Sub DrawPage()

        Dim strQuery As String

        Dim intColumnsToShow As Integer = 7
        strQuery = "usp_sel_FreeResources " + m_strAllocationPercent + "," + m_strFromDate + "," + m_strRoleID + "," + m_strPrimarySkillID + "," + m_strOtherSkillID1 + "," + m_strOtherSkillID2
        strQuery = strQuery + ",'" + CommonFunctions.General.BuildQueryString(m_strSortBy) + "','" + m_strSortOrder + "','" + m_strPagingChar + "'" + ",'" + m_intPageNumber.ToString() + "'"

        Dim arrUserFriendlyColumn() As String = {"Resource Name", "Project Name", "Project Role", "Planned Start Date", "Planned End Date", "Resource Status", "Reporting To"}
        Dim arrActualColumns() As String = {"EmployeeName", "ProjectName", "ProjectRole", "ExpectedStartDate", "ExpectedEndDate", "ResourceStatus", "ReportingToName"}
        'Dim arrGroupOn() As String = {"1"}

        m_sbHTML.Append("<BR>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            '.RowLinkArray = arrRowLink
            .PrimaryKey = "EmployeeID"
            .EmptyValueReplacement = "-"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            .DIVHeight = 300
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .ClientSideSortFunctionName = "Sort_OnClick"
            '.TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            '.GroupOnColumn = arrGroupOn
            .PageSize = 20
            .CurrentPage = m_intPageNumber

            m_sbHTML.Append(.DrawGrid())
        End With
        m_objGrid = Nothing
        m_sbHTML.Append("<BR>")
    End Sub

    Private Sub DrawNumericPaging()

        Dim intRecordCount As Integer
        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , True, 20)
        Dim strPaging As String = ""
        Dim strPagingSQL As String

        strPagingSQL = "usp_sel_Count_FreeResources " + m_strAllocationPercent + "," + m_strFromDate + "," + m_strRoleID + "," + m_strPrimarySkillID + "," + m_strOtherSkillID1 + "," + m_strOtherSkillID2 _
                             + ",'" + CommonFunctions.General.BuildQueryString(m_strSortBy) + "','" + m_strSortOrder + "','-1'"

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strPagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:06/10/15
        End If

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:AllPage_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        If Trim(strPaging & "") <> "" Then
            m_sbHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            'm_sbHTML.Append("<td align=right>" + strPaging + "</TD>")
        End If

        'm_sbHTML.Append("</TR></TABLE>")

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strFreePercentage As String
        strFreePercentage = Args.DataReader("FreePercentage")

        If Args.DataField.ToUpper() = "EMPLOYEENAME" Then
            Cancel = True
            m_strNewEmpName = Args.DataReader("EmployeeName")

            If m_strNewEmpName <> m_strOldEmpName Then
                Args.StringToBeInserted += "<TD colspan=7>" + m_strNewEmpName + " <B>[ </B>" + strFreePercentage + " % Available <B>]</B>" + "</TD></TR>"
                Args.StringToBeInserted += "<TR class=clsTREven > "
                Cancel = True
                'Args.StringToBeInserted += "<TD>&nbsp;</TD>"
            End If

            Args.StringToBeInserted += "<TD>&nbsp;</TD>"
            'If m_strNewEmpName <> m_strOldEmpName Then
            '    Args.StringToBeInserted += "<TD>" + m_strNewEmpName + "</TD>"
            'Else
            '    Args.StringToBeInserted += "<TD>&nbsp;</TD>"
            'End If


            m_strOldEmpName = m_strNewEmpName

        End If

    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
         

    End Sub
End Class
