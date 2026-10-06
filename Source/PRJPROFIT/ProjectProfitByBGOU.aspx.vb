Option Strict Off
Public Class ProjectProfitByBGOU
    Inherits WebPage.Templates.WhizTemplate

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
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        InitializeComponent()
    End Sub

#End Region
    Private WithEvents objMenu As WebPage.Templates.StaticMenu
    Private BGID As String
    Private OUID As String

    'By Manjiri
    Private PGID As String

    Private strAction As String = ""
    Protected m_ProjectID As String = ""
    Protected m_strSQLProject As String = ""
    Private m_strProjectID As String = ""
    Private m_ProjectName As String = ""
    Private intRoleLevel As Integer
    Private m_strProjectFilters As String
    Private strProjectIDs As String = ""
    Private m_CurrencySymbol As String = ""
    Private m_BaseCurrencySymbol As String = ""
    Private m_GPMTrend As String = "0"
    Private m_GroupRevenue As Double = 0
    Private m_GroupCost As Double = 0
    Private m_GroupGPM As Double = 0
    Private m_GroupInvoice As Double = 0

    Private m_TotalRevenue As Double = 0
    Private m_TotalCost As Double = 0
    Private m_TotalGPM As Double = 0
    Private m_TotalInvoice As Double = 0

    Private m_CurrentBG As Long = 0
    Private m_recordcount As Long = 0
    Private m_GroupCount As Long = 0

    'Added By swapnagandha K. On 4-Sep-2019
    Public m_StrWhereClause As String = ""
    Protected Shared m_strFileName As String
    Protected Shared m_lngReportID As Integer = 22275
    Private Shared WithEvents oRpt As AdHocReports.Report.AdHocReport
    'End Added By swapnagandha K. On 4-Sep-2019

    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Protected Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : Initialization for a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 05,2007
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim drProject As IDataReader
        Dim dataReader As IDataReader
        Dim lenProjectID As Integer
        strAction = ""
        'MANJIRI
        PGID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboPG"), ""), String)
        If PGID = "" Then
            PGID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PGID"), ""), String)
        End If


        BGID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboBG"), ""), String)
        If BGID = "" Then
            BGID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BGID"), ""), String)
        End If

        OUID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboOU"), ""), String)
        If OUID = "" Then
            OUID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("OUID"), ""), String)
        End If

        strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "")
        If strAction = "" Then
            strAction = HttpContext.Current.Request.Form("txtAction")
        End If
        'If strAction <> "Menu" Then
        m_ProjectID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboProjectID"), ""), String)
        If m_ProjectID = "" Then
            m_ProjectID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), ""), String)
        End If
        'End If

        m_GPMTrend = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("GPMTrend"), "0"), String)

        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        '=========================================================================================
        '   Applying Role level Security for Project Filters
        '=========================================================================================
        ' Added By PiyushB On 2:31PM  8/06/2008 For WhizibleSEM 7.1
        ' To show all project on the basis of Login Type  for 'Project Profit as per BG,OU' 
        If CType(Session("LoginType"), String) = "E" Then
            ' End_MV_ 7/19/2007
            If intRoleLevel = 2 Then
                m_strProjectFilters = ""
                Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
                If strFilter <> "" Then
                    m_strProjectFilters += strFilter
                End If
                Dim strRemove As String = "ProjectID IN"
                m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
                m_strProjectFilters = m_strProjectFilters.Replace("'", "")
                m_strProjectFilters = m_strProjectFilters.Replace("(", "")
                m_strProjectFilters = m_strProjectFilters.Replace(")", "")
            Else
                m_strProjectFilters = "NULL"
            End If
        ElseIf CType(Session("LoginType"), String) = "C" Then
            Dim strQuery As String = ""
            Dim strProjectList As String = ""

            strQuery = "usp_Sel_GetProjectNameList_SQERT_Customer " + CType(Session("intUserID"), String)
            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            While (drProject.Read())
                strProjectList = strProjectList + "," + drProject("ProjectID").ToString()

            End While
            CommonFunction.Data.DisposeDataReader(drProject)
            strProjectList = strProjectList.Substring(1, strProjectList.Length - 1)
            m_strProjectFilters = strProjectList
        End If

        m_strSQLProject = "usp_Sel_GetProjectNameList_SQERT_Profitability  "
        m_strSQLProject = m_strSQLProject & "NULL,"
        m_strSQLProject = m_strSQLProject & "NULL,"
        m_strSQLProject = m_strSQLProject & "NULL,"
        m_strSQLProject = m_strSQLProject & "NULL,"
        If m_strProjectFilters <> "NULL" Then
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "'," & CType(Session("LoginType"), String)
        Else
            m_strSQLProject = m_strSQLProject & CType(Session("intUserID"), String) & "," & m_strProjectFilters & "," & CType(Session("LoginType"), String)
        End If
        dataReader = CommonFunction.Data.GetDataReader(m_strSQLProject, True)
        While dataReader.Read()
            strProjectIDs = strProjectIDs + dataReader("ProjectID").ToString() + ","
        End While
        CommonFunction.Data.DisposeDataReader(dataReader)
        lenProjectID = strProjectIDs.Length
        If lenProjectID > 0 Then
            strProjectIDs = strProjectIDs.Substring(0, lenProjectID - 1)
        End If
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ' m_BaseCurrencySymbol = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("SELECT CurrencySymbol  FROM tbl_PM_CurrencyMaster INNER JOIN tbl_PM_CompanyInformation ON tbl_PM_CurrencyMaster.CurrencyID = tbl_PM_CompanyInformation.BaseCurrencyID", True).ToString(), "-").ToString()
        m_BaseCurrencySymbol = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CurrencyMaster_Currency", True).ToString(), "-").ToString()
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


    End Sub
    Protected Sub DrawHiddenFields()
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.HTMLControls.DrawTextBox("txtAction", "txtAction", , 150, , strAction, , , , , , True, , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
    End Sub
    Protected Sub writeMenu()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : Print Menu for a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 05,2007
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim ShowLink As String
        Dim ShowLinkToolTip As String
        Dim ShowLinkFunction As String
        objMenu = New WebPage.Templates.StaticMenu

        ' Dim arrMenu() As String = {"<img id='imgHelp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Help.gif'>"}
        Dim arrMenu() As String = {"?"}
        Dim arrMenuToolTip() As String = {"Help"}
        Dim arrCSFunction() As String = {"Help_OnClick('3944')"}
        objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)

    End Sub
    Protected Sub CreateCaption()
        '=====================================================================
        ' Procedure Name        : CreateCaption()	
        ' Purpose               : Create Caption of a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 05,2007
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim strBusinessGroup As String = ""
        Dim strOrganizationUnit As String = ""

        'By Manjiri
        Dim strProjectGroup As String = ""

        If PGID <> "" Then
            strProjectGroup = CommonFunction.Data.GetDataScalar("usp_sel_tbl_pm_Projectgroup_pg " + PGID, True).ToString()
        End If


        If BGID <> "" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strBusinessGroup = CommonFunction.Data.GetDataScalar("Select BusinessGroup From tbl_CNF_BusinessGroups WHERE BusinessGroupID=" + BGID, True).ToString()
            strBusinessGroup = CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_BusinessGroups_BG " + BGID, True).ToString()
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        End If

        If OUID <> "" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strOrganizationUnit = CommonFunction.Data.GetDataScalar("Select Location From tbl_PM_Location WHERE LocationID=" + OUID, True).ToString()
            strOrganizationUnit = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Location_OU " + OUID, True).ToString()
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        End If

        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=1 class=clsTRPageCaption align='left'>")
        CommonFunctions.General.WriteHTML("<td style='width:17%;text-align:left'><B>&nbsp;Project Profitability</B>")
        CommonFunctions.General.WriteHTML("</td>")
        'If strAction = "Display" Then
        CommonFunctions.General.WriteHTML("<td style='width:17%;text-align:right; FONT-WEIGHT: normal;'>&nbsp;( All Figures In : " + m_BaseCurrencySymbol + " )")
        CommonFunctions.General.WriteHTML("</td>")
        'End If
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</TABLE>")

    End Sub
    Protected Sub WritePage()

        Initialize()

        DrawPage()

        Response.Write("<br>")
        writeMenu()

    End Sub
    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : Draw  a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 05,2007
        ' Revisions             : 
        '                         
        '=====================================================================
        'CommonFunctions.General.WriteHTML("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
        Call DrawMenuPage()
        Call DrawDisplayPage()
        'CommonFunction.General.WriteHTML("</div>")
    End Sub
    Protected Sub DrawDisplayPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : Draw a Display Page After Menu is selected
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 05,2007
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim arrUserFriendlyCols() As String = {"Business Group", "Project Name", "Customer", "Organization Unit", "As On Date", "Accrued Revenue", "Accrued Cost", "Accrued GPM", "Accrued GPM %", "Invoice Revenue"}
        Dim arrActualCols() As String = {"BusinessGroup", "ProjectName", "CustomerName", "Location", "ToDate", "AccruedRevenue", "AccruedCost", "AccruedGPM", "AccruedGPMPercent", "InvoiceRevenue"}
        Dim strSQL As String = ""
        Dim strGroupOnColumn() As String = {"BusinessGroup"}
        Dim strSortByCols() As String = {"ProjectName", "CustomerName", "Location", "ToDate", "AccruedRevenue", "AccruedCost", "AccruedGPM", "AccruedGPMPercent", "InvoiceRevenue"}
        Dim strSummaryFunctions() As String = {"", "", "", "", "", "SUM", "SUM", "SUM", "AVG", "SUM"}
        Dim strrowLinkArray() As String = {"", "CallGPM(ProjectID)"}
        'Dim objDR As IDataReader
        Dim strWhereClause As String = ""
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        If BGID = "" Then
            strWhereClause = strWhereClause + "Null"
        Else
            strWhereClause = strWhereClause + BGID
        End If
        If OUID = "" Then
            strWhereClause = strWhereClause + ",Null"
        Else
            strWhereClause = strWhereClause + "," + OUID
        End If

        If strProjectIDs = "" Then
            strWhereClause = strWhereClause + ",Null"
        Else
            strWhereClause = strWhereClause + ",'" + strProjectIDs + "'"
        End If
        If m_ProjectID = "" Then
            strWhereClause = strWhereClause + ",Null"
        Else
            strWhereClause = strWhereClause + ",'" + m_ProjectID + "'"
        End If

        If m_GPMTrend <> "" Then
            strWhereClause = strWhereClause + "," + m_GPMTrend
        Else
            strWhereClause = strWhereClause + ",0"
        End If

        ' By Manjiri
        If PGID = "" Then
            strWhereClause = strWhereClause + ",Null"
        Else
            strWhereClause = strWhereClause + "," + PGID
        End If

        m_StrWhereClause = strWhereClause
        strSQL = " usp_SEL_Tbl_PM_ProjectProfitability_ProjectProfit_forProjectGroup  " + strWhereClause
        'objDR = CommonFunction.Data.GetDataReader(strSQL, True)
        m_objGrid = New WebPages.Template.AdvancedGrid
        With m_objGrid

            .NoOfDataColumns = arrUserFriendlyCols.Length
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = True
            .DIVID = "DivMain"
            .DIVStyle = "overflow:auto;width:99.99%;"
            '.DIVHeight = 450
            '.DIVHeight = "99.99%"
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .SortBy = "ProjectName"
            .SortOrder = "Asc"
            .RowLinkArray = strrowLinkArray
            .GroupOnColumn = strGroupOnColumn
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = strSummaryFunctions
            .SummaryFunctions = strSummaryFunctions
            '.CheckboxCheckOnColumnArray = arrCheckboxArray
            'Added By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
            m_recordcount = .NoOfRows
        End With
        m_objGrid = Nothing
    End Sub
    Protected Sub DrawMenuPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()	
        ' Purpose               : Draw Menu a Page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PiyushB
        ' Created               : Aug 05,2007
        ' Revisions             : 
        '                         
        '=====================================================================
        Dim strSQLOU As String
        Dim strSQLProject As String
        Dim strBGID As String = ""
        Dim strOUID As String = ""
        strSQLOU = "usp_Sel_pm_LocationList_SQERT "
        If Request("cboBG") <> "" Then
            strBGID = Request("cboBG")
            strSQLOU = strSQLOU & Request("cboBG") & "," & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String)
        Else
            strBGID = "NULL"
            strSQLOU = strSQLOU & "NULL " & "," & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String)
        End If
        strSQLProject = "usp_Sel_GetProjectNameList_SQERT_Profitability  "
        If Request("cboOU") <> "" Then
            strOUID = Request("cboOU")
            'Modified by TruptiK on 29-Apr-09
            'Purpose:-added projectfilter parameter to sp.
            'strSQLProject = strSQLProject & "NULL " & "," & strBGID & "," & strOUID & ",NULL " & "," & CType(Session("intUserID"), String) & "," & "NULL " & ",'" & CType(Session("LoginType"), String) & "'"
            strSQLProject = strSQLProject & "NULL " & "," & strBGID & "," & strOUID & ",NULL " & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "','" & CType(Session("LoginType"), String) & "'"
        Else
            strOUID = "NULL"
            'strSQLProject = strSQLProject & "NULL " & "," & strBGID & "," & strOUID & ",NULL " & "," & CType(Session("intUserID"), String) & "," & "NULL " & ",'" & CType(Session("LoginType"), String) & "'"
            strSQLProject = strSQLProject & "NULL " & "," & strBGID & "," & strOUID & ",NULL " & "," & CType(Session("intUserID"), String) & ",'" & m_strProjectFilters & "','" & CType(Session("LoginType"), String) & "'"
            'End of modification by TruptiK
        End If

        writeMenu()

        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='width:99.99%' class='clsGridTable' cellspacing='0' cellpadding='0'>")

        'Added by Manjiri'
        'PG Combo
        CommonFunctions.General.WriteHTML("<TR width=99.9%  class='clsTREven' align='center'>")
        CommonFunctions.General.WriteHTML("<td  align='right'>Project Group")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboPG", "usp_sel_Whizible2_tbl_pm_ProjectGroup " & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String), 150, PGID, "" + " Langugage=JavaScript OnChange=cboPG_change()", True, True))
        CommonFunctions.General.WriteHTML("</td>")


        'BG combo
        'CommonFunctions.General.WriteHTML("<TR width=99.9%  class='clsTREven' align='center'>")
        CommonFunctions.General.WriteHTML("<td  align='right'>Business Group")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_Sel_tbl_CNF_BusinessGroup_SQERT " & CType(Session("intUserID"), String) & "," & CType(Session("LoginType"), String), 150, BGID, "" + " Langugage=JavaScript OnChange=cboBU_change()", True, True))
        CommonFunctions.General.WriteHTML("</td>")

        'OU combo 
        CommonFunctions.General.WriteHTML("<td style='text-align:right' align=right>Organization Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align=left >")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboOU", strSQLOU, 150, OUID, " onchange='javascript:cboProject_change()'", True, True))
        CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("</tr>")

        'Project combo S
        'CommonFunctions.General.WriteHTML("<TR width=99.9% class=clsTREven align='center'>")
        CommonFunctions.General.WriteHTML("<td style='text-align:right' >Project ")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td  align=left>")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProjectID", strSQLProject, 200, m_ProjectID, "onchange='javascript:cboProject_change()' ", True, True))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'GPM Trend 
         CommonFunctions.General.WriteHTML("<TR width=99.9%  class='clsTREven' align='center'>")
        CommonFunctions.General.WriteHTML("<td style='text-align:right'>")
        CommonFunctions.General.WriteHTML("GPM")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='text-align:left' nowrap>")
        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("GPMTrend", "GPMTrend", , CType(IIf(m_GPMTrend = "1", True, False), Boolean), "1", , "onclick='javascript:cboProject_change()'", True))
        CommonFunctions.General.WriteHTML("<img src='../../Images/GREENflag.gif' title='Positive GPM' onclick='javascript:cboProject_change()'>")

        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("GPMTrend", "GPMTrend", , CType(IIf(m_GPMTrend = "-1", True, False), Boolean), "-1", , "onclick='javascript:cboProject_change()'", True))
        CommonFunctions.General.WriteHTML("<img src='../../Images/REDflag.gif' title='Negative GPM' onclick='javascript:cboProject_change()'>")

        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("GPMTrend", "GPMTrend", , CType(IIf(m_GPMTrend = "0", True, False), Boolean), "0", , "onclick='javascript:cboProject_change()'", True))
        CommonFunctions.General.WriteHTML("<img src='../../Images/grayflag.gif' title='All GPM' onclick='javascript:cboProject_change()'>")

        CommonFunctions.General.WriteHTML("</td>")
        'Added By swapnagandha K. On 4-Sep-2019
        CommonFunctions.General.WriteHTML("<td colspan=6 style='text-align:right' nowrap>")
        'CommonFunctions.General.WriteHTML("<div class='dropdown filedownload'>")
        'CommonFunctions.General.WriteHTML("<button class='nostylebtn dropdown-toggle' data-toggle='dropdown' data-placement='bottom' title='' data-original-title='Click here To download' autocomplete='off' aria-expanded='False'><i class='fas fa-download'></i></button>")

        ' CommonFunctions.General.WriteHTML("<ul class='dropdown-menu' id='fas-download'>")
        CommonFunctions.General.WriteHTML("<a href='#' style='margin-right: 22px;' onclick='DownloadReport()'>")
        CommonFunctions.General.WriteHTML("Export</a>")
        'CommonFunctions.General.WriteHTML("<li><a href = '#' onclick='DownloadReport('EXCEL')'>")
        'CommonFunctions.General.WriteHTML("<img src = '../ ../ ../ Whizible2.0/dist/img/xls.svg' width='18px'>Xlsx</a></li>")
        'CommonFunctions.General.WriteHTML("<li><a href = '#' onclick='DownloadReport('XML')'>")
        'CommonFunctions.General.WriteHTML("<img src = '../ ../ ../ Whizible2.0/dist/img/xml.svg' width='18px'>Xml</a></li>")
        'CommonFunctions.General.WriteHTML("<li><a href = '#' onclick='DownloadReport('TEXT')'>")
        'CommonFunctions.General.WriteHTML("<img src = '../ ../ ../ Whizible2.0/dist/img/doc.svg' width='18px'>Doc</a></li>")

        CommonFunctions.General.WriteHTML("</ul>")


        'CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</td>")
        'End Added By swapnagandha K. On 4-Sep-2019
        CommonFunctions.General.WriteHTML("</TR>")

        '        CommonFunctions.General.WriteHTML("<tr class=clsTREven><TD colspan=2></TD></TR>")
        CommonFunctions.General.WriteHTML("</Table>")

        ' CommonFunctions.General.WriteHTML("</div>")

        Response.Write("<br>")
        CreateCaption()
        Response.Write("<br>")

    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        m_recordcount += 1

        If m_CurrentBG <> CType(Args.DataReader("BusinessGroupID"), Long) Then
            m_GroupCount += 1
            If m_CurrentBG <> 0 Then

                Dim sbhtml As New System.Text.StringBuilder
                sbhtml.Append("<tr class='clsTRSectionHeader' >")
                sbhtml.Append("<td align='left' colspan=5><b>Total</b></td>")
                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupRevenue.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupCost.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupGPM.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")

                If m_GroupRevenue <> 0 Then
                    sbhtml.Append(FormatNumber(((m_GroupRevenue - m_GroupCost) / m_GroupRevenue * 100), 2))
                Else
                    sbhtml.Append("0.00")
                End If

                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_GroupInvoice.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("</tr>")
                Args.StringToBeInserted = sbhtml.ToString
                sbhtml = Nothing


            End If

            m_TotalRevenue += m_GroupRevenue
            m_TotalGPM += m_GroupGPM
            m_TotalCost += m_GroupCost
            m_TotalInvoice += m_GroupInvoice

            m_GroupCost = CType(Args.DataReader("AccruedCost"), Double)
            m_GroupGPM = CType(Args.DataReader("AccruedGPM"), Double)
            m_GroupInvoice = CType(Args.DataReader("InvoiceRevenue"), Double)
            m_GroupRevenue = CType(Args.DataReader("AccruedRevenue"), Double)
            m_CurrentBG = CType(Args.DataReader("BusinessGroupID"), Long)

        Else

            m_GroupCost += CType(Args.DataReader("AccruedCost"), Double)
            m_GroupGPM += CType(Args.DataReader("AccruedGPM"), Double)
            m_GroupInvoice += CType(Args.DataReader("InvoiceRevenue"), Double)
            m_GroupRevenue += CType(Args.DataReader("AccruedRevenue"), Double)

        End If

    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        If m_recordcount <> 0 Then

            Dim sbhtml As New System.Text.StringBuilder
            sbhtml.Append("<tr class='clsTRSectionHeader' >")
            sbhtml.Append("<td align='left' colspan=5><b>Total</b></td>")
            sbhtml.Append("<td  align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupRevenue.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("<td align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupCost.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("<td  align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupGPM.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("<td  align='right' nowrap><b>")

            If m_GroupRevenue <> 0 Then
                sbhtml.Append(FormatNumber(((m_GroupRevenue - m_GroupCost) / m_GroupRevenue * 100), 2))
            Else
                sbhtml.Append("0.00")
            End If

            sbhtml.Append("</b></td>")

            sbhtml.Append("<td  align='right' nowrap><b>")
            sbhtml.Append(m_BaseCurrencySymbol + " ")
            sbhtml.Append(m_GroupInvoice.ToString("N2"))
            sbhtml.Append("</b></td>")

            sbhtml.Append("</tr>")

            If m_GroupCount = 1 Then
                'CommonFunction.General.WriteHTML(sbhtml.ToString())
                Args.StringToBeInserted = sbhtml.ToString
                Cancel = True
            Else
                m_TotalRevenue += m_GroupRevenue
                m_TotalGPM += m_GroupGPM
                m_TotalCost += m_GroupCost
                m_TotalInvoice += m_GroupInvoice

                sbhtml.Append("<tr class='clsTRSectionHeader' >")
                sbhtml.Append("<td align='left' colspan=5><b>Grand Total</b></td>")
                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalRevenue.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalCost.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalGPM.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")

                If m_TotalRevenue <> 0 Then
                    sbhtml.Append(FormatNumber(((m_TotalRevenue - m_TotalCost) / m_TotalRevenue * 100), 2))
                Else
                    sbhtml.Append("0.00")
                End If

                sbhtml.Append("</b></td>")

                sbhtml.Append("<td  align='right' nowrap><b>")
                sbhtml.Append(m_BaseCurrencySymbol + " ")
                sbhtml.Append(m_TotalInvoice.ToString("N2"))
                sbhtml.Append("</b></td>")

                sbhtml.Append("</tr>")
                Args.StringToBeInserted = sbhtml.ToString
                Cancel = True
            End If


            sbhtml = Nothing
        Else
            Cancel = True
        End If

    End Sub
    ''Added by Yogesh J on 10-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_CallGPM_OnClick(Project As String, EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(Project, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by Yogesh J on 10-Feb-2016
    'Added By swapnagandha K. On 4-Sep-2019
    <System.Web.Services.WebMethod()>
    Public Shared Function ExportToExcel(ByVal ReportFormat As String, ByVal strWhereClause As String)
        '====================================================================
        ' Function  Name        : ExportToExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export Project Profitability Details to excel
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Swapnagandha K.
        ' Created               : 04-Sep-2019
        ' Revisions             :
        '=====================================================================
        Try
            Dim strSQL As String
            Dim strFilePath As String
            Dim strFormat As String
            Dim strCaptions As String



            Dim strFromDate As String = ""
            strSQL = " usp_CRW_seL_tbl_pm_ProjectProfitability_ProjectProfit_forProjectGroup_Total  " + strWhereClause

            ' The reports are created in the "Reports" folder
            strFilePath = CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Reports/"))
            ' get a unique file name
            m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            ' add extn to file name based on format requested
            Select Case ReportFormat
                Case "PDF" : m_strFileName += ".pdf"
                Case "HTML" : m_strFileName += ".htm"
                Case "RTF" : m_strFileName += ".rtf"
                Case "EXCEL" : m_strFileName += ".xls"
                Case "CSV" : m_strFileName += ".csv"
                Case "TEXT" : m_strFileName += ".txt"
                Case "XML" : m_strFileName += ".xml"
                Case Else : m_strFileName += ".pdf"
            End Select

            'Dim frmObjImpedimentLog As New frmImpedimentLog
            ' create object of Adhoc reports
            oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + m_strFileName, CommonFunctions.FileDirectory.CleanPath(HttpContext.Current.Server.MapPath("../../Attachments/Log/")))
            With oRpt
                ''.UseMSSQL = frmObjImpedimentLog.UseSQL
                .UseMSSQL = True
                '.DefaultLCID = CType(frmObjImpedimentLog.DefaultUILCID, Integer)
                .DefaultLCID = 1033
                '.LCID = frmObjImpedimentLog.CurrentThreadUICultureID
                .LCID = 1033
                If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                    .UseHashTables = True
                Else
                    .UseHashTables = False
                End If
                '.UIParameters = strCaptions
                '.UIParametersDelimiter = "|"
                '.WatermarkImageFilePath = ""
                .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
                .CompanyName = CommonFunctions.Application.CompanyName
                .GraphImageGenerationAbsolutePath = HttpContext.Current.Server.MapPath("../../Images/")

                ' generate the report in requested format

                Select Case ReportFormat
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

            Return (m_strFileName)

        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    'End Added By swapnagandha K. On 4-Sep-2019
End Class
