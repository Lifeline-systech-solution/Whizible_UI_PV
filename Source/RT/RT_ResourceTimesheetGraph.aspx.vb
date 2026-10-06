Public Class RT_ResourceTimesheetGraph
    Inherits WebPages.Template.WhizTemplate


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

    Private m_intGraphID As Integer
    Private m_strLevel As String
    Private m_strPageTitle As String
    Private m_blnUseSQL As Boolean
    Public m_intProjectID As Integer
    Private m_strPalleteStyle As String
    Private m_intGraphHeight As Integer
    Private m_intGraphWidth As Integer
    Public m_strCriteria As String

    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Put user code to initialize the page here
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        Dim m_strPageTitle As String
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        ' m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)

        m_strPalleteStyle = "EARTHTONES"

        '###### FOR TESTING ########
        m_intGraphHeight = 350
        m_intGraphWidth = 650 '492
        m_intGraphID = 15
        ' Call WritePage()
        ' Call CreateGraphSection("DA Details")
        Call CreateEarnedValueReport()


    End Sub

    Private Sub CreateEarnedValueReport()

        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strImageFileName As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(4) As String

        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = " exec usp_CRW_EarnedValueReport 302,'01/11/2003','12/31/2004'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        If drGraph.Read Then

            strItemName = "Earned Value"
            strImageFileName = "EV" & CType(Session("intUserID"), String)
            blnShowLegends = True
            'blnEnable3D = True
            strNomenclature = "EV"
            blnShowCaptions = True

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString

                .VirtualImagePath = ""
                .Enable3D = True
                arr(0) = "LINE"
                arr(1) = "LINE"
                arr(2) = "LINE"
                arr(3) = "LINE"
                arr(4) = "LINE"
                .ChartType = arr
                .GraphTitleColor = "black"
                .ChartBackColor = "PaleGoldenRod"
                .ChartAreaColor = "GoldenRod"
                .ShowLegends = True
                .LegendDocking = "bottom"
                .LegendStyle = "column"
                .LegendCaptionColor = "black"
                .PalleteStyle = m_strPalleteStyle
                .EnableXAxis = True
                .EnableYAxis = True
                .EnableSmartLabels = False
                .ShowCaptions = False
                .GraphTitleColor = "Green"

                '-- Fixed Settings
                .GraphTitle = "Earned Value"
                .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
                .SQL = strSQL
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .ShowExplodedPie = False
                .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"

                ' return the graph control
                .GenerateChartControl()
            End With
        End If

        CommonFunctions.Data.DisposeDataReader(drGraph)

        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & "EV") & CType(Session("intUserID"), String) & ".png") Then

            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + "EV" & CType(Session("intUserID"), String) & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If


    End Sub

    Private Sub CreateGraphSection(ByVal strGraphName As String)
        '=====================================================================
        ' Procedure Name        : CreateGraphSection()
        ' Purpose               : Creates the Graph Section
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 30, 2003
        ' Revisions             : 
        '=====================================================================
        Dim strGraphDescription, strGraphFileName As String
        Dim strSP_Name_ForGraph As String
        Dim IsDrillDownGraph As Boolean
        Dim strLinkField, strGraphtype As String
        Dim objGraphSection As WebPages.Template.SectionTitle
        Dim tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
        Dim divGraphs As System.Web.UI.HtmlControls.HtmlControl

        '-- Print the Section 
        objGraphSection = New WebPages.Template.SectionTitle
        With objGraphSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("GRAPH"), "DivOtherInfo", "ShowHideOtherInfo"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivOtherInfo' Style='Overflow:Auto;Width=100%'>")
        Response.Write("<TABLE Class=clsTable Width='99.9%'>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=center width=100%>")

        '-- Call fn. to create the Graph Image
        Call CreateGraph()

        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & "DADetails") & CType(Session("intUserID"), String) & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + "DADetails" & CType(Session("intUserID"), String) & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If

        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")

        '--End of Graph Section's div
        Response.Write("</DIV>")
    End Sub

    Private Sub CreateGraph()
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create Pie chart displaying Resource Timesheet Total Project wise
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : 
        ' Created               : July 21,2004
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
        Dim strItemName As String = ""
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(1) As String

        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = " EXEC usp_sel_GetDADetails 61,'01/01/2004','07/07/2004'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        If drGraph.Read Then

            strItemName = "DA Details"
            strImageFileName = "DADetails" & CType(Session("intUserID"), String)
            blnShowLegends = True
            'blnEnable3D = True
            strNomenclature = "Test"
            blnShowCaptions = True

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString

                .VirtualImagePath = ""
                .Enable3D = True
                arr(0) = "PIE"
                arr(1) = "PIE"
                .ChartType = arr
                .GraphTitleColor = "black"
                .ChartBackColor = "PaleGoldenRod"
                .ChartAreaColor = "GoldenRod"
                .ShowLegends = True
                .LegendDocking = "right"
                .LegendStyle = "column"
                .LegendCaptionColor = "black"
                .PalleteStyle = m_strPalleteStyle
                .EnableXAxis = True
                .EnableYAxis = True
                .EnableSmartLabels = False
                .ShowCaptions = True
                .GraphTitleColor = "Green"

                '-- Fixed Settings
                .GraphTitle = "DA Details"
                .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
                .SQL = strSQL
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .ShowExplodedPie = False
                .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"

                ' return the graph control
                .GenerateChartControl()
            End With
        End If

        CommonFunctions.Data.DisposeDataReader(drGraph)

    End Sub


End Class
