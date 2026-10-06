'=====================================================================
' Class	Name	        :	CRM_SLADetails
' Purpose				:	Page to plot graphs for Helpdesk Requests SLA
' Description			:	Same as above
' Assumptions			:	None
' Dependencies			:	None
' Author				:	SandipL
' Created				:	21 June 2007
' Revisions				:	
'=====================================================================
Imports Dundas.Charting.WebControl
Public Class CRM_SLA
    Inherits WebPage.Templates.WhizTemplate
    Private m_blnValidate As Boolean = True

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ''Added by Dhanashri S on 28 Mar 2016
        If Request.QueryString("Mode") = "SR" Or Request.QueryString("Mode") = "AR" Then
            If (Request.QueryString("PKRequestAgeingToken") <> "" And Request.QueryString("Year") <> "" And Request.QueryString("FilterID") <> "") Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("Year"), String) + CType(Request.QueryString("FilterID"), String) + "0" + "0", Request.QueryString("PKRequestAgeingToken")) = False) Then

                    'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        ''End of Addition by Dhanashri S on 28 MAr 2016
        'Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 
        If Request.QueryString("Mode") = "DB" Then
            If (Request.QueryString("PkShowSLAToken") <> "" And Request.QueryString("FilterID") <> "") Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("FilterID"), String) + "0" + "0", Request.QueryString("PkShowSLAToken")) = False) Then

                    'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        If Request.QueryString("Mode") = "SR" Or Request.QueryString("Mode") = "AR" Then
            If (Request.QueryString("PkShowSLATokenSR") <> "" And Request.QueryString("FilterID") <> "") Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("FilterID"), String) + HttpContext.Current.Session("intUserID").ToString() + "0" + "0", Request.QueryString("PkShowSLATokenSR")) = False) Then

                    'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        'If Request.QueryString("Mode") = "SR" Or Request.QueryString("Mode") = "AR" Then
        '    If (Request.QueryString("PkShowSLATokenSR") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
        '        m_blnValidate = False
        '    ElseIf Session("IssueProject").ToString <> "" And Request.QueryString("PKToken") <> "" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("IssueProject"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '            m_blnValidate = False
        '        End If
        '    End If
        '    If (m_blnValidate = False) Then
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    End If
        'End If
        'End Of Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 
    End Sub

