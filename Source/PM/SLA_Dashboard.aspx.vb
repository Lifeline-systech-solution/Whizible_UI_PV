Imports PbNIT
Public Class SLA_Dashboard
    Inherits WebPages.Template.WhizTemplate

#Region "Page Information"
    '=====================================================================
    ' Page Name             : SLA_Dashboard
    ' Purpose               : 
    ' Description           : 
    ' Parameters Passed     : 
    ' Returns               : 
    ' Parameters Affected   : 
    ' Assumptions           : 
    ' Dependencies          : 
    ' Author                : Amit Mahadik
    ' Created               : 29th January 2013
    ' Revisions             : 
    '=====================================================================

    '=====================================================================
    ' The SESSION VARIABLES set on this page.
    '=====================================================================
    ' 
    '=====================================================================	

    '=====================================================================
    ' The QUERY STRING Parameters for this page.
    '=====================================================================
    ' 
    '=====================================================================	
#End Region

#Region "Member Variables"



    Private m_strPageTitle As String
    Private m_blnUseSQL, m_blnSetProjectFilter As Boolean
    Private m_strTaskListFilter, m_strListName As String
    Private m_blnShowWeeklyView, m_blnShowTaskTypeTimesheet As Boolean
    Private m_strPageCaption As String
    Private m_strSortByField, m_strAscOrDesc As String
    Public m_objGlobal As WebPages.Template.IGlobal
    Private m_strNotSpecified As String



    Protected m_intProjectID As Integer = -1
    Protected m_intPDMRID As Integer = -1


    Protected m_strSortOrder As String = ""
    Protected m_strSortBy As String = ""
    Protected m_strWhereClause As String = ""

    Protected WithEvents m_strMenu As New WebPages.Template.StaticMenu
    Protected WithEvents m_strMenuFooter As New WebPages.Template.StaticMenu
    Private WithEvents m_objGridAutoRefreshingSLADashboard As WebPage.Templates.AdvancedGrid

#End Region

#Region "Web Form Designer Generated Code"

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

#Region "Main Call"


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page
        ' Description           : Also gets the various User Preferences from the Database
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          :
        ' Author                : Amit Mahadik
        ' Created               : 29th January 2013
        ' Revisions             : 
        '=====================================================================
        GetGlobalObject()
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_strNotSpecified = " "

        If Not Request.QueryString("PDMRID") Is Nothing Then
            m_intPDMRID = Request.QueryString("PDMRID").ToString
        Else
            m_intPDMRID = -1
        End If

    End Sub
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
    End Sub
    Public Sub DrawPage()
        '=====================================================================
        ' Purpose               : The Main functions which draw the Page are called here 
        ' Description           : this fn. is called from within the Form Tag
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 29th January 2013
        ' Revisions             : 
        '=====================================================================
        Call PlotPageHeader()
        Call PlotPageBody()
        Call PlotPageFooter()

    End Sub

#End Region

