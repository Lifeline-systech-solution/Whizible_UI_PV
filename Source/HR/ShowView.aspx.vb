Imports WebPages.Template
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Security
Public Class ShowView
    Inherits WebPages.Template.WhizTemplate
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.ID = "frmShowView"

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
    Dim WithEvents objGrid As New WebPage.Templates.GenericGrid
    Protected strPagingHTML As String
    Protected m_strpaging As String
    Protected m_intPageNumber As Integer = 1
    Protected m_intTotalNoOfRows As Integer = 0
    Protected m_strSkillID As String
    Protected m_strCategoryID As String
    Protected m_TotalRecords As Integer
    Protected m_ViewID As String = "1"
    Protected m_ExportID As String = ""
    Private m_strResourceNameforGroup As String = ""
    Private m_strBGforGroup As String = ""
    Private strNumPag As String
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected intReportID As Long
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Protected m_intShowMessage As Integer = 0
    Protected m_strFileName As String
    Protected strFormat As String
    Protected m_intProjectReport As Integer
    Protected strType As String
    Protected m_strReportDisclaimer As String = ""
    Private m_blnUseSQL As Boolean
    Private ViewReport As String = "0"
    Private m_blnShowGrid As Boolean = True
    Private m_dsGrid As DataSet
    Private WithEvents m_objSectionTitle As New WebPage.Templates.SectionTitle
    Private objPaging As WebPage.Templates.Paging

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub DrawNumericPage()
        Dim ds As DataSet
        Dim intRecordCount As Integer
        Dim strPaging As String = ""
        Dim strSectionTag As String = "divGrid"
        Dim strFunctionName As String = "ShowHide_divGrid"
        Dim strSQL As String = ""
        Dim strInitiativeFilter As String = ""
        Dim strBUFilter As String = ""
        Dim strOUFilter As String = ""
        Dim strAction As String
        Dim objDr As IDataReader
        Dim strParam As String
        Dim strNumPag As String


        If m_intPageNumber > 0 Then
            strNumPag = m_intPageNumber.ToString
        Else
            strNumPag = "0"
        End If
        Dim strAlpha As String = m_strpaging
        If strAlpha <> "" Then
            If strAlpha.ToUpper = "AND" Then
                strAlpha = "&"
            End If
        End If

        strSQL = "usp_CRW_Sel_tbl_PM_EmployeeSkillMatrix_Category_paging  "

        If m_strCategoryID <> "" Then
            strSQL += m_strCategoryID + ","
        Else
            strSQL += "NULL ,"
        End If

        If m_strSkillID <> "" Then
            strSQL += m_strSkillID + ","
        Else
            strSQL += "NULL, "
        End If

        If m_ViewID <> "" Then
            strSQL += m_ViewID
        Else
            strSQL += "1"
        End If

        'If m_strpaging <> "-1" Then
        '    strSQL += ",'" + m_strpaging.Replace("CHR(39)", "'").ToString + "'," & strNumPag
        'Else
        strSQL += "," & strNumPag
        'End If

        ' -- Get the Totol Count Records 
        Dim strSQLQuery As String
        If m_strpaging <> "-1" Then
            strSQLQuery = "usp_Sel_Total_Rec_ResourceSkills " & m_strCategoryID & "," & m_strSkillID & "," & m_ViewID + ",'" + m_strpaging.Replace("'", "''").ToString + "'"
        Else
            strSQLQuery = "usp_Sel_Total_Rec_ResourceSkills " & m_strCategoryID & "," & m_strSkillID & "," & m_ViewID + ",''"
        End If

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), "0"), "0"), Integer)

        Dim m_lngRecordCount As Integer

        m_lngRecordCount = m_TotalRecords 'm_intTotalNoOfRows

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        ' -- To plot Numeric Paging
        '<font size='1'>
        strPaging = "<TABLE cellspacing=0 Width=99.9% BORDER=0 class=clsTable><TR class='clsTRPageHeader'>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
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

        strPaging += "of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += " |<A href='javascript:NumPage_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        strPaging += "</td></TR></TABLE>"
        If m_blnShowGrid Then
            ' the section title
            Response.Write(m_objSectionTitle.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
            Response.Write("<script language=javascript>" & m_objSectionTitle.ClientsideScript & "</script>")

        Else
            ' the section title
            Response.Write(m_objSectionTitle.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , "../../images/plus.gif", , , , , , False, False))
            Response.Write("<script language=javascript>" & m_objSectionTitle.ClientsideScript & "</script>")

        End If

        'If m_Title <> "" Or m_Title Is Nothing Then
        '    m_Title = CommonFunction.General.UnBuildQueryString(CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtTitle"), ""), String))
        'End If
        'If m_Code <> "" Or m_Code Is Nothing Then
        '    m_Code = CommonFunction.General.UnBuildQueryString(CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCode"), ""), String))
        'End If
        'Destroy the object
        m_objSectionTitle = Nothing
        'm_dsGrid.Dispose() : m_dsGrid = Nothing

    End Sub



    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()
        ' Purpose               : Start of Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : This function must be called within FORM tag in aspx page.
        ' Author                : SuchitraP
        ' Created               : Oct 12,2007
        ' Revisions             :
        '=====================================================================

        InitVariable()

        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList

        Dim strSQL As String

        arrMenu.Add("Export Data")
        arrMenu.Add("?")

        arrMenuToolTip.Add("ExportData")
        arrMenuToolTip.Add("Help")

        arrCSFunction.Add("ExportData_OnClick()")
        arrCSFunction.Add("Help_OnClick()")



        If m_intPageNumber > 0 Then
            strNumPag = m_intPageNumber.ToString
        Else
            strNumPag = "0"
        End If
        Dim strAlpha As String = m_strpaging
        If strAlpha <> "" Then
            If strAlpha.ToUpper = "AND" Then
                strAlpha = "&"
            End If
        End If

        strSQL = "usp_CRW_Sel_tbl_PM_EmployeeSkillMatrix_Category_paging  "

         If m_strCategoryID <> "" Then
                strSQL += m_strCategoryID + ","
            Else
                strSQL += "NULL ,"
            End If

            If m_strSkillID <> "" Then
                strSQL += m_strSkillID + ","
            Else
                strSQL += "NULL, "
            End If

            If m_ViewID <> "" Then
                strSQL += m_ViewID
            Else
                strSQL += "1"
            End If

        'If m_strpaging <> "-1" Then
        'strSQL += ",'" + m_strpaging.Replace("CHR(39)", "'").ToString + "'," & strNumPag
        'Else
        strSQL += "," & strNumPag
        'End If
            objPaging = New WebPage.Templates.Paging
            strPagingHTML = objPaging.DrawPaging(strAlpha, strSQL, "Select", "Page_OnClick", "Title", True)

            'objPaging = Nothing

            m_ExportID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), ""), String)
            If m_ExportID.ToUpper = "EXPORT" Then
                ExportData()
            Else

            With Response
                .Write("<div id='divUpperMenu'>")
                .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip), True, strPagingHTML))
                .Write("</div>")
                .Write("<BR>")
                DrawPageFilters()
                .Write("<BR>")
                DrawView()
                .Write("<BR>")
                .Write("<TABLE ID='Title' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
                .Write("<TR class=clsTRPageCaption>")
                .Write("<TD align=Left>Resource Skill Details</TD></TR></TABLE></div>")
                .Write("<BR>")
                DrawNumericPage()
                .Write("<BR>")
                DrawGrid()
                .Write("<BR>")
                '.Write("<div id=totRecords>")
                .Write("<TABLE ID='Records' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
                .Write("<TR class='clsTREven'>")
                .Write("<TD align=right>Total Records : " + CType(m_intTotalNoOfRows, String) + "</TD></TR></TABLE></div>")
                .Write("<BR>")
                .Write("<div id='divBottomMenu'>")
                .Write(WebPages.Template.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip), True))
                ' .Write("</div>")
            End With
        End If

    End Sub
    Private Sub InitVariable()

        ' m_strSkillID = HttpContext.Current.Request.Form.Get("cboSkills")

        'If m_strSkillID Is Nothing Or m_strSkillID = "" Then
        '    m_strSkillID = "NULL"
        'End If

        m_strCategoryID = HttpContext.Current.Request.Form.Get("cboCategory")
        If m_strCategoryID Is Nothing Or m_strCategoryID = "" Then
            m_strCategoryID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CategoryID"), "NULL"), String)
        End If

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        m_ViewID = HttpContext.Current.Request.Form.Get("cboView")

        If m_ViewID Is Nothing Or m_ViewID = "" Then
            m_ViewID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ViewID"), "1"), String)
        End If
        ViewReport = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ViewReport"), "0"), String)

        m_strSkillID = HttpContext.Current.Request.Form.Get("cboSkills")
        If m_strSkillID Is Nothing Or m_strSkillID = "" Then
            m_strSkillID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SkillID"), "NULL"), String)
        End If
        m_strpaging = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Paging"), "-1").ToUpper

        intReportID = CType(HttpContext.Current.Request.QueryString("ReportID"), Long)
        strFormat = Request.QueryString("Format")
        If ViewReport = "1" Then
            ShowReport()
        End If
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Sub DrawPageFilters()
        CommonFunction.General.WriteHTML("<div id=PageFilters>")
        CommonFunction.General.WriteHTML("<TABLE ID='PageFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTRPageCaption' Width='100%'>")

        'Category combo
        CommonFunction.General.WriteHTML("<TD align=right  title='Category' width=5%>")
        CommonFunction.General.WriteHTML("Category")
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboCategory", "usp_Sel_tbl_PM_Tools_Category", 150, m_strCategoryID, "onchange=Category_onchange() ", True)
        CommonFunction.General.WriteHTML("</TD>")


        'Skill combo
        CommonFunction.General.WriteHTML("<TD align=right title='Skills' width=5%>")
        CommonFunction.General.WriteHTML("Skills")
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.HTMLControls.DrawComboBox("cboSkills", "usp_Sel_tbl_PM_Tools_Resource " + m_strCategoryID, 150, m_strSkillID, "onchange=Status_onchange() ", True)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</div>")


    End Sub
    Private Sub DrawView()
        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption>")
        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("<TD></TD>")
        CommonFunction.General.WriteHTML("<TD align=right width=80%>Views</TD>")
        CommonFunction.General.WriteHTML("<TD align=Left>")
        CommonFunction.HTMLControls.DrawComboBox("cboView", "usp_Sel_View_ResourceSkill ", 150, m_ViewID, "onchange=View_onchange() ", False)
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")

    End Sub
    Private Sub DrawGrid()

        Dim strSQL As String = "usp_CRW_Sel_tbl_PM_EmployeeSkillMatrix_Category "

        Dim arrActualColumnsBG As String() = {"Business Group", "Resource Name", "Organization Unit", "Joining Date", "Total Experience", "Other Skills"}
        Dim arrActualColumnsOU As String() = {"Organization Unit", "Resource Name", "Business Group", "Joining Date", "Total Experience", "Other Skills"}
        Dim arrActualColumnsProj As String() = {"Project Name", "Resource Name", "Business Group", "Organization Unit", "Joining Date", "Total Experience", "Other Skills"}

        Dim arrUserfriendlyColNamesBG As String() = {"Business Group", "Resource Name", "Organization Unit", "Joining Date", "Total Experience", "Other Skills"}
        Dim arrUserfriendlyColNamesOU As String() = {"Organization Unit", "Resource Name", "Business Group", "Joining Date", "Total Experience", "Other Skills"}
        Dim arrUserfriendlyColNamesProj As String() = {"Project Name", "Resource Name", "Business Group", "Organization Unit", "Joining Date", "Total Experience", "Other Skills"}

        Dim arrGroupOnColumnOU As String() = {"Organization Unit"}
        Dim arrGroupOnColumnBG As String() = {"Business Group"}
        Dim arrGroupOnColumnProj As String() = {"Project Name"}
        'If m_ViewID = "1" Then
        '    arrGroupOnColumn = {"Organization Unit"}
        'ElseIf m_ViewID = "2" Then
        '    arrGroupOnColumn = {"Business Group"}
        'End If
        'Dim arrActualColumns As String() = {}

        'If m_ViewID = "1" Then
        '    arrActualColumns={"Business Group", "Resource Name", "Organization Unit", "Joining Date", "Total Experience", "Other Skills"}
        'ElseIf m_ViewID = "2" Then
        '    arrActualColumns = {"Organization Unit", "Resource Name", "Business Group", "Joining Date", "Total Experience", "Other Skills"}
        'End If


        CommonFunctions.General.PlotStaticHeaderStyle("divPage")

        If m_strCategoryID <> "" Then
            strSQL += m_strCategoryID + ","
        Else
            strSQL += "NULL ,"
        End If

        If m_strSkillID <> "" Then
            strSQL += m_strSkillID + ","
        Else
            strSQL += "NULL,"
        End If

        If m_ViewID <> "" Then
            strSQL += m_ViewID
        Else
            strSQL += "1"
        End If

        If m_strpaging <> "-1" Then
            strSQL += ",'" + m_strpaging.Replace("'", "''").ToString + "'"
        Else
            strSQL += ",NULL"
        End If


        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "default", , , m_blnUseSQL)

        'Commented and added by Shamkant s for HTML encoding Date:07/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:07/10/15
        With objGrid
            '.ActualColumnArray = arrActualColumns
            '.UserFriendlyColumnArray = arrUserfriendlyColNames
            If m_ViewID = "1" Then
                .ActualColumnArray = arrActualColumnsOU
                .UserFriendlyColumnArray = arrUserfriendlyColNamesOU
                .GroupOnColumn = arrGroupOnColumnOU
                .NoOfDataColumns = 6
                .SortBy = "Organization Unit"
            ElseIf m_ViewID = "2" Then
                .ActualColumnArray = arrActualColumnsBG
                .UserFriendlyColumnArray = arrUserfriendlyColNamesBG
                .GroupOnColumn = arrGroupOnColumnBG
                .NoOfDataColumns = 6
                .SortBy = "Business Group"
            ElseIf m_ViewID = "3" Then
                .ActualColumnArray = arrActualColumnsProj
                .UserFriendlyColumnArray = arrUserfriendlyColNamesProj
                .GroupOnColumn = arrGroupOnColumnProj
                .NoOfDataColumns = 7
                .SortBy = "Project Name"
            End If
            .PageSize = 20
            .CurrentPage = m_intPageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .DIVID = "divPage"
            .DIVHeight = 255
            .DIVStyle = "overflow:auto;width:100%"
            .returnHTML = False
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
            .ConnectionString = CommonFunctions.Application.ConnectionString
            .DrawGrid()
            m_TotalRecords = .NoOfRows
        End With

    End Sub
    'Added by ArchanaN on 16 Oct 2006
    Private Sub ExportData()
        Dim sbHtml As New System.Text.StringBuilder
        Dim strMenu As String

        'Menu
        Dim arrMenu() As String = {"PDF", "HTML", "RTF", "EXCEL", "CSV", "TEXT", "XML", "?"}
        Dim arrMenuToolTip() As String = {"PDF OutPut", "HTML OutPut", "RTF OutPut", "EXCEL OutPut", "CSV OutPut", "TEXT OutPut", "XML OutPut", "Help"}
        Dim arrCSFunction() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Help_OnClick('CRW_HELP_2038')"}
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        Response.Write(strMenu)
        Response.Write("<br>")

        Response.Write("<div style='OVERFLOW:auto' id='DivMain'></div>")

        'If ViewReport = "1" Then
        '    ShowReport()
        'End If
        Dim strReportTitle As String
        If m_ViewID = "1" Then
            strReportTitle = "Resource Skill Details (OU wise)"
        End If

        If m_ViewID = "2" Then
            strReportTitle = "Resource Skill Details (BG wise)"
        End If

        If m_ViewID = "3" Then
            strReportTitle = "Resource Skill Details (Project wise)"
        End If

        'If CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "").ToUpper = "EXPORT" Then
        sbHtml.Append("<HTML>")
        sbHtml.Append(" <TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>" + strReportTitle + "</TD></TR></TABLE>")
        'sbHtml.Append("<DIV id='divList' style='overflow:auto;height:350px'>")
        'sbHtml.Append("<BR>")
        'sbHtml.Append("<BR>")
        sbHtml.Append("<DIV id='divList2' style='overflow:auto;height:90px'>")
        sbHtml.Append("<TABLE class='clsTable' cellspacing=0 cellpadding=0 width='100%'>")
        sbHtml.Append("<TR class=clsTREven>")
        'sbHtml.Append("<TD align=right vAlign=top>Category</TD>")
        sbHtml.Append("<TD align=left colspan=5>")
        sbHtml.Append("<Input  Type=hidden  name='intCategoryID' id='intCategoryID' class='clsTextBox' style='width:200px  ; text-align:Left' value='" + m_strCategoryID + "' ></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("<TR class=clsTREven>")
        'sbHtml.Append("<TD align=right vAlign=top>Skill</TD>")
        sbHtml.Append("<TD align=left colspan=5>")
        sbHtml.Append("<Input  Type=hidden  name='intSkillID' id='intSkillID' class='clsTextBox' style='width:200px  ; text-align:Left' value='" + m_strSkillID + "' ></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("<TR class=clsTREven>")
        ' sbHtml.Append("<TD align=right vAlign=top>View</TD>")
        sbHtml.Append("<TD align=left colspan=5>")
        sbHtml.Append("<Input  Type=hidden  name='intViewID' id='intViewID' class='clsTextBox' style='width:200px  ; text-align:Left' value='" + m_ViewID + "'  ></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</TABLE>")
        sbHtml.Append("</DIV>")

        CommonFunction.General.WriteHTML(sbHtml.ToString)
        ' End If
        sbHtml = Nothing

        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        m_strReportDisclaimer = MyBase.GetResourceString("REPORT_DISCLAIMER") + ""
        'Reset the resources.
        'MyBase.InitializeResources(strBaseResourceName, strBaseResourceAssemblyName)
        Response.Write(m_strReportDisclaimer)
        Response.Write("<br>")

        Response.Write(strMenu)
    End Sub

    Private Sub ShowReport()
        Dim strFilePath As String
        Dim strQuery As String
        Dim dr As IDataReader

        'm_strCategoryID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("cboCategory"), "NULL"), String)
        'm_ViewID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("cboView"), "1"), String)
        ''  ViewReport = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ViewReport"), "0"), String)
        'm_strSkillID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("cboSkills"), "NULL"), String)


        'If intReportID = 2117 Then
        If ViewReport = "1" Then
            strQuery = "usp_CRW_Sel_tbl_PM_EmployeeSkillMatrix_Category " + m_strCategoryID + "," + m_strSkillID + "," + m_ViewID + ",NULL"
            'If m_strpaging <> "-1" Then
            '    strQuery += ",'" + m_strpaging.ToString + "',"
            'Else
            '    strQuery += ",NULL"
            'End If

        End If

        dr = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dr.Read Then
            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim

            ' add extn to file name based on format requested
            Select Case UCase(Trim(strFormat))
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(intReportID, strQuery, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
            With oRpt
                .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
                .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
                .LCID = MyBase.CurrentThreadUICultureID
                .UseHashTables = True
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

                ' generate the report in requested format
                Select Case strFormat
                    Case "PDF" : .GenerateReport(AdHocReports.Format.PDF)
                    Case "HTML" : .GenerateReport(AdHocReports.Format.HTML)
                    Case "RTF" : .GenerateReport(AdHocReports.Format.RTF)
                    Case "EXCEL" : .GenerateReport(AdHocReports.Format.EXCEL)
                    Case "CSV" : .GenerateReport(AdHocReports.Format.CSV)
                    Case "TEXT" : .GenerateReport(AdHocReports.Format.TEXT)
                    Case "XML" : .GenerateReport(AdHocReports.Format.XML)
                    Case Else : .GenerateReport(AdHocReports.Format.PDF)
                End Select
            End With
            oRpt = Nothing

            m_strFileName = CommonFunctions.General.EncryptString(CommonFunctions.General.EncryptString(m_strFileName))
            Response.Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + m_strFileName, True)

        Else
            m_intShowMessage = 1
        End If


        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub
    'End by ArchanaN
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        'To group on Resource Name
        If Args.ColIndex = 1 And Args.ColumnName = "Resource Name" Then
            If m_strResourceNameforGroup = "" Then
                m_strResourceNameforGroup = Args.DataReader("Resource Name").ToString
            Else
                If (m_strResourceNameforGroup = Args.DataReader("Resource Name").ToString) Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD></TD>"
                End If
            End If
            m_strResourceNameforGroup = Args.DataReader("Resource Name").ToString
        End If

    End Sub


End Class