#End Region
    Private m_objGlobal As WebPages.Template.IGlobal   ' To store Global object
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private m_dsSLAs As System.Data.DataSet
    Protected m_filterID As Integer = 0
    Private m_strFilterText As String = ""
    Private m_lngEmployeeID As Integer
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' graph location
    Private m_intGraphHeight As Integer
    Private m_intGraphWidth As Integer
    Protected tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
    'Protected tblAgeing As New System.Web.UI.HtmlControls.HtmlTable
    'Protected divGraphs As System.Web.UI.HtmlControls.HtmlControl
    Private m_objGrid As WebPages.Template.GenericGrid
    Protected m_strMenu As String
    Protected m_strMode As String = "DB"
    Private m_strLoginType As String = "E"
    Protected m_intYear As Integer = Year(Now())
    Protected m_strSection As String
    Protected m_blnplotAgeingGraph As Boolean = False


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub WritePage()
        Dim intRowCount As Integer = 0
        Dim row As HtmlTableRow
        Dim cell As HtmlTableCell
        Dim cObjSectionTitle As WebPage.Templates.SectionTitle
        Call Initialize()

        writeMenu()
        Response.Write(m_strMenu)

        Response.Write("<br>")
        'commented and added by Shamkant S
        ' Response.Write("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:90%'>")
        'Response.Write("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:90%;Position:absolute'>") Commented By Vaijat K ON 15/12/2015
        Response.Write("<DIV id='DivMain' style='Overflow:auto;width:100%;'>")
        'commented ended by Shamkant s
        Call GeneratePageCaption()
        Response.Write("<br>")
        Call GeneratePageHeader()

      

        If m_blnplotAgeingGraph = True Then
            With tblGraphs
                row = New HtmlTableRow
                .Rows.Add(row)
                cell = New HtmlTableCell
                cell.Attributes.Add("width", "100%")
                cell.Attributes.Add("align", "center")
                cell.Attributes.Add("Valign", "middle")
                cell.Controls.Add(plotAgeingGraph())
                row.Cells.Add(cell)
            End With
            Return
        End If
        Dim strLeftSectionTitle As String = ""
        Dim strFunctionName As String = "ShowHide_DivAgeing"
        Dim strSectionTag As String = "DivGrid"

        cObjSectionTitle = New WebPage.Templates.SectionTitle
        ' the section title
        Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, ReturnHTML:=True))

        Response.Write("<script language=javascript>" & cObjSectionTitle.ClientsideScript & "</script>")

        Response.Write("<DIV id='DivGrid' style='width:100%;'>")
        Call WriteGrid()
        Response.Write("</DIV>")
        strLeftSectionTitle = "SLA Graphs"
        strFunctionName = "ShowHide_divGraphs"
        strSectionTag = "divGraphs"

        cObjSectionTitle = New WebPage.Templates.SectionTitle
        ' the section title
        Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, ReturnHTML:=True))
        Response.Write("<script language=javascript>" & cObjSectionTitle.ClientsideScript & "</script>")
        'divGraphs.Attributes.Add("style", "overflow:auto" + vbCrLf)
        With tblGraphs

            'row = New HtmlTableRow
            '.Rows.Add(row)
            'cell = New HtmlTableCell
            'cell.Attributes.Add("width", "100%")
            'cell.Attributes.Add("align", "center")
            'cell.Attributes.Add("Valign", "middle")
            'cell.Controls.Add(plotAgeingGraph())
            'row.Cells.Add(cell)


            row = New HtmlTableRow
            .Rows.Add(row)
            cell = New HtmlTableCell
            cell.Attributes.Add("width", "100%")
            cell.Attributes.Add("align", "center")
            cell.Attributes.Add("Valign", "middle")
            cell.Controls.Add(PlotAcknowledgementGraph())
            row.Cells.Add(cell)

            'row = New HtmlTableRow
            '.Rows.Add(row)
            cell = New HtmlTableCell
            cell.Attributes.Add("width", "100%")
            cell.Attributes.Add("align", "center")
            cell.Attributes.Add("Valign", "middle")
            cell.Controls.Add(PlotResponseGraph())
            row.Cells.Add(cell)

            row = New HtmlTableRow
            .Rows.Add(row)
            cell = New HtmlTableCell
            cell.Attributes.Add("width", "100%")
            cell.Attributes.Add("align", "center")
            cell.Attributes.Add("Valign", "middle")
            cell.Controls.Add(PlotResolutionGraph())
            row.Cells.Add(cell)

            'row = New HtmlTableRow
            '.Rows.Add(row)
            cell = New HtmlTableCell
            cell.Attributes.Add("width", "100%")
            cell.Attributes.Add("align", "center")
            cell.Attributes.Add("Valign", "middle")
            cell.Controls.Add(plotClosureGraph())
            row.Cells.Add(cell)

        End With
        tblGraphs.Attributes.Add("Style", "")

        'Dim SB As New System.Text.StringBuilder
        'Dim SW As New System.IO.StringWriter(SB)
        'Dim htmlTW As New HtmlTextWriter(SW)
        'divGraphs.RenderControl(htmlTW)
        'Dim HTML As String = SB.ToString()
        ''Response.Write(HTML)
        'Response.Write(Microsoft.VisualBasic.Strings.Replace(HTML, "divGraphs", "divOtherGraph", , , Microsoft.VisualBasic.CompareMethod.Binary))

        '' hiding the rendered controls
        'tblGraphs.Attributes.Add("style", "Display:None")
        'divGraphs.Attributes.Add("style", "Display:None")

        'SB = Nothing : SW = Nothing : htmlTW = Nothing


        m_dsSLAs.Dispose()
        m_dsSLAs = Nothing
    End Sub
    Private Sub writeMenu()
        '--- Modified by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes. "Close" link removed
        Dim arrMenu() As String = {"Prev Year", "Next Year", "SLA details", "Request Ageing"}
        '''', "Close"
        Dim arrMenuToolTip() As String = {"Prev Year", "Next Year", "SLA details", "Request Ageing"}
        '''', "Close"
        Dim arrCSFunction() As String = {"Prev_Onclick()", "Next_Onclick()", "SLAdetails_OnClick()", "Ageing_OnClick()"}
        '''', "Close_OnClick()"
        '--- End modification purvaj
        If m_blnplotAgeingGraph = True Then
            ReDim arrMenu(0)
            ReDim arrMenuToolTip(0)
            ReDim arrCSFunction(0)

            arrMenu(0) = "Close"
            arrMenuToolTip(0) = "Close"
            arrCSFunction(0) = "Close_OnClick()"
        End If

        Dim objMenu As New WebPage.Templates.StaticMenu
        m_strMenu = objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
    End Sub

    Private Sub WriteGrid()
        m_objGrid = New WebPages.Template.GenericGrid
        Dim arrUserFriendlyCols() As String = {"Sub Request Type", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
        Dim arrActualCols() As String = {"SubRequestType", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
        Dim arrIgnoreHTMLEncode() As String = {"", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"}
        With m_objGrid
            '.NoOfDataColumns = 12
            '.NoOfDataColumns = 15
            .NoOfDataColumns = arrUserFriendlyCols.Length
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            '.RowLinkArray = arrLink
            '.CheckBoxIDArray = arrchkbox
            '.PrimaryKey = "QueryID"
            .returnHTML = False
            '.SQL = SQL
            .GridDataTable = m_dsSLAs.Tables(0)
            '.UseSQL = m_blnUseSQL
            '.CurrentPage = m_intPageNumber
            '.PageSize = 20

            .DIVID = "divGrid"
            .DIVStyle = "overflow:auto;width:100%;"
            .DIVHeight = 150
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .DrawGrid()

        End With
        m_objGrid = Nothing
    End Sub
    Private Sub Initialize()
        Dim strSQL As String
        Dim drFilterText As IDataReader
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()

        m_objGlobal.TagID = 5070


        m_intGraphHeight = 375
        m_intGraphWidth = 450
        m_lngEmployeeID = CInt(HttpContext.Current.Session("intUserID"))

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        End If
        If Not Request.QueryString("Year") Is Nothing Then
            If Request.QueryString("Year") <> "" Then
                m_intYear = CInt(Request.QueryString("Year"))
            End If
        End If
        If Not Request.QueryString("plotAgeingGraph") Is Nothing Then
            m_blnplotAgeingGraph = CBool(Request.QueryString("plotAgeingGraph"))
        End If

        m_strLoginType = CStr(HttpContext.Current.Session("LoginType"))

        If Not Request.QueryString("FilterID") Is Nothing Then
            If Request.QueryString("FilterID") <> "" Then
                m_filterID = CInt(Request.QueryString("FilterID"))

            End If
        End If
        If Not Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))) Is Nothing Then
            m_strFilterText = CStr(Session("strCRM_Filter_" & UCase(Trim(m_strMode & ""))))
        End If

        If m_blnplotAgeingGraph = False Then
            strSQL = " usp_PM_CalculateSLAForHelpDesk_Graphs " & m_lngEmployeeID.ToString
            strSQL = strSQL + ",'" + m_strMode + "','" + m_strLoginType + "'," + m_intYear.ToString
            If m_filterID > 0 Then
                strSQL = strSQL + "," + m_filterID.ToString
            Else
                strSQL = strSQL + ",NULL"
                If m_strFilterText <> "" Then
                    strSQL = strSQL + ",'" + CommonFunctions.General.BuildQueryString(m_strFilterText) + "'"
                End If
            End If
            m_dsSLAs = CommonFunctions.Data.GetDataSet(strSQL, "SLA_Graphs")
        End If


    End Sub
    'Private Sub PlotSubRequestReport()

    'End Sub
    Private Function PlotAcknowledgementGraph() As Dundas.Charting.WebControl.Chart
        Return plotGraph(1, "Acknowledgement SLA", 6)
    End Function

    Private Function PlotResponseGraph() As Dundas.Charting.WebControl.Chart
        Return plotGraph(2, "Response SLA", 5)
    End Function
    Private Function PlotResolutionGraph() As Dundas.Charting.WebControl.Chart
        Return plotGraph(3, "Resolution SLA", 3)
    End Function
    Private Function plotClosureGraph() As Dundas.Charting.WebControl.Chart
        Return plotGraph(4, "Closure SLA", 2)
    End Function
    Private Sub GeneratePageCaption()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Help-desk SLA", "Year=" & m_intYear.ToString, , True))
    End Sub
    Protected Sub GeneratePageHeader()
        '=====================================================================
        ' Procedure Name        : GeneratePageHeader()	
        ' Purpose               : to generate page header
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SandipL
        ' Created               : 23 June 2007
        ' Revisions             :
        '=====================================================================

        Dim objHeaderFooter As New WebPage.Templates.HeaderFooter


        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)

        objHeaderFooter = Nothing



    End Sub
    Private Function plotGraph(ByVal intTableID As Integer, ByVal strGraphTitle As String, ByVal intCategoryID As Integer) As Dundas.Charting.WebControl.Chart
        '=====================================================================
        ' Procedure Name        : plotGraph()	
        ' Purpose               : to Generate  Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SandipL
        ' Created               : 21 June 2007
        ' Revisions             :
        '=====================================================================

        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strImageFileName As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim blnShowExplodedPie As Boolean = False
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(3) As String
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor() As String = {"", "Green", "Red", "Peru"}
        Dim dsGraph As New System.Data.DataSet("Graph")
        Dim ddChart As New Dundas.Charting.WebControl.Chart

        dsGraph.Tables.Add(m_dsSLAs.Tables(intTableID).Copy())
        'strSQL = "usp_Sel_IssueSLADashBoard null,'"

        strImageFileName = "RequestSLA" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "Request SLA"
        blnShowCaptions = True
        ' create the graph for the item values
        objGraph = New Graph.Graph


        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            '.BorderStyle = "FRAMETITLE5"
            '.BorderColor = "BurlyWood"
            arr(0) = "COLUMN"
            arr(1) = "COLUMN"
            arr(2) = "COLUMN"
            arr(3) = "COLUMN"
            'arr(4) = "STACKEDCOLUMN"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "Bisque"
            .ChartAreaColor = "FloralWhite"
            .ShowLegends = True
            .XAxisTitle = "Month"
            .Nomenclature = "Requests Reported"
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "black"
            .ShowDataColumnNameAsXAxisTitle = False
            '-- Fixed Settings
            .GraphTitle = strGraphTitle
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            '.SQL = strSQL
            .DataSet = dsGraph
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            ' .ExtendedSeriesColor = arrColor
            .LegendColor = arrColor
            ' .YAxisInterval = 1
            .XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .XAxisLabelStyle = 2
            .XAxisInterval = 1
            .DrillDownClientSideFunctionName = "ShowSLACategorywiseDetails(" & intCategoryID.ToString & ","
            .ChartAreaWidth = 95
            '            .GenerateStackedGraphImage()
            ddChart = .GenerateChartControl

        End With


        '-- Display Graph
        'If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & strImageFileName & ".png") Then
        '    Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY & strImageFileName & ".png" & "'>")
        'Else
        '    Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        'End If



        dsGraph.Dispose()
        dsGraph = Nothing
        Return ddChart

    End Function
    Private Function plotAgeingGraph() As Dundas.Charting.WebControl.Chart
        '=====================================================================
        ' Procedure Name        : plotAgeingGraph()	
        ' Purpose               : to Generate  Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SandipL
        ' Created               : 21 June 2007
        ' Revisions             :
        '=====================================================================

        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strImageFileName As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim blnShowExplodedPie As Boolean = False
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(4) As String
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor() As String = {"", "Green", "Yellow", "Chocolate", "Red"}
        Dim dsGraph As New System.Data.DataSet("Graph")
        Dim ddChart As New Dundas.Charting.WebControl.Chart

        strSQL = " usp_PM_HelpDeskStatuswiseAgeing " & m_lngEmployeeID.ToString
        strSQL = strSQL + ",'" + m_strMode + "','" + m_strLoginType + "'," + m_intYear.ToString

        If m_filterID > 0 Then
            strSQL = strSQL + "," + m_filterID.ToString
        Else
            strSQL = strSQL + ",NULL"
            If m_strFilterText <> "" Then
                strSQL = strSQL + ",'" + CommonFunctions.General.BuildQueryString(m_strFilterText) + "'"
            End If
        End If

        dsGraph = CommonFunctions.Data.GetDataSet(strSQL, "Ageing")
        'strSQL = "usp_Sel_IssueSLADashBoard null,'"

        strImageFileName = "RequestAgeing" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "Request Ageing"
        blnShowCaptions = True
        ' create the graph for the item values
        objGraph = New Graph.Graph
        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            '.BorderStyle = "FRAMETITLE5"
            '.BorderColor = "BurlyWood"
            arr(0) = "COLUMN"
            arr(1) = "COLUMN"
            arr(2) = "COLUMN"
            arr(3) = "COLUMN"
            arr(4) = "COLUMN"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "Bisque"
            .ChartAreaColor = "FloralWhite"
            .ShowLegends = True
            .XAxisTitle = "Status"
            .Nomenclature = "Requests Reported"
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "black"
            .ShowDataColumnNameAsXAxisTitle = False
            '-- Fixed Settings
            .GraphTitle = " Request Ageing"
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            '.SQL = strSQL
            .DataSet = dsGraph
            .Width = 600
            .Height = m_intGraphHeight
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            ' .ExtendedSeriesColor = arrColor
            .LegendColor = arrColor
            ' .YAxisInterval = 1
            .XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .XAxisLabelStyle = 2
            .XAxisInterval = 1
            .DrillDownClientSideFunctionName = "ShowRequestDetails("
            '            .GenerateStackedGraphImage()
            ddChart = .GenerateChartControl
        End With


        '-- Display Graph
        'If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & strImageFileName & ".png") Then
        '    Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY & strImageFileName & ".png" & "'>")
        'Else
        '    Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        'End If



        dsGraph.Dispose()
        dsGraph = Nothing
        Return ddChart

    End Function

    ''Added by Dhanashri S on 31 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateSLAdetailsToken(Year As String, FilterID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(Year, String) + CType(FilterID, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    ''End of Addition by Dhanashri S on 31 Mar 2016

    ''Added by Dhanashri S on 31 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateRequestAgeingToken(Year As String, FilterID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(Year, String) + CType(FilterID, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    ''End of Addition by Dhanashri S on 31 Mar 2016


End Class
