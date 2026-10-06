Public Class ProjectDB_Details
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
    ' Added By NitinVS on 14 March 2005 for WhizibleE SP2
    ' To Group on Deliverable Type for Deliverable Graphs
    Protected WithEvents m_objGrid As WebPage.Templates.AdvancedGrid
    ' End Addition By NitinVS on 14 March 2005 for WhizibleE SP2

    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        Dim m_strPageTitle As String
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        m_intProjectID = CType(Request.QueryString("ProjectID"), Integer)
        m_intGraphID = CType(Request.QueryString("GRAPHID"), Integer)
        m_strLevel = Request.QueryString("LEVEL")
        m_strPalleteStyle = "EARTHTONES"

        '###### FOR TESTING ########
        m_intGraphHeight = 290
        m_intGraphWidth = 600 '492
        'm_intGraphID = 15
        'm_intProjectID = 306
        '###########################
    End Sub
    Public Sub PlotHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub New()
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        '-- To get the Menu captions
        '-- Load this page's specific resource file
        MyBase.InitializeResources("AppResources.ProjectDB_Details", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")

    End Sub

    Public Sub WritePage()
        '-- This page will have 2 sections : Graph and Data grid section

        Dim drGraphDetails As IDataReader
        Dim strQuery, strMenu As String
        Dim strGraphTitle, strGraphName As String
        ' Added By NitinVS on 14 March 2005 for WhizibleE SP2
        ' To Group on Deliverable Type for Deliverable Graphs
        Dim intGraphID As Long
        ' End Addition By NitinVS on 14 March 2005 for WhizibleE SP2

        'Draw Top Menu
        strMenu = PrepareMenu()
        CommonFunctions.General.WriteHTML(strMenu & "<BR>")

        '-- Get details of Graph to plot from data table FROM Graph Master Table
        '######## PUT CULTURE Handling here for GRAPH NAME / TITLE
        strQuery = "Exec usp_Sel_tbl_ProjectDB_GraphMaster " & m_intGraphID
        drGraphDetails = CommonFunctions.Data.GetDataReader(strQuery, m_blnUseSQL)

        If drGraphDetails.Read Then
            strGraphTitle = CType(drGraphDetails("GraphName"), String)
            strGraphName = CType(drGraphDetails("GraphFileName"), String)

            '-- Caption of the Graph Page
            MyBase.InitializeResources("AppResources.ProjectDB_Details", "AppResources")
            CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True) + vbCrLf)
            Response.Write("<BR>" + vbCrLf)

            CommonFunction.General.WriteHTML("<DIV id='InitialDiv' STYLE='OVERFLOW: auto; Width: 100%'>")

            '-- Render the Graph Image
            Call CreateGraphSection(strGraphName)

            '-- If that Graph also has Data Table then call function to display Data Grid section
            '-- We get the Actual/UserFriendly/RowLLink and Tooltip Array for generating this Graph related
            '-- Grid from the Database itself as this is different for all graphs
            If CType(CommonFunctions.Data.CheckIsDBNull(drGraphDetails("ShowDataTable"), "0"), Boolean) Then

                Dim strFieldListTemp As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("ActualFieldList"), "").ToString
                Dim strActualFieldArrayList() As String = Split(strFieldListTemp, ",")

                Dim strUFFieldListTemp As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("UserFriendlyFieldList"), "").ToString
                Dim strUFFieldArrayList() As String = Split(strUFFieldListTemp, ",")

                Dim strRowLinkListTemp As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("LinkField"), "").ToString
                Dim strRowLinkArrayList() As String = Split(strRowLinkListTemp, ",")

                Dim strToolTipForGrid As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("ToolTipForGrid"), "").ToString
                Dim arrstrToolTipForGrid() As String = Split(strToolTipForGrid, "#|#")

                Dim strColGroup As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("GridVerticalGroupList"), "").ToString
                Dim arrColGroupList() As String = Split(strColGroup, ",")

                Dim strColGroupName As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("GridVerticalGroupListName"), "").ToString
                Dim arrColGroupListName() As String = Split(strColGroupName, ",")

                Dim strExpandedGroup As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("GridVerticalExpanded"), "").ToString
                Dim arrExpandedGroup() As String = Split(strExpandedGroup, ",")

                Dim blnShowSummaryFunctions As Boolean
                blnShowSummaryFunctions = CType(CommonFunctions.Data.CheckIsDBNull(drGraphDetails("ShowSummaryFunctions")), Boolean)

                Dim strSummaryFunctions As String = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("SummaryFunctions"), "").ToString
                Dim arrSummaryFunctions() As String = Split(strSummaryFunctions, ",")

                m_strCriteria = CommonFunctions.Data.CheckIsDBNull(drGraphDetails("DrillDownCriteria"), "").ToString

                ' Added By NitinVS on 14 March 2005 for WhizibleE SP2
                ' To Group Deliverable Graph Grid on Deliverable Type  
                intGraphID = CType(CommonFunctions.Data.CheckIsDBNull(drGraphDetails("GraphID"), ""), Long)
                If intGraphID = 24 Or intGraphID = 25 Or intGraphID = 26 Or intGraphID = 27 Then
                    Call PopulateDeliverableGridSection(CommonFunctions.Data.CheckIsDBNull(drGraphDetails("SP_Name_ForTable"), "").ToString, strRowLinkArrayList, strActualFieldArrayList, strUFFieldArrayList, arrstrToolTipForGrid, arrColGroupList, arrColGroupListName, arrExpandedGroup, blnShowSummaryFunctions, arrSummaryFunctions, intGraphID)
                Else
                    Call PopulateGridSection(CommonFunctions.Data.CheckIsDBNull(drGraphDetails("SP_Name_ForTable"), "").ToString, strRowLinkArrayList, strActualFieldArrayList, strUFFieldArrayList, arrstrToolTipForGrid, arrColGroupList, arrColGroupListName, arrExpandedGroup, blnShowSummaryFunctions, arrSummaryFunctions)
                End If

            End If

            CommonFunctions.Data.DisposeDataReader(drGraphDetails)

        Else
            '-- Code For giving error message to user/ or No Graph message

        End If
        CommonFunction.General.WriteHTML("</DIV> ")
        '-- Write Bottom menu
        CommonFunctions.General.WriteHTML("<BR>" + strMenu)

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
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strGraphName) & m_intProjectID & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + strGraphName & m_intProjectID & ".png" & "'>")
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
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Noveber 07,2003
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

        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = "EXEC usp_Sel_tbl_ProjectDB_GraphMaster " & m_intGraphID
        drGraph = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        If drGraph.Read Then
            '-- Get and Process the Query for generating the graph from table
            strQuery = CType(drGraph("SP_Name_ForGraph"), String)
            strQuery = Replace(strQuery, "<PROJECT_ID>", CType(m_intProjectID, String))
            strQuery = Replace(strQuery, "<SERVER_DATE>", Now.ToShortDateString.ToString)

            '-- Setting some main Graph Properties
            '-- FIXED VALUES FOR NOW:
            strItemName = drGraph("GraphName").ToString
            strImageFileName = drGraph("GraphFileName").ToString & m_intProjectID

            strChartType = CType(drGraph("GraphType"), String)

            drTemp = CommonFunctions.Data.GetDataReader(strQuery, m_blnUseSQL)

            '-- Build Array for specifying the Chart Type for each column
            ReDim arrstrChartType(drTemp.FieldCount - 1)
            For i = 0 To drTemp.FieldCount - 1

                arrstrChartType(i) = strChartType
            Next
            CommonFunctions.Data.DisposeDataReader(drTemp)

            blnShowLegends = True
            'blnEnable3D = True
            strNomenclature = "Test"
            blnShowCaptions = CType(drGraph("ShowCaptions"), Boolean)
            m_strPalleteStyle = "EARTHTONES"

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString

                .VirtualImagePath = ""
                .Enable3D = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("Enable3D"), "false"), Boolean)
                .ChartType = arrstrChartType 'GetChartType(ItemID, SQL, m_intGraphID, m_blnUseSQL)
                Dim Chart As Dundas.Charting.WebControl.Chart
                '-- Take settings From Database table
                .BorderStyle = CommonFunctions.Data.CheckIsDBNull(drGraph("BorderStyle")).ToString  'FrameTitle5
                .BorderColor = CommonFunctions.Data.CheckIsDBNull(drGraph("BorderColor")).ToString ' "Blue"
                .GraphTitleColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphTitleColor")).ToString  '"white"
                .ChartBackColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphBGColor")).ToString  '"PaleGoldenRod"
                .ChartAreaColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphAreaColor")).ToString  '"GoldenRod"
                .ShowLegends = blnShowLegends
                .LegendDocking = "bottom"
                .LegendStyle = "row"
                .LegendCaptionColor = CommonFunctions.Data.CheckIsDBNull(drGraph("CaptionColor")).ToString   '"black"
                .PalleteStyle = CommonFunctions.Data.CheckIsDBNull(drGraph("PalleteStyle")).ToString   ' m_strPalleteStyle
                .EnableXAxis = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("EnableXAxis"), "true"), Boolean)
                .EnableYAxis = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("EnableYAxis"), "true"), Boolean)
                .EnableSmartLabels = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("EnableSmartLabels"), "false"), Boolean)
                .ShowCaptions = blnShowCaptions
                .GraphTitleColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphTitleColor")).ToString   '"Green"

                '-- Fixed Settings
                .GraphTitle = strItemName
                .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
                .SQL = strQuery
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

    Sub PopulateGridSection(ByVal strSQLQueryForGrid As String, ByVal arrstrRowLinkField() As String, ByVal arrstrActualList() As String, ByVal arrstrUserFriendlyList() As String, ByVal arrstrToolTipForGrid() As String, ByVal arrColGroupList() As String, ByVal arrColGroupListName() As String, ByVal arrExpandedGroup() As String, ByVal blnShowSummaryFunctions As Boolean, ByVal arrSummaryFunctions() As String)
        '=====================================================================
        ' Procedure Name        : PopulateGridSection()
        ' Purpose               : Display the Complete Data Grid for the Graph
        ' Description           : Display the Data Details Section & Data Grid corresp. to the Graph
        ' Parameters Passed     : strSQLQueryForGrid As String
        '                         arrstrRowLinkField() 
        '                         arrstrActualList()
        '                         arrstrUserFriendlyList()
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : SQL Query for Populating the Data Grid is Passed as a parameter
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 30,2003
        ' Revisions             : 
        '=====================================================================

        Dim inti As Integer
        Dim strGRID As String
        Dim objGridSection As WebPages.Template.SectionTitle
        Dim objGrid As New WebPage.Templates.AdvancedGrid
        Dim arrList As New System.Collections.ArrayList
        Dim arrRowLinkList As New System.Collections.ArrayList
        Dim drGrid As IDataReader

        '-- Print the Section 
        objGridSection = New WebPages.Template.SectionTitle
        With objGridSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("DETAILS"), "DivGridInfo", "ShowHideGridInfo"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivGridInfo' Style='Overflow:Auto;Width=100%'>")

        '-- SQL Query for Populating the Grid: Replace the Place Holders
        strSQLQueryForGrid = Replace(Replace(strSQLQueryForGrid, "<PROJECT_ID>", m_intProjectID.ToString), "<SERVER_DATE>", Now.ToShortDateString)

        '-- Actual column heading
        '-- Set Properties of the DATA GRID

        With objGrid
            .ActualColumnArray = arrstrActualList
            .TDStyleArray = arrstrToolTipForGrid
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .ColNameToolTipOnEachRow = True
            If arrColGroupList.Length > 1 Then
                .ColumnGroupColumnsArray = arrColGroupList
                .ColumnGroupNameArray = arrColGroupListName
                .ColumnGroupExpandedArray = arrExpandedGroup
            End If

            If blnShowSummaryFunctions Then
                .ShowSummaryFunctions = blnShowSummaryFunctions
                .SummaryFunctions = arrSummaryFunctions

            End If

            .SQL = strSQLQueryForGrid
            .EmptyValueReplacement = MyBase.GetResourceString("NOT_SPECIFIED")
            .DIVHeight = 0
            .returnHTML = True
            .RowLinkArray = arrstrRowLinkField
            .UseSQL = m_blnUseSQL
            strGRID = .DrawGrid() ' Called from within the section below

        End With
        objGrid = Nothing

        '-- Write the HTML Data Grid
        Response.Write(strGRID)
        Response.Write("</DIV>")
    End Sub


    Private Function PrepareMenu() As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : To write the page for displaying static Project Dashboard's graphs
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('PROJECT_GRAPHS')"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu

    End Function
    ' Added By NitinVS on 14 March 2005 for WhizibleE SP2
    ' TO Group the data grid on Deliverable Type 
    Sub PopulateDeliverableGridSection(ByVal strSQLQueryForGrid As String, ByVal arrstrRowLinkField() As String, ByVal arrstrActualList() As String, ByVal arrstrUserFriendlyList() As String, ByVal arrstrToolTipForGrid() As String, ByVal arrColGroupList() As String, ByVal arrColGroupListName() As String, ByVal arrExpandedGroup() As String, ByVal blnShowSummaryFunctions As Boolean, ByVal arrSummaryFunctions() As String, ByVal GraphId As Long)
        '=====================================================================
        ' Procedure Name        : PopulateDeliverableGridSection()
        ' Purpose               : Display the Complete Data Grid for the Graph of Deliverables
        ' Description           : Display the Data Details Section & Data Grid corresp. to the Graph of Deliverables
        ' Parameters Passed     : strSQLQueryForGrid As String
        '                         arrstrRowLinkField() 
        '                         arrstrActualList()
        '                         arrstrUserFriendlyList()
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : SQL Query for Populating the Data Grid is Passed as a parameter
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : March 14, 2005
        ' Revisions             : 
        '=====================================================================

        Dim inti As Integer
        Dim strGRID As String
        Dim objGridSection As WebPages.Template.SectionTitle
        'Dim objGrid As New WebPage.Templates.AdvancedGrid
        Dim arrList As New System.Collections.ArrayList
        Dim arrRowLinkList As New System.Collections.ArrayList
        Dim drGrid As IDataReader
        Dim arrGroupOn() As String = {"1"}



        '-- Print the Section 
        objGridSection = New WebPages.Template.SectionTitle
        With objGridSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("DETAILS"), "DivGridInfo", "ShowHideGridInfo"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivGridInfo' Style='Overflow:Auto;Width=100%'>")

        '-- SQL Query for Populating the Grid: Replace the Place Holders
        strSQLQueryForGrid = Replace(Replace(strSQLQueryForGrid, "<PROJECT_ID>", m_intProjectID.ToString), "<SERVER_DATE>", Now.ToShortDateString)

        '-- Actual column heading
        '-- Set Properties of the DATA GRID
        m_objGrid = New WebPage.Templates.AdvancedGrid
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        With m_objGrid
            .ActualColumnArray = arrstrActualList
            .TDStyleArray = arrstrToolTipForGrid
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .ColNameToolTipOnEachRow = True
            If arrColGroupList.Length > 1 Then
                .ColumnGroupColumnsArray = arrColGroupList
                .ColumnGroupNameArray = arrColGroupListName
                .ColumnGroupExpandedArray = arrExpandedGroup
            End If

            If blnShowSummaryFunctions Then
                .ShowSummaryFunctions = blnShowSummaryFunctions
                .SummaryFunctions = arrSummaryFunctions
            End If

            .GroupOnColumn = arrGroupOn

            .SQL = strSQLQueryForGrid
            .EmptyValueReplacement = MyBase.GetResourceString("NOT_SPECIFIED")
            .DIVHeight = 0
            .returnHTML = True
            .RowLinkArray = arrstrRowLinkField
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid() ' Called from within the section below

        End With
        m_objGrid = Nothing

        '-- Write the HTML Data Grid
        Response.Write(strGRID)
        Response.Write("</DIV>")
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If m_intGraphID = 24 Or m_intGraphID = 25 Then
            If Args.ColumnName.ToUpper = "NO OF DELIVERABLES" Then
                Cancel = True
            End If
        End If

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If m_intGraphID = 24 Or m_intGraphID = 25 Then
            If Args.ColumnName.ToUpper = "NO OF DELIVERABLES" Then
                Cancel = True
            End If
        End If
    End Sub
End Class
'End Addition By NitinVS on 14 March 2005 for WhizibleE SP2
