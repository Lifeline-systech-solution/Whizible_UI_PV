Public Class DBGraphs

#Region "FormLevelVariables"
    Private m_lngProjectID As Long
    Private m_blnUseSQL As Boolean
    Private m_lngTagID As Long
    Private m_strReportDate As String
    Private m_intGraphID As Integer
    Private m_strConnectionString As String
    Private m_intUniqueID As Integer
    Private Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"
    Public m_intGraphCount As Integer = 1
    Private m_intCurrentGraphCount As Integer = 1
    Public m_blnshowFooterNote As Boolean = True
#End Region

#Region "Properties"
    Public WriteOnly Property ProjectID() As Long
        Set(ByVal Value As Long)
            m_lngProjectID = Value
        End Set
    End Property
    Public ReadOnly Property UseSQL() As Boolean
        Get
            Return m_blnUseSQL
        End Get
    End Property
    Public WriteOnly Property TagID() As Long
        Set(ByVal Value As Long)
            m_lngTagID = Value
        End Set
    End Property
    Public WriteOnly Property ReportGenerationDate() As String
        Set(ByVal Value As String)
            m_strReportDate = Value
        End Set
    End Property
    Public WriteOnly Property GraphID() As Integer
        Set(ByVal Value As Integer)
            m_intGraphID = Value
        End Set
    End Property

    Public WriteOnly Property ShowFooterNote() As Boolean
        Set(ByVal Value As Boolean)
            m_blnshowFooterNote = Value
        End Set
    End Property
    'Added By Padmnabh to pass uniqueID to graph procedure
    Public WriteOnly Property UniqueID() As Integer
        Set(ByVal Value As Integer)
            m_intUniqueID = Value
        End Set
    End Property
#End Region