#Region "User Methods"

    Private Sub PlotPageHeader()
        '=====================================================================
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 29th January 2013
        ' Revisions             : 
        '=====================================================================
        Dim PrferenceID_PK As String
        Dim strSQLPrferenceID_PK As String
        strSQLPrferenceID_PK = "usp_SEL_INS_tbl_PM_SLADashboard_FilterPreferences  " & m_objGlobal.UserID.ToString
        PrferenceID_PK = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLPrferenceID_PK, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)


        Dim strMenu As String
        Dim arrMenu() As String = {"Project Selection"}
        Dim arrMenuToolTip() As String = {"Project Selection"}
        Dim arrCSFunction() As String = {"OpenSLAFilters(" & PrferenceID_PK & ")"}
        strMenu = m_strMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        strMenu = strMenu.Replace("<TD align=Right>", "<TD align=center>")
        Response.Write(strMenu)

        'Dim strarrLegend() As String = {"Note:"}
        'Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        'CommonFunctions.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, "SLA Dashboard"))
        Response.Write("<BR>")

        ''AMIT MAHADIK FOR SLA DASHBOARD ON 18 APRIL 2013
        'Dim PrferenceID_PK As String
        'Dim strSQLPrferenceID_PK As String
        'strSQLPrferenceID_PK = "usp_SEL_INS_tbl_PM_SLADashboard_FilterPreferences  " & m_objGlobal.UserID.ToString
        'PrferenceID_PK = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLPrferenceID_PK, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)

        'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0 align=right>")
        'Response.Write("<tr class=clsTHHeader>")
        'Response.Write("<TD  class='clsTDBlank' style=""valign:bottom;align:left"">&nbsp;")
        'Response.Write("<a href=""#"" title='OpenSLAFilters' style='text-decoration:none;' onclick='javascript:OpenSLAFilters(" & PrferenceID_PK & ")' >&nbsp;SLA Project Selection&nbsp;&nbsp;</a>") '&nbsp;&nbsp;&nbsp;")';&nbsp;<img src='../../Images/Home/Projects.gif' border=0 style=""vertical-align:bottom"">&nbsp;&nbsp; padding:  1px 2px 1px 2px;border: #C0C0FF 1px outset;MARGIN: 1px 1px 1px 1px;
        'Response.Write("</td>")
        'Response.Write("</tr>")
        'Response.Write("</Table>")
        ''END AMIT MAHADIK FOR SLA DASHBOARD ON 18 APRIL 2013

    End Sub

    Private Sub PlotPageFooter()
        '=====================================================================
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 29th January 2013
        ' Revisions             : 
        '=====================================================================

        Dim strMenu As String
        Dim arrMenu() As String = {""}
        Dim arrMenuToolTip() As String = {""}
        Dim arrCSFunction() As String = {""}
        strMenu = m_strMenuFooter.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        Response.Write(strMenu)

    End Sub

    Private Sub PlotPageBody()
        '=====================================================================
        ' Purpose               : 
        ' Description           : Called from DrawPage() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 29th January 2013
        ' Revisions             : 
        '=====================================================================

        Response.Write("<DIV Id='divContainer' Style='Overflow:Auto;Height:100%'>")

        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")
        Response.Write("<tr class=clsTRColumnHeader>")
        Response.Write("<td  width='100%' align=left><a href=""javascript:ShowDescription_onClick('imgSummaryShowHide1','divSection1','MAINSECTION')""><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='Description' onclick="""" ID='imgSummaryShowHide1' name='imgSummaryShowHide1'></a>&nbsp;<B>SLA Dashboard</B></td>")
        Response.Write("</tr>")
        Response.Write("</Table>")
        Response.Write("<DIV Id='divSection1' Style='Overflow:Auto;Height:630px;width:100%; TEXT-ALIGN: center;'>")
        '''''<Plot Section1 here..>'''''
        Response.Write(PM_XMLHttp.PlotHtmlAutoRefreshingSLADashboard())
        'PlotGridAutoRefreshingSLADashboard()

        Response.Write("</DIV>")

        Response.Write("<BR>")
        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")
        Response.Write("<tr class=clsTRColumnHeader>")
        Response.Write("<td  width='100%' align=left><a href=""javascript:ShowDescription_onClick('imgSummaryShowHide2','divSection2','MAINSECTION')""><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='Description' onclick="""" ID='imgSummaryShowHide2' name='imgSummaryShowHide2'></a>&nbsp;<B>List of Open Incidents By project</B></td>")
        Response.Write("</tr>")
        Response.Write("</Table>")
        Response.Write("<DIV Id='divSection2' Style='Overflow:Auto;Height:auto;width:100%; TEXT-ALIGN: center;'>")
        '''''<Plot Section2 here..>'''''

        Response.Write(PM_XMLHttp.PlotHtmlListofOpenIncidentsByProject())

        Response.Write("</DIV>")


        Response.Write("</DIV>")


    End Sub

    Private Sub PlotGridAutoRefreshingSLADashboard()
        '=====================================================================
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 29th January 2013
        ' Revisions             : 
        '=====================================================================

        Dim strSQL As String
        Dim arrActualCols() As String = {"ProjectName", "IssueID", "Description", "Type", "Status", "Priority", "Response Upto 20%", "Response 21 to 50%", "Response 51 to 80%", "Response 81 to 90%", "Response Above 100%", "Resolution Upto 20%", "Resolution 21 to 50%", "Resolution 51 to 80%", "Resolution 81 to 90%", "Resolution Above 100%"}
        Dim arrUserFriendlyCols() As String = {"ProjectName", "IssueID", "Description", "Type", "Status", "Priority", "Response Upto 20%", "Response 21 to 50%", "Response 51 to 80%", "Response 81 to 90%", "Response Above 100%", "Resolution Upto 20%", "Resolution 21 to 50%", "Resolution 51 to 80%", "Resolution 81 to 90%", "Resolution Above 100%"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""}
        Dim strSectionFilter As String

        ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''End of Addition by Dhanashri S on 7 Oct 2015

        ' grid
        strSectionFilter = "Red"
        strSQL = "usp_sel_v_tbl_IB_Issue_SLADashboard"
        m_objGridAutoRefreshingSLADashboard = New WebPage.Templates.AdvancedGrid
        With m_objGridAutoRefreshingSLADashboard
            .DIVHeight = 630
            .DIVID = "divAutoRefreshingSLADashboard"
            .DIVStyle = "overflow:auto; width:100%;Z-INDEX: 90;"
            .NoOfDataColumns = 24
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .CheckBoxIDArray = arrCheckBox
            ''.PrimaryKey = "MetricID"
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .EmptyValueReplacement = " "
            ''Added by Dhanashri S on 7 Oct 2015 Purpose:HTML Encode
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''End of Addition by Dhanashri S on 7 Oct 2015
            .DrawGrid()
        End With

        m_objGridAutoRefreshingSLADashboard = Nothing

    End Sub

    'Private Sub PlotHtmlAutoRefreshingSLADashboard()
    '    '=====================================================================
    '    ' Purpose               : 
    '    ' Description           : 
    '    ' Parameters Passed     : NA
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : Amit Mahadik
    '    ' Created               : 30th January 2013
    '    ' Revisions             : 
    '    '=====================================================================
    '    Dim sbDashboardHTML As StringBuilder = New StringBuilder()
    '    Dim dsAutoRefreshingSLADashboard As DataSet
    '    dsAutoRefreshingSLADashboard = CommonFunctions.Data.GetDataSet("usp_sel_v_tbl_IB_Issue_SLADashboard", "AutoRefreshingSLADashboard")

    '    sbDashboardHTML.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>")

    '    sbDashboardHTML.Append("<tr class=clsTHHeader>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Project" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Region" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Issue No" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Issue Desc" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Issue Type" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Status" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Priority" & "</td>")

    '    sbDashboardHTML.Append("<td  align=left>" & "Upto 20%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "21 to 50%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "51 to 80%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "81 to 90%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Above 100%" & "</td>")

    '    sbDashboardHTML.Append("<td  align=left>" & "Upto 20%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "21 to 50%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "51 to 80%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "81 to 90%" & "</td>")
    '    sbDashboardHTML.Append("<td  align=left>" & "Above 100%" & "</td>")
    '    sbDashboardHTML.Append("</tr>")
    '    For Each drRow As DataRow In dsAutoRefreshingSLADashboard.Tables(0).Select("1=1")

    '        sbDashboardHTML.Append("<tr class=clsTRHeader>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("ProjectName") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Region") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("IssueID") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Description") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Type") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Status") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Priority") & "</td>")

    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Response Upto 20%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Response 21 to 50%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Response 51 to 80%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Response 81 to 90%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Response Above 100%") & "</td>")

    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Resolution Upto 20%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Resolution 21 to 50%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Resolution 51 to 80%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Resolution 81 to 90%") & "</td>")
    '        sbDashboardHTML.Append("<td  align=left>" & drRow("Resolution Above 100%") & "</td>")
    '        sbDashboardHTML.Append("</tr>")


    '    Next

    '    sbDashboardHTML.Append("</Table>")

    '    Response.Write(sbDashboardHTML.ToString())
    'End Sub
#End Region

#Region "Misc. Events"

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()        
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.SLA_Dashboard", "AppResources") ''TODO
        m_strPageTitle = "SLA Dashboard"
        m_strPageCaption = "SLA Dashboard"

    End Sub

    Public Sub PlotHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

#Region " Grid Events"











#End Region

#End Region

End Class