#Region "ConstructorAndMethods"
    Sub New(ByVal lngProjectID As Long, ByVal intTagID As Integer, ByVal strReportGenerationDate As String)
        Me.m_lngProjectID = lngProjectID
        Me.m_lngTagID = intTagID
        Me.m_strReportDate = strReportGenerationDate
        Me.m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
        Me.m_strConnectionString = CommonFunctions.General.GetConnectionString
    End Sub

    Sub New()
        'This is blank implementation
        Me.m_strConnectionString = CommonFunctions.General.GetConnectionString
        Me.m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    End Sub

    Public Sub GenerateGraphs()
        '=====================================================================
        ' Procedure Name        : GenerateGraphs()
        ' Purpose               : To create graphs 
        ' Description           : Same as above
        ' Parameters Passed     :  
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NiranjanK
        ' Created               : Oct 07,2005
        ' Revisions             : 
        '=====================================================================
        Dim strQuery As String
        Dim drGraphs As IDataReader
        Dim intTdCounter As Integer
        Dim intGraphID As Integer
        Dim strGraphName As String
        Dim strGraphDesc As String
        Dim strImageFileName As String

        'Get the graph information according to TagID
        strQuery = "usp_Sel_tbl_PM_GraphMaster " & m_lngTagID
        drGraphs = CommonFunctions.Data.GetDataReader(strQuery, m_blnUseSQL)
        ' Added by MahendraV On 10:53 AM 6/22/2007 for SP8 Performance
        ' Start_MV_6/22/2007
        Dim tblSingleGraph As DataTable = New DataTable("GraphTable")
        Dim graphDataColumn As DataColumn
        Dim graphDataRow As DataRow
        graphDataColumn = New DataColumn("GraphID", System.Type.GetType("System.Int32"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("SP_Name_ForGraph", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphDescription", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphName", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphFileName", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphType", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("ShowCaptions", System.Type.GetType("System.Boolean"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphHeight", System.Type.GetType("System.Int32"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphWidth", System.Type.GetType("System.Int32"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("Enable3D", System.Type.GetType("System.Boolean"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("BorderStyle", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("BorderColor", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphTitleColor", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphBGColor", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("GraphAreaColor", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("CaptionColor", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("PalleteStyle", System.Type.GetType("System.String"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("EnableXAxis", System.Type.GetType("System.Boolean"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("EnableYAxis", System.Type.GetType("System.Boolean"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        graphDataColumn = New DataColumn("EnableSmartLabels", System.Type.GetType("System.Boolean"))
        tblSingleGraph.Columns.Add(graphDataColumn)
        ' End_MV_6/22/2007
        Do While drGraphs.Read

            If CommonFunctions.General.CheckIsNothing(drGraphs) <> "" Then
                ' Added by MahendraV On 10:53 AM 6/22/2007 for SP8 Performance
                ' Start_MV_6/22/2007
                'intGraphID = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphID"), ""), Integer)

                graphDataRow = tblSingleGraph.NewRow()
                graphDataRow.Item("GraphID") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphID"), ""), Integer)
                graphDataRow.Item("SP_Name_ForGraph") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("SP_Name_ForGraph"), ""), String)
                graphDataRow.Item("GraphDescription") = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drGraphs("GraphDescription"), ""), "")
                graphDataRow.Item("GraphName") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphName"), ""), String)
                graphDataRow.Item("GraphFileName") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphFileName"), ""), String)
                graphDataRow.Item("GraphType") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphType"), ""), String)
                graphDataRow.Item("ShowCaptions") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("ShowCaptions"), ""), Boolean)
                graphDataRow.Item("GraphHeight") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphHeight"), "500"), Integer)
                graphDataRow.Item("GraphWidth") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphWidth"), "600"), Integer)
                graphDataRow.Item("Enable3D") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("Enable3D"), "false"), Boolean)
                graphDataRow.Item("BorderStyle") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("BorderStyle")), String)
                graphDataRow.Item("BorderColor") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("BorderColor")), String)
                graphDataRow.Item("GraphTitleColor") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphTitleColor")), String)
                graphDataRow.Item("GraphBGColor") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphBGColor")), String)
                graphDataRow.Item("GraphAreaColor") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("GraphAreaColor")), String)
                graphDataRow.Item("CaptionColor") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("CaptionColor")), String)
                graphDataRow.Item("PalleteStyle") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("PalleteStyle")), String)
                graphDataRow.Item("EnableXAxis") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("EnableXAxis"), "true"), Boolean)
                graphDataRow.Item("EnableYAxis") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("EnableYAxis"), "true"), Boolean)
                graphDataRow.Item("EnableSmartLabels") = CType(CommonFunctions.Data.CheckIsDBNull(drGraphs("EnableSmartLabels"), "false"), Boolean)
                tblSingleGraph.Rows.Add(graphDataRow)

                GenerateSingleGraph(tblSingleGraph)

                tblSingleGraph.Rows.Remove(graphDataRow)
                ' End_MV_6/22/2007
                'Added By SandeepA on 11 Oct,2005 for  generating the graph


                'End of Addition by SandeepA on 11 Oct,2005 

            End If
        Loop

        ' if odd number of graphs are generated then close the TR and Table 
        If m_intGraphCount Mod 2 = 0 Then
            With HttpContext.Current.Response
                .Write("</TD>")
                .Write("</TR>")
                .Write("</TABLE>")
            End With
        End If

        '--release datareader 
        drGraphs.Close()
        graphDataColumn.Dispose()
        tblSingleGraph.Dispose()
        CommonFunctions.Data.DisposeDataReader(drGraphs)
    End Sub
    ' Modified by MahendraV On 10:53 AM 6/22/2007 for SP8 Performance
    ' Start_MV_6/22/2007

    'Public Sub GenerateSingleGraph(ByVal intGraphID As Integer)
    Public Sub GenerateSingleGraph(ByVal tbl_GraphTable As DataTable)

        ' End_MV_6/22/2007
        '=====================================================================
        ' Procedure Name        : GenerateSingleGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : GraphID
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NiranjanK
        ' Created               : Oct 07,2005
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
        Dim m_strPalleteStyle As String
        Dim intGraphHeight As Integer
        Dim intGraphWidth As Integer
        Dim i As Integer
        Dim strQuery As String
        Dim strGraphDescription As String = ""
        Dim objDataSet As DataSet




        If m_intCurrentGraphCount = 1 Then
            With HttpContext.Current.Response
                .Write("<TABLE Class=clsTable Width='99.9%'>")
                .Write("<TR class=clsTREven>")
                .Write("<TD align=Left width=100%>")
            End With
        Else
            HttpContext.Current.Response.Write("<TD align=center width=100%>")
        End If
        '-- Generate graph
        ' get the item details
        ' Added by MahendraV On 10:59 AM 6/22/2007 
        ' To set DataSet object in place of using SQL in Graph object and reduce extra call of SP 'usp_sel_tbl_PM_GraphMaster_Single' for WhzibleSEM 7  Performance
        ' Start_MV_6/22/2007
        Dim objDataRow As DataRow
        objDataRow = tbl_GraphTable.Rows(0)
        strQuery = CType(objDataRow.Item("SP_Name_ForGraph"), String)
        strQuery = Replace(strQuery, "<PROJECT_ID>", CType(m_lngProjectID, String))
        strQuery = Replace(strQuery, "<SERVER_DATE>", "'" & Now.ToShortDateString.ToString & "'")
        strQuery = Replace(strQuery, "<TO_DATE>", "'" & m_strReportDate & "'")
        strQuery = Replace(strQuery, "<UNIQUE_ID>", m_intUniqueID.ToString)
        strGraphDescription = CType(objDataRow.Item("GraphDescription"), String)
        '-- Setting some main Graph Properties
        '-- FIXED VALUES FOR NOW:

        strItemName = CType(objDataRow.Item("GraphName"), String)
        strImageFileName = CType(objDataRow.Item("GraphFileName"), String) & m_lngProjectID
        strChartType = CType(objDataRow.Item("GraphType"), String)


        objDataSet = CommonFunctions.Data.GetDataSet(strQuery, "GraphTable", , , m_blnUseSQL, m_strConnectionString)
        ReDim arrstrChartType(objDataSet.Tables("GraphTable").Columns.Count - 1)
        For i = 0 To objDataSet.Tables("GraphTable").Columns.Count - 1
            arrstrChartType(i) = strChartType
        Next

        blnShowLegends = True
        strNomenclature = "Test"
        blnShowCaptions = CType(objDataRow.Item("ShowCaptions"), Boolean)
        m_strPalleteStyle = "EARTHTONES"
        ' Get Graph Height and Graph Width
        intGraphHeight = CType(objDataRow.Item("GraphHeight"), Integer)
        intGraphWidth = CType(objDataRow.Item("GraphWidth"), Integer)
        ' create the graph for the item values
        objGraph = New Graph.Graph


        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = HttpContext.Current.Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString

            .VirtualImagePath = ""
            .Enable3D = CType(objDataRow.Item("Enable3D"), Boolean)
            .ChartType = arrstrChartType 'GetChartType(ItemID, SQL, m_intGraphID, m_blnUseSQL)
            Dim Chart As Dundas.Charting.WebControl.Chart
            '-- Take settings From Database table
            .BorderStyle = CType(objDataRow.Item("BorderStyle"), String) 'FrameTitle5
            .BorderColor = CType(objDataRow.Item("BorderColor"), String) ' "Blue"
            .GraphTitleColor = CType(objDataRow.Item("GraphTitleColor"), String) '"white"
            .ChartBackColor = CType(objDataRow.Item("GraphBGColor"), String) '"PaleGoldenRod"
            .ChartAreaColor = CType(objDataRow.Item("GraphAreaColor"), String)  '"GoldenRod"
            .ShowLegends = blnShowLegends
            .LegendDocking = "right" '"bottom"
            .LegendStyle = "Column"
            .LegendCaptionColor = CType(objDataRow.Item("CaptionColor"), String)   '"black"
            .PalleteStyle = CType(objDataRow.Item("PalleteStyle"), String)  ' m_strPalleteStyle
            .EnableXAxis = CType(objDataRow.Item("EnableXAxis"), Boolean)
            .EnableYAxis = CType(objDataRow.Item("EnableYAxis"), Boolean)
            .EnableSmartLabels = CType(objDataRow.Item("EnableSmartLabels"), Boolean)
            .ShowCaptions = blnShowCaptions
            .GraphTitleColor = CType(objDataRow.Item("GraphTitleColor"), String)   '"Green"

            '-- Fixed Settings
            .GraphTitle = strItemName
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .DataSet = objDataSet
            .Width = intGraphWidth
            .Height = intGraphHeight
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

        ' End_MV_6/22/2007

        'strSQL = "EXEC usp_sel_tbl_PM_GraphMaster_Single " & intGraphID
        'drGraph = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL, m_strConnectionString)
        'If drGraph.Read Then

        '    '-- Get and Process the Query for generating the graph from table
        '    strQuery = CType(drGraph("SP_Name_ForGraph"), String)
        '    strQuery = Replace(strQuery, "<PROJECT_ID>", CType(m_lngProjectID, String))
        '    strQuery = Replace(strQuery, "<SERVER_DATE>", "'" & Now.ToShortDateString.ToString & "'")
        '    strQuery = Replace(strQuery, "<TO_DATE>", m_strReportDate)
        '    strQuery = Replace(strQuery, "<UNIQUE_ID>", m_intUniqueID.ToString)

        '    strGraphDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drGraph("GraphDescription"), ""), "")

        '    '-- Setting some main Graph Properties
        '    '-- FIXED VALUES FOR NOW:
        '    strItemName = drGraph("GraphName").ToString
        '    strImageFileName = drGraph("GraphFileName").ToString & m_lngProjectID
        '    strChartType = CType(drGraph("GraphType"), String)

        '    drTemp = CommonFunctions.Data.GetDataReader(strQuery, m_blnUseSQL, m_strConnectionString)

        '    '-- Build Array for specifying the Chart Type for each column

        '    ReDim arrstrChartType(drTemp.FieldCount - 1)
        '    For i = 0 To drTemp.FieldCount - 1

        '        arrstrChartType(i) = strChartType
        '    Next
        '    CommonFunctions.Data.DisposeDataReader(drTemp)
        '    blnShowLegends = True
        '    'blnEnable3D = True
        '    strNomenclature = "Test"
        '    blnShowCaptions = CType(drGraph("ShowCaptions"), Boolean)
        '    m_strPalleteStyle = "EARTHTONES"
        '    ' Get Graph Height and Graph Width
        '    intGraphHeight = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("GraphHeight"), "500"), Integer)
        '    intGraphWidth = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("GraphWidth"), "600"), Integer)
        '    ' create the graph for the item values
        '    objGraph = New Graph.Graph

        '    With objGraph
        '        strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
        '        .VirtualImagePath = strVirtualImgPath
        '        .AbsoluteImagePath = HttpContext.Current.Server.MapPath(strVirtualImgPath)
        '        .ConnectionString = CommonFunction.Application.ConnectionString

        '        .VirtualImagePath = ""
        '        .Enable3D = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("Enable3D"), "false"), Boolean)
        '        .ChartType = arrstrChartType 'GetChartType(ItemID, SQL, m_intGraphID, m_blnUseSQL)
        '        Dim Chart As Dundas.Charting.WebControl.Chart
        '        '-- Take settings From Database table
        '        .BorderStyle = CommonFunctions.Data.CheckIsDBNull(drGraph("BorderStyle")).ToString  'FrameTitle5
        '        .BorderColor = CommonFunctions.Data.CheckIsDBNull(drGraph("BorderColor")).ToString ' "Blue"
        '        .GraphTitleColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphTitleColor")).ToString  '"white"
        '        .ChartBackColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphBGColor")).ToString  '"PaleGoldenRod"
        '        .ChartAreaColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphAreaColor")).ToString  '"GoldenRod"
        '        .ShowLegends = blnShowLegends
        '        .LegendDocking = "right" '"bottom"
        '        .LegendStyle = "Column"
        '        .LegendCaptionColor = CommonFunctions.Data.CheckIsDBNull(drGraph("CaptionColor")).ToString   '"black"
        '        .PalleteStyle = CommonFunctions.Data.CheckIsDBNull(drGraph("PalleteStyle")).ToString   ' m_strPalleteStyle
        '        .EnableXAxis = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("EnableXAxis"), "true"), Boolean)
        '        .EnableYAxis = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("EnableYAxis"), "true"), Boolean)
        '        .EnableSmartLabels = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("EnableSmartLabels"), "false"), Boolean)
        '        .ShowCaptions = blnShowCaptions
        '        .GraphTitleColor = CommonFunctions.Data.CheckIsDBNull(drGraph("GraphTitleColor")).ToString   '"Green"

        '        '-- Fixed Settings
        '        .GraphTitle = strItemName
        '        .TitleFont = New Font("verdana", 9, FontStyle.Bold)
        '        ' Added by MahendraV On 6:43 PM 6/21/2007 To set DataSet object in place of using SQL in Graph object
        '        ' Start_MV_6/21/2007

        '        '.SQL = strQuery
        '        .DataSet = objDataSet
        '        ' End_MV_6/21/2007
        '        .Width = intGraphWidth
        '        .Height = intGraphHeight
        '        .ShowExplodedPie = False
        '        .LegendFont = New Font("verdana", 8, FontStyle.Regular)
        '        .BorderGradientColor = "WHITE"
        '        .BorderGradientStyle = "TOPBOTTOM"
        '        .ChartBackGradientColor = "WHITE"
        '        .ChartBackGradientStyle = "TOPBOTTOM"
        '        .ChartAreaGradientColor = "WHITE"
        '        .ChartAreaGradientStyle = "TOPBOTTOM"

        '        ' return the graph control
        '        .GenerateChartControl()
        '    End With
        'End If


        If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageFileName) & ".png") Then
            HttpContext.Current.Response.Write("<IMG align ='bottom' HEIGHT=" & intGraphHeight & " WIDTH=" & intGraphWidth & " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
        Else
            HttpContext.Current.Response.Write("<IMG align ='bottom' src='..\..\images\NoPreview.gif'>")
        End If

        ' Show graph Description if 
        If m_blnshowFooterNote = True Then
            HttpContext.Current.Response.Write("<br> <B>Note: </B>" + strGraphDescription)
        End If

        If m_intCurrentGraphCount < m_intGraphCount Then
            HttpContext.Current.Response.Write("</TD>")
            m_intGraphCount += 1
        Else
            With HttpContext.Current.Response
                .Write("</TD>")
                .Write("</TR>")
                .Write("</TABLE>")
                m_intGraphCount = 1
            End With
        End If
        'drGraph.Close()
        'CommonFunctions.Data.DisposeDataReader(drGraph)
        objGraph = Nothing
    End Sub
#End Region

End Class
